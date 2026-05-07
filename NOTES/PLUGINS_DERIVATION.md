## Approach

The key insight: Neovim's `pack/*/opt/` mechanism keeps plugins *off* the RTP by default — `packadd` both adds to RTP and sources `plugin/`. What you want instead is to manually append to RTP *without* calling `packadd`, so `require()` works but `plugin/*.lua` / `plugin/*.vim` files are never auto-sourced.

The derivation just needs to build the `pack/nix/opt/<name>/` tree. Lua and vimscript plugins are structurally identical from Nix's perspective.

---

## The Derivation

```nix
# neovim-plugin-pack.nix
{ lib, stdenvNoCC }:

# Call with a list of plugin derivations, e.g.:
#   pkgs.callPackage ./neovim-plugin-pack.nix {} (with pkgs.vimPlugins; [ telescope-nvim nvim-cmp ])
plugins:

let
  # Compute the on-disk opt/ directory name for a plugin derivation.
  # nixpkgs vimPlugins always have pname; fall back to stripping the
  # version suffix from .name for custom derivations named "plugin-xyz-<ver>".
  pluginName = p:
    let
      raw = p.pname or (
        let m = builtins.match "(.+)-[0-9][^-]*" p.name;
        in if m != null then builtins.head m else p.name
      );
    in
      # Strip the "plugin-" prefix that's conventional in Nix attribute sets
      lib.removePrefix "plugin-" raw;

in stdenvNoCC.mkDerivation {
  name = "neovim-opt-pack";

  dontUnpack = true;
  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/pack/nix/opt

    ${lib.concatMapStrings (p: ''
      ln -s ${p} $out/pack/nix/opt/${pluginName p}
    '') plugins}

    runHook postInstall
  '';

  # Expose for downstream inspection / testing
  passthru = { inherit plugins pluginName; };

  meta.description = "Neovim opt-pack: plugins symlinked for manual RTP management";
}
```

---

## Wiring it in (home-manager example)

```nix
{ config, pkgs, lib, ... }:

let
  makeOptPack = pkgs.callPackage ./neovim-plugin-pack.nix {};

  myPlugins = with pkgs.vimPlugins; [
    telescope-nvim
    nvim-treesitter
    nvim-cmp
    # your custom plugin-xyz derivations go here too
  ];

  optPack = makeOptPack myPlugins;
in
{
  programs.neovim = {
    enable = true;
    # Add the pack derivation to the packpath — NOT extraPlugins,
    # which would place them in 'start/' and auto-source them.
    extraLuaConfig = ''
      vim.opt.packpath:append("${optPack}")
    '';
  };
}
```

---

## Lua: RTP without sourcing

Drop this early in your `init.lua` (before any `require` calls that depend on the plugins):

```lua
-- Add all opt/ plugins to runtimepath WITHOUT sourcing them.
-- packadd() would source plugin/ files; this doesn't.
local function add_opt_plugins_to_rtp()
  for _, dir in ipairs(vim.fn.globpath(vim.o.packpath, "pack/*/opt/*", 0, 1)) do
    -- prepend so user config takes precedence over plugin runtime files
    vim.opt.rtp:append(dir)
    -- also pick up after/ directories
    local after = dir .. "/after"
    if vim.fn.isdirectory(after) == 1 then
      vim.opt.rtp:append(after)
    end
  end
end

add_opt_plugins_to_rtp()
```

After this runs:
- `require('telescope')` → works ✓  
- `plugin/telescope.lua` → **not sourced** ✓  
- `ftplugin/`, `syntax/`, `autoload/` → available via normal RTP lookup ✓

---

## Why this works for both Lua and Vimscript

There's no structural difference in the derivation — both kinds of plugins are just directory trees. The distinction only matters at *load time*:

| Mechanism | Effect |
|---|---|
| `pack/*/start/` | Added to RTP **and** `plugin/` sourced automatically |
| `pack/*/opt/` + `:packadd` | Added to RTP **and** `plugin/` sourced on demand |
| `pack/*/opt/` + manual `rtp:append` | Added to RTP only — **nothing sourced** |

The third row is what this setup gives you. You stay in full control: `require()` a lua plugin when you're ready, call `vim.cmd.runtime('plugin/foo.vim')` for a vimscript one if/when needed, or load lazily based on events — all without any auto-sourcing magic.

{pkgs}: with pkgs; []


/*

For runtime tools that a *wrapped executable* needs on its `PATH`, the idiomatic pattern is `makeWrapper`:

```nix
pkgs.stdenv.mkDerivation {
  name = "my-neovim";
  nativeBuildInputs = [ pkgs.makeWrapper ];

  installPhase = ''
    mkdir -p $out/bin
    makeWrapper ${pkgs.neovim}/bin/nvim $out/bin/nvim \
      --prefix PATH : ${lib.makeBinPath [
        pkgs.rust-analyzer
        pkgs.lua-language-server
        pkgs.nodePackages.typescript-language-server
      ]}
  '';
}
```

`--prefix PATH :` prepends those `bin/` directories to `PATH` *at runtime* when the wrapper is invoked, without polluting the system PATH otherwise.

In practice for Neovim specifically, `nixpkgs` already has this built in:

```nix
pkgs.neovim.override {
  extraPackages = [ pkgs.rust-analyzer pkgs.lua-language-server ];
}
```

which does the `makeWrapper` dance for you. Home-manager's `programs.neovim.extraPackages` does the same thing one level up.

---

So the mental model is:

| Dependency type | Attribute |
|---|---|
| Build-time tool (runs during build) | `nativeBuildInputs` |
| Linked library (headers, `.so`) | `buildInputs` |
| Linked library re-exported to consumers | `propagatedBuildInputs` |
| Runtime tool (needs to be on PATH when output runs) | `makeWrapper --prefix PATH` |

*/
As of Neovim 0.10+, the core Treesitter functionality was moved into the editor itself. By **0.12 (spring 2026)**, the built-in `vim.treesitter` API is mature, stable, and covers parser management, syntax highlighting, indentation, folding, and query handling. You can safely drop `nvim-treesitter` for baseline usage.

Here’s how to configure Treesitter using **only built-in APIs** in Neovim 0.12:

### 🔹 1. Parser Management (Built-in)
Neovim now ships with first-class parser management commands:
```vim
:TSInstall <lang>      " Download & compile a parser
:TSUninstall <lang>    " Remove a parser
:TSUpdate              " Update all installed parsers
:TSInstallInfo         " List installed/available parsers
```
Parsers are stored in `stdpath("data")/treesitter` by default. No plugin required.

> 💡 **Note**: You still need `git` and a C compiler (e.g., `gcc` or `clang`) for on-the-fly compilation.

### 🔹 2. Enable Core Features
Syntax highlighting is **automatically enabled** when a parser is installed. Indentation and folding require explicit `vim.opt` settings:

```lua
-- Folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- Indentation
vim.opt.indentexpr = "v:lua.vim.treesitter.indent()"

-- Optional: Disable auto-highlighting for specific filetypes
-- vim.g.treesitter_filetype_exclude = { "markdown", "txt" }
```

To manually toggle highlighting at runtime:
```vim
:TSEnable highlight
:TSDisable highlight
```

### 🔹 3. Language Aliases & Filetype Mapping
If your filetype doesn't match the parser name (e.g., `cuda` → `cpp`, `templ` → `go`), register aliases natively:

```lua
-- Map filetype alias to actual parser
vim.treesitter.language.register("cpp", "cuda")
vim.treesitter.language.register("javascript", "jsx")
vim.treesitter.language.register("typescript", "tsx")
```

### 🔹 4. Custom Queries (Built-in)
You can inject or override queries without external plugins:

**Option A: Runtime directory (recommended)**
Place `.scm` files in `~/.config/nvim/queries/<lang>/`:
```
~/.config/nvim/queries/python/highlights.scm
~/.config/nvim/queries/python/injections.scm
```

**Option B: Programmatic injection**
```lua
vim.treesitter.query.add("python", "highlights", [[
  (function_definition
    name: (identifier) @function.def)
]])
```

### 📦 Complete `init.lua` Example (0.12 Native)
```lua
-- Enable Treesitter-powered features
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.indentexpr = "v:lua.vim.treesitter.indent()"

-- Register filetype aliases
vim.treesitter.language.register("cpp", "cuda")
vim.treesitter.language.register("javascript", "jsx")

-- Optional: Auto-install parsers on first run (custom helper)
local parsers_to_ensure = { "c", "lua", "python", "javascript", "typescript", "bash", "json" }
for _, lang in ipairs(parsers_to_ensure) do
  if not vim.treesitter.language.is_installed(lang) then
    vim.cmd.TSInstall(lang)
  end
end
```

### 🔄 Migration Checklist (from `nvim-treesitter`)
| Legacy Plugin Config | Built-in 0.12 Equivalent |
|----------------------|--------------------------|
| `require'nvim-treesitter.configs'.setup({})` | Remove entirely. Use `vim.treesitter.*` APIs |
| `ensure_installed = {...}` | Use `:TSInstall` or custom Lua loop (see above) |
| `highlight.enable = true` | Automatic when parser exists |
| `indent.enable = true` | `vim.opt.indentexpr = "v:lua.vim.treesitter.indent()"` |
| `fold.enable = true` | `vim.opt.foldmethod = "expr"` + `foldexpr` |
| `query.set_query(lang, name, str)` | `vim.treesitter.query.add(lang, name, str)` |
| `language.register_alias()` | `vim.treesitter.language.register()` |

### 🔍 Verification & Debugging
```vim
:checkhealth treesitter   " Official health check
:TSInstallInfo            " See parser status
:verbose set indentexpr?  " Confirm Treesitter indentation is active
```
Run `:help treesitter` in Neovim 0.12 for the latest official documentation on `vim.treesitter` APIs.

### ⚠️ When You Might Still Need Plugins
The built-in API covers **parsing, highlighting, indentation, folding, and queries**. Advanced features like:
- Textobjects (`nvim-treesitter-textobjects`)
- Incremental selection
- Auto-tag closing / refactor support
still rely on community plugins or external modules. If you only need core syntax/indent/fold support, the built-in API is fully sufficient in 0.12.

Let me know if you need help migrating specific `nvim-treesitter` features to native APIs or writing custom injection/query patterns!




There's a lot to unpack here — Neovim 0.12 landed on March 29, 2026, and the situation has shifted dramatically since then.

---

### The elephant in the room: nvim-treesitter was archived

nvim-treesitter was officially archived on April 3, 2026, just five days after 0.12 shipped. The archival stemmed from maintainer burnout caused by user behavior in the repository. The repo is now read-only. Discussions are currently underway within the Neovim core regarding restructuring the role of nvim-treesitter — a configuration with separated responsibilities is being considered, starting with a limited scope covering a small number of languages, and potentially extending to accept a wider range of languages similar to nvim-lspconfig.

The practical upshot: **more features have moved to Neovim's built-in API**, and the remaining gap (parser installation) needs to be filled differently.

---

### What 0.12 now provides built-in (no plugin needed)

**Highlighting**

Treesitter highlighting is provided by Neovim. To enable it for a filetype, put `vim.treesitter.start()` in a `ftplugin/<filetype>.lua` in your config directory, or place the following in your `init.lua`:

```lua
vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    pcall(vim.treesitter.start)  -- pcall: silently skips if no parser
  end,
})
```

That's it. No `require('nvim-treesitter.configs').setup(...)` needed.

**Folding**

Treesitter-based folding is provided by Neovim. To enable it, put the following in your `ftplugin` or `FileType` autocommand:

```lua
vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    vim.wo[0][0].foldmethod = 'expr'
    vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
  end,
})
```

**Incremental node selection**

`v_an`, `v_in`, `v_]n`, `v_[n` now provide incremental selection of treesitter nodes. This was previously only available via nvim-treesitter's `incremental_selection` module. No config needed.

**Markdown**

Treesitter-based Markdown highlighting is enabled by default. You don't need to do anything for `.md` files.

**Safer parser API**

`vim.treesitter.get_parser()` no longer throws on failure — it now returns `nil` when it cannot create a parser. Any code you had with `pcall(vim.treesitter.get_parser, ...)` can be simplified.

---

### What is NOT built-in

**Parser installation** — Neovim bundles a few parsers (C, Lua, Markdown, Vim, Vimdoc) but Neovim 0.12 integrated Tree-sitter into the core but still lacks a built-in parser installer.

**TS-based indentation** — This was always a nvim-treesitter feature, not core. There's no `vim.treesitter.indent()` equivalent yet. You either skip it (use `cindent`/`smartindent` per filetype) or use a plugin.

---

### Your situation: Nix/NixVim

This is actually where **Nix has a significant advantage**. In a Nix derivation, parsers are compiled as Nix packages and dropped into `runtimepath` — no runtime compilation, no `tree-sitter-cli` dependency, no `:TSInstall`. Parser management is fully declarative. So the main thing you need to handle is just **activating** the built-in features, not installing parsers.

If you're using nixvim, parsers are declared like:

```nix
programs.nixvim = {
  plugins.treesitter = {
    enable = true;
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      python rust lua markdown
      # ...
    ];
  };
};
```

Or if you're managing neovim manually in Nix, parsers like `pkgs.tree-sitter-grammars.tree-sitter-python` are `.so` files that get placed into the right `parser/` directory on runtimepath.

---

### Breaking changes to be aware of

**`Query:iter_matches()` `"all"` option removed**

The `"all"` option to `Query:iter_matches()`, which was introduced in Nvim 0.11 to aid in transitioning to the new behavior, has been removed. If you have any custom query code using that, update it.

**`treesitter-directive-offset!` metadata change**

The `treesitter-directive-offset!` directive no longer sets `metadata[capture_id].range`; it instead sets `metadata[capture_id].offset`. The offset will be applied in `vim.treesitter.get_range()`, which should be preferred over reading metadata directly for retrieving node ranges.

---

### Summary of what to change

| Before (old nvim-treesitter) | After (0.12 built-in) |
|---|---|
| `configs.setup({ highlight = { enable = true } })` | `FileType` autocmd calling `vim.treesitter.start()` |
| `configs.setup({ fold = { enable = true } })` | `FileType` autocmd setting `foldmethod`/`foldexpr` |
| `incremental_selection` module | Built-in `v_an`, `v_in`, `v_]n`, `v_[n` |
| `:TSInstall` | Nix packages / `tree-sitter-manager.nvim` |
| `ensure_installed = { ... }` | Nix grammar declarations |
| `pcall(vim.treesitter.get_parser, ...)` | Direct call, check for `nil` return |





To migrate your **Neovim Treesitter** configuration for version **0.12** (spring 2026) and rely on the **built-in Treesitter API** as much as possible, follow this approach. Neovim 0.12 significantly expands core Treesitter support, including bundled parsers for many common languages, default **Markdown** highlighting, and native incremental selection commands.

### 1. Understand the Big Changes
- **nvim-treesitter** plugin (the old popular one) has its `master` branch archived/frozen. A rewritten version lives on the `main` branch, but it's now more limited and focuses mainly on parser management + queries. The old `require('nvim-treesitter.configs').setup()` API is deprecated/removed in the new version.
- Neovim core now handles **highlighting**, **injections**, **folding**, and more out of the box for bundled languages.
- **Highlighting** is enabled by default for languages with bundled parsers (including Markdown).
- Parser installation is no longer fully bundled; you need the `tree-sitter` CLI for compilation in most setups.
- Many advanced modules (indent, textobjects, refactor, etc.) from the old plugin either moved, were removed, or require manual setup with core APIs.

Goal: Minimize or eliminate the plugin dependency where possible.

### 2. Minimal Setup (Recommended: Use Built-in as Much as Possible)
If your languages are covered by Neovim's bundled parsers, you can often **delete most of your old Treesitter config**.

```lua
-- No setup block needed for basic highlighting!
-- It just works for bundled languages.

-- Optional: Ensure additional parsers (if not bundled)
-- You can do this manually or with a lightweight helper.

-- Example: Install parsers on demand or at startup
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "rust", "go", "python" },  -- add your languages
  callback = function()
    if not vim.treesitter.language.get_lang(vim.bo.filetype) then
      -- Or use a plugin/helper for installation
      vim.cmd("TSInstall " .. vim.bo.filetype)
    end
  end,
})
```

**Check bundled parsers**: Run `:help treesitter` or inspect `runtime/parser/` directory. Common ones like **Lua**, **C**, **Markdown**, **Vimscript**, etc., are included.

**Install the tree-sitter CLI** (required for compiling new parsers):
- On most systems: `sudo apt install tree-sitter` / `brew install tree-sitter` / etc. (use version ~0.26+; **not** the npm version).

### 3. If You Still Need Parser Management (nvim-treesitter on `main`)
Update your plugin spec (example with **lazy.nvim**):

```lua
{
  "nvim-treesitter/nvim-treesitter",
  branch = "main",  -- Critical! Old master is frozen.
  build = ":TSUpdate",  -- Or run :TSUpdate manually after changes
  lazy = false,  -- Or true with event = "VeryLazy"
  config = function()
    require("nvim-treesitter").setup({
      -- Much simpler now; many old options removed
      ensure_installed = { "lua", "vim", "vimdoc", "markdown", "python", "rust" },  -- or "all"
      -- highlight = { enable = true }  -- default in core, often unnecessary
      -- indent = { enable = true }     -- may still work if supported
    })
  end,
}
```

- The new plugin's `setup()` is called on the top-level module (`require("nvim-treesitter")`), **not** `nvim-treesitter.configs`.
- After updating, run `:TSUpdate` and check `:checkhealth`.
- Many old features (e.g., advanced textobjects, context, refactor) were intentionally dropped or moved to separate plugins. Replace them with core alternatives where possible.

### 4. Leverage Built-in Treesitter APIs Directly
Instead of plugin configs, use core functions for more control and fewer dependencies:

- **Start highlighting manually** (rarely needed, but useful for custom buffers):
  ```lua
  vim.treesitter.start(0, "lua")  -- 0 = current buffer
  ```

- **Safe parser handling** (breaking change in 0.12):
  ```lua
  local parser = vim.treesitter.get_parser(0)  -- buf nr, or nil if fails
  if parser then
    -- do something with parser
  end
  ```
  (It no longer errors on failure; returns `nil`.)

- **Incremental selection** (new in 0.12, no plugin needed):
  - `van` / `vin` → select outer/inner node
  - `v]n` / `v[n` → next/previous sibling
  - Map these in visual mode if desired.

- **Custom queries**: Place them in `after/queries/{lang}/highlights.scm` (or injections, folds, etc.) in your config. Core loads them automatically.

- **Other core APIs**:
  - `vim.treesitter.query.parse(lang, query_string)`
  - `vim.treesitter.get_range(node)`
  - Language registration: `vim.treesitter.language.register("lang", "filetype")`

For folding, use `foldexpr = "v:lua.vim.treesitter.foldexpr()"` or similar.

### 5. Common Migrations from Old Config
| Old (pre-0.12 / master)              | New (0.12 built-in / main)                          |
|--------------------------------------|-----------------------------------------------------|
| `require('nvim-treesitter.configs').setup(...)` | Delete or use minimal `require("nvim-treesitter").setup` |
| `highlight = { enable = true }`     | Usually default; remove |
| `indent = { enable = true }`        | Check if still supported in new plugin; otherwise manual |
| `textobjects` / `refactor`          | Use core `an`/`in` or separate plugins |
| `:TSInstall` / `ensure_installed`   | Still works via plugin on `main`, or manual |
| Old queries location                | Still in `queries/` but prefer runtime/after/ |

### 6. Tips & Troubleshooting
- Run `:checkhealth` after changes — it will flag Treesitter issues.
- If you see errors like "attempt to call method 'range' (a nil value)", you're likely on the old `master` branch — switch to `main` and reinstall the plugin.
- For very custom setups, consider lightweight alternatives like `tree-sitter-manager.nvim` instead of the full nvim-treesitter.
- Test in a clean config first (`nvim --clean` or minimal init.lua).
- Read official docs: `:help treesitter` and `:help news-0.12`.

This shift makes Neovim more "batteries-included" for Treesitter. Start by removing your old `configs.setup()` block entirely — highlighting will likely just work better out of the box. Add back only what you truly need via core APIs or the slimmed-down plugin.

If you share your current Treesitter config snippet, I can give a more precise diff.






Yes, you **can remove** (or disable) the `:TSInstall` command.

Here’s exactly how to do it cleanly in Neovim 0.12, depending on your setup.

### 1. Best Option: Don’t Load the Installation Commands at All

If you handle parser installation completely outside of Neovim (e.g. with a Makefile, script, Nix, or manually placing `.so` files), the cleanest solution is to **avoid loading the parts of `nvim-treesitter` that register the `TS*` commands**.

With **lazy.nvim**, do this:

```lua
{
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = true,                    -- Important: lazy-load it
  cmd = { "TSUpdate", "TSUninstall" },  -- Only load for the commands you still want
  -- Do NOT include "TSInstall" here
  config = function()
    require("nvim-treesitter").setup({
      -- your minimal config
    })
  end,
}
```

By omitting `"TSInstall"` (and possibly `"TSInstallFromGrammar"`, `"TSInstallSync"`, etc.) from the `cmd` table, the command will never be registered.

### 2. Delete the Command After It’s Created

If you prefer to keep the plugin loaded normally, you can explicitly delete the command after Neovim starts:

```lua
-- Put this in your config after the plugin is loaded (e.g. in the plugin's config function)
vim.api.nvim_del_user_command("TSInstall")
vim.api.nvim_del_user_command("TSInstallSync")      -- if it exists
vim.api.nvim_del_user_command("TSInstallFromGrammar")
```

You can also delete the whole family if you want:

```lua
for _, cmd in ipairs({ "TSInstall", "TSInstallSync", "TSInstallFromGrammar" }) do
  pcall(vim.api.nvim_del_user_command, cmd)
end
```

`pcall` prevents errors if the command doesn’t exist.

### 3. Alternative: Override with a No-op Command

If you want the command to still exist but do nothing (so muscle memory doesn’t break):

```lua
vim.api.nvim_create_user_command("TSInstall", function()
  vim.notify("TSInstall is disabled. Manage parsers externally.", vim.log.levels.WARN)
end, { nargs = "*", complete = function() return {} end })
```

### Recommended Approach for Your Goal

Since you want to manage parsers **outside** Neovim, I suggest this combination:

1. Use `lazy = true` + a restricted `cmd` table (only `TSUpdate` and `TSUninstall` if you still need them).
2. Or fully remove the plugin dependency for installation and only keep `nvim-treesitter` if you need its other utilities (queries, parser info, etc.).
3. Manually place compiled parsers in `~/.local/share/nvim/site/parser/` (or any directory in `runtimepath`).

Neovim will automatically pick up any `parser/*.so` (or `*.dll` / `*.dylib`) it finds in the runtime path.

Would you like me to show you a full minimal plugin spec that completely avoids installing parsers through Neovim while still benefiting from the rest of the Treesitter ecosystem? Just paste your current `nvim-treesitter` spec and I’ll give you the exact replacement.

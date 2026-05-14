print("Entering after_init.lua.")

utils.printv("CONFIG_DIR: " .. CONFIG_DIR)
utils.printv("PLUGINS INCLUDED: " .. vim.inspect(utils.PLUGINS_INCLUDED))
utils.printbv(#utils.PLUGINS_INCLUDED .. " plugins included")

if HAS_NIX then 
  vim.opt.runtimepath:remove("/home/isaac/.local/share/nvim/site")
end

local setup_plugin = utils.setup_plugin
local packadd = utils.packadd
local map = utils.map

-- utils.printbv(#utils.PLUGINS_INCLUDED .. " plugins included")

utils.setup_plugin_default("telescope", function(telescope)
    telescope.setup({
        extensions = {
            fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                            -- the default case_mode is "smart_case"
            }
        }
    })
    telescope.load_extension('fzf')
    print("loaded telescope with fzf-native")
end)

if false then  --=============

setup_plugin("plenary")
setup_plugin("nio")
setup_plugin("nvim-web-devicons")

setup_plugin("bamboo", function(bamboo)
	(bamboo.setup)({
		style = "multiplex",
		colors = {
			bg0 = "#020802",
		},
	});
	(bamboo.load)()
	utils.printbv("Set up bamboo")
end)
setup_plugin("zen-mode")
setup_plugin("lualine")
setup_plugin("nvim-navic")
setup_plugin("bufferline")
setup_plugin("statuscol")

setup_plugin("treesitter-modules")
setup_plugin("dropbar")
utils.packadd("nvim-navbuddy")
setup_plugin("aerial")

setup_plugin("oil")
setup_plugin("yazi")
setup_plugin("neo-tree")
setup_plugin("nvim-tree")

setup_plugin("pickme")
-- setup_plugin("telescope") MOVED

setup_plugin("fzf-lua")
setup_plugin("deck")

setup_plugin("mini.indent")
setup_plugin("mini.keymap")
setup_plugin("mini.sessions")

setup_plugin("snacks")
setup_plugin("blink")

setup_plugin("hlslens")
setup_plugin("hlsearch")

setup_plugin("grug-far")
setup_plugin("spectre")

setup_plugin("flybuf")
setup_plugin("stickybuf")
setup_plugin("swm", function(swm)
	map("n", "<C-w>h", swm.h)
	map("n", "<C-w>j", swm.j)
	map("n", "<C-w>k", swm.k)
	map("n", "<C-w>l", swm.l)
end)

setup_plugin("smart-splits")

setup_plugin("ufo")

setup_plugin("NeoComposer")
setup_plugin("nvim-macros", {
	json_file_path = "./macros.json",
	default_macro_register = "a",
	json_formatter = "jq",
})
setup_plugin("recorder")

utils.packadd("vim-visual-multi")

setup_plugin("leap")
setup_plugin("flash")
setup_plugin("hop")

setup_plugin("rainbow-delimiters")
setup_plugin("nvim-autopairs")

utils.packadd("vim-sandwich")

setup_plugin("nvim-surround")

utils.packadd("vim-mundo")

setup_plugin("mini.keymap")
setup_plugin("hydra")
setup_plugin("insx")
setup_plugin("which-key")

setup_plugin("indentmini")
utils.packadd("indent-blankline")
setup_plugin("nvim-anydent")
setup_plugin("mini.align")
utils.packadd("tabular")

setup_plugin("nvim-treesitter-textobjects")
utils.packadd("nvim-various-textobjs")

setup_plugin("Comment")
setup_plugin("todo-comments")
utils.packadd("vim-commentary")

setup_plugin("treesj")
setup_plugin("dial")
setup_plugin("harpoon-core")
setup_plugin("marks")
setup_plugin("markit")

setup_plugin("nvim-pasta")

setup_plugin("beam")

setup_plugin("blink.cmp")
setup_plugin("nvim-cmp")

setup_plugin("friendly-snippets")
setup_plugin("ultisnips")
setup_plugin("LuaSnip")

setup_plugin("cmp-nvim-lsp")
setup_plugin("cmp-buffer")
setup_plugin("cmp-path")
setup_plugin("cmp-cmdline")

setup_plugin("lsp-format")
setup_plugin("lspkind")

setup_plugin("lspsaga")

setup_plugin("lazydev")
setup_plugin("rustaceanvim")
setup_plugin("crates")
setup_plugin("haskell-tools")

setup_plugin("none-ls")

setup_plugin("guard")
setup_plugin("conform")

setup_plugin("asyncrun")
setup_plugin("neotest-haskell")
setup_plugin("neotest-python")
setup_plugin("neotest")
setup_plugin("dap-python", function(dap_python)
	(dap_python.setup)("debugpy-adapter")
	dap_python.test_runner = "pytest"
	map("n", "<leader>tt", function()
		print("Leader is working!")
	end)
	map("n", "<leader>pp", function()
		print("This works")
	end)
	map("n", "<leader>dn", dap_python.test_method)
	map("n", "<leader>df", dap_python.test_class)
	map("v", "<leader>ds", dap_python.debug_selection)
end)
setup_plugin("dapui")
setup_plugin("nvim-dap-virtual-text")
setup_plugin("dap")
setup_plugin("mypy")
setup_plugin("nvim-lint")

setup_plugin("trouble.nvim")
setup_plugin("quicker")
setup_plugin("nvim-bqf")

setup_plugin("vim-floaterm")
setup_plugin("toggleterm")

setup_plugin("overseer")

setup_plugin("refactoring")

setup_plugin("project")
setup_plugin("telescope-project")

setup_plugin("jj")
setup_plugin("jujutsu")
setup_plugin("lazygit")
setup_plugin("git-conflict")
setup_plugin("neogit")
setup_plugin("jiejie")
setup_plugin("diffview")
setup_plugin("gitsigns")
setup_plugin("vim-fugitive")

setup_plugin("octo")
setup_plugin("gitlab-nvim")
setup_plugin("gitlab")

setup_plugin("dashboard-nvim")
setup_plugin("dashboard")
setup_plugin("noice")
setup_plugin("modes")

setup_plugin("fidget")
setup_plugin("nvim-notify")
setup_plugin("headlines")

setup_plugin("auto-session")
setup_plugin("persistence")

utils.packadd("vimtex", function()
	vim.g.vimtex_view_method = "zathura"
end)
setup_plugin("texmagic")
setup_plugin("schemastore")
setup_plugin("firenvim")
setup_plugin("render-markdown")
setup_plugin("jupytext")
setup_plugin("quarto")
setup_plugin("markdown-preview")

setup_plugin("structlog")
setup_plugin("neorepl")

end

utils.setup_plugin("xit")

vim.treesitter.language.register("py", "python")

vim.filetype.add({
  extension = { xit = "xit" },
})
vim.treesitter.language.register("xit", "xit")
vim.api.nvim_create_autocmd("FileType", {
  pattern = "xit",
  callback = function(ev)
    print("executing xit callback")
    vim.treesitter.language.add('xit', { path = PARSER_DIR .. "/xit.so" })
    vim.treesitter.start(ev.buf, "xit")
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    vim.treesitter.start()
  end,
})
-- print(vim.o.runtimepath:find(vim.env.VIMRUNTIME) ~= nil)

-- print(vim.inspect(vim.opt.runtimepath))


-- setup_plugin("nvim-treesitter", function(treesitter)
-- 	local TS_LANGUAGES = {
-- 		"haskell",
-- 		"javascript",
-- 		"json",
-- 		"lua",
-- 		"markdown",
-- 		"nix",
-- 		"python",
-- 		"rust",
-- 		"toml",
-- 		"typescript",
-- 		"yaml",
-- 		"zig",
-- 	}

-- 	utils.printbv("Setting up treesitter.")
-- 	local my_install_dir = (not HAS_NIX) and ((vim.fn.stdpath("data")) .. "/site") or DERIVATION_DIR
-- 	utils.printv(my_install_dir)
-- 	local my_parser_install_dir = (not HAS_NIX) and (vim.fn.stdpath("data")) .. "/site/parsers" or nil
-- 	utils.printv(my_parser_install_dir)
-- 	local my_ensure_installed = HAS_NIX and {} or TS_LANGUAGES
-- 	utils.printv(vim.inspect(my_ensure_installed))

-- 	utils.printbv("Treesitter exists")
-- 	(treesitter.setup)({
-- 		install_dir = my_install_dir,
-- 		parser_install_dir = my_parser_install_dir,
-- 		ensure_installed = my_ensure_installed,
-- 		highlight = { enable = true },
-- 		indent = { enable = true },
-- 	})
-- end)



local my_install_dir = (not HAS_NIX) and ((vim.fn.stdpath("data")) .. "/site") or DERIVATION_DIR

local my_parser_install_dir = my_install_dir .. "/parser"
-- (not HAS_NIX) and (vim.fn.stdpath("data")) .. "/site/parsers" or DERIVATION_DIR .. 

local my_ensure_installed = HAS_NIX and {} or TS_LANGUAGES

utils.printb("Setting up treesitter.")
utils.printb(my_install_dir)
utils.printb(my_parser_install_dir)
utils.printb(vim.inspect(my_ensure_installed))

-- vim.treesitter.setup(
--     {
-- 		install_dir = my_install_dir,
-- 		parser_install_dir = my_parser_install_dir,
-- 		ensure_installed = my_ensure_installed,
-- 		highlight = { enable = true },
-- 		indent = { enable = true },
-- 	}
-- )

parser_root = vim.fn.fnamemodify(OPT_DIR, ":h:h:h")
vim.opt.runtimepath:prepend(PARSER_DIR)

vim.opt.runtimepath:prepend("/nix/store/ydlwparyk4mxl6wzhlp3x54zl3nk82c5-pde")

vim.opt.runtimepath:remove("/home/isaac/.local/share/nvim/site")


setup_plugin("dial")


-- debug.getinfo(2, "S").source:sub(2):match("(.*/)") or "./"


--[[

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
] <> ])
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



# TASK_RUNNERS.md

The "state-of-the-art" in Neovim task running has shifted away from simple shell wrappers toward **asynchronous, UI-rich engines** that can parse project-specific files (like `Taskfile.yml` or `justfile`) and present them in searchable menus.

As of 2026, there are three primary contenders, each with a different philosophy.

---

### 1. Overseer.nvim (The Heavyweight)

**Overseer** is currently considered the most powerful and extensible task runner. It doesn't just run commands; it manages them as a life-cycle, complete with status icons, output buffers, and a searchable sidebar.

* **Logic:** It uses "Templates" to detect tasks.
* **Compatibility:** It has built-in or community templates for almost everything.
* **Just/Taskfile:** You can easily define a provider that parses your `justfile` or `Taskfile.yml` and populates the Overseer menu.

```lua
-- Example: Using Overseer to trigger a Just task
require('overseer').setup({
  templates = { "builtin", "my_custom_just_provider" },
})

```

### 2. Neotest (The Logic-Engine)

While primarily a testing framework, **Neotest** is the state-of-the-art for anything that requires a "tree" view of executable items. If your "tasks" are actually granular build steps or tests, Neotest is more precise than a general task runner.

### 3. Sky.nvim / Toggleterm (The "Workflow" Runners)

If you prefer a more "terminal-first" approach, many power users combine **Toggleterm.lua** with a custom picker (like Telescope) to trigger tasks.

---

### Compatibility with Taskfile and Just

Since **Just** and **Taskfile** are CLI-first, Neovim plugins usually interface with them in one of two ways:

#### A. The "Steptest / Neotest" Approach

There are specific adapters for Neotest and Overseer that parse your `justfile` or `Taskfile.yml`.

* **[just.nvim]():** A dedicated plugin for `just` that provides a Telescope picker for your just tasks.
* **[Task.nvim]():** A structured task runner that plays well with external YAML-based task definitions.

#### B. The Telescope/Fzf-lua Integration (Fastest)

The most common "pro" setup is to use **Telescope** to parse the output of `just --list` or `task --list-all` and execute the selection in a floating terminal.

**Example: A "State-of-the-art" Just Picker in Lua**

```lua
local function run_just_task()
    local opts = {}
    -- Use vim.system to get just tasks as a table
    local obj = vim.system({"just", "--summary"}, { text = true }):wait()
    local tasks = vim.split(obj.stdout, " ")

    vim.ui.select(tasks, { prompt = "Run Just Task:" }, function(choice)
        if choice then
            -- Run in a floating terminal (using toggleterm or built-in)
            vim.cmd("TermExec cmd='just " .. choice .. "'")
        end
    end)
end

```

---

### Comparison Table

| Plugin | Complexity | Best For | Compatibility |
| --- | --- | --- | --- |
| **Overseer.nvim** | High | Complex build pipelines, background tasks. | Excellent (via templates) |
| **just.nvim** | Low | Dedicated `just` users. | Native `just` |
| **Toggleterm** | Medium | Simple shell scripts, interactive tasks. | Manual |
| **Resession.nvim** | Medium | Saving task states across sessions. | Generic |

---

### Recommendation

If you want the "all-in-one" powerful experience: Go with **Overseer.nvim**. It is the only one that feels like a modern IDE's task runner (like VS Code's `tasks.json`) but with the extensibility of Neovim.

**Would you like me to help you write a custom Overseer template that automatically detects a `justfile` and lists the tasks in your project?**


Integrating **Taskfile** (go-task) into Neovim as a state-of-the-art workflow typically involves using **Overseer.nvim** as the engine. It provides the background process management, while a custom template handles the parsing of your `Taskfile.yml`.

### 1. The Strategy: The Overseer Template

The most powerful way to do this is to define an Overseer "provider." This script will:

1. Check if a `Taskfile.yml` or `Taskfile.yaml` exists in the project root.
2. Run `task --list-all --json` to get the tasks.
3. Expose them to the Overseer `TaskLauncher`.

### 2. The Implementation (Lua)

Add this to your configuration (or a separate `lua/plugins/tasks.lua` file). This uses the `vim.system` API we discussed to fetch tasks asynchronously.

```lua
local overseer = require("overseer")

overseer.register_template({
  name = "Taskfile Runner",
  generator = function(opts, cb)
    -- 1. Check for Taskfile
    local taskfile = vim.fs.find({ "Taskfile.yml", "Taskfile.yaml" }, { upward = true, path = opts.dir })[1]
    if not taskfile then
      cb({})
      return
    end

    -- 2. Fetch tasks via CLI
    vim.system({ "task", "--list-all", "--json" }, { text = true }, function(obj)
      if obj.code ~= 0 then
        cb({})
        return
      end

      local data = vim.json.decode(obj.stdout)
      local tasks = {}

      -- 3. Map JSON tasks to Overseer format
      for _, task in ipairs(data.tasks or {}) do
        table.insert(tasks, overseer.wrap_template({
          name = task.name,
          desc = task.desc or "Taskfile task",
          params = {},
          builder = function()
            return {
              cmd = { "task" },
              args = { task.name },
              components = { "default", "on_result_diagnostics" },
            }
          end,
        }, { name = task.name }))
      end

      cb(tasks)
    end)
  end,
  condition = {
    callback = function(opts)
      return vim.fs.find({ "Taskfile.yml", "Taskfile.yaml" }, { upward = true, path = opts.dir })[1] ~= nil
    end,
  },
})

```

---

### 3. Usage & Workflow

Once this is registered, your workflow becomes very streamlined:

* **Run a Task:** Call `:OverseerRun`. You will see all tasks from your `Taskfile.yml` listed.
* **Monitor:** Open `:OverseerToggle` to see a sidebar with running/failed/passed tasks.
* **Action:** You can restart, edit, or view logs for each task individually.

---

### 4. Alternative: The Telescope "Quick Pick"

If you don't need the full management features of Overseer and just want to trigger a task and see it in a terminal, you can use a simple **Telescope** picker. This is much "lighter" and requires less setup.

```lua
local function taskfile_picker()
    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local conf = require("telescope.config").values
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")

    -- Get tasks from Taskfile
    local handle = io.popen("task --list-all --summary")
    local result = handle:read("*a")
    handle:close()

    local tasks = {}
    for line in result:gmatch("[^\r\n]+") do
        local name = line:match("^%* ([%w%-_]+):")
        if name then table.insert(tasks, name) end
    end

    pickers.new({}, {
        prompt_title = "Taskfile Tasks",
        finder = finders.new_table({ results = tasks }),
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                -- Execute in a terminal
                vim.cmd("split | term task " .. selection[1])
            end)
            return true
        end,
    }):find()
end

vim.keymap.set("n", "<leader>tk", taskfile_picker, { desc = "Pick Taskfile task" })

```

### Why this is "State-of-the-Art"

* **JSON Integration:** Using `task --json` ensures that even if task names have spaces or complex characters, the parser won't break.
* **Non-blocking:** By using `vim.system` (callback-based), your UI remains fluid even if the `Taskfile` is massive.
* **Process Lifecycle:** Overseer handles the cleanup of processes, so you don't end up with "ghost" shell tasks if you close Neovim unexpectedly.

**Would you like me to refine the Overseer template to include "Task Parameters" (e.g., if you have a task that takes variable inputs)?**

To implement parameters for **Taskfile** tasks in **Overseer.nvim**, you need to define a `params` schema in the template. This allows Neovim to prompt you for input (like a version number, a filename, or a flag) before the task actually starts.

Since `go-task` handles variables using the `var=value` syntax (e.g., `task build VERSION=1.0.0`), we can map Overseer parameters directly to these CLI arguments.

### 1. The Parameterized Taskfile Template

Here is the updated template. I’ve added a logic block that checks if a task description contains specific keywords to trigger a parameter prompt, but you can also define them globally.

```lua
local overseer = require("overseer")

overseer.register_template({
  name = "Taskfile (with Params)",
  generator = function(opts, cb)
    local taskfile = vim.fs.find({ "Taskfile.yml", "Taskfile.yaml" }, { upward = true, path = opts.dir })[1]
    if not taskfile then return cb({}) end

    vim.system({ "task", "--list-all", "--json" }, { text = true }, function(obj)
      if obj.code ~= 0 then return cb({}) end
      local data = vim.json.decode(obj.stdout)
      local tasks = {}

      for _, task in ipairs(data.tasks or {}) do
        table.insert(tasks, overseer.wrap_template({
          name = task.name,
          desc = task.desc,
          -- Define parameters here
          params = {
            args = {
              type = "string",
              name = "Extra Arguments",
              desc = "Vars to pass (e.g. VERSION=1.0)",
              optional = true,
            },
          },
          builder = function(params)
            local cmd_args = { task.name }
            if params.args and params.args ~= "" then
              table.insert(cmd_args, params.args)
            end
            
            return {
              cmd = { "task" },
              args = cmd_args,
              components = { 
                "default", 
                { "display_duration", detail_level = 2 },
                "on_output_summarize",
                "on_exit_set_status" 
              },
            }
          end,
        }, { name = task.name }))
      end
      cb(tasks)
    end)
  end,
})

```

### 2. Why this is the "State-of-the-Art" workflow

Using Overseer this way provides a "Task Runner Console" experience similar to JetBrains or VS Code, but with Vim's speed.

* **Prompting:** When you select a task with `params`, Overseer opens a small floating window asking for the "Extra Arguments."
* **Status Tracking:** Instead of just a terminal scrolling by, you get a status line in your buffer or a side-panel showing exactly which tasks are running.
* **Components:** The `components` table in the builder allows you to add features like `on_result_diagnostics` which can automatically populate your **Quickfix list** if a Taskfile command (like a linter) fails.

---

### 3. Pro-Tip: Integrating with Neovim 0.12's `vim.ui.select`

If you want to keep your config "pure" without too many plugins, you can wrap the Taskfile logic in `vim.ui.select`. This uses the built-in system menu (or Telescope if you have `telescope-ui-select` installed).

```lua
local function run_task_with_ui()
  vim.system({"task", "--list-all", "--summary"}, {text = true}, function(obj)
    local tasks = {}
    for line in obj.stdout:gmatch("[^\r\n]+") do
      local name = line:match("^%* ([%w%-_]+):")
      if name then table.insert(tasks, name) end
    end

    vim.schedule(function()
      vim.ui.select(tasks, { prompt = "Execute Task:" }, function(choice)
        if not choice then return end
        -- Run in a background job or terminal
        vim.cmd("vsplit | term task " .. choice)
      end)
    end)
  end)
end

```

### Next Step

To make this really powerful, would you like me to show you how to add a **"Watcher"** component? This allows Neovim to automatically re-run a specific Taskfile task every time you save a `.py` or `.lua` file.

To implement a **Watcher** in Overseer, we leverage the plugin's "Components." This is what separates a basic script from a professional IDE-like task runner. By adding the `on_save_reload` component, you can keep a build or test task running in the background that reacts to your file changes.

### 1. The Watcher-Enabled Taskfile Template

This version of the template adds a `watch` parameter. If you toggle it to `true` when starting the task, Overseer will monitor your project directory and re-trigger the `task` command every time you save a file.

```lua
local overseer = require("overseer")

overseer.register_template({
  name = "Taskfile (with Watcher)",
  generator = function(opts, cb)
    local taskfile = vim.fs.find({ "Taskfile.yml", "Taskfile.yaml" }, { upward = true, path = opts.dir })[1]
    if not taskfile then return cb({}) end

    vim.system({ "task", "--list-all", "--json" }, { text = true }, function(obj)
      if obj.code ~= 0 then return cb({}) end
      local data = vim.json.decode(obj.stdout)
      local tasks = {}

      for _, task in ipairs(data.tasks or {}) do
        table.insert(tasks, overseer.wrap_template({
          name = task.name,
          desc = task.desc,
          params = {
            args = { type = "string", name = "Vars", optional = true },
            watch = { type = "boolean", name = "Watch files?", default = false },
          },
          builder = function(params)
            local cmd_args = { task.name }
            if params.args and params.args ~= "" then
              table.insert(cmd_args, params.args)
            end
            
            local components = { "default" }
            if params.watch then
              -- This component tells Overseer to restart the task on save
              table.insert(components, { "on_save_reload", delay = 500 })
            end

            return {
              cmd = { "task" },
              args = cmd_args,
              components = components,
            }
          end,
        }, { name = task.name }))
      end
      cb(tasks)
    end)
  end,
})

```

---

### 2. How the Watcher Works

Overseer doesn't just run a shell loop. It uses Neovim's internal **autocmd** system (`BufWritePost`) to detect when you've written to a buffer that belongs to the same project as the Taskfile.

1. **Selection:** You run `:OverseerRun`, pick a task, and set `Watch files?` to `true`.
2. **Execution:** The task runs once and stays in the Overseer list (usually marked with a "waiting" or "watching" icon).
3. **Trigger:** You edit a Python file and `:w`.
4. **Reaction:** Overseer immediately kills the previous process (if still running) and spawns a new one.

---

### 3. State-of-the-art UI: The Statusline

To make this workflow truly elite, you should display your task status in your statusline (e.g., Lualine). This way, you don't even have to open a side-panel to know if your background Taskfile command passed or failed.

**Example Lualine integration:**

```lua
require('lualine').setup({
  sections = {
    lualine_x = {
      {
        "overseer",
        label = 'Tasks: ', -- Prefix for the section
        unique = true,     -- Only show one representative icon per state
      }
    }
  }
})

```

### 4. Directing Output to the Quickfix List

If your Taskfile is running a compiler or a linter (like `ruff` or `pyright`), you can add the `on_result_diagnostics` component to the `builder` in the code above. This will parse the output and put errors directly into your **Quickfix list** (`:copen`), allowing you to jump straight to the broken line.

---

### One Final Caveat for Mac Users

Since you are on macOS, ensure you have `fswatch` installed (`brew install fswatch`). While Neovim has built-in file watching, some complex project structures work better with a dedicated library, and plugins like Overseer can hook into it for better performance.

**Would you like me to help you set up a custom "Diagnostic Provider" so that Taskfile errors show up as red squiggly lines directly in your code?**


To make Taskfile errors appear as **red squiggly lines (Diagnostics)** in your editor, we need to bridge the gap between the task's output and Neovim's internal `vim.diagnostic` engine.

In 2026, the most robust way to do this is using the **`on_result_diagnostics`** component in Overseer. This component uses an `errorformat` (a string that tells Neovim how to parse lines of text) to extract file paths, line numbers, and error messages.

### 1. The Diagnostic-Enabled Template

Update your `Taskfile` template to include an `errorformat`. Since you are working in Python, I'll use a standard Python error format, but you can change this depending on what your Taskfile runs (e.g., `ruff`, `flake8`, or `pytest`).

```lua
local overseer = require("overseer")

overseer.register_template({
  name = "Taskfile with Diagnostics",
  generator = function(opts, cb)
    local taskfile = vim.fs.find({ "Taskfile.yml", "Taskfile.yaml" }, { upward = true, path = opts.dir })[1]
    if not taskfile then return cb({}) end

    vim.system({ "task", "--list-all", "--json" }, { text = true }, function(obj)
      if obj.code ~= 0 then return cb({}) end
      local data = vim.json.decode(obj.stdout)
      local tasks = {}

      for _, task in ipairs(data.tasks or {}) do
        table.insert(tasks, overseer.wrap_template({
          name = task.name,
          params = {
            watch = { type = "boolean", name = "Watch files?", default = false },
          },
          builder = function(params)
            local components = { "default" }
            if params.watch then
              table.insert(components, { "on_save_reload", delay = 500 })
            end

            -- ADDED: This component parses the output into diagnostics
            table.insert(components, {
              "on_result_diagnostics",
              remove_on_restart = true,
              -- Standard Python error format (adjust as needed)
              errorformat = [[%f:%l:%c: %t%*[^ ] %m,%f:%l: %t%*[^ ] %m] <> ],
            })

            return {
              cmd = { "task" },
              args = { task.name },
              components = components,
            }
          end,
        }, { name = task.name }))
      end
      cb(tasks)
    end)
  end,
})

```

---

### 2. How the "Squiggles" Appear

Once you run a task with this template:

1. Overseer captures the **stdout** of the task.
2. The `errorformat` scans the text. For example, if your task runs a linter that outputs `main.py:10:5: E error message`, the component recognizes `main.py` at line `10`.
3. Overseer calls `vim.diagnostic.set()`.
4. **Instant Feedback:** Red squiggles appear in your buffer on line 10. If you have a Watcher active, the squiggles will vanish automatically as soon as you fix the code and save (because the task re-runs and the output is now clean).

---

### 3. Tuning the `errorformat`

The `errorformat` (often abbreviated as `efm`) is a powerful but cryptic syntax inherited from Vim. Here are common strings for Taskfile projects:

* **Python (Ruff/Flake8):** `%f:%l:%c: %m`
* **Go (golangci-lint):** `%f:%l:%c: %m`
* **Generic (File:Line:Msg):** `%f:%l: %m`

### 4. Why this is better than standard LSP

While an LSP (like `pyright`) is great, sometimes your **Taskfile** runs complex integration tests or specialized linters that an LSP doesn't see. By turning your task runner into a diagnostic provider, you get a "Single Source of Truth." If the `task` fails, the editor shows it, regardless of whether the LSP thinks the code is "valid."

### Next Step

Since you are experimenting on Mac with a path toward Nix, would you like me to show you how to wrap this whole setup into a **Neovim Command** (like `:Task build --watch`) so you don't even have to use the Overseer UI?

----- error handling in Lua

# Error handling in Lua

for notes: https://docs.drools.org/8.39.0.Final/drools-docs/docs-website/drools/language-reference/index.html

### 1. Basic "Try-Catch" with `pcall`

`pcall` (protected call) executes a function. If an error occurs, it catches it and returns `false` plus the error message. If it succeeds, it returns `true` plus any values returned by the function.

```lua
-- Standard pcall pattern
local success, result = pcall(function()
    -- This code is "protected"
    local data = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    error("Something went wrong!") -- Manual trigger for example
    return data
end)

if success then
    print("Success! Data length: " .. #result)
else
    -- 'result' contains the error message if success is false
    print("Caught an error: " .. result)
end

```

---

### 2. Advanced "Try-Catch" with `xpcall`

`xpcall` (extended protected call) is the same as `pcall`, but it allows you to pass a **message handler** function. This handler runs *before* the stack is unwound, which is essential if you want a full **stack trace** (using `debug.traceback`).

```lua
local function my_function()
    error("Oops!")
end

local function my_handler(err)
    return "Custom Error Handler: " .. debug.traceback(err)
end

local status, err_msg = xpcall(my_function, my_handler)

if not status then
    print(err_msg) -- Will print the error + the line-by-line stack trace
end

```

---

### 3. The "Neovim Way": Guard Clauses

While `pcall` is useful for "risky" operations (like network calls or parsing JSON), most Neovim power users prefer **Guard Clauses** (conditionals) for ergonomics. This prevents the "callback hell" of wrapping everything in functions.

**Avoid this:**

```lua
pcall(function()
    require('telescope').setup()
end)

```

**Do this instead:**

```lua
local status, telescope = pcall(require, "telescope")
if not status then
    return -- Silently exit if plugin isn't installed
end

telescope.setup({ ... })

```

---

### Summary Table

| Feature | Lua Equivalent | Notes |
| --- | --- | --- |
| **`try`** | `pcall(function() ... end)` | Wraps code in an anonymous function. |
| **`except` / `catch**` | `if not success then` | Checks the boolean return of `pcall`. |
| **`throw`** | `error("msg")` | Interrupts execution and bubbles up to the nearest `pcall`. |
| **`finally`** | *None* | You must manually handle cleanup after the `if/else` block. |

### When to use what?

* **Use `pcall**` when calling `require` or external commands that might fail.
* **Use `assert(condition, message)**` for simple validation where you *want* the script to stop if something is wrong.
* **Use `vim.validate**` (Neovim-specific) to check the types of function arguments cleanly.

-----



# Linking

Here's a Lua script that will create symbolic links from plugin repositories to your plugin directory:

```lua
#!/usr/bin/env lua

local plugins = {
    ["user/repo-name"] = { path = "source_path/repo1" },
    ["another-user/cool-plugin"] = { path = "/home/user/dev/cool-plugin" },
    ["someone/awesome-nvim"] = { path = "~/projects/awesome-nvim" },
}

local PLUGIN_DIR = vim.fn.stdpath("data") .. "/site/pack/plugins/start"
-- Or use a custom path:
-- local PLUGIN_DIR = "/path/to/your/plugin/dir"

-- Expand tilde in paths
local function expand_path(path)
    if path:sub(1, 1) == "~" then
        return os.getenv("HOME") .. path:sub(2)
    end
    return path
end

-- Extract repo name from "user/repo-name" format
local function get_repo_name(plugin_id)
    return plugin_id:match("([^/]+)$")
end

-- Create symbolic links
for plugin_id, config in pairs(plugins) do
    local repo_name = get_repo_name(plugin_id)
    local source_path = expand_path(config.path)
    local target_path = PLUGIN_DIR .. "/" .. repo_name
    
    -- Check if source exists
    local source_exists = os.rename(source_path, source_path) and true or false
    
    if not source_exists then
        print(string.format("Warning: Source path does not exist: %s", source_path))
    else
        -- Remove existing link/directory if it exists
        os.execute(string.format("rm -rf '%s'", target_path))
        
        -- Create symbolic link
        local cmd = string.format("ln -s '%s' '%s'", source_path, target_path)
        local success = os.execute(cmd)
        
        if success then
            print(string.format("✓ Linked: %s -> %s", repo_name, source_path))
        else
            print(string.format("✗ Failed to link: %s", plugin_id))
        end
    end
end

print("\nDone!")
```

If you're using this within Neovim (as a `.lua` file in your config), here's a version that uses Neovim's functions:

```lua
local plugins = {
    ["user/repo-name"] = { path = "source_path/repo1" },
    ["another-user/cool-plugin"] = { path = "/home/user/dev/cool-plugin" },
    ["someone/awesome-nvim"] = { path = "~/projects/awesome-nvim" },
}

local PLUGIN_DIR = vim.fn.stdpath("data") .. "/site/pack/plugins/start"

-- Extract repo name from "user/repo-name" format
local function get_repo_name(plugin_id)
    return plugin_id:match("([^/]+)$")
end

-- Create symbolic links
for plugin_id, config in pairs(plugins) do
    local repo_name = get_repo_name(plugin_id)
    local source_path = vim.fn.expand(config.path)
    local target_path = PLUGIN_DIR .. "/" .. repo_name
    
    -- Check if source exists
    if vim.fn.isdirectory(source_path) == 0 then
        vim.notify(string.format("Warning: Source path does not exist: %s", source_path), vim.log.levels.WARN)
    else
        -- Remove existing link/directory if it exists
        vim.fn.delete(target_path, "rf")
        
        -- Create symbolic link
        local success = vim.loop.fs_symlink(source_path, target_path)
        
        if success then
            vim.notify(string.format("✓ Linked: %s -> %s", repo_name, source_path), vim.log.levels.INFO)
        else
            vim.notify(string.format("✗ Failed to link: %s", plugin_id), vim.log.levels.ERROR)
        end
    end
end

print("Symbolic links created!")
```

The script:
1. Extracts the repo name from the `"user/repo-name"` format
2. Expands paths (handles `~` for home directory)
3. Creates symbolic links at `PLUGIN_DIR/repo-name` pointing to the source paths
4. Handles errors and provides feedback

You can run it with `:luafile path/to/script.lua` in Neovim or just require it in your config.

--]]


if false then

print('options.lua loaded')

-- MAPPINGS

print('mappings.lua loaded')

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>alf", function()
	print("A lua func")
end, { noremap = true })

-- COMMANDS

print('commands.lua loaded')

-- vim.api.nvim_create_user_command("LoadPython", function()
--     require("languages.python")
--   end, {})


-- COLORS

--vim.api.nvim_set_hl(0, "Comment", { bg = "Purple" })
--vim.api.nvim_set_hl(0, 'Normal', { fg = "Green", bg = "Red" })
--vim.api.nvim_set_hl(0, 'Error', { fg = "<white>", undercurl = true })
--vim.api.nvim_set_hl(0, 'Cursor', { reverse = true })

--vim.cmd("highlight clear")

print('colors.lua loaded')
vim.cmd("syntax reset")
--vim.g.colors_name = 'melange'

-- local bg = vim.opt.background:get()

-- package.loaded['melange/palettes/' .. bg] = nil -- Only needed for development
--local palette = require('melange/palettes/' .. bg)

--local a = palette.a -- Grays
--local b = palette.b -- Bright foreground colors
--local c = palette.c -- Foreground colors
--local d = palette.d -- Background colors

-- See https://github.com/neovim/neovim/pull/7406
--[[
vim.g.terminal_color_0 = "$color.terminalColor00$"
vim.g.terminal_color_1 = "$color.terminalColor01$"
vim.g.terminal_color_2 = "$color.terminalColor02$"
vim.g.terminal_color_3 = "$color.terminalColor03$"
vim.g.terminal_color_4 = "$color.terminalColor04$"
vim.g.terminal_color_5 = "$color.terminalColor05$"
vim.g.terminal_color_6 = "$color.terminalColor06$"
vim.g.terminal_color_7 = "$color.terminalColor07$"
vim.g.terminal_color_8 = "$color.terminalColor08$"
vim.g.terminal_color_9 = "$color.terminalColor09$"
vim.g.terminal_color_10 = "$color.terminalColor0A$"
vim.g.terminal_color_11 = "$color.terminalColor0B$"
vim.g.terminal_color_12 = "$color.terminalColor0C$"
vim.g.terminal_color_13 = "$color.terminalColor0D$"
vim.g.terminal_color_14 = "$color.terminalColor0E$"
vim.g.terminal_color_15 = "$color.terminalColor0F$"
--]]
local enable_font_variants = true
--vim.g.melange_enable_font_variants == nil or vim.g.melange_enable_font_variants

local bold = enable_font_variants
local italic = enable_font_variants
local underline = enable_font_variants
local undercurl = enable_font_variants
local strikethrough = enable_font_variants

for name, attrs in pairs({
        ---- :help highlight-default -------------------------------

        Normal = { bg = "#000800", fg = "#808080" },
        NormalFloat = { bg = "#000800", fg = "#808080" },
        NormalNC = "Normal",

        -- Cursor: ...

        WinSeparator = { bg = "#000800", fg = "#111211" },
        -- VertSplit = { bg = "<|color.nvim.VertSplit.bg |>", fg = "<|color.nvim.VertSplit.fg |>" },
        -- Special = { fg = "<|%color.nvim.Special |>" },
        -- CursorLine = { bg = "<|%color.nvim.CursorLine.bg |>" },

        Identifier = { fg = "#426989" }, --$color.nvim.Identifier.fg$" },
        ["@variable"] = { fg = "#13446c" },
        Function = { fg = "#246b44" },
        Statement = { fg = "#3f0d08" },
        Directory = { fg = "#13446c" },
        String = { fg = "#808080" },
        Comment = { fg = "#333933" },
        PreProc = { fg = "#123622" },
        Operator = { fg = "#246b44" },
        Delimiter = { fg = "#123622" },
        NeotreeFileName = { fg = "#9a9a9a" },

        -- inheriting background from default Nvim* colors
        Search = { fg = "#8AA88A", bg = "#003600" },
        CurSearch = { fg = "#809880", bg = "#002600" },

        StatusLine = { fg = "#455684", bg = "#111211" },
        StatusLineNC = { fg = "#455684", bg = "#111211" },
        Visual = { fg = "#061815", bg = "#0d8f77" },
        Folded = { fg = "#808080", bg = "#001300" },
        DiffAdd = { fg = "#668366", bg = "#002200" },
        DiffChange = { fg = "#7f86f3", bg = "#050a58" },
        DiffDelete = { fg = "#d5776f" },
        DiffText = { fg = "#050a58", bg = "#7f86f3" },
        Pmenu = { fg = "#505ad6", bg = "#000800" },
        PmenuSel = { fg = "#737df1", bg = "#002600" },
        PmenuThumb = { bg = "#777777" },
        CursorColumn = { bg = "#000e00" },
        CursorLine = { bg = "#000e00" },
        ColorColumn = { bg = "#9b73f1" },
        WinBar = { fg = "#dddddd", bg = "#000800" },
        WinBarNC = { fg = "#dddddd", bg = "#000800" },
        FloatShadow = { bg = "#002600" },
        FloatShadowThrough = {
                bg = "#118811",
        },
        MatchParen = { bg = "#51136e" },
        RedrawDebugClear = { bg = "#dddddd" },
        RedrawDebugComposed = {
                bg = "#dddddd",
        },
        RedrawDebugRecompose = {
                bg = "#dddddd",
        },
        Error = { fg = "#bd1dc5", bg = "#000800" },

        -- inheriting foreground from default Nvim* colors
        SpecialKey = { fg = "#491d5e" },
        NonText = { fg = "#111211" },
        Directory = { fg = "#13446c" },
        ErrorMsg = { fg = "#bd1dc5" },
        MoreMsg = { fg = "#1db6c5" },
        ModeMsg = { fg = "#376808" },
        LineNr = { fg = "#333833" },
        Question = { fg = "#402967" },
        WarningMsg = { fg = "#CBC383" },
        SignColumn = { fg = "#1b8984" },
        Conceal = { fg = "#808080", bg = "#000800" },
        QuickFixLine = { fg = "#A30101" },
        Special = { fg = "#49125e" },

        DiagnosticError = { fg = "#bd1dc5" },
        DiagnosticFloatingWarn = { fg = "#CBC383" },
        DiagnosticWarn = { fg = "#CBC383" },
        DiagnosticFloatingInfo = { fg = "#555555" },
        DiagnosticInfo = { fg = "#555555" },
        DiagnosticFloatingHint = { fg = "#9b73f1" },
        DiagnosticHint = { fg = "#9b73f1" },
        DiagnosticFloatingOk = { fg = "#555555" },
        DiagnosticOk = { fg = "#555555" },
        Added = { fg = "#368366" },
        ["@diff.minus"] = { fg = "#d5776f" },
        Removed = { fg = "#d5776f" },
        Changed = { fg = "#7f86f3" },
        CmpItemAbbrDeprecatedDefault = { fg = "#ffffff" },
        CmpItemKindDefault = { fg = "#eeeeee" },
        RainbowDelimiter1 = { fg = "#2b1400" },
        RainbowDelimiter2 = { fg = "#4f473b" },
        RainbowDelimiter3 = { fg = "#381900" },
        RainbowDelimiter4 = { fg = "#726c62" },
        RainbowDelimiter5 = { fg = "#51331a" },
        RainbowDelimiter6 = { fg = "#959189" },
        RainbowDelimiter7 = { fg = "#78604d" },
}) do
        if type(attrs) == "table" then
                vim.api.nvim_set_hl(0, name, attrs)
        else
                vim.api.nvim_set_hl(0, name, { link = attrs })
        end
end

-- PYTHON

print('python.lua loaded')

-- vim.opt.rtp:prepend("$LSPCONFIG")
local lspconf = vim.lsp.config

vim.lsp.log.set_level('debug')
-- lspconf.ruff.setup({
--     init_options = {
--       settings = {
--         args = {
--           "--line-length=100",
--           "--extend-ignore=E501",
--           "--select=I",
--           "--ignore=C90",
--           "--target-version=py311",
--         },
-- }
--   }})
vim.lsp.enable("ruff")

-- lspconf.pylsp.setup({
-- 	on_attach = custom_attach,
-- 	settings = {

-- 		pylsp = {
--             auto_source = true,
    
-- 			plugins = {
-- 				-- autopep8 = { enabled = false },
-- 				-- yapf = { enabled = false },

				
-- 				-- pylsp_mypy = {
-- 				-- 	enabled = true,
-- 				-- 	strict = true,
-- 				-- },
-- 				-- rope = {
-- 				-- 	enabled = true,
-- 				-- },
-- 				-- ruff = {
-- 				-- 	enabled = true,
-- 				-- },
-- 				-- jedi_completion = {
-- 				-- 	fuzzy = true,
-- 				-- },
-- 				-- pylint = {
-- 				-- 	enabled = true,
-- 				-- 	executable = "pylint",
-- 				-- },
--                 ruff = {
--                     enabled = true,  -- Enable the plugin
--                     formatEnabled = true,  -- Enable formatting using ruffs formatter
--                     executable = "<path-to-ruff-bin>",  -- Custom path to ruff
--                     config = "<path_to_custom_ruff_toml>",  -- Custom config for ruff to use
--                     extendSelect = { "I" },  -- Rules that are additionally used by ruff
--                     extendIgnore = { "C90" },  -- Rules that are additionally ignored by ruff
--                     format = { "I" },  -- Rules that are marked as fixable by ruff that should be fixed when running textDocument/formatting
--                     severities = { ["D212"] = "I" },  -- Optional table of rules where a custom severity is desired
--                     unsafeFixes = false,  -- Whether or not to offer unsafe fixes as code actions. Ignored with the "Fix All" action
              
--                     -- Rules that are ignored when a pyproject.toml or ruff.toml is present:
--                     lineLength = 120,  -- Line length to pass to ruff checking and formatting
--                     exclude = { "__about__.py" },  -- Files to be excluded by ruff checking
--                     select = { "F" },  -- Rules to be enabled by ruff
--                     ignore = { "D210" },  -- Rules to be ignored by ruff
--                     perFileIgnores = { ["__init__.py"] = "CPY001" },  -- Rules that should be ignored for specific files
--                     preview = false,  -- Whether to enable the preview style linting and formatting.
--                     targetVersion = "py310",  -- The minimum python version to target (applies for both linting and formatting).
--                   },
-- 			},
-- 		},
-- 		flags = {
-- 			debounce_text_changes = 200,
-- 		},
-- 		capabilities = capabilities,
-- 		formatCommand = { "ruff", "format" },
-- 	},
-- })

-- LUA



-- XIT

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.xit",
  callback = function()
    vim.bo.filetype = "xit"
  end,
})

-- 

vim.cmd [[
  syntax clear
  syntax on
  highlight TSVariable guifg=Green
  highlight link Identifier TSVariable
]]

--

vim.api.nvim_create_augroup('XitFiletypeGroup', { clear = true })

vim.api.nvim_create_autocmd('FileType', {

  group = 'XitFiletypeGroup',
  pattern = 'xit',
  callback = function()
    vim.opt.rtp:prepend("$TREESITTER")
    print(".xit filetype detected")
    vim.opt.rtp:prepend("$XIT")
    vim.opt.rtp:prepend("$TSXIT")
    
    parser_configs = require("nvim-treesitter.parsers") --.get_parser_configs()
    parser_configs.xit = {
      install_info = {
        url = "$TSXIT",
        files = {"parser"},
        install_dir = "$TSXIT",
        generate_requires_npm = false,
        requires_generate_from_grammar = false,
      },
      filetype = "xit",
    }
    require('nvim-treesitter').setup({
      highlight = {enable = true,},
      -- ensure_installed = { "xit", "python", "lua", "javascript" },
      auto_install = false,
    })

    require('xit').setup({
      disable_default_highlights = false,
      disable_default_mappings = false,
      default_jump_group = "all", -- possible values: all, open_and_ongoing
      wrap_jumps = true,
    })
    
    print("set up xit")

    vim.api.nvim_set_hl(0, '@XitHeadline', {
      fg = '#FFD700',
      bg = 'NONE',
      bold = true,
      underline = true,
    })
  end,
})

-- vim.api.nvim_create_augroup('XitFiletypeGroup', { clear = true })

-- vim.api.nvim_create_autocmd('FileType', {

--   group = 'XitFiletypeGroup',
--   pattern = 'xit',
--   callback = function()
--     vim.opt.rtp:prepend("$TREESITTER")
--     vim.opt.rtp:prepend("$XIT")
--     require('nvim-treesitter.configs').setup({highlight = {enable = true,}})
--     -- require('xit').setup({
--     --   disable_default_highlights = false,
--     --   disable_default_mappings = false,
--     --   default_jump_group = "all", -- possible values: all, open_and_ongoing
--     --   wrap_jumps = true,
--     -- })
--     vim.api.nvim_set_hl(0, '@XitHeadline', {
--       fg = '#FFD700',
--       bg = 'NONE',
--       bold = true,
--       underline = true,
--     })
--   end,
-- })

-- STATUSLINE

print('status_line.lua loaded')

vim.keymap.set("n", "<leader>s", function()
	
    vim.opt.rtp:prepend("$LUALINE")
	local lualine = require("lualine")

	vim.opt.rtp:prepend("$NAVIC")
	local navic = require("nvim-navic")

	local colors = {
		-- bg = "<| color.nvim.statusLine.bg |>",
		-- fg = "<| color.nvim.statusLine.fg |>",
		-- yellow = "<| color.nvim.statusLine.yellow |>",
		-- cyan = "<| color.nvim.statusLine.cyan |>",
		-- darkblue = "<| color.nvim.statusLine.darkblue |>",
		-- green = "<| color.nvim.statusLine.green |>",
		-- orange = "<| color.nvim.statusLine.orange |>",
		-- violet = "<| color.nvim.statusLine.violet |>",
		-- magenta = "<| color.nvim.statusLine.magenta |>",
		-- blue = "<| color.nvim.statusLine.blue |>",
		-- red = "<| color.nvim.statusLine.red |>",

        bg        = "#1e1e2e",  -- Dark background
        fg        = "#cdd6f4",  -- Light foreground text
        yellow    = "#f9e2af",  -- Soft yellow
        cyan      = "#89dceb",  -- Bright cyan
        darkblue  = "#1e66f5",  -- Saturated blue
        green     = "#a6e3a1",  -- Pleasant green
        orange    = "#fab387",  -- Soft orange
        violet    = "#cba6f7",  -- Light violet
        magenta   = "#f5c2e7",  -- Pink/magenta
        blue      = "#89b4fa",  -- Soft blue
        red       = "#f38ba8",  -- Warm red
	}

	local conditions = {
		buffer_not_empty = function()
			return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
		end,
		hide_in_width = function()
			return vim.fn.winwidth(0) > 80
		end,
		check_git_workspace = function()
			local filepath = vim.fn.expand("%:p:h")
			local gitdir = vim.fn.finddir(".git", filepath .. ";")
			return gitdir and #gitdir > 0 and #gitdir < #filepath
		end,
	}

	local config = {
		options = {
			component_separators = "",
			section_separators = "",
			theme = {
				normal = { c = { fg = colors.fg, bg = colors.bg } },
				inactive = { c = { fg = colors.fg, bg = colors.bg } },
			},
		},
		sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_y = {},
			lualine_z = {},
			lualine_c = {},
			lualine_x = {},
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_y = {},
			lualine_z = {},
			lualine_c = {},
			lualine_x = {},
		},
	}

	local function ins_left(component)
		table.insert(config.sections.lualine_c, component)
	end

	local function ins_right(component)
		table.insert(config.sections.lualine_x, component)
	end

	ins_left({
		function()
			return " "
		end,
		color = function()
			local mode_color = {
				n = colors.red,
				i = colors.green,
				v = colors.blue,
				[""] = colors.blue,
				V = colors.blue,
				c = colors.magenta,
				no = colors.red,
				s = colors.orange,
				S = colors.orange,
				[""] = colors.orange,
				ic = colors.yellow,
				R = colors.violet,
				Rv = colors.violet,
				cv = colors.red,
				ce = colors.red,
				r = colors.cyan,
				rm = colors.cyan,
				["r?"] = colors.cyan,
				["!"] = colors.red,
				t = colors.red,
			}
			return { fg = mode_color[vim.fn.mode()] }
		end,
		padding = { right = 1 },
	})

	ins_left({
		"filesize",
		cond = conditions.buffer_not_empty,
	})

	ins_left({
		"filename",
		cond = conditions.buffer_not_empty,
		color = { fg = colors.magenta, gui = "bold" },
	})

	ins_left({ "location" })

	ins_left({ "progress", color = { fg = colors.fg, gui = "bold" } })

	ins_left({
		"diagnostics",
		sources = { "nvim_diagnostic" },
		symbols = { error = " ", warn = " ", info = " " },
		diagnostics_color = {
			color_error = { fg = colors.red },
			color_warn = { fg = colors.yellow },
			color_info = { fg = colors.cyan },
		},
	})

	ins_left({
		function()
			return "%="
		end,
	})

	ins_left({
		function()
			local msg = "No Active Lsp"
			local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
			local clients = vim.lsp.get_clients()
			if next(clients) == nil then
				return msg
			end
			for _, client in ipairs(clients) do
				local filetypes = client.config.filetypes
				if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
					return client.name
				end
			end
			return msg
		end,
		icon = " LSP:",
		color = { fg = colors.cyan, gui = "bold" },
	})

	ins_right({
		"o:encoding",
		fmt = string.upper,
		cond = conditions.hide_in_width,
		color = { fg = colors.green, gui = "bold" },
	})

	ins_right({
		"fileformat",
		fmt = string.upper,
		icons_enabled = false,
		color = { fg = colors.green, gui = "bold" },
	})

	ins_right({
		"branch",
		icon = "",
		color = { fg = colors.violet, gui = "bold" },
	})

	ins_right({
		"diff",
		symbols = { added = " ", modified = "󰝤 ", removed = " " },
		diff_color = {
			added = { fg = colors.green },
			modified = { fg = colors.orange },
			removed = { fg = colors.red },
		},
		cond = conditions.hide_in_width,
	})

	lualine.setup(config)
end, { noremap = true, silent = true })

-- FILE TREE BROWSER

print('file_browser_tree.lua loaded')

vim.keymap.set("n", "<leader>t", function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    vim.opt.rtp:prepend("$NVIMTREE")
    
    local nvimtree = require("nvim-tree")
    nvimtree.setup(
        {
            sort = {
              sorter = "case_sensitive",
            },
            view = {
              width = 30,
            },
            renderer = {
              group_empty = true,
            },
            filters = {
              dotfiles = false,
            },
        }
    )
    -- require("nvim-web-devicons").setup()
    -- -- require("nui")
    -- require("plenary")
    print('nvim-tree requires successful')
	-- local oil = require("oil")
	-- local genghis = require("genghis")
end)

-- vim.keymap.set("n", "<leader>l", function()
--     vim.g.loaded_netrw = 1
--     vim.g.loaded_netrwPlugin = 1

--     vim.opt.rtp:prepend("$NEOTREE")
--     vim.opt.rtp:prepend("$WEBDEVICONS")
--     vim.opt.rtp:prepend("$PLENARY")
--     vim.opt.rtp:prepend("$NUI")
--     local neotree = require("neo-tree")
--     require("nvim-web-devicons").setup()
--     -- require("nui")
--     require("plenary")
--     print('neotree requires successful')
-- 	-- local oil = require("oil")
-- 	-- local genghis = require("genghis")

-- 	neotree.setup({
-- 		close_if_last_window = true,
-- 		-- popup_border_style = "rounded",
-- 		-- enable_git_status = true,
-- 		-- enable_diagnostics = true,
-- 		-- open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
-- 		-- sort_case_insensitive = false,
-- 		-- sort_function = nil,
-- 		-- default_component_configs = {
-- 		-- 	container = {
-- 		-- 		enable_character_fade = true,
-- 		-- 		right_padding = 0,
-- 		-- 	},
-- 		-- 	indent = {
-- 		-- 		indent_size = 2,
-- 		-- 		padding = 1,
-- 		-- 		with_markers = true,
-- 		-- 		indent_marker = "│",
-- 		-- 		last_indent_marker = "└",
-- 		-- 		highlight = "NeoTreeIndentMarker",
-- 		-- 		with_expanders = nil,
-- 		-- 		expander_collapsed = "",
-- 		-- 		expander_expanded = "",
-- 		-- 		expander_highlight = "NeoTreeExpander",
-- 		-- 	},
-- 		-- 	icon = {
-- 		-- 		folder_closed = "",
-- 		-- 		folder_open = "",
-- 		-- 		folder_empty = "",
-- 		-- 		default = "",
-- 		-- 		highlight = "NeoTreeFileIcon",
-- 		-- 	},
-- 		-- 	modified = {
-- 		-- 		symbol = "[+]",
-- 		-- 		highlight = "NeoTreeModified",
-- 		-- 	},
-- 		-- 	name = {
-- 		-- 		trailing_slash = false,
-- 		-- 		use_git_status_colors = true,
-- 		-- 		highlight = "NeoTreeFileName",
-- 		-- 	},
-- 		-- 	git_status = {
-- 		-- 		symbols = {
-- 		-- 			added = "✚",
-- 		-- 			modified = "",
-- 		-- 			deleted = "✖",
-- 		-- 			renamed = "",
-- 		-- 			untracked = "",
-- 		-- 			ignored = "",
-- 		-- 			unstaged = "",
-- 		-- 			staged = "",
-- 		-- 			conflict = "",
-- 		-- 		},
-- 		-- 	},
-- 		-- },
-- 		-- commands = {},
-- 		-- window = {
-- 		-- 	position = "left",
-- 		-- 	width = 40,
-- 		-- 	mapping_options = {
-- 		-- 		noremap = true,
-- 		-- 		nowait = true,
-- 		-- 	},
-- 		-- 	mappings = {
-- 		-- 		["<space>"] = {
-- 		-- 			"toggle_node",
-- 		-- 			nowait = false,
-- 		-- 		},
-- 		-- 		["<2-LeftMouse>"] = "open",
-- 		-- 		["<cr>"] = "open",
-- 		-- 		["<esc>"] = "revert_preview",
-- 		-- 		["P"] = { "toggle_preview", config = { use_float = true } },
-- 		-- 		["l"] = "focus_preview",
-- 		-- 		["S"] = "open_split",
-- 		-- 		["s"] = "open_vsplit",
-- 		-- 		["t"] = "open_tabnew",
-- 		-- 		["w"] = "open_with_window_picker",
-- 		-- 		["C"] = "close_node",
-- 		-- 		["z"] = "close_all_nodes",
-- 		-- 		["a"] = {
-- 		-- 			"add",
-- 		-- 			config = {
-- 		-- 				show_path = "none",
-- 		-- 			},
-- 		-- 		},
-- 		-- 		["A"] = "add_directory",
-- 		-- 		["d"] = "delete",
-- 		-- 		["r"] = "rename",
-- 		-- 		["y"] = "copy_to_clipboard",
-- 		-- 		["x"] = "cut_to_clipboard",
-- 		-- 		["p"] = "paste_from_clipboard",
-- 		-- 		["c"] = "copy",
-- 		-- 		["m"] = "move",
-- 		-- 		["q"] = "close_window",
-- 		-- 		["R"] = "refresh",
-- 		-- 		["?"] = "show_help",
-- 		-- 		["<"] = "prev_source",
-- 		-- 		[">"] = "next_source",
-- 		-- 	},
-- 		-- },
-- 		-- nesting_rules = {},
-- 		-- filesystem = {
-- 		-- 	filtered_items = {
-- 		-- 		visible = false,
-- 		-- 		hide_dotfiles = true,
-- 		-- 		hide_gitignored = true,
-- 		-- 		hide_hidden = true,
-- 		-- 		hide_by_name = {},
-- 		-- 		hide_by_pattern = {},
-- 		-- 		always_show = {},
-- 		-- 		never_show = {},
-- 		-- 		never_show_by_pattern = {},
-- 		-- 	},
-- 		-- 	follow_current_file = { enabled = true },
-- 		-- 	group_empty_dirs = false,
-- 		-- 	hijack_netrw_behavior = "open_default",
-- 		-- 	use_libuv_file_watcher = true,
-- 		-- 	window = {
-- 		-- 		mappings = {
-- 		-- 			["<bs>"] = "navigate_up",
-- 		-- 			["."] = "set_root",
-- 		-- 			["H"] = "toggle_hidden",
-- 		-- 			["/"] = "fuzzy_finder",
-- 		-- 			["D"] = "fuzzy_finder_directory",
-- 		-- 			["#"] = "fuzzy_sorter",
-- 		-- 			["f"] = "filter_on_submit",
-- 		-- 			["<c-x>"] = "clear_filter",
-- 		-- 			["[g"] = "prev_git_modified",
-- 		-- 			["]g"] = "next_git_modified",
-- 		-- 		},
-- 		-- 		fuzzy_finder_mappings = {
-- 		-- 			["<down>"] = "move_cursor_down",
-- 		-- 			["<C-n>"] = "move_cursor_down",
-- 		-- 			["<up>"] = "move_cursor_up",
-- 		-- 			["<C-p>"] = "move_cursor_up",
-- 		-- 		},
-- 		-- 	},
-- 		-- 	commands = {},
-- 		-- },
-- 		-- buffers = {
-- 		-- 	follow_current_file = { enabled = true },
-- 		-- 	group_empty_dirs = true,
-- 		-- 	show_unloaded = true,
-- 		-- 	window = {
-- 		-- 		mappings = {
-- 		-- 			["bd"] = "buffer_delete",
-- 		-- 			["<bs>"] = "navigate_up",
-- 		-- 			["."] = "set_root",
-- 		-- 		},
-- 		-- 	},
-- 		-- },
-- 		-- git_status = {
-- 		-- 	window = {
-- 		-- 		position = "float",
-- 		-- 		mappings = {
-- 		-- 			["A"] = "git_add_all",
-- 		-- 			["gu"] = "git_unstage_file",
-- 		-- 			["ga"] = "git_add_file",
-- 		-- 			["gr"] = "git_revert_file",
-- 		-- 			["gc"] = "git_commit",
-- 		-- 			["gp"] = "git_push",
-- 		-- 			["gg"] = "git_commit_and_push",
-- 		-- 		},
-- 		-- 	},
-- 		-- },
-- 	})
-- end, { noremap = true, silent = true })

-- vim.keymap.set('n', '<leader>t', ':Neotree<CR>')

vim.opt.rtp:prepend("$TREESITTER")
require('nvim-treesitter')
require'nvim-treesitter'.setup {
    -- ensure_installed = { "python", "lua", "javascript" },  -- Ensure installed parsers
    highlight = { enable = true },
    fold = { enable = false }  -- Disable folding if necessary
  }

function addRelPath(dir)
    local spath =
        debug.getinfo(1,'S').source
          :sub(2)
          :gsub("^([^/])","./%1")
          :gsub("[^/]*$","")
    dir=dir and (dir.."/") or ""
    spath = spath..dir
    package.path = spath.."?.lua;"
                 ..spath.."?/init.lua"
                --  ..package.path
end


addRelPath()
require("_colors")
require("options")
require("mappings")
require("commands")

require("features.status_line")
require("features.file_browser_tree")

require('languages.python')
require('languages.xit')
-- require("mappings")
-- require("options")

-- require("features.file_browser_tree")
-- require("features.status_line")


-- require("languages.xit")



end
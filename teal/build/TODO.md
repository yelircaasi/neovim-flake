**Here's a complete, self-contained Lua file** for a Neovim 0.12+ native LSP setup (using `vim.lsp.config` and `vim.lsp.enable`) focused on Python with **Ruff** (linting + formatting) and **mypy** integration. It avoids `nvim-lspconfig`.

Save this as e.g. `lua/lsp/python.lua` (or include it directly in your `init.lua`).

```lua
-- lua/lsp/python.lua
-- Neovim 0.12+ native LSP for Python: Ruff + mypy + conform.nvim format-on-save
-- Best practices as of May 2026

local function on_attach(client, bufnr)
  -- Disable Ruff hover if you add another server like pyright/basedpyright later
  if client.name == "ruff" then
    client.server_capabilities.hoverProvider = false
  end

  -- Common keymaps (adjust as needed)
  local opts = { buffer = bufnr, silent = true }
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>cf", function() require("conform").format({ bufnr = bufnr }) end, opts)
end

-- Ruff LSP (fast linting, formatting, import organization, etc.)
-- Place this in after/lsp/ruff.lua or define inline
vim.lsp.config("ruff", {
  cmd = { "ruff", "server" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
  on_attach = on_attach,
  init_options = {
    settings = {
      -- Ruff server settings (see Ruff docs)
      logLevel = "info", -- or "debug" for troubleshooting
      -- Example: enable specific rules or configure line length
      -- lint = { select = { "ALL" }, ignore = {} },
      -- format = { preview = true },
    },
  },
})

-- Enable Ruff
vim.lsp.enable("ruff")

-- Optional: Add pyright/basedpyright for richer completion & type checking
-- (Uncomment if desired; it complements Ruff well)
--[[
vim.lsp.config("pyright", {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "setup.py", ... },
  on_attach = on_attach,
  settings = {
    pyright = {
      disableOrganizeImports = true, -- Let Ruff handle imports
    },
    python = {
      analysis = {
        typeCheckingMode = "basic", -- or "strict"
        diagnosticMode = "workspace",
      },
    },
  },
})
vim.lsp.enable("pyright")
--]]

-- Mypy integration
-- Option 1: Via nvim-lint (recommended for live diagnostics)
-- Option 2: Use conform for on-save mypy checks (slower but thorough)

-- Diagnostics config (best practices)
vim.diagnostic.config({
  virtual_text = { prefix = "●", spacing = 2 },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = { border = "rounded", source = "always" },
})

-- Conform.nvim setup for formatting on save (Ruff + optional mypy)
require("conform").setup({
  formatters_by_ft = {
    python = {
      "ruff_fix",           -- Auto-fix lint errors
      "ruff_format",        -- Ruff formatter (replaces Black)
      "ruff_organize_imports",
      -- "mypy"             -- Uncomment for type checking on save (slow; better in CI)
    },
  },
  format_on_save = {
    timeout_ms = 1000,
    lsp_format = "fallback", -- Use LSP formatting if available
  },
  -- Custom mypy formatter (runs mypy and reports errors)
  formatters = {
    mypy = {
      command = "mypy",
      args = { "--no-error-summary", "--show-column-numbers", "--no-color-output", "$FILENAME" },
      stdin = false,
      -- Ignore exit code so it doesn't block save; use for diagnostics instead
      ignore_exitcode = true,
    },
  },
})

-- Auto-format on save via autocmd (fallback / extra control)
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.py",
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
  desc = "Format Python on save with conform",
})

-- Optional: nvim-lint for mypy + ruff linting (faster live feedback)
-- Add `mfussenegger/nvim-lint` plugin if you want this
--[[
require("lint").linters_by_ft = {
  python = { "ruff", "mypy" },
}
vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
--]]
```

### How to use / best practices (May 2026)

1. **Install tools** (project or global):
   - `pip install ruff mypy` (or `uv`, `pipx`, etc.)
   - Ensure `ruff` and `mypy` are in your `$PATH`.

2. **Project config** (recommended):
   - `pyproject.toml` for Ruff + mypy settings (unified).
   - Example minimal Ruff section:
     ```toml
     [tool.ruff]
     line-length = 88
     target-version = "py312"
     select = ["ALL"]
     ignore = ["E501"]  # or whatever
     ```

3. **Load the config** in your `init.lua`:
   ```lua
   require("lsp.python")  -- or vim.cmd("runtime! lua/lsp/python.lua")
   ```

4. **Why this setup?**
   - **Ruff LSP**: Blazing fast, replaces many tools (isort, flake8, pycodestyle, etc.). Native `vim.lsp.config` support is first-class.
   - **Conform**: Dedicated formatter, format-on-save, handles Ruff's fix/format/organize cleanly.
   - **Mypy**: Best as a type checker via `nvim-lint` (live) or on-save/CI. Full static checking is heavier than Ruff.
   - No `nvim-lspconfig` → pure native API.
   - Scalable: Easy to add pyright later for advanced features while disabling overlapping capabilities.

Test with `:LspInfo`, `:ConformInfo`, and open a `.py` file. Let me know if you want a full `pyright` addition, DAP (debugpy), or project-specific overrides!

---

# GEMINI

As of May 2026, Neovim 0.12 has significantly streamlined the "native" LSP experience. The `vim.lsp.config()` and `vim.lsp.enable()` APIs (introduced in 0.11 and polished in 0.12) have largely replaced the manual `vim.lsp.start()` boilerplate, making `nvim-lspconfig` optional for standard setups.

For Python, the industry has shifted toward **`ruff server`** (the Rust-based native LSP replacing the old `ruff-lsp` Python package) and **`pyright`** or **`basedpyright`**. Since you specifically requested **mypy**, the most robust way to integrate it into an LSP flow without extra plugins is via the `pylsp` server with the `pylsp-mypy` plugin.

### Modern Python Setup (init.lua)

```lua
-- 1. LSP CONFIGURATION (Native Neovim 0.12+ API)
-- We define configs using vim.lsp.config and activate them with vim.lsp.enable

-- Ruff: Handles linting and primary formatting
vim.lsp.config('ruff', {
  cmd = { 'ruff', 'server' },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'ruff.toml', '.git' },
  settings = {
    -- Any specific ruff settings go here
  },
})

-- PyLSP: Specifically configured for Mypy type checking
vim.lsp.config('pylsp', {
  cmd = { 'pylsp' },
  filetypes = { 'python' },
  settings = {
    pylsp = {
      plugins = {
        -- Disable standard lints/formatters provided by Ruff
        pyflakes = { enabled = false },
        pycodestyle = { enabled = false },
        mccabe = { enabled = false },
        -- Enable Mypy
        pylsp_mypy = {
          enabled = true,
          live_mode = true, -- Provides type-checking as you type
          strict = true,
        },
      },
    },
  },
})

-- Enable both servers
vim.lsp.enable('ruff')
vim.lsp.enable('pylsp')

-- 2. FORMATTING (Conform.nvim)
-- Using conform for "Format on Save" with Ruff
require("conform").setup({
  formatters_by_ft = {
    python = { "ruff_format", "ruff_organize_imports" },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
})

-- 3. MODERN LSP KEYMAPS (Neovim 0.12 Defaults)
-- Neovim 0.12 provides better defaults, but here are the standard 2026 mappings:
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local opts = { buffer = args.buf }
    -- Note: 'grn' (rename), 'gra' (code action), and 'grr' (references) 
    -- are now built-in defaults in 0.12.
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>cl', vim.lsp.codelens.run, opts)
  end,
})
```

---

### Key Improvements in this Setup
* **Built-in Registry:** `vim.lsp.config()` acts as a centralized store for server configurations. It’s cleaner than the old `start_client` loops.
* **Automatic Activation:** `vim.lsp.enable()` automatically attaches the server when you open a file matching the `filetypes` and `root_markers`.
* **Ruff Native Server:** By using `ruff server` instead of `ruff-lsp`, you get significantly lower latency and native support for the latest Ruff features.
* **Conform.nvim Logic:** We use `ruff_format` and `ruff_organize_imports` sequentially. Setting `lsp_format = "fallback"` ensures that if Ruff isn't available, Neovim won't hang trying to format.

### Requirements
Ensure you have the following installed on your system:
1.  **Ruff:** `pip install ruff` (ensure version > 0.5.0 for the native server).
2.  **PyLSP + Mypy:** `pip install "python-lsp-server[all]" pylsp-mypy`.
3.  **Conform:** Installed via your plugin manager (e.g., `lazy.nvim`).

[Modern Neovim LSP Setup Guide](https://www.youtube.com/watch?v=lljs_7xB7Ps)
This video explains how to leverage the 0.12 built-in features to reduce dependency on external configuration plugins while maintaining a high-performance Python environment.

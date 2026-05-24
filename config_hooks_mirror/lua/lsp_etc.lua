-- LSP ========================================================================================

-- Mypy integration
-- Option 1: Via nvim-lint (recommended for live diagnostics)
-- Option 2: Use conform for on-save mypy checks (slower but thorough)

-- pip install "python-lsp-server[all]" pylsp-mypy
-- [Modern Neovim LSP Setup Guide](https://www.youtube.com/watch?v=lljs_7xB7Ps)

-- new LSP config, compiled from old ones

vim.cmd("set completeopt+=noselect")

-- CONFIGS ------------------------------------------------------------------------------------

vim.lsp.config["tinymist"] = {} -- TODO (?)
vim.lsp.config["haskell-ls"] = {} -- TODO (?)
vim.lsp.config["lua_ls"] = { -- TODO (?)
	settings = {
		Lua = {
			workspace = { library = vim.api.nvim_get_runtime_file("", true) },
		},
	},
}
vim.lsp.config["haskell-language-server"] = { ------------------------------------------------------------------ HASKELL
	cmd = { "haskell-language-server" },
	filetypes = { "haskell" },
	root_markers = { { "*.cabal" }, ".git" },
	settings = {},
}
vim.lsp.config["luals"] = { ---------------------------------------------------------------------------------------- LUA
	-- Command and arguments to start the server.
	cmd = { "lua-language-server" },
	-- Filetypes to automatically attach to.
	filetypes = { "lua" },
	-- Sets the "workspace" to the directory where any of these files is found.
	-- Files that share a root directory will reuse the LSP server connection.
	-- Nested lists indicate equal priority, see |vim.lsp.Config|.
	root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
	-- Specific settings to send to the server. The schema is server-defined.
	-- Example: https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
			diagnostics = {
				globals = {
					"vim",
				},
			},
		},
	},
}
vim.lsp.config["ruff"] = { -------------------------------------------------------------------------------------- PYTHON
	cmd = { "ruff", "server" },
	filetypes = { "python" },
	root_markers = { { ".ruff_cache", "pyproject.toml" }, ".git" },
	-- {
	-- 	 "pyproject.toml",
	--   "ruff.toml",
	-- 	 ".ruff.toml",
	-- 	 "setup.py",
	-- 	 "setup.cfg",
	-- 	 "requirements.txt",
	--   ".git",
	-- }
	-- example: https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
	settings = {},
}
vim.lsp.config["pyright"] = {
	cmd = { "pyright-langserver", "--stdio" },
	filetypes = { "python" },
	root_markers = {
		{ "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile" },
		".git",
	},
	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				typeCheckingMode = "basic", -- alternative: "strict"
			},
		},
	},
}
vim.lsp.config["nixd"] = {
	cmd = { "nixd" },
	filetypes = { "nix" },
	root_markers = { "flake.nix", ".git" },
	settings = {},
}
vim.lsp.config["rust-analyzer"] = { ------------------------------------------------------------------------------- RUST
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
	root_markers = { { "Cargo.toml", "cargo.lock" }, ".git" },
	settings = {},
}

-- AUTOCOMMANDS -------------------------------------------------------------------------------

local function on_attach(ev)
	local client = vim.lsp.get_client_by_id(ev.data.client_id)
	if client.name == "ruff" then
		client.server_capabilities.hoverProvider = false
	end

	if client:supports_method("textDocument/completion") then
		vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
	end

	local opts = { buffer = ev.buf, silent = true }
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "<leader>cf", function()
		require("conform").format({ bufnr = ev.buf })
	end, opts)
	vim.keymap.set("n", "<leader>cl", vim.lsp.codelens.run, opts)
end

vim.api.nvim_create_autocmd("LspAttach", { callback = on_attach })

-- ENABLE -------------------------------------------------------------------------------------
vim.lsp.enable("lua_ls")
vim.lsp.enable("luals")
vim.lsp.enable("nixd")
vim.lsp.enable("pylsp")
vim.lsp.enable("pyright")
vim.lsp.enable("ruff")
vim.lsp.enable("ruff")
vim.lsp.enable("tinymist")

-- LSP UI ------------------------------------------------------------------------------------------------

current_mode_index = 1
diagnostics_active = false

local diagnostic_modes = {
	{
		name = "End of Line (Virtual Text)",
		config = {
			virtual_text = {
				prefix = "●", -- Could be '■', '▎', 'x'
				spacing = 4,
				source = "if_many",
			},
			virtual_lines = false,
			signs = true,
			underline = true,
			update_in_insert = false,
			severity_sort = true,
			float = { border = "rounded", source = "always" },
		},
	},
	{
		name = "Under Line (Virtual Lines)",
		config = {
			virtual_text = false,
			-- 'virtual_lines' is now a built-in handler in Nvim 0.10/0.11+
			virtual_lines = {
				only_current_line = true, -- Only show for current line to reduce clutter
				highlight_whole_line = false,
			},
			signs = true,
			underline = true,
			update_in_insert = false,
			severity_sort = true,
			float = { border = "rounded", source = "always" },
		},
	},
	{
		name = "Gutter Only (Signs)",
		config = {
			virtual_text = false,
			virtual_lines = false,
			signs = {
				-- Custom mapping for signs if you want specific characters
				text = {
					[vim.diagnostic.severity.ERROR] = "E",
					[vim.diagnostic.severity.WARN] = "W",
					[vim.diagnostic.severity.HINT] = "H",
					[vim.diagnostic.severity.INFO] = "I",
				},
			},
			underline = false, -- Often cleaner to disable underline in "minimal" mode
			update_in_insert = false,
			severity_sort = true,
			float = { border = "rounded", source = "always" },
		},
	},
}

local function set_diagnostics_mode()
	if not diagnostics_active then
		vim.diagnostic.enable(false)
		utils.printv("LSP Diagnostics: OFF")
		return
	end

	vim.diagnostic.enable(true)
	local mode = diagnostic_modes[current_mode_index]
	vim.diagnostic.config(mode.config)
	utils.printv("LSP Mode: " .. mode.name)
end

vim.keymap.set("n", "<leader>dt", function()
	diagnostics_active = not diagnostics_active
	set_diagnostics_mode()
end, { desc = "Toggle LSP Diagnostics" })

vim.keymap.set("n", "<leader>dm", function()
	if not diagnostics_active then
		diagnostics_active = true
		current_mode_index = 1
	else
		current_mode_index = current_mode_index + 1
		if current_mode_index > #diagnostic_modes then
			current_mode_index = 1
		end
	end
	set_diagnostics_mode()
end, { desc = "Cycle LSP Diagnostic Modes" })

set_diagnostics_mode()

-- CONFORM --------------------------------------------------------------------------------------------

setup_plugin("conform", function(conform)
	conform.setup({
		formatters_by_ft = {
			python = {
				"ruff_fix",
				"ruff_format",
				"ruff_organize_imports",
				-- "mypy",
			},
			nix = {
				"alejandra",
			},
			lua = {
				"stylua",
			},
			haskell = {
				"fourmolu",
			},
			rust = {
				"rustfmt",
			},
			go = {
				"gofmt",
			},
		},
		format_on_save = {
			timeout_ms = 1000,
			lsp_format = "fallback", -- Use LSP formatting if available
		},
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

	vim.api.nvim_create_autocmd("BufWritePre", {
		pattern = "*.py",
		callback = function(args)
			conform.format({ bufnr = args.buf })
		end,
		desc = "Format Python on save with conform",
	})
end)

-- ALTERNATIVE
setup_plugin("conform", function(conform)
	require("conform").setup({
		formatters_by_ft = {
			python = {
				-- To fix auto-fixable lint errors.
				"ruff_fix",
				-- To run the Ruff formatter.
				"ruff_format",
				-- To organize the imports.
				"ruff_organize_imports",
			},
			lua = {
				"stylua",
			},
		},
	})

	-- Optional: format on save
	vim.api.nvim_create_autocmd("BufWritePre", {
		callback = function(args)
			require("conform").format({ bufnr = args.buf })
		end,
	})
end)

-- LSP KEYMAPS
-- autocommand group to attach keymaps only to buffers with an active LSP client.
local lsp_keymaps_group = vim.api.nvim_create_augroup("LspKeymaps", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
	group = lsp_keymaps_group,
	callback = function(ev)
		local lsp_map = function(keys, func, desc)
			map_explicit({
				mode = "n",
				sequence = keys,
				action = func,
				opts = { buffer = ev.buf, desc = "LSP: " .. desc },
			})
		end

		-- Navigation and Information
		lsp_map("gd", vim.lsp.buf.definition, "Go to Definition")
		lsp_map("gD", vim.lsp.buf.declaration, "Go to Declaration")
		lsp_map("gr", vim.lsp.buf.references, "Go to References")
		lsp_map("gI", vim.lsp.buf.implementation, "Go to Implementation")
		lsp_map("K", vim.lsp.buf.hover, "Hover Documentation")
		lsp_map("<C-k>", vim.lsp.buf.signature_help, "Signature Help")

		-- Actions
		lsp_map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
		lsp_map("<leader>rn", vim.lsp.buf.rename, "Rename")

		-- Diagnostics
		lsp_map("[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
		lsp_map("]d", vim.diagnostic.goto_next, "Next Diagnostic")
		lsp_map("<leader>dl", vim.diagnostic.open_float, "Show Line Diagnostics")

		-- format on save (to use LSP formatter instead of conform)
		-- vim.api.nvim_buf_create_autocmd("BufWritePre", {
		--   buffer = ev.buf,
		--   callback = function() vim.lsp.buf.format { async = false } end
		-- })
		--
		local bufopts = { noremap = true, silent = true, buffer = bufnr }
	end,
})

-- SUPERCHARGED
setup_plugin("lsp-format")
setup_plugin("lspkind")

setup_plugin("lspsaga")

-- QUICKFIX

setup_plugin("trouble.nvim")
setup_plugin("quicker")

vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",

	callback = function()
		print("Entered quickfix!")
	end,

	setup_plugin("nvim-bqf", {}),
})

-- MISCELLANEOUS
setup_plugin("null-ls") -- still necessary?
-- setup_plugin("guard") -- TODO - needed?
setup_plugin("mypy")
setup_plugin("nvim-lint")
setup_plugin("refactoring")

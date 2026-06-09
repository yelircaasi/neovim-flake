-- TODO: set up pylsp-rope for refactoring
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
setup_plugin("lsp-format", {
	typescript = {
		tab_width = function()
			return vim.opt.shiftwidth:get()
		end,
	},
	yaml = { tab_width = 2 },
})
setup_plugin("lspkind", function(lspkind)
	lspkind.init({
		-- defines how annotations are shown
		-- default: symbol
		-- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
		mode = "symbol_text",

		-- default symbol map
		-- can be either 'default' (requires nerd-fonts font) or
		-- 'codicons' for codicon preset (requires vscode-codicons font)
		--
		-- default: 'default'
		preset = "codicons",

		-- override preset symbols
		--
		-- default: {}
		symbol_map = {
			Text = "󰉿",
			Method = "󰆧",
			Function = "󰊕",
			Constructor = "",
			Field = "󰜢",
			Variable = "󰀫",
			Class = "󰠱",
			Interface = "",
			Module = "",
			Property = "󰜢",
			Unit = "󰑭",
			Value = "󰎠",
			Enum = "",
			Keyword = "󰌋",
			Snippet = "",
			Color = "󰏘",
			File = "󰈙",
			Reference = "󰈇",
			Folder = "󰉋",
			EnumMember = "",
			Constant = "󰏿",
			Struct = "󰙅",
			Event = "",
			Operator = "󰆕",
			TypeParameter = "",
		},
	})
end)

setup_plugin("lspsaga", {
	layout = "normal", -- "float"
	symbol_in_winbar = {
		enable = true,
		separator = " › ",
		hide_keyword = false,
		show_file = true,
		folder_level = 1,
		color_mode = true,
		delay = 300,
	},
	code_action = {
		num_shortcut = true,
		show_server_name = false,
		extend_gitsigns = false,
		keys = {
			quit = "q",
			exec = "<CR>",
		},
	},
	definition = {
		width = 0.6,
		height = 0.5,
		keys = {
			edit = "o",
			edit = "<C-c>o",
			vsplit = "<C-c>v",
			split = "<C-c>i",
			tabe = "<C-c>t",
			quit = "q",
			close = "<C-c>k",
		},
	},
	diagnostic = {
		show_code_action = true,
		jump_num_shortcut = true,
		max_width = 0.8,
		max_height = 0.6,
		text_hl_follow = true,
		border_follow = true,
		extend_relatedInformation = false,
		show_layout = "float",
		show_normal_height = 10,
		max_show_width = 0.9,
		max_show_height = 0.6,
		diagnostic_only_current = false,
		keys = {
			exec_action = "o",
			quit = "q",
			toggle_or_jump = "<CR>",
			quit_in_show = { "q", "<ESC>" },
		},
	},
	finder = {
		max_height = 0.5,
		left_width = 0.3,
		right_width = 0.3,
		default = "ref+imp",
		methods = {},
		layout = "float",
		filter = {}, -- TODO
		silent = false,
		keys = {
			shuttle = "[w",
			toggle_or_open = "o",
			vsplit = "s",
			split = "i",
			tabe = "t",
			tabnew = "r",
			quit = "q",
			close = "<C-c>k",
		},
	},
	outline = {
		win_position = "right",
		win_width = 30,
		auto_preview = true,
		detail = true,
		auto_close = true,
		close_after_jump = false,
		layout = "normal",
		max_height = 0.5,
		left_width = 0.3,
		keys = {
			toggle_or_jump = "o",
			quit = "q",
			jump = "e",
		},
	},
	rename = {
		in_select = true,
		auto_save = false,
		project_max_width = 0.5,
		project_max_height = 0.5,
		keys = {
			quit = "<C-k>",
			exec = "<CR>",
			select = "x",
		},
	},
	ui = {
		border = "single",
		devicon = true,
		title = true,
		expand = "⊞",
		collapse = "⊟",
		code_action = "💡",
		actionfix = " ",
		lines = { "┗", "┣", "┃", "━", "┏" },
		kind = {},
		imp_sign = "󰳛 ",
	},
})
vim.keymap.set({ "n", "t" }, "<A-d>", "<cmd>Lspsaga term_toggle")
vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc")

-- QUICKFIX

---@class trouble.Mode: trouble.Config,trouble.Section.spec
---@field desc? string
---@field sections? string[]

---@class trouble.Config
---@field mode? string
---@field config? fun(opts:trouble.Config)
---@field formatters? table<string,trouble.Formatter> custom formatters
---@field filters? table<string, trouble.FilterFn> custom filters
---@field sorters? table<string, trouble.SorterFn> custom sorters
local trouble_defaults = {
	auto_close = false, -- auto close when there are no items
	auto_open = false, -- auto open when there are items
	auto_preview = true, -- automatically open preview when on an item
	auto_refresh = true, -- auto refresh when open
	auto_jump = false, -- auto jump to the item when there's only one
	focus = false, -- Focus the window when opened
	restore = true, -- restores the last location in the list when opening
	follow = true, -- Follow the current item
	indent_guides = true, -- show indent guides
	max_items = 200, -- limit number of items that can be displayed per section
	multiline = true, -- render multi-line messages
	pinned = false, -- When pinned, the opened trouble window will be bound to the current buffer
	warn_no_results = true, -- show a warning when there are no results
	open_no_results = false, -- open the trouble window when there are no results
	---@type trouble.Window.opts
	win = {}, -- window options for the results window. Can be a split or a floating window.
	-- Window options for the preview window. Can be a split, floating window,
	-- or `main` to show the preview in the main editor window.
	---@type trouble.Window.opts
	preview = {
		type = "main",
		-- when a buffer is not yet loaded, the preview window will be created
		-- in a scratch buffer with only syntax highlighting enabled.
		-- Set to false, if you want the preview to always be a real loaded buffer.
		scratch = true,
	},
	-- Throttle/Debounce settings. Should usually not be changed.
	---@type table<string, number|{ms:number, debounce?:boolean}>
	throttle = {
		refresh = 20, -- fetches new data when needed
		update = 10, -- updates the window
		render = 10, -- renders the window
		follow = 100, -- follows the current item
		preview = { ms = 100, debounce = true }, -- shows the preview for the current item
	},
	-- Key mappings can be set to the name of a builtin action,
	-- or you can define your own custom action.
	---@type table<string, trouble.Action.spec|false>
	keys = {
		["?"] = "help",
		r = "refresh",
		R = "toggle_refresh",
		q = "close",
		o = "jump_close",
		["<esc>"] = "cancel",
		["<cr>"] = "jump",
		["<2-leftmouse>"] = "jump",
		["<c-s>"] = "jump_split",
		["<c-v>"] = "jump_vsplit",
		-- go down to next item (accepts count)
		-- j = "next",
		["}"] = "next",
		["]]"] = "next",
		-- go up to prev item (accepts count)
		-- k = "prev",
		["{"] = "prev",
		["[["] = "prev",
		dd = "delete",
		d = { action = "delete", mode = "v" },
		i = "inspect",
		p = "preview",
		P = "toggle_preview",
		zo = "fold_open",
		zO = "fold_open_recursive",
		zc = "fold_close",
		zC = "fold_close_recursive",
		za = "fold_toggle",
		zA = "fold_toggle_recursive",
		zm = "fold_more",
		zM = "fold_close_all",
		zr = "fold_reduce",
		zR = "fold_open_all",
		zx = "fold_update",
		zX = "fold_update_all",
		zn = "fold_disable",
		zN = "fold_enable",
		zi = "fold_toggle_enable",
		gb = { -- example of a custom action that toggles the active view filter
			action = function(view)
				view:filter({ buf = 0 }, { toggle = true })
			end,
			desc = "Toggle Current Buffer Filter",
		},
		s = { -- example of a custom action that toggles the severity
			action = function(view)
				local f = view:get_filter("severity")
				local severity = ((f and f.filter.severity or 0) + 1) % 5
				view:filter({ severity = severity }, {
					id = "severity",
					template = "{hl:Title}Filter:{hl} {severity}",
					del = severity == 0,
				})
			end,
			desc = "Toggle Severity Filter",
		},
	},
	---@type table<string, trouble.Mode>
	modes = {
		-- sources define their own modes, which you can use directly,
		-- or override like in the example below
		lsp_references = {
			-- some modes are configurable, see the source code for more details
			params = {
				include_declaration = true,
			},
		},
		-- The LSP base mode for:
		-- * lsp_definitions, lsp_references, lsp_implementations
		-- * lsp_type_definitions, lsp_declarations, lsp_command
		lsp_base = {
			params = {
				-- don't include the current location in the results
				include_current = false,
			},
		},
		-- more advanced example that extends the lsp_document_symbols
		symbols = {
			desc = "document symbols",
			mode = "lsp_document_symbols",
			focus = false,
			win = { position = "right" },
			filter = {
				-- remove Package since luals uses it for control flow structures
				["not"] = { ft = "lua", kind = "Package" },
				any = {
					-- all symbol kinds for help / markdown files
					ft = { "help", "markdown" },
					-- default set of symbol kinds
					kind = {
						"Class",
						"Constructor",
						"Enum",
						"Field",
						"Function",
						"Interface",
						"Method",
						"Module",
						"Namespace",
						"Package",
						"Property",
						"Struct",
						"Trait",
					},
				},
			},
		},
	},
	icons = {
		---@type trouble.Indent.symbols
		indent = {
			top = "│ ",
			middle = "├╴",
			last = "└╴",
			-- last          = "-╴",
			-- last       = "╰╴", -- rounded
			fold_open = " ",
			fold_closed = " ",
			ws = "  ",
		},
		folder_closed = " ",
		folder_open = " ",
		kinds = {
			Array = " ",
			Boolean = "󰨙 ",
			Class = " ",
			Constant = "󰏿 ",
			Constructor = " ",
			Enum = " ",
			EnumMember = " ",
			Event = " ",
			Field = " ",
			File = " ",
			Function = "󰊕 ",
			Interface = " ",
			Key = " ",
			Method = "󰊕 ",
			Module = " ",
			Namespace = "󰦮 ",
			Null = " ",
			Number = "󰎠 ",
			Object = " ",
			Operator = " ",
			Package = " ",
			Property = " ",
			String = " ",
			Struct = "󰆼 ",
			TypeParameter = " ",
			Variable = "󰀫 ",
		},
	},
}
setup_plugin("trouble.nvim", trouble_defaults)
setup_plugin("quicker", {
	-- Local options to set for quickfix
	opts = {
		buflisted = false,
		number = false,
		relativenumber = false,
		signcolumn = "auto",
		winfixheight = true,
		wrap = false,
	},
	-- Set to false to disable the default options in `opts`
	use_default_opts = true,
	-- Keymaps to set for the quickfix buffer
	keys = {
		-- { ">", "<cmd>lua require('quicker').expand()<CR>", desc = "Expand quickfix content" },
	},
	-- Callback function to run any custom logic or keymaps for the quickfix buffer
	on_qf = function(bufnr) end,
	edit = {
		-- Enable editing the quickfix like a normal buffer
		enabled = true,
		-- Set to true to write buffers after applying edits.
		-- Set to "unmodified" to only write unmodified buffers.
		autosave = "unmodified",
	},
	-- Keep the cursor to the right of the filename and lnum columns
	constrain_cursor = true,
	highlight = {
		-- Use treesitter highlighting
		treesitter = true,
		-- Use LSP semantic token highlighting
		lsp = true,
		-- Load the referenced buffers to apply more accurate highlights (may be slow)
		load_buffers = false,
	},
	follow = {
		-- When quickfix window is open, scroll to closest item to the cursor
		enabled = false,
	},
	-- Map of quickfix item type to icon
	type_icons = {
		E = "󰅚 ",
		W = "󰀪 ",
		I = " ",
		N = " ",
		H = " ",
	},
	-- Border characters
	borders = {
		vert = "┃",
		-- Strong headers separate results from different files
		strong_header = "━",
		strong_cross = "╋",
		strong_end = "┫",
		-- Soft headers separate results within the same file
		soft_header = "╌",
		soft_cross = "╂",
		soft_end = "┨",
	},
	-- How to trim the leading whitespace from results. Can be 'all', 'common', or false
	trim_leading_whitespace = "common",
	-- Maximum width of the filename column
	max_filename_width = function()
		return math.floor(math.min(95, vim.o.columns / 2))
	end,
	-- How far the header should extend to the right
	header_length = function(type, start_col)
		return vim.o.columns - start_col
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",

	callback = function()
		print("Entered quickfix!")
	end,

	setup_plugin("nvim-bqf", {}),
})

-- MISCELLANEOUS
setup_plugin("null-ls") -- OBSOLETE
-- setup_plugin("guard") -- TODO - needed?
setup_plugin("mypy", {
	-- additional arguments to pass to invocations of `mypy`
	-- by default, it is called with `--show-error-end --follow-imports=silent`
	extra_args = { "--check-untyped-defs", "--verbose" },
	-- override mypy diagnostic severities
	-- the default is { error = vim.diagnostic.severity.WARN, note = vim.diagnostic.severity.HINT }
	severities = { error = vim.diagnostic.severity.ERROR, note = vim.diagnostic.severity.INFO },
})
setup_plugin("nvim-lint", function(lint)
	lint.linters_by_ft = {
		markdown = { "vale" },
	}

	vim.api.nvim_create_autocmd({ "BufWritePost" }, {
		callback = function()
			-- try_lint without arguments runs the linters defined in `linters_by_ft`
			-- for the current filetype
			lint.try_lint()

			-- You can call `try_lint` with a linter name or a list of names to always
			-- run specific linters, independent of the `linters_by_ft` configuration
			lint.try_lint("cspell")
		end,
	})
end)
setup_plugin("refactoring", function(refactoring)
	refactoring.setup()
	local keymap = vim.keymap

	keymap.set({ "n", "x" }, "<leader>re", function()
		return require("refactoring").extract_func()
	end, { desc = "Extract Function", expr = true })
	-- `_` is the default textobject for "current line"
	keymap.set("n", "<leader>ree", function()
		return require("refactoring").extract_func() .. "_"
	end, { desc = "Extract Function (line)", expr = true })

	keymap.set({ "n", "x" }, "<leader>rE", function()
		return require("refactoring").extract_func_to_file()
	end, { desc = "Extract Function To File", expr = true })

	keymap.set({ "n", "x" }, "<leader>rv", function()
		return require("refactoring").extract_var()
	end, { desc = "Extract Variable", expr = true })

	-- `_` is the default textobject for "current line"
	keymap.set("n", "<leader>rvv", function()
		return require("refactoring").extract_var() .. "_"
	end, { desc = "Extract Variable (line)", expr = true })

	keymap.set({ "n", "x" }, "<leader>ri", function()
		return require("refactoring").inline_var()
	end, { desc = "Inline Variable", expr = true })
	keymap.set({ "n", "x" }, "<leader>rI", function()
		return require("refactoring").inline_func()
	end, { desc = "Inline function", expr = true })

	keymap.set({ "n", "x" }, "<leader>rs", function()
		return require("refactoring").select_refactor()
	end, { desc = "Select refactor" })

	-- `iw` is the builtin textobject for "in word". You can use any other textobject or even create the keymap without any textobject if you prefer to provide one yourself each time that you use the keymap
	keymap.set("n", "<leader>pv", function()
		return require("refactoring.debug").print_var({ output_location = "below" }) .. "iw"
	end, { desc = "Debug print var below", expr = true })
	keymap.set("x", "<leader>pv", function()
		return require("refactoring.debug").print_var({ output_location = "below" })
	end, { desc = "Debug print var below", expr = true })

	-- `iw` is the builtin textobject for "in word". You can use any other textobject or even create the keymap without any textobject if you prefer to provide one yourself each time that you use the keymap
	keymap.set("n", "<leader>pV", function()
		return require("refactoring.debug").print_var({ output_location = "above" }) .. "iw"
	end, { desc = "Debug print var above", expr = true })
	keymap.set("x", "<leader>pV", function()
		return require("refactoring.debug").print_var({ output_location = "above" })
	end, { desc = "Debug print var above", expr = true })

	keymap.set({ "x", "n" }, "<leader>pe", function()
		return require("refactoring.debug").print_exp({ output_location = "below" })
	end, { desc = "Debug print exp below", expr = true })
	-- `_` is the default textobject for "current line"
	keymap.set("n", "<leader>pee", function()
		return require("refactoring.debug").print_exp({ output_location = "below" }) .. "_"
	end, { desc = "Debug print exp below", expr = true })

	keymap.set({ "x", "n" }, "<leader>pE", function()
		return require("refactoring.debug").print_exp({ output_location = "above" })
	end, { desc = "Debug print exp above", expr = true })
	-- `_` is the default textobject for "current line"
	keymap.set("n", "<leader>pEE", function()
		return require("refactoring.debug").print_exp({ output_location = "above" }) .. "_"
	end, { desc = "Debug print exp above", expr = true })

	keymap.set("n", "<leader>pP", function()
		return require("refactoring.debug").print_loc({ output_location = "above" })
	end, { desc = "Debug print location", expr = true })
	keymap.set("n", "<leader>pp", function()
		return require("refactoring.debug").print_loc({ output_location = "below" })
	end, { desc = "Debug print location", expr = true })

	keymap.set({ "x", "n" }, "<leader>pc", function()
		-- `ag` is a custom textobject that selects the whole buffer. It's provided by plugins like `mini.ai` (requires manual configuration using `MiniExtra.gen_ai_spec.buffer()`).
		-- return require("refactoring.debug").cleanup { restore_view = true } .. "ag"

		-- this keymap doesn't select any textobject by default, so you need to provide one each time you use it.
		return require("refactoring.debug").cleanup({ restore_view = true })
	end, { desc = "Debug print clean", expr = true, remap = true })
end)

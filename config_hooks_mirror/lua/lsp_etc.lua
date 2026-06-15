-- TODO: Divide up by language and keep only the global (cross-language) configuration here.

-- [Modern Neovim LSP Setup Guide](https://www.youtube.com/watch?v=lljs_7xB7Ps)

vim.cmd("set completeopt+=noselect")

-- AUTOCOMMANDS -------------------------------------------------------------------------------

local function on_attach(ev)
	local client = vim.lsp.get_client_by_id(ev.data.client_id)
	if client.name == "ruff" then
		client.server_capabilities.hoverProvider = false
	end

	if client:supports_method("textDocument/completion") then
		vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
	end

	local shared_opts = { buffer = ev.buf, silent = true }
	map_explicit({
		mode = "n",
		sequence = "gd",
		action = vim.lsp.buf.definition,
		opts = shared_opts,
	})
	map_explicit({
		mode = "n",
		sequence = "K",
		action = vim.lsp.buf.hover,
		opts = shared_opts,
	})
	map_explicit({
		mode = "n",
		sequence = "<leader>rn",
		action = vim.lsp.buf.rename,
		opts = shared_opts,
	})
	map_explicit({
		mode = "n",
		sequence = "<leader>ca",
		action = vim.lsp.buf.code_action,
		opts = shared_opts,
	})
	map_explicit({
		mode = "n",
		sequence = "<leader>cf",
		action = function()
			require("conform").format({ bufnr = ev.buf })
		end,
		opts = shared_opts,
	})
	map_explicit({
		mode = "n",
		sequence = "<leader>cl",
		action = vim.lsp.codelens.run,
		opts = shared_opts,
	})
end

vim.api.nvim_create_autocmd("LspAttach", { callback = on_attach })

-- LSP UI ------------------------------------------------------------------------------------------------

-- https://github.com/dgagn/diagflow.nvim
-- LSP diagnostics in virtual text at the top right of your screen
local diagflow_defaults = {
	enable = true,
	max_width = 60, -- The maximum width of the diagnostic messages
	max_height = 10, -- the maximum height per diagnostics
	severity_colors = { -- The highlight groups to use for each diagnostic severity level
		error = "DiagnosticFloatingError",
		warning = "DiagnosticFloatingWarn",
		info = "DiagnosticFloatingInfo",
		hint = "DiagnosticFloatingHint",
	},
	format = function(diagnostic)
		return diagnostic.message
	end,
	gap_size = 1,
	scope = "cursor", -- 'cursor', 'line' this changes the scope, so instead of showing errors under the cursor, it shows errors on the entire line.
	padding_top = 0,
	padding_right = 0,
	text_align = "right", -- 'left', 'right'
	placement = "top", -- 'top', 'inline'
	inline_padding_left = 0, -- the padding left when the placement is inline
	update_event = { "DiagnosticChanged", "BufReadPost" }, -- the event that updates the diagnostics cache
	toggle_event = {}, -- if InsertEnter, can toggle the diagnostics on inserts
	show_sign = false, -- set to true if you want to render the diagnostic sign before the diagnostic message
	render_event = { "DiagnosticChanged", "CursorMoved" },
	border_chars = {
		top_left = "┌",
		top_right = "┐",
		bottom_left = "└",
		bottom_right = "┘",
		horizontal = "─",
		vertical = "│",
	},
	show_borders = false,
}
setup_plugin("diagflow", diagflow_defaults)

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

map_explicit({
	mode = "n",
	sequence = "<leader>dt",
	action = function()
		diagnostics_active = not diagnostics_active
		set_diagnostics_mode()
	end,
	opts = { desc = "Toggle LSP Diagnostics" },
})
map_explicit({
	mode = "n",
	sequence = "<leader>dm",
	action = function()
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
	end,
	desc = "Cycle LSP Diagnostic Modes",
})

set_diagnostics_mode()

-- CONFORM --------------------------------------------------------------------------------------------

local conform_config = {
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
}
setup_plugin("conform", function(conform)
	conform.setup(conform_config)

	vim.api.nvim_create_autocmd("BufWritePre", {
		-- pattern = "*.py",
		callback = function(args)
			conform.format({ bufnr = args.buf })
		end,
		-- desc = "Format Python on save with conform",
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

local lspkind_defaults = {
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
}
setup_plugin("lspkind", function(lspkind)
	lspkind.init(lspkind_defaults)
end)

local lspsaga_defaults = {
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
}
setup_plugin("lspsaga", lspsaga_defaults)
map_explicit({
	mode = { "n", "t" },
	action = "<A-d>",
	desc = "<cmd>Lspsaga term_toggle",
})
map_explicit({
	mode = "n",
	action = "K",
	desc = "<cmd>Lspsaga hover_doc",
})

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

local quicker_defaults = {
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
}
setup_plugin("quicker", quicker_defaults)

vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",

	callback = function()
		print("Entered quickfix!")
	end,

	setup_plugin("nvim-bqf", {}),
})

-- MISCELLANEOUS
-- setup_plugin("null-ls") -- OBSOLETE
-- setup_plugin("guard") -- TODO - needed?

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

-- https://github.com/kevinhwang91/nvim-bqf
-- Better quickfix window in Neovim, polish old quickfix window.
local bqf_config = {
	auto_enable = true,
	auto_resize_height = true, -- highly recommended enable
	preview = {
		win_height = 12,
		win_vheight = 12,
		delay_syntax = 80,
		border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
		show_title = false,
		should_preview_cb = function(bufnr, qwinid)
			local ret = true
			local bufname = vim.api.nvim_buf_get_name(bufnr)
			local fsize = vim.fn.getfsize(bufname)
			if fsize > 100 * 1024 then
				-- skip file size greater than 100k
				ret = false
			elseif bufname:match("^fugitive://") then
				-- skip fugitive buffer
				ret = false
			end
			return ret
		end,
	},
	-- make `drop` and `tab drop` to become preferred
	func_map = {
		drop = "o",
		openc = "O",
		split = "<C-s>",
		tabdrop = "<C-t>",
		-- set to empty string to disable
		tabc = "",
		ptogglemode = "z,",
	},
	filter = {
		fzf = {
			action_for = { ["ctrl-s"] = "split", ["ctrl-t"] = "tab drop" },
			extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
		},
	},
}
setup_plugin("bqf", bqf_config)

-- https://github.com/Dr-42/error-jump.nvim
-- Gives basic functionality for error messages with format filename:line:column
setup_plugin("error-jump", function(error_jump)
	map_explicit({
		mode = "n",
		sequence = "<leader>es",
		action = error_jump.jump_to_error,
		desc = "[E]rror [S]ource",
	})
	map_explicit({
		mode = "n",
		sequence = "<leader>en",
		action = error_jump.next_error,
		desc = "[E]rror [N]ext",
	})
	map_explicit({
		mode = "n",
		sequence = "<leader>eN",
		action = error_jump.previous_error,
		desc = "[E]rror [N]previous",
	})
	map_explicit({
		mode = "n",
		sequence = "<leader>ec",
		action = error_jump.compile,
		desc = "[E]rror [C]ompile",
	})
end)

-- https://github.com/ashfinal/qfview.nvim
-- Pretty quickfix/location view for Neovim
-- no config options
setup_plugin("qfview")

-- https://github.com/marcelofern/vale.nvim
-- A Neovim wrapper around Vale, the syntax-aware linter for prose.
local vale_defaults = {
	-- path to the vale binary.
	bin = "/bin/vale",
	-- path to your vale-specific configuration.
	vale_config_path = "$HOME/.config/vale/vale.ini",
}
setup_plugin("vale", vale_defaults)

-- https://github.com/chrisgrieser/nvim-genghis
-- Lightweight and quick file operations without being a full-blown file manager.
local nvim_genghis_defaults = {
	fileOperations = {
		-- automatically keep the extension when no file extension is given
		-- (everything after the first non-leading dot is treated as the extension)
		autoAddExt = true,

		trashCmd = function() ---@type fun(): string|string[]
			if jit.os == "OSX" then
				return "trash"
			end -- builtin since macOS 14
			if jit.os == "Windows" then
				return "trash"
			end
			if jit.os == "Linux" then
				return { "gio", "trash" }
			end
			return "trash-cli"
		end,

		ignoreInFolderSelection = { -- using lua pattern matching (e.g., escape `-` as `%-`)
			"/node_modules/", -- nodejs
			"/typings/", -- python
			"/doc/", -- vim help files folders
			"%.app/", -- macOS pseudo-folders
			"/%.", -- hidden folders
		},
	},

	navigation = {
		onlySameExtAsCurrentFile = false,
		ignoreDotfiles = true,
		ignoreExt = { "png", "svg", "webp", "jpg", "jpeg", "gif", "pdf", "zip" },
		ignoreFilesWithName = { ".DS_Store" },
	},

	successNotifications = true,

	icons = { -- set an icon to empty string to disable it
		chmodx = "󰒃",
		copyFile = "󱉥",
		copyPath = "󰅍",
		duplicate = "",
		file = "󰈔",
		move = "󰪹",
		new = "󰝒",
		nextFile = "󰖽",
		prevFile = "󰖿",
		rename = "󰑕",
		trash = "󰩹",
	},
}
setup_plugin("nvim-genghis", nvim_genghis_defaults)

-- https://github.com/Ttibsi/pre-commit.nvim
-- Trigger pre-commit linters/formatter straight from within Neovim
local precommit_defaults = nil
setup_plugin("precommit", precommit_defaults)

-- https://github.com/mfussenegger/nvim-lint
-- An asynchronous linter plugin for Neovim complementary to the built-in Language Server Protocol support.
setup_plugin("lint", function(lint) end)

-- https://github.com/RaafatTurki/corn.nvim
-- LSP diagnostics at your corner
local corn_defaults = {
	-- enables plugin auto commands
	auto_cmds = true,

	-- sorts diagnostics according to a criteria. must be one of `severity`, `severity_reverse`, `column`, `column_reverse`, `line_number` or `line_number_reverse`
	sort_method = "severity",

	-- sets the scope to be searched for diagnostics, must be one of `line` or `file`
	scope = "line",

	-- sets the style of the border, must be one of `single`, `double`, `rounded`, `solid`, `shadow` or `none`
	border_style = "single",

	-- sets which vim modes corn isn't allowed to render in, should contain strings like 'n', 'i', 'v', 'V' .. etc
	blacklisted_modes = {},

	-- sets which severity corn isn't allowed to render in, should contain diagnostic severities like:
	-- vim.diagnostic.severity.HINT
	-- vim.diagnostic.severity.INFO
	-- vim.diagnostic.severity.WARN
	-- vim.diagnostic.severity.ERROR
	blacklisted_severities = {},

	-- highlights to use for each diagnostic severity level
	highlights = {
		error = "DiagnosticFloatingError",
		warn = "DiagnosticFloatingWarn",
		info = "DiagnosticFloatingInfo",
		hint = "DiagnosticFloatingHint",
	},

	-- icons to use for each diagnostic severity level
	icons = {
		error = "E",
		warn = "W",
		hint = "H",
		info = "I",
	},

	-- a preprocessor function that takes a raw Corn.Item and returns it after modification, could be used for truncation or other purposes
	item_preprocess_func = function(item)
		-- the default truncation logic is here ...
		return item
	end,

	-- a hook that executes each time corn is toggled. the current state is provided via `is_hidden`
	on_toggle = function(is_hidden)
		-- custom logic goes here
	end,
}
setup_plugin("corn", corn_defaults)

-- https://github.com/dnlhc/glance.nvim
-- Peek preview window for LSP locations in Neovim
setup_plugin("glance", function(glance)
	local actions = glance.actions

	local glance_defaults = {
		height = 18, -- Height of the window
		zindex = 45,

		-- When enabled, adds virtual lines behind the preview window to maintain context in the parent window
		-- Requires Neovim >= 0.10.0
		preserve_win_context = true,

		-- Controls whether the preview window is "embedded" within your parent window or floating
		-- above all windows.
		detached = function(winid)
			-- Automatically detach when parent window width < 100 columns
			return vim.api.nvim_win_get_width(winid) < 100
		end,
		-- Or use a fixed setting: detached = true,

		preview_win_opts = { -- Configure preview window options
			cursorline = true,
			number = true,
			wrap = true,
		},

		border = {
			enable = false, -- Show window borders. Only horizontal borders allowed
			top_char = "―",
			bottom_char = "―",
		},

		list = {
			position = "right", -- Position of the list window 'left'|'right'
			width = 0.33, -- Width as percentage (0.1 to 0.5)
		},

		theme = {
			enable = true, -- Generate colors based on current colorscheme
			mode = "auto", -- 'brighten'|'darken'|'auto', 'auto' will set mode based on the brightness of your colorscheme
		},

		mappings = {
			list = {
				["j"] = actions.next, -- Next item
				["k"] = actions.previous, -- Previous item
				["<Down>"] = actions.next,
				["<Up>"] = actions.previous,
				["<Tab>"] = actions.next_location, -- Next location (skips groups, cycles)
				["<S-Tab>"] = actions.previous_location, -- Previous location (skips groups, cycles)
				["<C-u>"] = actions.preview_scroll_win(5), -- Scroll up the preview window
				["<C-d>"] = actions.preview_scroll_win(-5), -- Scroll down the preview window
				["v"] = actions.jump_vsplit, -- Open location in vertical split
				["s"] = actions.jump_split, -- Open location in horizontal split
				["t"] = actions.jump_tab, -- Open in new tab
				["<CR>"] = actions.jump, -- Jump to location
				["o"] = actions.jump,
				["l"] = actions.open_fold,
				["h"] = actions.close_fold,
				["<leader>l"] = actions.enter_win("preview"), -- Focus preview window
				["q"] = actions.close, -- Closes Glance window
				["Q"] = actions.close,
				["<Esc>"] = actions.close,
				["<C-q>"] = actions.quickfix, -- Send all locations to quickfix list
				-- ['<Esc>'] = false -- Disable a mapping
			},

			preview = {
				["Q"] = actions.close,
				["<Tab>"] = actions.next_location, -- Next location (skips groups, cycles)
				["<S-Tab>"] = actions.previous_location, -- Previous location (skips groups, cycles)
				["<leader>l"] = actions.enter_win("list"), -- Focus list window
			},
		},

		hooks = {}, -- Described in Hooks section

		folds = {
			fold_closed = "",
			fold_open = "",
			folded = true, -- Automatically fold list on startup
		},

		indent_lines = {
			enable = true, -- Show indent guidelines
			icon = "│",
		},

		winbar = {
			enable = true, -- Enable winbar for the preview (requires neovim-0.8+)
		},

		use_trouble_qf = false, -- Quickfix action will open trouble.nvim instead of built-in quickfix list
	}

	glance.setup()
end)

-- https://github.com/doums/dmap.nvim
-- nvim plugin providing a subtle overview of LSP diagnostics
local dmap_defaults = {
	-- highlight groups used for diagnostic marks
	-- by default link to corresponding `DiagnosticSign*` groups
	d_hl = {
		hint = "dmapHint",
		info = "dmapInfo",
		warn = "dmapWarn",
		error = "dmapError",
	},
	-- highlight group used for the diagnostic window
	-- by default link to `NormalFloat`
	win_hl = "dmapWin",
	-- text used for diagnostic marks
	-- ⚠ the text must be one character long
	d_mark = {
		hint = "╸",
		info = "╸",
		warn = "╸",
		error = "╸",
	},
	-- max height of the diagnostic window
	-- if not set defaults to the height of the reference window
	-- must be positive
	win_max_height = nil,
	-- alignment of the diagnostic window relative to the reference window
	-- `left` | `right`
	win_align = "right",
	-- horizontal offset (in character cell) of the diagnostic window
	-- must be positive
	win_h_offset = 1,
	-- vertical offset (in character cell) of the diagnostic window
	-- must be positive
	win_v_offset = 1,
	-- ignore these diagnostic sources
	ignore_sources = {},
	-- ignore these filetypes buffer
	ignore_filetypes = { "NvimTree" },
	-- severity option passed to `vim.diagnostic.get()` (`:h diagnostic-severity`)
	severity = nil,
	-- override arguments passed to `nvim_open_win` (see `:h nvim_open_win`)
	-- ⚠ can potentially break the plugin, use at your own risk
	nvim_float_api = nil,
}
setup_plugin("dmap", dmap_defaults)

-- https://github.com/emileferreira/nvim-strict
-- Strict, native code style formatting plugin for Neovim. Expose deep nesting, overlong lines, trailing whitespace, trailing empty lines, todos and inconsistent indentation.
local strict_defaults = {
	included_filetypes = nil,
	excluded_filetypes = nil,
	excluded_buftypes = { "help", "nofile", "terminal", "prompt" },
	match_priority = -1,
	deep_nesting = {
		highlight = true,
		highlight_group = "DiffDelete",
		depth_limit = 3,
		ignored_trailing_characters = nil,
		ignored_leading_characters = nil,
	},
	overlong_lines = {
		highlight = true,
		highlight_group = "DiffDelete",
		length_limit = 80,
		split_on_save = true,
	},
	trailing_whitespace = {
		highlight = true,
		highlight_group = "SpellBad",
		remove_on_save = true,
	},
	trailing_empty_lines = {
		highlight = true,
		highlight_group = "SpellBad",
		remove_on_save = true,
	},
	space_indentation = {
		highlight = false,
		highlight_group = "SpellBad",
		convert_on_save = false,
	},
	tab_indentation = {
		highlight = true,
		highlight_group = "SpellBad",
		convert_on_save = true,
	},
	todos = {
		highlight = true,
		highlight_group = "DiffAdd",
	},
}
setup_plugin("strict", strict_defaults)

-- https://github.com/davidyz/inlayhint-filler.nvim
-- For some languages like Python, the inlay-hint provided by the language server are actually optional
--     symbols/tokens that can be inserted into the buffer. This plugin provides an API to insert the
--     inlay-hint under the cursor into the buffer. In Python, this is useful when you want to insert
--     the type annotation from the language server into the code, or you want to turn an unnamed
--     argument (f(10)) into a named argument (f(x=10)).
--     This is particularly useful when working with functions that takes dozens of arguments.
local inlayhint_filler_defaults = {
	blacklisted_servers = {}, -- string[]
	force = false,
	eager = false,
	verbose = false,
}
setup_plugin("inlayhint-filler", inlayhint_filler_defaults)

-- https://github.com/m-demare/hlargs.nvim
-- Highlight arguments' definitions and usages, using Treesitter
local hlargs_defaults = {
	color = "#ef9062",
	highlight = {},
	excluded_filetypes = {},
	disable = function(lang, bufnr) -- If changed, `excluded_filetypes` will be ignored
		return vim.tbl_contains(opts.excluded_filetypes, lang)
	end,
	paint_arg_declarations = true,
	paint_arg_usages = true,
	paint_catch_blocks = {
		declarations = false,
		usages = false,
	},
	extras = {
		named_parameters = false,
		unused_args = false,
	},
	hl_priority = 120,
	excluded_argnames = {
		declarations = {},
		usages = {
			python = { "self", "cls" },
			lua = { "self" },
		},
	},
	performance = {
		parse_delay = 1,
		slow_parse_delay = 50,
		max_iterations = 400,
		max_concurrent_partial_parses = 30,
		debounce = {
			partial_parse = 3,
			partial_insert_mode = 100,
			total_parse = 700,
			slow_parse = 5000,
		},
	},
}
setup_plugin("hlargs", hlargs_defaults)

-- PROBABLY NOT, BUT WORTH A TRY
-- https://github.com/ray-x/lsp_signature.nvim
-- LSP signature hint as you type
local lsp_signature_defaults = {
	debug = false, -- set to true to enable debug logging
	log_path = vim.fn.stdpath("log") .. "/lsp_signature.log", -- log dir when debug is true
	-- default is  ~/.cache/nvim/lsp_signature.log
	verbose = false, -- show debug line number

	bind = true, -- This is mandatory, otherwise border config won't get registered.
	-- If you want to hook lspsaga or other signature handler, pls set to false
	doc_lines = 10, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
	-- set to 0 if you DO NOT want any API comments be shown
	-- This setting only take effect in insert mode, it does not affect signature help in normal
	-- mode, 10 by default

	max_height = 12, -- max height of signature floating_window, include borders
	max_width = function()
		return vim.api.nvim_win_get_width(0) * 0.8
	end, -- max_width of signature floating_window, line will be wrapped if exceed max_width
	-- the value need >= 40
	-- if max_width is function, it will be called
	wrap = true, -- allow doc/signature text wrap inside floating_window, useful if your lsp return doc/sig is too long
	floating_window = true, -- show hint in a floating window, set to false for virtual text only mode

	floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
	-- will set to true when fully tested, set to false will use whichever side has more space
	-- this setting will be helpful if you do not want the PUM and floating win overlap

	floating_window_off_x = 1, -- adjust float windows x position.
	-- can be either a number or function
	floating_window_off_y = 0, -- adjust float windows y position. e.g -2 move window up 2 lines; 2 move down 2 lines
	-- can be either number or function, see examples
	ignore_error = func(err, ctx, config), -- this scilence errors, check init.lua for more details

	close_timeout = 4000, -- close floating window after ms when laster parameter is entered
	fix_pos = false, -- set to true, the floating window will not auto-close until finish all parameters
	hint_enable = true, -- virtual hint enable
	hint_prefix = "🐼 ", -- Panda for parameter, NOTE: for the terminal not support emoji, might crash
	-- or, provide a table with 3 icons
	-- hint_prefix = {
	--     above = "↙ ",  -- when the hint is on the line above the current line
	--     current = "← ",  -- when the hint is on the same line
	--     below = "↖ "  -- when the hint is on the line below the current line
	-- }
	hint_scheme = "String",
	hint_inline = function()
		return false
	end, -- should the hint be inline(nvim 0.10 only)?  default false
	-- return true | 'inline' to show hint inline, return false | 'eol' to show hint at end of line
	-- return one of: true|false|virt_text_pos: 'eol', 'eol_right_align', 'overlay', 'right_align', 'inline'
	hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
	handler_opts = {
		border = "rounded", -- double, rounded, single, shadow, none, or a table of borders
	},

	always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58

	auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
	extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
	zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom

	padding = "", -- character to pad on left and right of signature can be ' ', or '|'  etc

	transparency = nil, -- disabled by default, allow floating win transparent value 1~100
	shadow_blend = 36, -- if you using shadow as border use this set the opacity
	shadow_guibg = "Black", -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
	timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
	toggle_key = nil, -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
	toggle_key_flip_floatwin_setting = false, -- true: toggle floating_windows: true|false setting after toggle key pressed
	-- false: floating_windows setup will not change, toggle_key will pop up signature helper, but signature
	-- may not popup when typing depends on floating_window setting

	select_signature_key = nil, -- cycle to next signature, e.g. '<M-n>' function overloading
	move_signature_window_key = nil, -- move the floating window, e.g. {'<M-k>', '<M-j>'} to move up and down, or
	-- table of 4 keymaps, e.g. {'<M-k>', '<M-j>', '<M-h>', '<M-l>'} to move up, down, left, right
	move_cursor_key = nil, -- imap, use nvim_set_current_win to move cursor between current win and floating window
	-- e.g. move_cursor_key = '<M-p>',
	-- once moved to floating window, you can use <M-d>, <M-u> to move cursor up and down
	keymaps = {}, -- relate to move_cursor_key; the keymaps inside floating window with arguments of bufnr
	-- e.g. keymaps = function(bufnr) vim.keymap.set(...) end
	-- it can be function that set keymaps
	-- e.g. keymaps = { { 'j', '<C-o>j' }, } this map j to <C-o>j in floating window
	-- <M-d> and <M-u> are default keymaps to move cursor up and down
}
setup_plugin("lsp_signature", lsp_signature_defaults)

-- https://github.com/kosayoda/nvim-lightbulb
-- VSCode 💡 for neovim's built-in LSP.
local nvim_lightbulb_defaults = {
	-- Priority of the lightbulb for all handlers except float.
	priority = 10,

	-- Whether or not to hide the lightbulb when the buffer is not focused.
	-- Only works if configured during NvimLightbulb.setup
	hide_in_unfocused_buffer = true,

	-- Whether or not to link the highlight groups automatically.
	-- Default highlight group links:
	--   LightBulbSign -> DiagnosticSignInfo
	--   LightBulbFloatWin -> DiagnosticFloatingInfo
	--   LightBulbVirtualText -> DiagnosticVirtualTextInfo
	--   LightBulbNumber -> DiagnosticSignInfo
	--   LightBulbLine -> CursorLine
	-- Only works if configured during NvimLightbulb.setup
	link_highlights = true,

	-- Perform full validation of configuration.
	-- Available options: "auto", "always", "never"
	--   "auto" only performs full validation in NvimLightbulb.setup.
	--   "always" performs full validation in NvimLightbulb.update_lightbulb as well.
	--   "never" disables config validation.
	validate_config = "auto",

	-- Code action kinds to observe.
	-- To match all code actions, set to `nil`.
	-- Otherwise, set to a table of kinds.
	-- Example: { "quickfix", "refactor.rewrite" }
	-- See: https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#codeActionKind
	action_kinds = nil,

	-- Enable code lens support.
	-- If the current position has executable code lenses, the icon is changed from `text` to `lens_text`
	-- for sign, virtual_text, float and status_text.
	-- The code lens icon is configurable per handler.
	code_lenses = false,

	-- Configuration for various handlers:
	-- 1. Sign column.
	sign = {
		enabled = true,
		-- Text to show in the sign column.
		-- Must be between 1-2 characters.
		text = "💡",
		lens_text = "🔎",
		-- Highlight group to highlight the sign column text.
		hl = "LightBulbSign",
	},

	-- 2. Virtual text.
	virtual_text = {
		enabled = false,
		-- Text to show in the virt_text.
		text = "💡",
		lens_text = "🔎",
		-- Position of virtual text given to |nvim_buf_set_extmark|.
		-- Can be a number representing a fixed column (see `virt_text_pos`).
		-- Can be a string representing a position (see `virt_text_win_col`).
		pos = "eol",
		-- Highlight group to highlight the virtual text.
		hl = "LightBulbVirtualText",
		-- How to combine other highlights with text highlight.
		-- See `hl_mode` of |nvim_buf_set_extmark|.
		hl_mode = "combine",
	},

	-- 3. Floating window.
	float = {
		enabled = false,
		-- Text to show in the floating window.
		text = "💡",
		lens_text = "🔎",
		-- Highlight group to highlight the floating window.
		hl = "LightBulbFloatWin",
		-- Window options.
		-- See |vim.lsp.util.open_floating_preview| and |nvim_open_win|.
		-- Note that some options may be overridden by |open_floating_preview|.
		win_opts = {
			focusable = false,
		},
	},

	-- 4. Status text.
	-- When enabled, will allow using |NvimLightbulb.get_status_text|
	-- to retrieve the configured text.
	status_text = {
		enabled = false,
		-- Text to set if a lightbulb is available.
		text = "💡",
		lens_text = "🔎",
		-- Text to set if a lightbulb is unavailable.
		text_unavailable = "",
	},

	-- 5. Number column.
	number = {
		enabled = false,
		-- Highlight group to highlight the number column if there is a lightbulb.
		hl = "LightBulbNumber",
	},

	-- 6. Content line.
	line = {
		enabled = false,
		-- Highlight group to highlight the line if there is a lightbulb.
		hl = "LightBulbLine",
	},

	-- Autocmd configuration.
	-- If enabled, automatically defines an autocmd to show the lightbulb.
	-- If disabled, you will have to manually call |NvimLightbulb.update_lightbulb|.
	-- Only works if configured during NvimLightbulb.setup
	autocmd = {
		-- Whether or not to enable autocmd creation.
		enabled = false,
		-- See |updatetime|.
		-- Set to a negative value to avoid setting the updatetime.
		updatetime = 200,
		-- See |nvim_create_autocmd|.
		events = { "CursorHold", "CursorHoldI" },
		-- See |nvim_create_autocmd| and |autocmd-pattern|.
		pattern = { "*" },
	},

	-- Scenarios to not show a lightbulb.
	ignore = {
		-- LSP client names to ignore.
		-- Example: {"null-ls", "lua_ls"}
		clients = {},
		-- Filetypes to ignore.
		-- Example: {"neo-tree", "lua"}
		ft = {},
		-- Ignore code actions without a `kind` like refactor.rewrite, quickfix.
		actions_without_kind = false,
	},

	--- A general filter function for code actions.
	--- The function is called for code actions *after* any `ignore` or `action_kinds`
	--- options are applied.
	--- The function should return true to keep the code action, false otherwise.
	---@type (fun(client_name:string, result:lsp.CodeAction|lsp.Command):boolean)|nil
	filter = nil,
}
setup_plugin("nvim-lightbulb", nvim_lightbulb_defaults)

--─────────────────────────────────────────────────────────────────────────────
--──── mappings ───────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

local lsp_map_opts = { buffer = bufnr, silent = true }

map_explicit({
	mode = { "i" },
	sequence = "kj",
	action = "<escape>",
})
map_explicit({
	mode = "n",
	sequence = "<leader>wq",
	action = function()
		vim.cmd("wq")
	end,
})
map_explicit({
	mode = "n",
	sequence = "<leader>ww",
	action = function()
		vim.cmd("w")
	end,
})
map_explicit({
	mode = "n",
	sequence = "<leader>q",
	action = function()
		-- Populates the Quickfix list with all diagnostics from the current buffer
		vim.diagnostic.setqflist({ bufnr = 0 })
		vim.cmd("copen")
	end,
	desc = "Open Quickfix with diagnostics",
})

-- TODO: check duplication; fold into above
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

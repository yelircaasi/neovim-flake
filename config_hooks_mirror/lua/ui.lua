--─────────────────────────────────────────────────────────────────────────────
--──── columns ────────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- https://github.com/m4xshen/smartcolumn.nvim
-- A Neovim plugin hiding your colorcolumn when unneeded.
local smartcolumn_defaults = {} -- TODO
setup_plugin("smartcolumn", smartcolumn_defaults)

-- https://github.com/luukvbaal/statuscol.nvim
-- Status column plugin that provides a configurable 'statuscolumn' and click handlers.
local statuscol_defaults = {} -- TODO
setup_plugin("statuscol", statuscol_defaults)

--─────────────────────────────────────────────────────────────────────────────
--──── menus, selection ───────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- https://github.com/nvzone/menu
-- Menu plugin for neovim ( supports nested menus ) made using volt
local menu_defaults = {} -- TODO
setup_plugin("menu", menu_defaults)

--─────────────────────────────────────────────────────────────────────────────
--──── outline ────────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- https://github.com/oskarrrrrrr/symbols.nvim
-- Code navigation sidebar for Neovim.
local symbols_defaults = {} -- TODO
setup_plugin("symbols", symbols_defaults)

-- TODO: maybe use aerial instead of navbuddy
-- https://github.com/stevearc/aerial.nvim
-- Neovim plugin for a code outline window
local aerial_config = {
	layout = {
		min_width = 30,
		default_direction = "prefer_right",
	},
	attach_mode = "window",
	close_automatic_events = {
		"unsupported",
		"switch_buffer",
	},
}
setup_plugin("aerial", function(aerial)
	aerial.setup(aerial_config)

	vim.keymap.set("n", "<leader>o", "<cmd>AerialToggle<cr>")
	vim.keymap.set("n", "{", "<cmd>AerialPrev<cr>")
	vim.keymap.set("n", "}", "<cmd>AerialNext<cr>")
end)

-- utils.packadd("nui") -- TODO: comment out after next build
-- https://github.com/SmiteshP/nvim-navbuddy
-- A simple popup display that provides breadcrumbs feature using LSP server
setup_plugin("nvim-navbuddy", function(navbuddy)
	navbuddy.setup({
		lsp = {
			auto_attach = true,
		},
	})

	vim.keymap.set("n", "<leader>nb", function()
		navbuddy.open()
	end)
end)

--─────────────────────────────────────────────────────────────────────────────
--──── lines, bars ──────────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- https://github.com/nvim-lualine/lualine.nvim
-- A blazing fast and easy to configure neovim statusline plugin written in pure lua.
local lualine_config = {
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
}
setup_plugin("lualine", lualine_config)

-- https://github.com/Bekaboo/dropbar.nvim
-- IDE-like breadcrumbs, out of the box
local dropbar_config = {
	-- bar = {
	-- 	padding = {
	-- 		left = 1,
	-- 		right = 1,
	-- 	},
	-- },
}
setup_plugin("dropbar", function(dropbar)
	dropbar.setup(dropbar_config)

	vim.ui.select = require("dropbar.utils.menu").select

	vim.keymap.set("n", "<leader>;", function()
		require("dropbar.api").pick()
	end)

	vim.keymap.set("n", "[;", function()
		require("dropbar.api").goto_context_start()
	end)

	vim.keymap.set("n", "];", function()
		require("dropbar.api").select_next_context()
	end)
end)

-- https://github.com/SmiteshP/nvim-navic
-- Simple winbar/statusline plugin that shows your current code context
local navic_defaults = {
	icons = {
		File = "󰈙 ",
		Module = " ",
		Namespace = "󰌗 ",
		Package = " ",
		Class = "󰌗 ",
		Method = "󰆧 ",
		Property = " ",
		Field = " ",
		Constructor = " ",
		Enum = "󰕘",
		Interface = "󰕘",
		Function = "󰊕 ",
		Variable = "󰆧 ",
		Constant = "󰏿 ",
		String = "󰀬 ",
		Number = "󰎠 ",
		Boolean = "◩ ",
		Array = "󰅪 ",
		Object = "󰅩 ",
		Key = "󰌋 ",
		Null = "󰟢 ",
		EnumMember = " ",
		Struct = "󰌗 ",
		Event = " ",
		Operator = "󰆕 ",
		TypeParameter = "󰊄 ",
		enabled = true,
	},
	lsp = {
		auto_attach = false,
		preference = nil,
	},
	highlight = false,
	separator = " > ",
	depth_limit = 0,
	depth_limit_indicator = "..",
	safe_output = true,
	lazy_update_context = false,
	click = false,
	format_text = function(text)
		return text
	end,
}
setup_plugin("navic", navic_defaults)

-- https://github.com/akinsho/bufferline.nvim
-- A snazzy bufferline for Neovim
local bufferline_defaults = {} -- TODO
setup_plugin("bufferline", bufferline_defaults)

---------------- alternative lines -------------
if false then
	setup_plugin("cokeline", {})
	setup_plugin("galaxyline", function(_) end)
	setup_plugin("heirline", {})
	setup_plugin("heirline-components", {})
	setup_plugin("nougat", function(_) end)
	setup_plugin("staline", {})
	setup_plugin("tabby", {})
	setup_plugin("minibar", {})
	setup_plugin("winbar", {})
	setup_plugin("windline", function(_) end)
end

--─────────────────────────────────────────────────────────────────────────────
--──── command interface ──────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- PROBABLY NOT, BUT WORTH A TRY
-- https://github.com/notomo/cmdbuf.nvim
-- Alternative command-line window plugin for neovim
local cmdbuf_defaults = {} -- TODO
setup_plugin("cmdbuf", function(cmdbuf)
	vim.keymap.set("n", "q:", function()
		cmdbuf.split_open(vim.o.cmdwinheight)
	end)
	vim.keymap.set("c", "<C-f>", function()
		cmdbuf.split_open(vim.o.cmdwinheight, { line = vim.fn.getcmdline(), column = vim.fn.getcmdpos() })
		vim.api.nvim_feedkeys(vim.keycode("<C-c>"), "n", true)
	end)

	-- Custom buffer mappings
	vim.api.nvim_create_autocmd({ "User" }, {
		group = vim.api.nvim_create_augroup("config.cmdbuf", {}),
		pattern = { "CmdbufNew" },
		callback = function(args)
			vim.bo.bufhidden = "wipe" -- if you don't need previous opened buffer state
			vim.keymap.set("n", "q", [[<Cmd>quit<CR>]], { nowait = true, buf = 0 })
			vim.keymap.set("n", "dd", [[<Cmd>lua require('cmdbuf').delete()<CR>]], { buf = 0 })
			vim.keymap.set({ "n", "i" }, "<C-c>", function()
				return cmdbuf.cmdline_expr()
			end, { buf = 0, expr = true })

			local typ = cmdbuf.get_context().type
			if typ == "vim/cmd" then
				-- you can filter buffer lines
				local lines = vim.iter(vim.api.nvim_buf_get_lines(args.buf, 0, -1, false))
					:filter(function(line)
						return line ~= "q"
					end)
					:totable()
				vim.api.nvim_buf_set_lines(args.buf, 0, -1, false, lines)
			end
		end,
	})

	-- open lua command-line window
	vim.keymap.set("n", "ql", function()
		cmdbuf.split_open(vim.o.cmdwinheight, { type = "lua/cmd" })
	end)

	-- q/, q? alternative
	vim.keymap.set("n", "q/", function()
		cmdbuf.split_open(vim.o.cmdwinheight, { type = "vim/search/forward" })
	end)
	vim.keymap.set("n", "q?", function()
		cmdbuf.split_open(vim.o.cmdwinheight, { type = "vim/search/backward" })
	end)
end)

-- https://github.com/nvim-mini/mini.cmdline
-- Command line tweaks. Part of 'mini.nvim' library.
local mini_cmdline_defaults = {
	-- Autocompletion: show `:h 'wildmenu'` as you type
	autocomplete = {
		enable = true,

		-- Delay (in ms) after which to trigger completion
		-- Neovim>=0.12 is recommended for positive values
		delay = 0,

		-- Custom rule of when to trigger completion
		predicate = nil,

		-- Whether to map arrow keys for more consistent wildmenu behavior
		map_arrows = true,
	},

	-- Autocorrection: adjust non-existing words (commands, options, etc.)
	autocorrect = {
		enable = true,

		-- Custom autocorrection rule
		func = nil,
	},

	-- Autopeek: show command's target range in a floating window
	autopeek = {
		enable = true,

		-- Number of lines to show above and below range lines
		n_context = 1,

		-- Custom rule of when to show peek window
		predicate = nil,

		-- Window options
		window = {
			-- Floating window config
			config = {},

			-- Function to render statuscolumn
			statuscolumn = nil,
		},
	},
}
setup_plugin("mini.cmdline", mini_cmdline_defaults)

--─────────────────────────────────────────────────────────────────────────────
--──── output, notification ───────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- https://github.com/j-hui/fidget.nvim
-- Extensible UI for Neovim notifications and LSP progress messages.
local fidget_defaults = {
	-- Options related to LSP progress subsystem
	progress = {
		poll_rate = 0, -- How and when to poll for progress messages
		suppress_on_insert = false, -- Suppress new messages while in insert mode
		ignore_done_already = false, -- Ignore new tasks that are already complete
		ignore_empty_message = false, -- Ignore new tasks that don't contain a message
		-- Clear notification group when LSP server detaches
		clear_on_detach = function(client_id)
			local client = vim.lsp.get_client_by_id(client_id)
			return client and client.name or nil
		end,
		-- How to get a progress message's notification group key
		notification_group = function(msg)
			return msg.lsp_client.name
		end,
		ignore = {}, -- List of LSP servers to ignore

		-- Options related to how LSP progress messages are displayed as notifications
		display = {
			render_limit = 16, -- How many LSP messages to show at once
			done_ttl = 3, -- How long a message should persist after completion
			done_icon = "✔", -- Icon shown when all LSP progress tasks are complete
			done_style = "Constant", -- Highlight group for completed LSP tasks
			progress_ttl = math.huge, -- How long a message should persist when in progress
			-- Icon shown when LSP progress tasks are in progress
			progress_icon = { "dots" },
			-- Highlight group for in-progress LSP tasks
			progress_style = "WarningMsg",
			group_style = "Title", -- Highlight group for group name (LSP server name)
			icon_style = "Question", -- Highlight group for group icons
			priority = 30, -- Ordering priority for LSP notification group
			skip_history = true, -- Whether progress notifications should be omitted from history
			-- How to format a progress message
			format_message = require("fidget.progress.display").default_format_message,
			-- How to format a progress annotation
			format_annote = function(msg)
				return msg.title
			end,
			-- How to format a progress notification group's name
			format_group_name = function(group)
				return tostring(group)
			end,
			overrides = { -- Override options from the default notification config
				rust_analyzer = { name = "rust-analyzer" },
			},
		},

		-- Options related to Neovim's built-in LSP client
		lsp = {
			progress_ringbuf_size = 0, -- Configure the nvim's LSP progress ring buffer size
			log_handler = false, -- Log `$/progress` handler invocations (for debugging)
		},
	},

	-- Options related to notification subsystem
	notification = {
		poll_rate = 10, -- How frequently to update and render notifications
		filter = vim.log.levels.INFO, -- Minimum notifications level
		history_size = 128, -- Number of removed messages to retain in history
		override_vim_notify = false, -- Automatically override vim.notify() with Fidget
		-- How to configure notification groups when instantiated
		configs = { default = require("fidget.notification").default_config },
		-- Conditionally redirect notifications to another backend
		redirect = function(msg, level, opts)
			if opts and opts.on_open then
				return require("fidget.integration.nvim-notify").delegate(msg, level, opts)
			end
		end,

		-- Options related to how notifications are rendered as text
		view = {
			stack_upwards = true, -- Display notification items from bottom to top
			align = "message", -- Indent messages longer than a single line
			reflow = false, -- Reflow (wrap) messages wider than notification window
			icon_separator = " ", -- Separator between group name and icon
			group_separator = "---", -- Separator between notification groups
			-- Highlight group used for group separator
			group_separator_hl = "Comment",
			line_margin = 1, -- Spaces to pad both sides of each non-empty line
			-- How to render notification messages
			render_message = function(msg, cnt)
				return cnt == 1 and msg or string.format("(%dx) %s", cnt, msg)
			end,
		},

		-- Options related to the notification window and buffer
		window = {
			normal_hl = "Comment", -- Base highlight group in the notification window
			winblend = 100, -- Background color opacity in the notification window
			border = "none", -- Border around the notification window
			zindex = 45, -- Stacking priority of the notification window
			max_width = 0, -- Maximum width of the notification window
			max_height = 0, -- Maximum height of the notification window
			x_padding = 1, -- Padding from right edge of window boundary
			y_padding = 0, -- Padding from bottom edge of window boundary
			align = "bottom", -- How to align the notification window
			relative = "editor", -- What the notification window position is relative to
			tabstop = 8, -- Width of each tab character in the notification window
			avoid = {}, -- Filetypes the notification window should avoid
			-- e.g., { "aerial", "NvimTree", "neotest-summary" }
		},
	},

	-- Options related to integrating with other plugins
	integration = {
		["nvim-tree"] = {
			enable = true, -- Integrate with nvim-tree/nvim-tree.lua (if installed)
			-- DEPRECATED; use notification.window.avoid = { "NvimTree" }
		},
		["xcodebuild-nvim"] = {
			enable = true, -- Integrate with wojciech-kulik/xcodebuild.nvim (if installed)
			-- DEPRECATED; use notification.window.avoid = { "TestExplorer" }
		},
	},

	-- Options related to logging
	logger = {
		level = vim.log.levels.WARN, -- Minimum logging level
		max_size = 10000, -- Maximum log file size, in KB
		float_precision = 0.01, -- Limit the number of decimals displayed for floats
		-- Where Fidget writes its logs to
		path = string.format("%s/fidget.nvim.log", vim.fn.stdpath("cache")),
	},
}
setup_plugin("fidget", {
	notification = {
		window = {
			winblend = 0,
		},
	},
	progress = {
		suppress_on_insert = false,
	},
})

-- PROBABLY NOT, BUT WORTH A TRY (== nvim-notify ?)
-- https://github.com/rcarriga/nvim-notify
-- A fancy, configurable, notification manager for NeoVim
local notify_defaults = {} -- TODO
setup_plugin("notify", notify_defaults)

-- TODO: resolve and remove duplication
setup_plugin("nvim-notify", function(notify)
	notify.setup({
		stages = "fade",
		timeout = 3000,
		render = "wrapped-default",
		max_width = function()
			return math.floor(vim.o.columns * 0.4)
		end,
	})

	vim.notify = notify
end)

-- https://github.com/mhanberg/control-panel.nvim
-- experimental plugin, use with caution
local control_panel_defaults = nil
setup_plugin("control_panel", control_panel_defaults)

-- TODO: translate lazy.nvim options from README
-- https://github.com/mhanberg/output-panel.nvim
-- A panel to view the logs from your LSP servers.
local output_panel_defaults = {
	max_buffer_size = 5000, -- default
}
setup_plugin("output_panel", output_panel_defaults)

--─────────────────────────────────────────────────────────────────────────────
--──── UI libraries ───────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- https://github.com/CosmicNvim/cosmic-ui
-- Cosmic-UI is a simple wrapper around specific vim functionality. Built in order to provide a quick and easy way to create a Cosmic UI experience with Neovim!
local cosmic_ui_defaults = {
	notify_title = "CosmicUI",

	rename = {
		enabled = true, -- optional (defaults to true when table exists)
		border = {
			highlight = "FloatBorder",
			style = nil, -- falls back to vim.o.winborder
			title = "Rename",
			title_align = "left",
			title_hl = "FloatBorder",
		},
		prompt = "> ",
		prompt_hl = "Comment",
	},

	codeactions = {
		enabled = true, -- optional (defaults to true when table exists)
		min_width = nil,
		border = {
			bottom_hl = "FloatBorder",
			highlight = "FloatBorder",
			style = nil, -- falls back to vim.o.winborder
			title = "Code Actions",
			title_align = "center",
			title_hl = "FloatBorder",
		},
	},

	formatters = {
		enabled = true, -- optional (defaults to true when table exists)
	},
}
setup_plugin("cosmic-ui", cosmic_ui_defaults)

-- https://github.com/nvzone/volt
-- Create blazing fast & beautiful reactive UI in Neovim
setup_plugin("volt", function(_) end)

-- https://github.com/folke/noice.nvim
-- Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu.
local noice_config = {
	lsp = {
		-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
		},
	},
	-- you can enable a preset for easier configuration
	presets = {
		bottom_search = true, -- use a classic bottom cmdline for search
		command_palette = true, -- position the cmdline and popupmenu together
		long_message_to_split = true, -- long messages will be sent to a split
		inc_rename = false, -- enables an input dialog for inc-rename.nvim
		lsp_doc_border = false, -- add a border to hover docs and signature help
	},
}
setup_plugin("noice", noice_config)

--─────────────────────────────────────────────────────────────────────────────
--──── fonts, characters ──────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────
setup_plugin("nvim-web-devicons", {
	-- your personal icons can go here (to override)
	-- you can specify color or cterm_color instead of specifying both of them
	-- DevIcon will be appended to `name`
	override = {
		zsh = {
			icon = "",
			color = "#428850",
			cterm_color = "65",
			name = "Zsh",
		},
	},
	-- globally enable different highlight colors per icon (default to true)
	-- if set to false all icons will have the default icon's color
	color_icons = true,
	-- globally enable default icons (default to false)
	-- will get overriden by `get_icons` option
	default = true,
	-- globally enable "strict" selection of icons - icon will be looked up in
	-- different tables, first by filename, and if not found by extension; this
	-- prevents cases when file doesn't have any extension but still gets some icon
	-- because its name happened to match some extension (default to false)
	strict = true,
	-- set the light or dark variant manually, instead of relying on `background`
	-- (default to nil)
	variant = "light|dark",
	-- override blend value for all highlight groups :h highlight-blend.
	-- setting this value to `0` will make all icons opaque. in practice this means
	-- that icons width will not be affected by pumblend option (see issue #608)
	-- (default to nil)
	blend = 0,
	-- same as `override` but specifically for overrides by filename
	-- takes effect when `strict` is true
	override_by_filename = {
		[".gitignore"] = {
			icon = "",
			color = "#f1502f",
			name = "Gitignore",
		},
	},
	-- same as `override` but specifically for overrides by extension
	-- takes effect when `strict` is true
	override_by_extension = {
		["log"] = {
			icon = "",
			color = "#81e043",
			name = "Log",
		},
	},
	-- same as `override` but specifically for operating system
	-- takes effect when `strict` is true
	override_by_operating_system = {
		["apple"] = {
			icon = "",
			color = "#A2AAAD",
			cterm_color = "248",
			name = "Apple",
		},
	},
})

-- https://github.com/dullmode/bye-nerdfont.nvim
-- DESC
local bye_nerdfont_defaults = {} -- TODO
setup_plugin("bye-nerdfont", bye_nerdfont_defaults)

--─────────────────────────────────────────────────────────────────────────────
--──── focus ──────────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

setup_plugin("vimade", {
	recipe = { "default", { animate = true } },
	fadelevel = 0.4,
})

setup_plugin("zen-mode", {
	wezterm = {
		enabled = true,
		-- can be either an absolute font size or the number of incremental steps
		font = "+4", -- (10% increase per step)
	},
})
vim.o.laststatus = 3

--─────────────────────────────────────────────────────────────────────────────
--──── mode-related ───────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- https://github.com/mawkler/modicator.nvim
-- Cursor line number mode indicator plugin for Neovim
local modicator_defaults = {} -- TODO
setup_plugin("modicator", modicator_defaults)

setup_plugin("modes", {
	colors = {
		bg = "", -- Optional bg param, defaults to Normal hl group
		copy = "#f5c359",
		delete = "#c75c6a",
		change = "#c75c6a", -- Optional param, defaults to delete
		format = "#c79585",
		insert = "#78ccc5",
		replace = "#245361",
		select = "#9745be", -- Optional param, defaults to visual
		visual = "#9745be",
	},

	-- Set opacity for cursorline and number background
	line_opacity = 0.15,

	-- Enable cursor highlights
	set_cursor = true,

	-- Enable cursorline initially, and disable cursorline for inactive windows
	-- or ignored filetypes
	set_cursorline = true,

	-- Enable line number highlights to match cursorline
	set_number = true,

	-- Enable sign column highlights to match cursorline
	set_signcolumn = true,

	-- Disable modes highlights for specified filetypes
	-- or enable with prefix "!" if otherwise disabled (please PR common patterns)
	-- Can also be a function fun():boolean that disables modes highlights when true
	ignore = { "NvimTree", "TelescopePrompt", "!minifiles" },
})

--─────────────────────────────────────────────────────────────────────────────
--──── other/general ──────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- https://github.com/rasulomaroff/reactive.nvim
-- Reactivity. Right in your neovim.
local reactive_defaults = {} -- TODO
setup_plugin("reactive", reactive_defaults)

-- https://github.com/lukas-reineke/headlines.nvim | adds horizontal highlights for text filetypes, like markdown, orgmode, and neorg
setup_plugin("headlines", { -- TODO: move to colors (?)
	markdown = {
		headline_highlights = {
			"Headline1",
			"Headline2",
			"Headline3",
			"Headline4",
			"Headline5",
			"Headline6",
		},
		codeblock_highlight = "CodeBlock",
	},
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "norg" },
	callback = function()
		vim.opt_local.conceallevel = 2
	end,
})

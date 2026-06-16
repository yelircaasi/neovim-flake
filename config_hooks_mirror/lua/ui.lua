--─────────────────────────────────────────────────────────────────────────────
--──── columns ────────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- EXPERIMENTAL
-- TODO: compare https://github.com/lukas-reineke/virt-column.nvim (may be better)
-- https://github.com/xiyaowong/virtcolumn.nvim
-- Display a line as the colorcolumn
local virtcolumn_defaults = nil
utils.packadd("virtcolumn", function(virtcolumn)
	vim.g.virtcolumn_char = "▕" -- char to display the line
	vim.g.virtcolumn_priority = 10 -- priority of extmark
end)

-- :help virt-column.txt
-- https://github.com/lukas-reineke/virt-column.nvim
-- Display a character as the colorcolumn
local virt_column_defaults = {} -- TODO: https://github.com/lukas-reineke/virt-column.nvim/blob/master/lua/virt-column/config.lua
setup_plugin("virt-column", function(virt_column)
	virt_column.setup(virt_column_defaults)
end)

-- https://github.com/m4xshen/smartcolumn.nvim
-- A Neovim plugin hiding your colorcolumn when unneeded.
local smartcolumn_defaults = {
	colorcolumn = "80",
	disabled_filetypes = { "help", "text", "markdown" },
	custom_colorcolumn = {},
	scope = "file",
	editorconfig = true,
}
setup_plugin("smartcolumn", smartcolumn_defaults)

-- https://github.com/luukvbaal/statuscol.nvim
-- Status column plugin that provides a configurable 'statuscolumn' and click handlers.
setup_plugin("statuscol", function(statuscol)
	local builtin = require("statuscol.builtin")
	local statuscol_defaults = {
		setopt = true, -- Whether to set the 'statuscolumn' option, may be set to false for those who
		-- want to use the click handlers in their own 'statuscolumn': _G.Sc[SFL]a().
		-- Although I recommend just using the segments field below to build your
		-- statuscolumn to benefit from the performance optimizations in this plugin.
		-- builtin.lnumfunc number string options
		thousands = false, -- or line number thousands separator string ("." / ",")
		relculright = false, -- whether to right-align the cursor line number with 'relativenumber' set
		-- Builtin 'statuscolumn' options
		ft_ignore = nil, -- Lua table with 'filetype' values for which 'statuscolumn' will be unset
		bt_ignore = nil, -- Lua table with 'buftype' values for which 'statuscolumn' will be unset
		-- Default segments (fold -> sign -> line number + separator), explained below
		segments = {
			{ text = { "%C" }, click = "v:lua.ScFa" },
			{ text = { "%s" }, click = "v:lua.ScSa" },
			{
				text = { builtin.lnumfunc, " " },
				condition = { true, builtin.not_empty },
				click = "v:lua.ScLa",
			},
		},
		clickmod = "c", -- modifier used for certain actions in the builtin clickhandlers:
		-- "a" for Alt, "c" for Ctrl and "m" for Meta.
		clickhandlers = { -- builtin click handlers, keys are pattern matched
			Lnum = builtin.lnum_click,
			FoldClose = builtin.foldclose_click,
			FoldOpen = builtin.foldopen_click,
			FoldOther = builtin.foldother_click,
			DapBreakpointRejected = builtin.toggle_breakpoint,
			DapBreakpoint = builtin.toggle_breakpoint,
			DapBreakpointCondition = builtin.toggle_breakpoint,
			["diagnostic/signs"] = builtin.diagnostic_click,
			gitsigns = builtin.gitsigns_click,
		},
	}
	statuscol.setup(statuscol_defaults)
end)

--─────────────────────────────────────────────────────────────────────────────
--──── menus, selection ───────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- https://github.com/nvzone/menu
-- Menu plugin for neovim ( supports nested menus ) made using volt
local menu_defaults = nil
setup_plugin("menu") -- testing only; usable as a library

--─────────────────────────────────────────────────────────────────────────────
--──── outline ────────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

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

	map_explicit({
		mode = "n",
		sequence = "<leader>o",
		action = "<cmd>AerialToggle<cr>",
	})
	map_explicit({
		mode = "n",
		sequence = "{",
		action = "<cmd>AerialPrev<cr>",
	})
	map_explicit({
		mode = "n",
		sequence = "}",
		action = "<cmd>AerialNext<cr>",
	})
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

	map_explicit({
		mode = "n",
		sequence = "<leader>nb",
		action = function()
			navbuddy.open()
		end,
	})
end)

--─────────────────────────────────────────────────────────────────────────────
--──── lines, bars ────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

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

	map_explicit({
		mode = "n",
		sequence = "<leader>;",
		action = function()
			require("dropbar.api").pick()
		end,
	})

	map_explicit({
		mode = "n",
		sequence = "[;",
		action = function()
			require("dropbar.api").goto_context_start()
		end,
	})

	map_explicit({
		mode = "n",
		sequence = "];",
		action = function()
			require("dropbar.api").select_next_context()
		end,
	})
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
setup_plugin("nvim-navic", navic_defaults)

-- https://github.com/akinsho/bufferline.nvim
-- A snazzy bufferline for Neovim

setup_plugin("bufferline", function(bufferline)
	local bufferline_defaults = {
		options = {
			mode = "buffers", -- set to "tabs" to only show tabpages instead
			style_preset = bufferline.style_preset.default, -- or bufferline.style_preset.minimal,
			themable = true, -- | false, -- allows highlight groups to be overriden i.e. sets highlights as default
			numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
			close_command = "bdelete! %d", -- can be a string | function, | false see "Mouse actions"
			right_mouse_command = "bdelete! %d", -- can be a string | function | false, see "Mouse actions"
			left_mouse_command = "buffer %d", -- can be a string | function, | false see "Mouse actions"
			middle_mouse_command = nil, -- can be a string | function, | false see "Mouse actions"
			indicator = {
				icon = "▎", -- this should be omitted if indicator style is not 'icon'
				style = "icon", -- | 'underline' | 'none',
			},
			buffer_close_icon = "󰅖",
			modified_icon = "● ",
			close_icon = " ",
			left_trunc_marker = " ",
			right_trunc_marker = " ",
			--- name_formatter can be used to change the buffer's label in the bufferline.
			--- Please note some names can/will break the
			--- bufferline so use this at your discretion knowing that it has
			--- some limitations that will *NOT* be fixed.
			name_formatter = function(buf) -- buf contains:
				-- name                | str        | the basename of the active file
				-- path                | str        | the full path of the active file
				-- bufnr               | int        | the number of the active buffer
				-- buffers (tabs only) | table(int) | the numbers of the buffers in the tab
				-- tabnr (tabs only)   | int        | the "handle" of the tab, can be converted to its ordinal number using: `vim.api.nvim_tabpage_get_number(buf.tabnr)`
			end,
			max_name_length = 18,
			max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
			truncate_names = true, -- whether or not tab names should be truncated
			tab_size = 18,
			diagnostics = false, -- | "nvim_lsp" | "coc",
			diagnostics_update_in_insert = false, -- only applies to coc
			diagnostics_update_on_event = true, -- use nvim's diagnostic handler
			-- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
			diagnostics_indicator = function(count, level, diagnostics_dict, context)
				return "(" .. count .. ")"
			end,
			-- NOTE: this will be called a lot so don't do any heavy processing here
			custom_filter = function(buf_number, buf_numbers)
				-- filter out filetypes you don't want to see
				if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
					return true
				end
				-- filter out by buffer name
				if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
					return true
				end
				-- filter out based on arbitrary rules
				-- e.g. filter out vim wiki buffer from tabline in your work repo
				if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
					return true
				end
				-- filter out by it's index number in list (don't show first buffer)
				if buf_numbers[1] ~= buf_number then
					return true
				end
			end,
			offsets = {
				{
					filetype = "NvimTree",
					text = "File Explorer", -- | function ,
					text_align = "left", -- | "center" | "right"
					separator = true,
				},
			},
			color_icons = true, -- | false, -- whether or not to add the filetype icon highlights
			get_element_icon = function(element)
				-- element consists of {filetype: string, path: string, extension: string, directory: string}
				-- This can be used to change how bufferline fetches the icon
				-- for an element e.g. a buffer or a tab.
				-- e.g.
				local icon, hl =
					require("nvim-web-devicons").get_icon_by_filetype(element.filetype, { default = false })
				return icon, hl
				-- or
				-- local custom_map = {my_thing_ft: {icon = "my_thing_icon", hl}}
				-- return custom_map[element.filetype]
			end,
			show_buffer_icons = true, -- | false, -- disable filetype icons for buffers
			show_buffer_close_icons = true, -- | false,
			show_close_icon = true, -- | false,
			show_tab_indicators = true, -- | false,
			show_duplicate_prefix = true, -- | false, -- whether to show duplicate buffer prefix
			duplicates_across_groups = true, -- whether to consider duplicate paths in different groups as duplicates
			persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
			move_wraps_at_ends = false, -- whether or not the move command "wraps" at the first or last position
			-- can also be a table containing 2 custom separators
			-- [focused and unfocused]. eg: { '|', '|' }
			separator_style = "slant", -- | "slope" | "thick" | "thin" | { "any", "any" },
			enforce_regular_tabs = false, -- | true,
			always_show_bufferline = true, -- | false,
			auto_toggle_bufferline = true, -- | false,
			hover = {
				enabled = true,
				delay = 200,
				reveal = { "close" },
			},
			sort_by = "insert_after_current",
			-- | "insert_at_end"
			-- | "id"
			-- | "extension"
			-- | "relative_directory"
			-- | "directory"
			-- | "tabs"
			-- | function(buffer_a, buffer_b)
			-- 	-- add custom logic
			-- 	local modified_a = vim.fn.getftime(buffer_a.path)
			-- 	local modified_b = vim.fn.getftime(buffer_b.path)
			-- 	return modified_a > modified_b
			-- end,
			pick = {
				alphabet = "abcdefghijklmopqrstuvwxyzABCDEFGHIJKLMOPQRSTUVWXYZ1234567890",
			},
		},
	}
	bufferline.setup(bufferline_defaults)
end)

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
local cmdbuf_defaults = nil
setup_plugin("cmdbuf", function(cmdbuf)
	map_explicit({
		mode = "n",
		sequence = "q:",
		action = function()
			cmdbuf.split_open(vim.o.cmdwinheight)
		end,
	})
	map_explicit({
		mode = "c",
		sequence = "<C-f>",
		action = function()
			cmdbuf.split_open(vim.o.cmdwinheight, { line = vim.fn.getcmdline(), column = vim.fn.getcmdpos() })
			vim.api.nvim_feedkeys(vim.keycode("<C-c>"), "n", true)
		end,
	})

	-- Custom buffer mappings
	vim.api.nvim_create_autocmd({ "User" }, {
		group = vim.api.nvim_create_augroup("config.cmdbuf", {}),
		pattern = { "CmdbufNew" },
		callback = function(args)
			vim.bo.bufhidden = "wipe" -- if you don't need previous opened buffer state
			map_explicit({
				mode = "n",
				"q",
				[[<Cmd>quit<CR>]],
				opts = { nowait = true, buf = 0 },
			})
			map_explicit({
				mode = "n",
				"dd",
				[[<Cmd>lua require('cmdbuf').delete()<CR>]],
				opts = { buf = 0 },
			})
			map_explicit({
				mode = { "n", "i" },
				"<C-c>",
				function()
					return cmdbuf.cmdline_expr()
				end,
				opts = { buf = 0, expr = true },
			})

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
	map_explicit({
		mode = "n",
		sequence = "ql",
		action = function()
			cmdbuf.split_open(vim.o.cmdwinheight, { type = "lua/cmd" })
		end,
	})

	-- q/, q? alternative
	map_explicit({
		mode = "n",
		sequence = "q/",
		action = function()
			cmdbuf.split_open(vim.o.cmdwinheight, { type = "vim/search/forward" })
		end,
	})
	map_explicit({
		mode = "n",
		sequence = "q?",
		action = function()
			cmdbuf.split_open(vim.o.cmdwinheight, { type = "vim/search/backward" })
		end,
	})
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
local fidget_defaults = [[{
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
}]]
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
local notify_defaults = {
	stages = "fade",
	timeout = 3000,
	render = "wrapped-default",
	max_width = function()
		return math.floor(vim.o.columns * 0.4)
	end,
}
vim.opt.termguicolors = true
-- highlight NotifyERRORBorder guifg=#8A1F1F
-- highlight NotifyWARNBorder guifg=#79491D
-- highlight NotifyINFOBorder guifg=#4F6752
-- highlight NotifyDEBUGBorder guifg=#8B8B8B
-- highlight NotifyTRACEBorder guifg=#4F3552
-- highlight NotifyERRORIcon guifg=#F70067
-- highlight NotifyWARNIcon guifg=#F79000
-- highlight NotifyINFOIcon guifg=#A9FF68
-- highlight NotifyDEBUGIcon guifg=#8B8B8B
-- highlight NotifyTRACEIcon guifg=#D484FF
-- highlight NotifyERRORTitle  guifg=#F70067
-- highlight NotifyWARNTitle guifg=#F79000
-- highlight NotifyINFOTitle guifg=#A9FF68
-- highlight NotifyDEBUGTitle  guifg=#8B8B8B
-- highlight NotifyTRACETitle  guifg=#D484FF
-- highlight link NotifyERRORBody Normal
-- highlight link NotifyWARNBody Normal
-- highlight link NotifyINFOBody Normal
-- highlight link NotifyDEBUGBody Normal
-- highlight link NotifyTRACEBody Normal
setup_plugin("notify", function(notify)
	notify.setup(notify_defaults)

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
--──── other/general ──────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- https://github.com/rasulomaroff/reactive.nvim
-- Reactivity. Right in your neovim.
local reactive_config = { -- TODO; not currently using this so I can explore
	builtin = {},
	configs = {},
	load = {},
}
setup_plugin("reactive")

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "norg" },
	callback = function()
		vim.opt_local.conceallevel = 2
	end,
})

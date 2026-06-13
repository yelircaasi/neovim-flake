--─────────────────────────────────────────────────────────────────────────────
--──── FILES ──────────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- https://github.com/kbario/spear.nvim
-- blazingly smooth intrafolder file navigation for neovim
local spear_defaults = {
	-- how you want spear to match extensions if multiple are provided
	-- "first" (default): spears to the first extension matched
	-- "next": spears to the next extension matched if the first matches current
	match_pref = "first",
	-- will save the file you are spearing from when you spear from it
	-- false (default)
	-- true
	save_on_spear = false,
	-- whether or not to print error messages
	-- true (default)
	-- false
	print_err = true,
	-- whether or not to print info messages such as 'speared to app.tsx'
	-- true (default)
	-- false
	print_info = true,
}
setup_plugin("spear", spear_defaults)

--─────────────────────────────────────────────────────────────────────────────
--──── WINDOWS ────────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────
setup_plugin("smart-splits", function(ss)
	ss.setup({
		ignored_filetypes = { "nofile", "quickfix", "prompt" },
		default_amount = 3,
		-- Multiplexer integration (resize across tmux/wezterm panes)
		at_edge = "wrap",
		multiplexer_integration = "wezterm",
	})

	local map = vim.keymap.set
	-- Resize
	map("n", "<A-h>", ss.resize_left, { desc = "Resize window left" })
	map("n", "<A-j>", ss.resize_down, { desc = "Resize window down" })
	map("n", "<A-k>", ss.resize_up, { desc = "Resize window up" })
	map("n", "<A-l>", ss.resize_right, { desc = "Resize window right" })
	-- Swap buffers between windows
	map("n", "<leader><leader>h", ss.swap_buf_left, { desc = "Swap buffer left" })
	map("n", "<leader><leader>j", ss.swap_buf_down, { desc = "Swap buffer down" })
	map("n", "<leader><leader>k", ss.swap_buf_up, { desc = "Swap buffer up" })
	map("n", "<leader><leader>l", ss.swap_buf_right, { desc = "Swap buffer right" })
end)

setup_plugin("swm", function(swm)
	local map = vim.keymap.set
	-- Window navigation: swm makes these smart about floating windows
	map("n", "<C-w>h", swm.h, { desc = "Window left" })
	map("n", "<C-w>j", swm.j, { desc = "Window down" })
	map("n", "<C-w>k", swm.k, { desc = "Window up" })
	map("n", "<C-w>l", swm.l, { desc = "Window right" })
	-- Also bind to plain <C-hjkl> for convenience
	map("n", "<C-h>", swm.h, { desc = "Window left" })
	map("n", "<C-j>", swm.j, { desc = "Window down" })
	map("n", "<C-k>", swm.k, { desc = "Window up" })
	map("n", "<C-l>", swm.l, { desc = "Window right" })
end)

-- https://github.com/DrKGD/pragma.nvim
-- Neovim plugin for programatically setup window layouts
local pragma_defaults = {} -- TODO
setup_plugin("pragma", pragma_defaults)

-- https://github.com/declancm/windex.nvim
-- Clean window maximizing, terminal toggling, window/tmux pane movements and more!
local windex_nvim_defaults = {
	-- KEYMAPS:
	default_keymaps = true, -- Enable default keymaps.
	extra_keymaps = false, -- Enable extra keymaps.
	arrow_keys = false, -- Default window movement keymaps use arrow keys instead of 'h,j,k,l'.

	-- OPTIONS:
	numbered_term = false, -- Enable line numbers in the terminal.
	save_buffers = false, -- Save all buffers before switching tmux panes.
	warnings = true, -- Enable warnings before some actions such as closing tmux panes.
}
setup_plugin("windex-nvim", windex_nvim_defaults)

--─────────────────────────────────────────────────────────────────────────────
--──── BUFFERS ────────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- A minimal BufExplorer alternative
-- https://github.com/mistweaverco/bafa.nvim
-- A minimal BufExplorer alternative for lazy people for your favorite editor.
local bafa_defaults = {} -- TODO
setup_plugin("bafa", bafa_defaults)

-- https://github.com/nvimdev/flybuf.nvim
-- show buffers in a float window and support use shortcut to open buffer
utils.setup_plugin("flybuf", function(flybuf)
	flybuf.setup({
		-- Show relative line numbers in the buffer list
		rnu = true,
	})
	vim.keymap.set("n", "<leader>bf", "FlyBuf", { desc = "FlyBuf: buffer list" })
end)

-- https://github.com/Hajime-Suzuki/vuffers.nvim
-- a neovim plugin that creates a vertical split window to help you manage and navigate your buffers more efficiently
local vuffers_defaults = {
	debug = {
		enabled = true,
		level = "error", -- "error" | "warn" | "info" | "debug" | "trace"
	},
	exclude = {
		-- do not show them on the vuffers list
		filenames = { "term://" },
		filetypes = { "lazygit", "NvimTree", "qf" },
	},
	handlers = {
		-- when deleting a buffer via vuffers list (by default triggered by "d" key)
		on_delete_buffer = function(bufnr)
			vim.api.nvim_command(":bwipeout " .. bufnr)
		end,
	},
	keymaps = {
		-- if false, no bindings will be provided at all
		-- thus you will have to bind on your own
		use_default = true,
		-- key maps on the vuffers list
		-- - may map multiple keys for the same action
		--    open = { "<CR>", "<C-l>" }
		-- - disable a specific binding using "false"
		--    open = false
		view = {
			open = "<CR>",
			delete = "d",
			pin = "p",
			unpin = "P",
			rename = "r",
			reset_custom_display_name = "R",
			reset_custom_display_names = "<leader>R",
			move_up = "U",
			move_down = "D",
			move_to = "i",
		},
	},
	sort = {
		type = "none", -- "none" | "filename"
		direction = "asc", -- "asc" | "desc"
	},
	view = {
		modified_icon = "󰛿", -- when a buffer is modified, this icon will be shown
		pinned_icon = "󰐾",
		show_file_extension = false,
		window = {
			auto_resize = false,
			width = 35,
			focus_on_open = false,
		},
	},
}
setup_plugin("vuffers", vuffers_defaults)

-- https://github.com/mrquantumcodes/retrospect.nvim
-- A simple and lightweight buffer manager for Neovim
local retrospect_defaults = {} -- TODO
setup_plugin("retrospect", retrospect_defaults)

-- https://github.com/stevearc/stickybuf.nvim
-- Neovim plugin for locking a buffer to a window
setup_plugin("stickybuf", function(stickybuf)
	-- Automatically pin special buffers so they can't be replaced
	local cfg = {
		get_auto_pin = function(bufnr)
			local buftype = vim.bo[bufnr].buftype
			local filetype = vim.bo[bufnr].filetype
			local buftypes = { "help", "nofile", "prompt", "quickfix", "terminal" }
			local fttypes = {
				"neo-tree",
				"neotest-summary",
				"neotest-output-panel",
				"Outline",
				"toggleterm",
				"trouble",
			}
			if vim.tbl_contains(buftypes, buftype) then
				return stickybuf.strategy.buf
			end
			if vim.tbl_contains(fttypes, filetype) then
				return stickybuf.strategy.buf
			end
		end,
	}
	stickybuf.setup(cfg)
end)

--─────────────────────────────────────────────────────────────────────────────
--──── TEXT ───────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- NOTE: beam.nvim is a cursor beam plugin for mode-based cursor shapes.
-- Most terminal emulators handle this, so only enable if yours doesn't.
setup_plugin("beam", function(beam)
	beam.setup({
		cursors = {
			normal = "block",
			insert = "beam",
			replace = "underline",
			visual = "block",
			operator = "block",
		},
	})
end)

local navigator_defaults = {
	debug = false, -- log output, set to true and log path: ~/.cache/nvim/gh.log
	-- slowdownd startup and some actions
	width = 0.75, -- max width ratio (number of cols for the floating window) / (window width)
	height = 0.3, -- max list window height, 0.3 by default
	preview_height = 0.35, -- max height of preview windows
	border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }, -- border style, can be one of 'none', 'single', 'double',
	-- 'shadow', or a list of chars which defines the border
	on_attach = function(client, bufnr) -- no longer supported for nvim >= 0.12, use your own LspAttach autocmd
	end,

	ts_fold = {
		enable = false,
		comment_fold = true, -- fold with comment string
		max_lines_scan_comments = 20, -- only fold when the fold level higher than this value
		disable_filetypes = { "help", "guihua", "text" }, -- list of filetypes which doesn't fold using treesitter
	}, -- modified version of treesitter folding
	default_mapping = true, -- set to false if you will remap every key
	keymaps = { { key = "gK", func = vim.lsp.declaration, desc = "declaration" } }, -- a list of key maps
	-- this kepmap gK will override "gD" mapping function declaration()  in default kepmap
	-- please check mapping.lua for all keymaps
	-- rule of overriding: if func and mode ('n' by default) is same
	-- the key will be overridden
	treesitter_analysis = true, -- treesitter variable context
	treesitter_navigation = true, -- bool|table false: use lsp to navigate between symbol ']r/[r', table: a list of
	--lang using TS navigation
	treesitter_analysis_max_num = 100, -- how many items to run treesitter analysis
	treesitter_analysis_condense = true, -- condense form for treesitter analysis
	-- this value prevent slow in large projects, e.g. found 100000 reference in a project
	transparency = 50, -- 0 ~ 100 blur the main window, 100: fully transparent, 0: opaque,  set to nil or 100 to disable it

	lsp_signature_help = true, -- if you would like to hook ray-x/lsp_signature plugin in navigator
	-- setup here. if it is nil, navigator will not init signature help
	signature_help_cfg = nil, -- if you would like to init ray-x/lsp_signature plugin in navigator, and pass in your own config to signature help
	icons = { -- refer to lua/navigator.lua for more icons config
		-- requires nerd fonts or nvim-web-devicons
		icons = true,
		-- Code action
		code_action_icon = "🏏", -- note: need terminal support, for those not support unicode, might crash
		-- Diagnostics
		diagnostic_head = "🐛",
		diagnostic_head_severity_1 = "🈲",
		fold = {
			prefix = "⚡", -- icon to show before the folding need to be 2 spaces in display width
			separator = "", -- e.g. shows   3 lines 
		},
	},
	mason = false, -- Deprecated, setup LSP in your own config and use LspAttach to hook navigator mappings
	lsp = {
		enable = true, -- skip lsp setup, and only use treesitter in navigator.
		-- Use this if you are not using LSP servers, and only want to enable treesitter support.
		-- If you only want to prevent navigator from touching your LSP server configs,
		-- use `disable_lsp = "all"` instead.
		-- If disabled, make sure add require('navigator.lspclient.mapping').setup({bufnr=bufnr, client=client}) in your
		-- own on_attach
		code_action = { enable = true, sign = true, sign_priority = 40, virtual_text = true },
		code_lens_action = { enable = true, sign = true, sign_priority = 40, virtual_text = true },
		document_highlight = true, -- LSP reference highlight,
		-- it might already supported by you setup, e.g. LunarVim
		format_on_save = true, -- {true|false} set to false to disasble lsp code format on save (if you are using prettier/efm/formater etc)
		-- table: {enable = {'lua', 'go'}, disable = {'javascript', 'typescript'}} to enable/disable specific language
		-- enable: a whitelist of language that will be formatted on save
		-- disable: a blacklist of language that will not be formatted on save
		-- function: function(bufnr) return true end to enable/disable lsp format on save
		format_options = { async = false }, -- async: disable by default, the option used in vim.lsp.buf.format({async={true|false}, name = 'xxx'})
		disable_format_cap = { "sqlls", "lua_ls", "gopls" }, -- a list of lsp disable format capacity (e.g. if you using efm or vim-codeformat etc), empty {} by default
		-- If you using null-ls and want null-ls format your code
		-- you should disable all other lsp and allow only null-ls.
		-- disable_lsp = {'pylsd', 'sqlls'},  -- prevents navigator from setting up this list of servers.
		-- if you use your own LSP setup, and don't want navigator to setup
		-- any LSP server for you, use `disable_lsp = "all"`.
		-- you may need to add this to your own on_attach hook:
		-- require('navigator.lspclient.mapping').setup({bufnr=bufnr, client=client})
		-- for e.g. denols and tsserver you may want to enable one lsp server at a time.
		-- default value: {}
		diagnostic = {
			underline = true,
			virtual_text = { spacing = 3, source = true }, -- show virtual for diagnostic message
			-- set to false to prefer virtual lines
			update_in_insert = false, -- update diagnostic message in insert mode
			severity_sort = { reverse = true },
			float = { -- setup for floating windows style, set to false to disable floating window
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
			virtual_lines = {
				current_line = false, -- show diagnostic only on current line
			},
			register = "D", -- yank the error into register
		},

		hover = {
			enable = true,
			-- fallback when hover failed
			-- e.g. if filetype is go, try godoc
			go = function()
				local w = vim.fn.expand("<cWORD>")
				vim.cmd("GoDoc " .. w)
			end,
			-- if python, do python doc
			python = function()
				-- run pydoc, behaviours defined in lua/navigator.lua
			end,
			default = function()
				-- fallback apply to all file types not been specified above
				-- local w = vim.fn.expand('<cWORD>')
				-- vim.lsp.buf.workspace_symbol(w)
			end,
		},

		diagnostic_scrollbar_sign = { "▃", "▆", "█" }, -- experimental:  diagnostic status in scroll bar area; set to false to disable the diagnostic sign,
		--                for other style, set to {'╍', 'ﮆ'} or {'-', '='}
		diagnostic_virtual_text = true, -- show virtual for diagnostic message
		diagnostic_update_in_insert = false, -- update diagnostic message in insert mode
		display_diagnostic_qf = true, -- always show quickfix if there are diagnostic errors, set to false if you want to ignore it
		-- set to 'trouble' to show diagnostcs in Trouble
		ctags = {
			cmd = "ctags",
			tagfile = "tags",
			options = "-R --exclude=.git --exclude=node_modules --exclude=test --exclude=vendor --excmd=number",
		},
		-- setup LSP in your own config (nvim 0.12+), then hook navigator in LspAttach
		-- refer to :help lsp and nvim-lspconfig docs for more info
		servers = { "cmake", "ltex" }, -- by default empty, and it should load all LSP clients available based on filetype
		-- but if you want navigator load  e.g. `cmake` and `ltex` for you , you
		-- can put them in the `servers` list and navigator will auto load them.
		-- you could still specify the custom config  like this
		-- cmake = {filetypes = {'cmake', 'makefile'}, single_file_support = false},
	},
}

-- https://github.com/ray-x/navigator.lua
-- DESC
local navigator_defaults = {} -- TODO
setup_plugin("navigator", navigator_defaults)

-- PROBABLY NOT, BUT WORTH A TRY
utils.packadd("vim-wordmotion")

-- PROBABLY NOT, BUT WORTH A TRY
utils.packadd("clever-f.vim")

-- https://github.com/smoka7/hop.nvim
setup_plugin("hop", function(hop)
	local directions = require("hop.hint").HintDirection
	vim.keymap.set("", "f", function()
		hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
	end, { remap = true })
	vim.keymap.set("", "F", function()
		hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
	end, { remap = true })
	vim.keymap.set("", "t", function()
		hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
	end, { remap = true })
	vim.keymap.set("", "T", function()
		hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
	end, { remap = true })
end) -- PROBABLY NOT, BUT WORTH A TRY

local mini_jump_defaults = {
	-- Module mappings. Use `''` (empty string) to disable one.
	mappings = {
		forward = "f",
		backward = "F",
		forward_till = "t",
		backward_till = "T",
		repeat_jump = ";",
	},

	-- Delay values (in ms) for different functionalities. Set any of them to
	-- a very big number (like 10^7) to virtually disable.
	delay = {
		-- Delay between jump and highlighting all possible jumps
		highlight = 250,

		-- Delay between jump and automatic stop if idle (no jump is done)
		idle_stop = 10000000,
	},

	-- Whether to disable showing non-error feedback
	-- This also affects (purely informational) helper messages shown after
	-- idle time if user input is required.
	silent = false,
}
setup_plugin("mini.jump", mini_jump_defaults)

local mini_jump2d_defaults = {
	-- Function producing jump spots (byte indexed) for a particular line.
	-- For more information see |MiniJump2d.start()|.
	-- If `nil` (default) - use |MiniJump2d.default_spotter()|
	spotter = nil,

	-- Characters used for labels of jump spots (in supplied order)
	labels = "abcdefghijklmnopqrstuvwxyz",

	-- Options for visual effects
	view = {
		-- Whether to dim lines with at least one jump spot
		dim = false,

		-- How many steps ahead to show. Set to big number to show all steps.
		n_steps_ahead = 0,
	},

	-- Which lines are used for computing spots
	allowed_lines = {
		blank = true, -- Blank line (not sent to spotter even if `true`)
		cursor_before = true, -- Lines before cursor line
		cursor_at = true, -- Cursor line
		cursor_after = true, -- Lines after cursor line
		fold = true, -- Start of fold (not sent to spotter even if `true`)
	},

	-- Which windows from current tabpage are used for visible lines
	allowed_windows = {
		current = true,
		not_current = true,
	},

	-- Functions to be executed at certain events
	hooks = {
		before_start = nil, -- Before jump start
		after_jump = nil, -- After jump was actually done
	},

	-- Module mappings. Use `''` (empty string) to disable one.
	mappings = {
		start_jumping = "<CR>",
	},

	-- Whether to disable showing non-error feedback
	-- This also affects (purely informational) helper messages shown after
	-- idle time if user input is required.
	silent = false,
}
setup_plugin("mini.jump2d", mini_jump2d_defaults)

setup_plugin("neowords", function(_) end) -- https://github.com/backdround/neowords.nvim Flexible and reliable hops by any type of words

setup_plugin("leap", function(leap)
	leap.opts.safe_labels = {}

	vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward)")
	vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward)")
end)

local flash_defaults = {
	-- labels = "abcdefghijklmnopqrstuvwxyz",
	labels = "asdfghjklqwertyuiopzxcvbnm",
	search = {
		-- search/jump in all windows
		multi_window = true,
		-- search direction
		forward = true,
		-- when `false`, find only matches in the given direction
		wrap = true,
		---@type Flash.Pattern.Mode
		-- Each mode will take ignorecase and smartcase into account.
		-- * exact: exact match
		-- * search: regular search
		-- * fuzzy: fuzzy search
		-- * fun(str): custom function that returns a pattern
		--   For example, to only match at the beginning of a word:
		--   mode = function(str)
		--     return "\\<" .. str
		--   end,
		mode = "exact",
		-- behave like `incsearch`
		incremental = false,
		-- Excluded filetypes and custom window filters
		---@type (string|fun(win:window))[]
		exclude = {
			"notify",
			"cmp_menu",
			"noice",
			"flash_prompt",
			function(win)
				-- exclude non-focusable windows
				return not vim.api.nvim_win_get_config(win).focusable
			end,
		},
		-- Optional trigger character that needs to be typed before
		-- a jump label can be used. It's NOT recommended to set this,
		-- unless you know what you're doing
		trigger = "",
		-- max pattern length. If the pattern length is equal to this
		-- labels will no longer be skipped. When it exceeds this length
		-- it will either end in a jump or terminate the search
		max_length = false, ---@type number|false
	},
	jump = {
		-- save location in the jumplist
		jumplist = true,
		-- jump position
		pos = "start", ---@type "start" | "end" | "range"
		-- add pattern to search history
		history = false,
		-- add pattern to search register
		register = false,
		-- clear highlight after jump
		nohlsearch = false,
		-- automatically jump when there is only one match
		autojump = false,
		-- You can force inclusive/exclusive jumps by setting the
		-- `inclusive` option. By default it will be automatically
		-- set based on the mode.
		inclusive = nil, ---@type boolean?
		-- jump position offset. Not used for range jumps.
		-- 0: default
		-- 1: when pos == "end" and pos < current position
		offset = nil, ---@type number
	},
	label = {
		-- allow uppercase labels
		uppercase = true,
		-- add any labels with the correct case here, that you want to exclude
		exclude = "",
		-- add a label for the first match in the current window.
		-- you can always jump to the first match with `<CR>`
		current = true,
		-- show the label after the match
		after = true, ---@type boolean|number[]
		-- show the label before the match
		before = false, ---@type boolean|number[]
		-- position of the label extmark
		style = "overlay", ---@type "eol" | "overlay" | "right_align" | "inline"
		-- flash tries to re-use labels that were already assigned to a position,
		-- when typing more characters. By default only lower-case labels are re-used.
		reuse = "lowercase", ---@type "lowercase" | "all" | "none"
		-- for the current window, label targets closer to the cursor first
		distance = true,
		-- minimum pattern length to show labels
		-- Ignored for custom labelers.
		min_pattern_length = 0,
		-- Enable this to use rainbow colors to highlight labels
		-- Can be useful for visualizing Treesitter ranges.
		rainbow = {
			enabled = false,
			-- number between 1 and 9
			shade = 5,
		},
		-- With `format`, you can change how the label is rendered.
		-- Should return a list of `[text, highlight]` tuples.
		---@class Flash.Format
		---@field state Flash.State
		---@field match Flash.Match
		---@field hl_group string
		---@field after boolean
		---@type fun(opts:Flash.Format): string[][]
		format = function(opts)
			return { { opts.match.label, opts.hl_group } }
		end,
	},
	highlight = {
		-- show a backdrop with hl FlashBackdrop
		backdrop = true,
		-- Highlight the search matches
		matches = true,
		-- extmark priority
		priority = 5000,
		groups = {
			match = "FlashMatch",
			current = "FlashCurrent",
			backdrop = "FlashBackdrop",
			label = "FlashLabel",
		},
	},
	-- action to perform when picking a label.
	-- defaults to the jumping logic depending on the mode.
	---@type fun(match:Flash.Match, state:Flash.State)|nil
	action = nil,
	-- initial pattern to use when opening flash
	pattern = "",
	-- When `true`, flash will try to continue the last search
	continue = false,
	-- Set config to a function to dynamically change the config
	config = nil, ---@type fun(opts:Flash.Config)|nil
	-- You can override the default options for a specific mode.
	-- Use it with `require("flash").jump({mode = "forward"})`
	---@type table<string, Flash.Config>
	modes = {
		-- options used when flash is activated through
		-- a regular search with `/` or `?`
		search = {
			-- when `true`, flash will be activated during regular search by default.
			-- You can always toggle when searching with `require("flash").toggle()`
			enabled = false,
			highlight = { backdrop = false },
			jump = { history = true, register = true, nohlsearch = true },
			search = {
				-- `forward` will be automatically set to the search direction
				-- `mode` is always set to `search`
				-- `incremental` is set to `true` when `incsearch` is enabled
			},
		},
		-- options used when flash is activated through
		-- `f`, `F`, `t`, `T`, `;` and `,` motions
		char = {
			enabled = true,
			-- dynamic configuration for ftFT motions
			config = function(opts)
				-- autohide flash when in operator-pending mode
				opts.autohide = opts.autohide or (vim.fn.mode(true):find("no") and vim.v.operator == "y")

				-- disable jump labels when not enabled, when using a count,
				-- or when recording/executing registers
				opts.jump_labels = opts.jump_labels
					and vim.v.count == 0
					and vim.fn.reg_executing() == ""
					and vim.fn.reg_recording() == ""

				-- Show jump labels only in operator-pending mode
				-- opts.jump_labels = vim.v.count == 0 and vim.fn.mode(true):find("o")
			end,
			-- hide after jump when not using jump labels
			autohide = false,
			-- show jump labels
			jump_labels = false,
			-- set to `false` to use the current line only
			multi_line = true,
			-- When using jump labels, don't use these keys
			-- This allows using those keys directly after the motion
			label = { exclude = "hjkliardc" },
			-- by default all keymaps are enabled, but you can disable some of them,
			-- by removing them from the list.
			-- If you rather use another key, you can map them
			-- to something else, e.g., { [";"] = "L", [","] = H }
			keys = { "f", "F", "t", "T", ";", "," },
			---@alias Flash.CharActions table<string, "next" | "prev" | "right" | "left">
			-- The direction for `prev` and `next` is determined by the motion.
			-- `left` and `right` are always left and right.
			char_actions = function(motion)
				return {
					[";"] = "next", -- set to `right` to always go right
					[","] = "prev", -- set to `left` to always go left
					-- clever-f style
					[motion:lower()] = "next",
					[motion:upper()] = "prev",
					-- jump2d style: same case goes next, opposite case goes prev
					-- [motion] = "next",
					-- [motion:match("%l") and motion:upper() or motion:lower()] = "prev",
				}
			end,
			search = { wrap = false },
			highlight = { backdrop = true },
			jump = {
				register = false,
				-- when using jump labels, set to 'true' to automatically jump
				-- or execute a motion when there is only one match
				autojump = false,
			},
		},
		-- options used for treesitter selections
		-- `require("flash").treesitter()`
		treesitter = {
			labels = "abcdefghijklmnopqrstuvwxyz",
			jump = { pos = "range", autojump = true },
			search = { incremental = false },
			label = { before = true, after = true, style = "inline" },
			highlight = {
				backdrop = false,
				matches = false,
			},
		},
		treesitter_search = {
			jump = { pos = "range" },
			search = { multi_window = true, wrap = true, incremental = false },
			remote_op = { restore = true },
			label = { before = true, after = true, style = "inline" },
		},
		-- options used for remote flash
		remote = {
			remote_op = { restore = true, motion = true },
		},
	},
	-- options for the floating window that shows the prompt,
	-- for regular jumps
	-- `require("flash").prompt()` is always available to get the prompt text
	prompt = {
		enabled = true,
		prefix = { { "⚡", "FlashPromptIcon" } },
		win_config = {
			relative = "editor",
			border = "none",
			width = 1, -- when <=1 it's a percentage of the editor width
			height = 1,
			row = -1, -- when negative it's an offset from the bottom
			col = 0, -- when negative it's an offset from the right
			zindex = 1000,
		},
	},
	-- options for remote operator pending mode
	remote_op = {
		-- restore window views and cursor position
		-- after doing a remote operation
		restore = false,
		-- For `jump.pos = "range"`, this setting is ignored.
		-- `true`: always enter a new motion when doing a remote operation
		-- `false`: use the window's cursor position and jump target
		-- `nil`: act as `true` for remote windows, `false` for the current window
		motion = false,
	},
}
setup_plugin("flash", function(flash)
	flash.setup(flash_defaults)

	vim.keymap.set({ "n", "x", "o" }, "s", function()
		require("flash").jump()
	end)

	vim.keymap.set({ "n", "x", "o" }, "S", function()
		require("flash").treesitter()
	end)

	vim.keymap.set("o", "r", function()
		require("flash").remote()
	end)

	vim.keymap.set({ "o", "x" }, "R", function()
		require("flash").treesitter_search()
	end)
end)

local hop_defaults = {
	keys = "asdghklqwertyuiopzxcvbnmfj",
	quit_key = "<Esc>",
	-- perm_method = require('hop.perm').TrieBacktrackFilling,
	reverse_distribution = false,
	x_bias = 10,
	-- distance_method = hint.manh_distance,
	teasing = true,
	virtual_cursor = false,
	jump_on_sole_occurrence = true,
	case_insensitive = true,
	create_hl_autocmd = true,
	current_line_only = false,
	dim_unmatched = true,
	hl_mode = "combine",
	uppercase_labels = false,
	multi_windows = false,
	windows_list = function()
		return vim.api.nvim_tabpage_list_wins(0)
	end,
	ignore_injections = false,
	hint_position = 1, ---@type HintPosition
	hint_offset = 0, ---@type WindowCell
	hint_type = "overlay", ---@type HintType
	excluded_filetypes = {},
	match_mappings = {},
	extensions = { "hop-yank", "hop-treesitter" },
}
setup_plugin("hop", function(hop)
	hop.setup(hop_defaults)

	vim.keymap.set("", "s", function()
		hop.hint_char1()
	end)
end)

setup_plugin("treemonkey", function(_) end)

--─────────────────────────────────────────────────────────────────────────────
--──── MARKS ───────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- https://github.com/SalOrak/whaler.nvim
-- Minimalistic & highly extensible project manager for NeoVim.
local whaler_defaults = {} -- TODO
setup_plugin("whaler", whaler_defaults)

-- https://github.com/chentoast/marks.nvim
-- A better user experience for viewing and interacting with Vim marks.
local marks_nvim_defaults = {} -- TODO
setup_plugin("marks-nvim", marks_nvim_defaults)

-- https://github.com/MeanderingProgrammer/harpoon-core.nvim
-- Neovim harpoon like plugin, but only the core bits
setup_plugin("harpoon", function(harpoon)
	-- harpoon-core uses the same API as harpoon2
	harpoon.setup({})
	local list = harpoon:list()

	local map = vim.keymap.set
	map("n", "<leader>ha", function()
		list:add()
	end, { desc = "Harpoon: add file" })
	map("n", "<leader>hh", function()
		harpoon.ui:toggle_quick_menu(list)
	end, { desc = "Harpoon: menu" })
	-- Quick jump to slots 1-4
	for i = 1, 4 do
		map("n", "<leader>" .. i, function()
			list:select(i)
		end, { desc = "Harpoon: jump to " .. i })
	end
	map("n", "<leader>hp", function()
		list:prev()
	end, { desc = "Harpoon: prev" })
	map("n", "<leader>hn", function()
		list:next()
	end, { desc = "Harpoon: next" })
end)

setup_plugin("marks", function(marks)
	marks.setup({
		default_mappings = true, -- m{a-z}, m{A-Z} etc
		builtin_marks = { ".", "<", ">", "^" },
		cyclic = true, -- wrap around when jumping with ]' ['
		force_write_shada = false,
		sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
		bookmark_0 = {
			sign = "⚑",
			virt_text = "bookmark",
		},
	})

	local map = vim.keymap.set
	map("n", "<leader>mlb", "MarksListBuf", { desc = "Marks: list buffer marks" })
	map("n", "<leader>mqb", "MarksQFListBuf", { desc = "Marks: list buffer marks in quickfix" })
	-- map("n", "<leader>md", marks.delete_buf,  { desc = "Marks: delete all buffer marks" })
end)

-- markit is a marks extension; moving setup inside BufReadPre ensures it's
-- ready before any buffer is fully loaded. Flatten into top-level if you
-- don't need the deferred init.
setup_plugin("markit", function(markit)
	markit.setup({
		default_mappings = false, -- define your own below to avoid conflicts with marks.nvim
		marks_in_signs = true,
	})

	local map = vim.keymap.set
	map("n", "m;", "Markit mark toggle<cr>", { desc = "Markit: toggle mark" })
	map("n", "m:", "Markit mark list all<cr>", { desc = "Markit: list marks" })
end)

-- https://github.com/otavioschwanck/arrow.nvim
--  Bookmark your files, separated by project, and quickly navigate through them.
local arrow_defaults = {} -- TODO
setup_plugin("arrow", arrow_defaults)

-- PROBABLY NOT, BUT WORTH A TRY
utils.packadd("vim-edgemotion")

--─────────────────────────────────────────────────────────────────────────────
--──── URL-RELATED ────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- https://github.com/rmagatti/gx-extended.nvim
-- gx-extended.nvim supercharges Neovim's built-in gx command. Press gx on anything — package names, import statements, issue numbers, commit hashes, and more — and it opens the right URL in your browser.
local gx_extended_nvim_defaults = {} -- TODO
setup_plugin("gx-extended-nvim", gx_extended_nvim_defaults)

-- https://github.com/axieax/urlview.nvim
-- viewing all the URLs in a buffer
local urlview_defaults = {} -- TODO
setup_plugin("urlview", urlview_defaults)

--─────────────────────────────────────────────────────────────────────────────
--──── OTHER ───────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- likely deprecated; see README
-- https://github.com/rktjmp/highlight-current-n.nvim
-- Highlights the current /, ? or * match under your cursor when pressing n or N and gets out of the way afterwards.
local highlight_current_n_nvim_defaults = {} -- TODO
setup_plugin("highlight-current-n-nvim", highlight_current_n_nvim_defaults)

utils.setup_plugin("flybuf", function(flybuf)
	flybuf.setup({
		-- Show relative line numbers in the buffer list
		rnu = true,
	})
	vim.keymap.set("n", "<leader>bf", "FlyBuf", { desc = "FlyBuf: buffer list" })
end)

setup_plugin("navigator", {})

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

setup_plugin("nvim-pasta", function(pasta)
	pasta.setup({
		-- Reindent pasted text to match surrounding context
		next_key = vim.api.nvim_replace_termcodes("<C-n>", true, true, true),
		prev_key = vim.api.nvim_replace_termcodes("<C-p>", true, true, true),
	})
	-- p/P are remapped by pasta automatically; C-n/C-p cycle through paste history
end)

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

-- OLD:
-- vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
-- 	callback = function()
-- 		setup_plugin("markit", function(markit)
-- 			-- utils.packadd("pickme")
-- 		end)
-- 	end,
-- })

-- FILES ==========================================================================================

setup_plugin("spear", {})

-- WINDOWS ========================================================================================

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

setup_plugin("pragma", {}) -- https://github.com/DrKGD/pragma.nvim Neovim plugin for programatically setup window layouts

setup_plugin("windex-nvim", {})

-- BUFFERS ========================================================================================
setup_plugin("bafa", {}) -- A minimal 🤏🏾 BufExplorer alternative

setup_plugin("vuffers", {})
setup_plugin("retrospect", {}) -- https://github.com/mrquantumcodes/retrospect.nvim A simple and lightweight buffer manager for Neovim

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

-- TEXT ===========================================================================================

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

-- MARKS ==========================================================================================

setup_plugin("whaler", {})
setup_plugin("marks-nvim", {})

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

setup_plugin("arrow", {}) -- https://github.com/otavioschwanck/arrow.nvim  Bookmark your files, separated by project, and quickly navigate through them.

-- OTHER ==========================================================================================

setup_plugin("gx-extended-nvim", {})

-- likely deprecated; see README
setup_plugin("highlight-current-n-nvim", {}) -- https://github.com/rktjmp/highlight-current-n.nvim Highlights the current /, ? or * match under your cursor when pressing n or N and gets out of the way afterwards.

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
local pragma_defaults = {
	register_command = true,

	action = {
		buffer = {
			special = {
				["nvimtree"] = function(winid)
					local ntapi = require("nvim-tree.api")
					ntapi.tree.close_in_all_tabs()
					ntapi.tree.open({ winid = winid })
					return true
				end,

				["vuffers"] = function(winid)
					local vuffers = require("vuffers")
					vuffers.close()
					vuffers.open({ win = winid })
					return true
				end,

				["doing_tasks"] = function(winid)
					local path = require("doing.state").state.tasks.file
					local buf = vim.fn.bufadd(path)

					-- Load buffer and run FileType autocmd
					vim.api.nvim_set_option_value("filetype", "doing_tasks", { buf = buf })
					vim.fn.bufload(buf)
					vim.api.nvim_exec_autocmds("FileType", { buffer = buf })
					vim.api.nvim_win_set_buf(winid, buf)

					return true
				end,
			},
		},
	},

	layouts = {
		["fakezen"] = function()
			return require("pragma.pragma-builder")
				.new({ "fakezen" })
				:winonly({})
				:subdivide({
					select = false,
					alias = "left",
					direction = "left",
					width = 0.15,
					winopts = {
						number = false,
						relativenumber = false,
						statuscolumn = "",
					},
				})
				:subdivide({
					select = false,
					alias = "right",
					direction = "right",
					width = 0.15,
					winopts = {
						number = false,
						relativenumber = false,
						statuscolumn = "",
					},
				})
				:buffer({ strategy = "scratch", winalias = "left", winfixbuf = true })
				:buffer({ strategy = "scratch", winalias = "right", winfixbuf = true })
				:buffer({ strategy = "lastbuffer", winalias = "root" })
		end,

		["vhh"] = function()
			return require("pragma.pragma-builder")
				.new({ "vhh" })
				:winonly({})
				:subdivide({ direction = "below", height = 0.33 })
				:subdivide({ direction = "left", width = 0.4 })
				:focus({ alias = "root" })
		end,

		["vvvh-nvimtree-tasks-vuffer"] = function()
			return require("pragma.pragma-builder")
				.new({ "vvh-nvimtree-vuffer-lastused" })
				:winonly({})
				:subdivide({ direction = "left", alias = "nvimtree", width = 40 })
				:subdivide({
					direction = "below",
					alias = "doing_tasks",
					height = 0.60,
					winopts = {
						number = true,
						relativenumber = false,
						wrap = true,
						statuscolumn = "",
					},
				})
				:subdivide({
					direction = "below",
					alias = "vuffers",
					height = 0.5,
					winopts = {
						number = true,
						relativenumber = false,
						statuscolumn = "%{str2nr(line('$'))-v:lnum+1}",
					},
				})
				:buffer({ strategy = "special", name = "nvimtree", winalias = "nvimtree", winfixbuf = true })
				:buffer({ strategy = "special", name = "vuffers", winalias = "vuffers", winfixbuf = true })
				:buffer({ strategy = "special", name = "doing_tasks", winalias = "doing_tasks", winfixbuf = true })
				:buffer({ strategy = "lastbuffer", winalias = "root" })
				:focus({ alias = "root" })
		end,

		["vvh-nvimtree-vuffer"] = function()
			return require("pragma.pragma-builder")
				.new({ "vvh-nvimtree-vuffer-lastused" })
				:winonly({})
				:subdivide({ direction = "left", alias = "nvimtree", width = 40 })
				:subdivide({
					direction = "below",
					alias = "vuffers",
					height = 0.35,
					winopts = {
						number = true,
						relativenumber = false,
						wrap = true,
						statuscolumn = "",
					},
				})
				:buffer({ strategy = "special", name = "nvimtree", winalias = "nvimtree", winfixbuf = true })
				:buffer({ strategy = "special", name = "vuffers", winalias = "vuffers", winfixbuf = true })
				:buffer({ strategy = "lastbuffer", winalias = "root" })
				:focus({ alias = "root" })
		end,
	},
}
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
local bafa_defaults = {
	-- 🔔 Notification configuration
	notify = {
		-- Used for for feedback messages
		-- Anything that has a `vim.notify` like interface will work
		-- e.g. `juu.notify`, `telescope.notify`, etc.
		-- print is also supported,
		-- even though it's does not implement the notify interface
		provider = "vim.notify",
	},
	ui = {
		-- 🪄 Rendering configuration
		render = {
			-- Custom buffer line format function, default is nil.
			-- The function receives a BafaUiBufferLine as argument
			-- and should return a string to be displayed in the UI.
			custom_format_buffer_line = nil,
		},
		-- 🧭 Buffer ordering configuration
		sort = {
			-- Buffer ordering strategy
			-- "default" | "last_used" | "manual"
			-- "default": Buffers are ordered by last usage time
			-- "last_used": Buffers are ordered by their buffer number
			-- "manual": Buffers are ordered manually by the user
			method = "default",
			-- Only applicable when `method` is "default" or "last_used"
			-- When true, instead of focusing the current buffer,
			-- the previously used buffer will be focused when opening the UI
			focus_alternate_buffer = false,
		},
		-- 🦘 Jump-labels configuration
		jump_labels = {
			-- Keys to use for jump-labels
			-- in order of preference
			-- Should be unique characters
			-- Duplicates will be ignored
			-- require('bafa.utils.keys').protected_jump_label_keys
			-- are also protected and will be ignored
			-- You can customize this to your keyboard layout
			-- will also use uppercase variants of these keys
			-- if the lower-case ones are exhausted
			-- This should give us roughly 46 unique keys (minus the protected ones)
			-- That should be enough for most use-cases
			-- but when we run out of keys, only the first buffers (in order, from top to bottom)
			-- will get jump-labels assigned
			keys = {
				"a",
				"s",
				"d",
				"f",
				"j",
				"k",
				"l",
				";",
				"q",
				"w",
				"e",
				"r",
				"u",
				"i",
				"o",
				"p",
				"z",
				"x",
				"c",
				"n",
				"m",
				",",
				".",
			},
		},
		-- 🚨 Show diagnostics in the UI
		diagnostics = true,
		-- 📄 Show line numbers in the UI
		line_numbers = false,
		-- 👀 Title configuration
		title = {
			-- Title of the floating window
			text = "🦥",
			-- Position of the title: "left", "center", "right"
			-- See `:h nvim_open_win` for more details
			pos = "center",
		},
		-- 🎨 Floating window border configuration
		-- Floating window border: "single", "double", "rounded", "solid", "shadow", or a table
		-- See `:h nvim_open_win` for more details on custom borders
		border = "rounded",
		-- 🎨 Floating window style configuration
		-- Floating window style: "minimal", "normal"
		-- See `:h nvim_open_win` for more details
		style = "minimal",
		-- 📏 Floating window alignment configuration
		position = {
			-- Window position preset:
			-- "center", "top-center", "bottom-center", "top-left", "top-right",
			-- "bottom-left", "bottom-right", "center-left", "center-right"
			preset = "center",
			-- Custom row position (overrides preset if set)
			-- also supports a function that returns a number
			row = nil,
			-- Custom column position (overrides preset if set)
			-- also supports a function that returns a number
			col = nil,
		},
		-- 💄 Icons configuration
		icons = {
			-- 🚨 Diagnostics icons configuration
			diagnostics = {
				Error = "", -- Icon for error diagnostics
				Warn = "", -- Icon for warning diagnostics
				Info = "", -- Icon for info diagnostics
				Hint = "", -- Icon for hint diagnostics
			},
			-- 🖊️ Buffer changes sign configuration
			sign = {
				changes = "┃", -- Sign character for modified/deleted buffers
			},
		},
		-- 🎨 Highlight groups configuration
		hl = {
			-- 🖊️ Buffer changes sign highlight groups configuration
			sign = {
				modified = "GitSignsChange", -- Highlight group for modified buffer signs (fallback: DiffChange)
				deleted = "GitSignsDelete", -- Highlight group for deleted buffer signs (fallback: DiffDelete)
			},
		},
	},
}
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
local retrospect_defaults = {
	save_key = "<leader>\\", -- Keybinding to save session (default: <leader>\)
	load_key = "<leader><BS>", -- Keybinding to load session (default: <leader><BS>)
	autosave = false, -- Autosave session on every file write (default: false)
}
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
--──── PROJECTS ───────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- https://github.com/CWood-sdf/spaceport.nvim
-- The blazingly fastest way to get to your projects
local spaceport_nvim_defaults = {

	-- This prevents the same directory from being repeated multiple times in the recents section
	-- For example, I have replaceDirs set to { {"~/projects", "_" } } so that ~/projects is not repeated a ton
	-- Note every element is applied to the directory in order,
	--   so if you have { {"~/projects", "_"} } and you also want to replace
	--   ~/projects/foo with @, then you would need
	--   { {"~/projects/foo", "@"}, {"~/projects", "_"} }
	--   or { {"~/projects", "_"}, {"_/foo", "@"} }
	replaceDirs = {},

	-- turn /home/user/ into ~/ (also works on windows for C:\Users\user\)
	replaceHome = true,

	-- What to do when entering a directory, personally I use "Oil .", but Ex is preinstalled with neovim
	projectEntry = "Ex",

	-- Homes used by telescope.extensions.spaceport.find()
	-- Spaceport scans these for exact `.git` directories using `fd`.
	projectHomes = { "~" },
	-- projectHomes = { "~/git-projects", "~/other-projects" },

	-- The farthest back in time that directories should be shown
	-- I personally use "yesterday" so that there aren't millions of directories on the screen.
	-- the possible values are: "pin", "today", "yesterday", "pastWeek", "pastMonth", and "later"
	lastViewTime = "later",

	-- The maximum number of directories to show in the recents section (0 means show all of them)
	maxRecentFiles = 0,

	-- The sections to show on the screen (see `Customization` for more info)
	sections = {
		"_global_remaps",
		"name",
		"remaps",
		"recents",
	},

	-- toggle or set file and directory icons.
	--  For example, the following can be used to set different icons `{ file = " ", dir = " ", remaps = " ", pinned = " ", today = " ", yesterday = " ", week = " ", month = " ", long = " ", news = "󱀄 " }`
	icons = true,

	-- For true speed, it has the type string[][],
	--  each element of the shortcuts array contains two strings, the first is the key, the second is a match string to a directory
	--   for example, I have ~/.config/nvim as shortcut f, so I can type `f` to go to my neovim dotfiles, this is set with { { "f", ".config/nvim" } }
	shortcuts = {
		{ "f", ".config/nvim" },
	},

	--- Set to true to have more verbose logging
	debug = false,

	-- The path to the log file
	logPath = vim.fn.stdpath("log") .. "/spaceport.log",
	-- How many hours to preserve each log entry for
	logPreserveHours = 24,
}
setup_plugin("spaceport-nvim", spaceport_nvim_defaults)

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
-- Code analysis & navigation plugin for Neovim. Navigate codes like a breeze.
--     Make exploring LSP and Treesitter symbols a piece of cake. Take control like a boss.
local navigator_config = {
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
setup_plugin("navigator", navigator_config)

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

-- TODO: set up as telescope extension
-- https://github.com/SalOrak/whaler.nvim
-- Minimalistic & highly extensible project manager for NeoVim.
local whaler_defaults = {
	-- Path directories to search. By default the list is empty.
	directories = { "/home/user/projects", { path = "/home/user/work", alias = "work" } },

	-- Path directories to append directly to list of projects. By default is empty.
	oneoff_directories = { "/home/user/.config/nvim" },

	-- Whether to automatically open file explorer. By default is `true`
	auto_file_explorer = true,

	-- Whether to automatically change current working directory. By default is `true`
	auto_cwd = true,

	-- Minimum verbosity level to notify when something happens. By default is WARN.
	-- See `vim.log.levels`
	verbosity = vim.log.levels.WARN,

	-- Automagically creates a configuration for the file explorer of your choice.
	-- Options are "fzf_lua_explorer", "netrw"(default), "nvimtree", "neotree", "oil", "telescope_file_browser", "rnvimr"
	file_explorer = "netrw",

	-- Show hidden directories or not (default false)
	hidden = false,

	-- (OPTIONAL) If you want to fully customize the file explorer configuration,
	-- below are all the possible options and its default values.
	file_explorer_config = {

		-- Plugin. Should be installed.
		plugin_name = "netrw",

		-- The plugin command to open.
		-- Command must accept a path as parameter
		-- Prefix string to be appended after the command and before the directory path.
		command = "Explorer",

		-- Example: In the `telescope_file_browser` the value is ` path=`.
		--          The final command is `Telescope file_browser path=/path/to/dir`.
		-- By default is " " (space)
		prefix_dir = " ",
	},

	-- Which picker to use. One of 'telescope', 'fzf_lua' or 'vanilla'. Default to 'telescope'
	picker = "telescope",

	-- Picker options
	-- Options to pass to Telescope. Below is the default.
	telescope_opts = {
		results_title = false,
		layout_strategy = "center",
		previewer = false,
		layout_config = {
			--preview_cutoff = 1000,
			height = 0.3,
			width = 0.4,
		},
		sorting_strategy = "ascending",
		border = true,
	},
	-- For compatiblity you can also use `theme` directly to modify Telescope.
	theme = {},

	-- Options to pass to FzfLua directly. See
	-- https://github.com/ibhagwan/fzf-lua?tab=readme-ov-file#customization for
	-- options. Below is the defaults.
	fzflua_opts = {
		prompt = "Whaler >> ",
		--- You can modify the actions! Go ahead!
		actions = {
			["default"] = function(selected)
				local Whaler = require("whaler")
				local dirs_map = State:get().dirs_map

				local display = selected[1]
				local path = dirs_map[selected[1]]

				-- For changing projects and
				Whaler.select(path, display)
			end,
		},
		fn_format_entry = function(entry)
			if entry.alias then
				return ("[" .. entry.alias .. "] " .. vim.fn.fnamemodify(entry.path, ":t"))
			end
			return entry.path
		end,
	},
}
setup_plugin("whaler", whaler_defaults)

-- https://github.com/chentoast/marks.nvim
-- A better user experience for viewing and interacting with Vim marks.
local marks_nvim_defaults = {
	-- whether to map keybinds or not. default true
	default_mappings = true,
	-- which builtin marks to show. default {}
	builtin_marks = { ".", "<", ">", "^" },
	-- whether movements cycle back to the beginning/end of buffer. default true
	cyclic = true,
	-- whether the shada file is updated after modifying uppercase marks. default false
	force_write_shada = false,
	-- how often (in ms) to redraw signs/recompute mark positions.
	-- higher values will have better performance but may cause visual lag,
	-- while lower values may cause performance penalties. default 150.
	refresh_interval = 250,
	-- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
	-- marks, and bookmarks.
	-- can be either a table with all/none of the keys, or a single number, in which case
	-- the priority applies to all marks.
	-- default 10.
	sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
	-- disables mark tracking for specific filetypes. default {}
	excluded_filetypes = {},
	-- disables mark tracking for specific buftypes. default {}
	excluded_buftypes = {},
	-- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
	-- sign/virttext. Bookmarks can be used to group together positions and quickly move
	-- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
	-- default virt_text is "".
	bookmark_0 = {
		sign = "⚑",
		virt_text = "hello world",
		-- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
		-- defaults to false.
		annotate = false,
	},
	mappings = {},
}
setup_plugin("marks", marks_nvim_defaults)

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
local arrow_defaults = {
	show_icons = true,
	always_show_path = false,
	separate_by_branch = false, -- Bookmarks will be separated by git branch
	hide_handbook = false, -- set to true to hide the shortcuts on menu.
	hide_buffer_handbook = false, --set to true to hide shortcuts on buffer menu
	save_path = function()
		return vim.fn.stdpath("cache") .. "/arrow"
	end,
	mappings = {
		edit = "e",
		delete_mode = "d",
		clear_all_items = "C",
		toggle = "s", -- used as save if separate_save_and_remove is true
		open_vertical = "v",
		open_horizontal = "-",
		quit = "q",
		remove = "x", -- only used if separate_save_and_remove is true
		next_item = "]",
		prev_item = "[",
	},
	custom_actions = {
		open = function(target_file_name, current_file_name) end, -- target_file_name = file selected to be open, current_file_name = filename from where this was called
		split_vertical = function(target_file_name, current_file_name) end,
		split_horizontal = function(target_file_name, current_file_name) end,
	},
	window = { -- controls the appearance and position of an arrow window (see nvim_open_win() for all options)
		width = "auto",
		height = "auto",
		row = "auto",
		col = "auto",
		border = "double",
	},
	per_buffer_config = {
		lines = 4, -- Number of lines showed on preview.
		sort_automatically = true, -- Auto sort buffer marks.
		satellite = { -- default to nil, display arrow index in scrollbar at every update
			enable = false,
			overlap = true,
			priority = 1000,
		},
		zindex = 10, --default 50
		treesitter_context = nil, -- it can be { line_shift_down = 2 }, currently not usable, for detail see https://github.com/otavioschwanck/arrow.nvim/pull/43#issue-2236320268
	},
	separate_save_and_remove = false, -- if true, will remove the toggle and create the save/remove keymaps.
	leader_key = ";",
	save_key = "cwd", -- what will be used as root to save the bookmarks. Can be also `git_root` and `git_root_bare`.
	global_bookmarks = false, -- if true, arrow will save files globally (ignores separate_by_branch)
	index_keys = "123456789zxcbnmZXVBNM,afghjklAFGHJKLwrtyuiopWRTYUIOP", -- keys mapped to bookmark index, i.e. 1st bookmark will be accessible by 1, and 12th - by c
	full_path_list = { "update_stuff" }, -- filenames on this list will ALWAYS show the file path too.
}
setup_plugin("arrow", arrow_defaults)

-- PROBABLY NOT, BUT WORTH A TRY
-- https://github.com/haya14busa/vim-edgemotion
-- Move to the edge!
utils.packadd("vim-edgemotion")

--─────────────────────────────────────────────────────────────────────────────
--──── URL-RELATED ────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- TODO: set up Jira
-- https://github.com/rmagatti/gx-extended.nvim
-- gx-extended.nvim supercharges Neovim's built-in gx command. Press gx on anything — package names, import statements, issue numbers, commit hashes, and more — and it opens the right URL in your browser.
local gx_extended_nvim_defaults = {
	-- Optional: NPM imports in JS/TS files
	enable_npm_imports = true,

	-- Optional: GitHub file line permalinks
	enable_github_file_line = true,

	-- Optional: Custom browser
	open_fn = function() end, -- TODO: create open_fn (see/vendor lazy.util.open)
	extensions = {
		{
			patterns = { "*" },
			name = "Jira Tickets",
			match_to_url = function(line_string)
				local ticket = string.match(line_string, "([A-Z]+-[0-9]+)")
				if ticket then
					return "https://yourcompany.atlassian.net/browse/" .. ticket
				end
			end,
		},
	},
}
setup_plugin("gx-extended-nvim", gx_extended_nvim_defaults)

-- https://github.com/axieax/urlview.nvim
-- viewing all the URLs in a buffer
local urlview_defaults = {
	-- Prompt title (`<context> <default_title>`, e.g. `Buffer Links:`)
	default_title = "Links:",
	-- Default picker to display links with
	-- Options: "native" (vim.ui.select) or "telescope"
	default_picker = "native",
	-- Set the default protocol for us to prefix URLs with if they don't start with http/https
	default_prefix = "https://",
	-- Command or method to open links with
	-- Options: "netrw", "system" (default OS browser), "clipboard"; or "firefox", "chromium" etc.
	-- By default, this is "netrw", or "system" if netrw is disabled
	default_action = "netrw",
	-- Set the register to use when yanking
	-- Default: + (system clipboard)
	default_register = "+",
	-- Whether plugin URLs should link to the branch used by your package manager
	default_include_branch = false,
	-- Ensure links shown in the picker are unique (no duplicates)
	unique = true,
	-- Ensure links shown in the picker are sorted alphabetically
	sorted = true,
	-- Minimum log level (recommended at least `vim.log.levels.WARN` for error detection warnings)
	log_level_min = vim.log.levels.INFO,
	-- Keymaps for jumping to previous / next URL in buffer
	jump = {
		prev = "[u",
		next = "]u",
	},
}
setup_plugin("urlview", urlview_defaults)

--─────────────────────────────────────────────────────────────────────────────
--──── OTHER ───────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- TODO: vendor similar approach; see README: https://github.com/rktjmp/highlight-current-n.nvim#neovim-09
-- likely deprecated; see README
-- https://github.com/rktjmp/highlight-current-n.nvim
-- Highlights the current /, ? or * match under your cursor when pressing n or N and gets out of the way afterwards.
local highlight_current_n_defaults = nil
setup_plugin("highlight-current-n-nvim", function(highlight_current_n)
	-- Map keys
	vim.keymap.set("n", "n", "<Plug>(highlight-current-n-n")
	vim.keymap.set("n", "n", "<Plug>(highlight-current-n-N")

	-- If you want the highlighting to take effect in other maps they must
	-- also be nmaps (or rather, not "nore").
	--
	-- * will search <cword> ahead, but it can be more ergonomic to have *
	-- simply fill the / register with the current <cword>, which makes future
	-- commands like cgn "feel better". This effectively does that by performing
	-- "search ahead <cword> (*), go back to last match (N)".
	vim.keymap.set("n", "*", "*N")

	-- Some QOL autocommands
	--[[ TODO: translate
		augroup ClearSearchHL
		autocmd!
		" You may only want to see hlsearch /while/ searching, you can automatically
		" toggle hlsearch with the following autocommands
		autocmd CmdlineEnter /,\? set hlsearch
		autocmd CmdlineLeave /,\? set nohlsearch
		" this will apply similar n|N highlighting to the first search result
		" careful with escaping ? in lua, you may need \\?
		autocmd CmdlineLeave /,\? lua require('highlight_current_n')['/,?']()
		augroup END
	--]]
end)

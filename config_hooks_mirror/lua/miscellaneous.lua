--─────────────────────────────────────────────────────────────────────────────
--──── to vendor ──────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- <EXPERIMENTAL>
-- https://github.com/LunarVim/Launch.nvim
-- Launch.nvim is modular starter for Neovim.
local launch_defaults = nil
setup_plugin("Launch", launch_defaults)

-- <EXPERIMENTAL>
-- https://github.com/bagohart/minimal-narrow-region.nvim
-- Opinionated minimal implementation of Emacs' narrowing feature (https://www.gnu.org/software/emacs/manual/html_node/emacs/Narrowing.html)
local minimal_narrow_region_defaults = nil
setup_plugin("minimal-narrow-region", function(mnr)
	-- No mappings by default, create them explicitly:
	map_explicit({
		mode = "x",
		sequence = "<Leader><Leader>nr",
		action = mnr.NarrowRegionOpen,
	})
	map_explicit({
		mode = "n",
		sequence = "<Leader><Leader>NR",
		action = mnr.NarrowRegionClose,
	})
end)

-- TODO: adapt for just/taskfile/etc.
-- https://github.com/ChSotiriou/nvim-telemake
-- nvim extension with nvim-telescope to select and run any Makefile target
setup_plugin("telemake") -- TODO: set up as telescope extension

-- https://github.com/anuvyklack/nvim-api-wrappersI've eb
-- library with OOP wrappers around Neovim api.
--     This library itself depend on middleclass library.
local nvim_api_wrappers_defaults = nil
setup_plugin("nvim-api-wrappers", nvim_api_wrappers_defaults)

-- https://github.com/willothy/wezterm.nvim
-- Utilities for interacting with Wezterm from within Neovim
local wezterm_nvim_defaults = { create_commands = true }
setup_plugin("wezterm-nvim", wezterm_nvim_defaults)

-- https://github.com/Mohammed-Taher/AdvancedNewFile.nvim
-- A simple plugin for neovim to create files and folders quickly.
setup_plugin("advanced_new_file", function(anf)
	anf.goto_file = true
	anf.notify = true
	anf.show_cwd = false
	anf.prompt = "File name (or Folder): "
	map_explicit({
		mode = "n",
		sequence = "<C-n>",
		action = "<cmd>AdvancedNewFile<CR>",
		opts = { noremap = true },
	})
end)

-- TODO: move to modules?
-- https://github.com/notomo/tracebundler.nvim
-- Trace and bundle neovim lua for debugging
local tracebundler_defaults = nil
setup_plugin("tracebundler", tracebundler_defaults)

-- https://github.com/chaitanyabsprip/present.nvim
-- Presentation plugin for neovim written in lua
local present_defaults = {
	default_mappings = true,
	kitty = {
		normal_font_size = 12,
		zoomed_font_size = 28,
	},
}
setup_plugin("present", present_defaults)
-- https://github.com/letieu/wezterm-move.nvim
-- https://github.com/mawkler/move-mode.nvim

--─────────────────────────────────────────────────────────────────────────────
--──── nvim-/lua-related ──────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- https://github.com/notomo/runtimetable.nvim
-- Create runtime files from lua table.
setup_plugin("runtimetable", function(_) end)

-- https://github.com/tastyep/structlog.nvim
-- Structured Logging for nvim, using Lua
setup_plugin("structlog", function(log)
	log.configure({
		my_logger = {
			pipelines = {
				{
					level = log.level.INFO,
					processors = {
						log.processors.StackWriter({ "line", "file" }, { max_parents = 0, stack_level = 0 }),
						log.processors.Timestamper("%H:%M:%S"),
					},
					formatter = log.formatters.FormatColorizer( --
						"%s [%s] %s: %-30s",
						{ "timestamp", "level", "logger_name", "msg" },
						{ level = log.formatters.FormatColorizer.color_level() }
					),
					sink = log.sinks.Console(),
				},
				{
					level = log.level.WARN,
					processors = {},
					formatter = log.formatters.Format( --
						"%s",
						{ "msg" },
						{ blacklist = { "level", "logger_name" } }
					),
					sink = log.sinks.NvimNotify(),
				},
				{
					level = log.level.TRACE,
					processors = {
						log.processors.StackWriter({ "line", "file" }, { max_parents = 3 }),
						log.processors.Timestamper("%H:%M:%S"),
					},
					formatter = log.formatters.Format( --
						"%s [%s] %s: %-30s",
						{ "timestamp", "level", "logger_name", "msg" }
					),
					sink = log.sinks.File("./test.log"),
				},
			},
		},
		-- other_logger = {...}
	})

	-- local logger = log.get_logger("my_logger")
	-- logger:info("A log message")
	-- logger:warn("A log message with keyword arguments", { warning = "something happened" })
end)

-- PROBABLY NOT, BUT WORTH A TRY
-- https://github.com/svermeulen/nvim-teal-maker
-- Neovim plugin that adds plugin support for teal language
local nvim_teal_maker_defaults = nil
setup_plugin("tealmaker", nvim_teal_maker_defaults)

-- https://github.com/CWood-sdf/cmdTree.nvim
--  Declaratively make your neovim user commands
setup_plugin("cmdTree", function(cmdtree) end)

--─────────────────────────────────────────────────────────────────────────────
--──── timer, time tracking ───────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- TODO: compare https://github.com/epwalsh/pomo.nvim (maybe vendor?)
-- https://github.com/jackMort/pommodoro-clock.nvim
-- yet another pommodoro neovim plugin that displays an ASCII timer in an overlay
local pommodoro_clock_defaults = {
	modes = {
		["work"] = { "POMMODORO", 25 },
		["short_break"] = { "SHORT BREAK", 5 },
		["long_break"] = { "LONG BREAK", 30 },
	},
	animation_duration = 300,
	animation_fps = 30,
	say_command = "spd-say -l en -t female3",
	sound = "voice", -- set to "none" to disable
}
setup_plugin("pommodoro-clock", pommodoro_clock_defaults)

-- TODO: add nui as dependency
-- https://github.com/wthollingsworth/pomodoro.nvim
-- A Pomodoro timer for Neovim written in Lua
local pomodoro_defaults = {
	time_work = 25,
	time_break_short = 5,
	time_break_long = 20,
	timers_to_long_break = 4,
}
setup_plugin("pomodoro", pomodoro_defaults)
-- let g:pomodoro_time_work = 25
-- let g:pomodoro_time_break_short = 5
-- let g:pomodoro_time_break_long = 20
-- let g:pomodoro_timers_to_long_break = 4

-- https://github.com/nvzone/timerly
-- Beautiful countdown timer plugin for Neovim
local timerly_defaults = {
	minutes = { 25, 5 },
	on_start = nil, -- func
	on_finish = function()
		vim.notify("Timerly: time's up!")
	end,
	mapping = nil, -- is func
	position = "center", -- top-left, top-right, bottom-left, bottom-right
	-- or function(w, h) return row, col end , w - w of window, arg passed by plugin
}
setup_plugin("timerly", function(timerly)
	timerly.setup(timerly_defaults)

	vim.api.nvim_create_user_command("Timer", function()
		vim.o.showtabline = 0
		vim.o.laststatus = 0
		vim.wo.number = false
		vim.o.scl = "no"
		vim.o.cmdheight = 0
		vim.cmd("TimerlyToggle")
	end, {})
end)

-- https://github.com/eliasCVII/timew.nvim
-- Run some timewarrior commands from neovim
local timew_defaults = {
	-- these two settings follow the same format as they do in the timew command.
	-- they are shorthand for "timew summary :ids :{your setting}"
	summary_sort = "week", -- day, week, month or year. Display your summary based on a given timeframe.
	delete_sort = "week", -- day, week, month or year. I use summary to display a list of your tracked tasks
}
setup_plugin("timew", function(timew)
	timew.setup(timew_defaults)

	-- Set Timew bindings
	map_explicit({
		mode = "n",
		sequence = "<leader>tn",
		action = "<Cmd>Timew start<CR>",
	})
	map_explicit({
		mode = "n",
		sequence = "<leader>ts",
		action = "<Cmd>Timew stop<CR>",
	})
	map_explicit({
		mode = "n",
		sequence = "<leader>tc",
		action = "<Cmd>Timew continue<CR>",
	})
	map_explicit({
		mode = "n",
		sequence = "<leader>tC",
		action = "<Cmd>Timew cancel<CR>",
	})
	map_explicit({
		mode = "n",
		sequence = "<leader>td",
		action = "<Cmd>Timew delete<CR>",
	})
	map_explicit({
		mode = "n",
		sequence = "<leader>tS",
		action = "<Cmd>Timew summary<CR>",
	})
end)

-- https://github.com/dbinagi/nomodoro
-- Pomodoro time tracker for NeoVim written entirely in LUA
local nomodoro_defaults = {
	work_time = 25,
	short_break_time = 5,
	long_break_time = 15,
	break_cycle = 4,
	menu_available = true,
	texts = {
		on_break_complete = "TIME IS UP!",
		on_work_complete = "TIME IS UP!",
		status_icon = "🍅 ",
		timer_format = "!%0M:%0S", -- To include hours: '!%0H:%0M:%0S'
	},
	on_work_complete = function() end,
	on_break_complete = function() end,
}
setup_plugin("nomodoro", nomodoro_defaults)

-- https://github.com/Cassin01/sche.nvim
-- A text-based schedule plugin for neovim (fennel)
local sche_defaults = {
	default_keymap = true,
	notify_todays_schedule = true,
	notify_tomorrows_schedule = true,
	hl = {
		GCalendarMikan = { fg = "#F4511E" },
		GCalendarPeacock = { fg = "#039BE5" },
		GCalendarGraphite = { fg = "#616161" },
		GCalendarSage = { fg = "#33B679" },
		GCalendarBanana = { fg = "#f6bf26" },
		GCalendarLavender = { fg = "#7986cb" },
		GCalendarTomato = { fg = "#d50000" },
		GCalendarFlamingo = { fg = "#e67c73" },
	},
	notify = {
		["@"] = function(annex)
			return "There is a chedule: " .. annex
		end,
		["#"] = function(annex)
			return "There is a memo: " .. annex
		end,
		["+"] = function(annex)
			return "There is a todo: " .. annex
		end,
		["-"] = function(annex)
			return "There is a remainder: " .. annex
		end,
		["!"] = function(annex)
			return "There is a deadline: " .. annex
		end,
		["."] = function(annex)
			return "You have completed: " .. annex
		end,
	},
	sche_path = "none",
	syntax = {
		on = true,
		date = {
			vim_regex = "\\d\\d\\d\\d/\\d\\d/\\d\\d",
			lua_regex = "%d%d%d%d/%d%d/%d%d",
			vimstrftime = "%Y/%m/%d",
		},
		month = "abridged",
		weekday = "abridged",
		sunday = "'\\<Sun\\>'",
		saturday = "'\\<Sat\\>'",
	},
}
setup_plugin("sche", sche_defaults)

-- https://github.com/hugginsio/twig.nvim
-- taskwarrior integration
local twig_defaults = {
	project_pattern = ".+", -- an additional Lua match pattern to apply to the buffer name
	fallback = true, -- if `project_pattern` does not match, fall back to the buffer name alone
}
setup_plugin("twig", twig_defaults)

--─────────────────────────────────────────────────────────────────────────────
--──── dashboard/startpage/splash ─────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- TODO: hacky, but works -> necessary due to name collision
-- https://github.com/nvimdev/dashboard-nvim/
--[[
- Low memory usage. dashboard does not store the all user configs in memory like header etc
       these string will take some memory. now it will be clean after you open a file. 
	   You can still use dashboard command to open a new one , then dashboard will read the config from cache.
- Blazing fast  --]]
local dashboard_defaults = {
	theme = "hyper", --    theme is doom and hyper default is hyper
	disable_move, --       default is false disable move keymap for hyper
	shortcut_type, --      shortcut type 'letter' or 'number'
	shuffle_letter, --     default is false, shortcut 'letter' will be randomize, set to false to have ordered letter
	letter_list, --        default is a-z, excluding j and k
	change_to_vcs_root, -- default is false,for open file in hyper mru. it will change to the root of vcs
	config = {}, --        config used for theme
	hide = {
		statusline, -- hide statusline default is true
		tabline, --    hide the tabline
		winbar, --     hide winbar
	},
	preview = {
		command, --     preview command
		file_path, --   preview file path
		file_height, -- preview file height
		file_width, --  preview file width
	},
}
local function setup_nvimdev_dashboard()
	utils.packadd("dashboard-nvim")
	local dashboard = require("dashboard")
	dashboard.setup(dashboard_defaults)
end

-- https://github.com/MeanderingProgrammer/dashboard.nvim
--[[
Fully customizable header with reference for integrating with ascii art plugin
Provide directories and this plugin will:
  - Display them on the dashboard
  - Make them accessible with single letter hotkey
Input is ordered and hotkeys are generated sequentially, making for a consistent experience
--]]
local dashboard_defaults = {
	-- Sequence that determines keymaps
	autokeys = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
	-- Dashboard header
	header = {},
	-- Format to display date in
	date_format = nil,
	-- List of directory paths, or functions that return paths
	directories = {},
	-- Sections to add at bottom, these can be string references to
	-- functions in sections.lua, custom strings, or custom functions
	footer = {},
	-- Buffer local options
	bo = {
		bufhidden = "wipe",
		buflisted = false,
		filetype = "dashboard",
		swapfile = false,
	},
	-- Window local options
	wo = {
		cursorcolumn = false,
		cursorline = false,
		number = false,
		relativenumber = false,
		spell = false,
		statuscolumn = "",
		wrap = false,
	},
	-- Gets called after directory is changed and is provided with the
	-- directory path as an argument
	on_load = function(path)
		-- do nothing
	end,
	-- Highlight groups to use for various components
	highlight_groups = {
		header = "Constant",
		icon = "Type",
		directory = "Delimiter",
		hotkey = "Statement",
	},
}
setup_plugin("dashboard", dashboard_defaults)

-- https://github.com/jovanlanik/fsplash.nvim
-- Show a custom splash screen in a floating window
local fsplash_defaults = {
	-- lines of text containing the splash
	lines = {
		" _  ___   _____ __  __ ",
		"| \\| \\ \\ / /_ _|  \\/  |",
		"| .` |\\ V / | || |\\/| |",
		"|_|\\_| \\_/ |___|_|  |_|",
	},
	-- autocmds that close the splash
	autocmds = {
		"ModeChanged",
		"CursorMoved",
		"TextChanged",
		"VimResized",
		"WinScrolled",
	},
	-- highlights in this table will be set using vim.api.nvim_set_hl()
	highlights = {
		-- this resets NormalFloat
		["NormalFloat"] = {},
		-- the following line would set it to gray
		-- ['NormalFloat'] = { ctermfg = 'darkgray' };
	},
	-- floting window border
	border = "solid",
	-- winblend option
	winblend = 0,
}
setup_plugin("fsplash", fsplash_defaults)

-- https://github.com/folke/drop.nvim
--  Fun little plugin that can be used as a screensaver and on your dashboard
local drop_defaults = {

	---@type DropTheme|string
	theme = "auto", -- when auto, it will choose a theme based on the date
	---@type ({theme: string}|DropDate|{from:DropDate, to:DropDate}|{holiday:"us_thanksgiving"|"easter"})[]
	themes = {
		{ theme = "new_year", month = 1, day = 1 },
		{ theme = "valentines_day", month = 2, day = 14 },
		{ theme = "st_patricks_day", month = 3, day = 17 },
		{ theme = "easter", holiday = "easter" },
		{ theme = "april_fools", month = 4, day = 1 },
		{ theme = "us_independence_day", month = 7, day = 4 },
		{ theme = "halloween", month = 10, day = 31 },
		{ theme = "us_thanksgiving", holiday = "us_thanksgiving" },
		{ theme = "xmas", from = { month = 12, day = 24 }, to = { month = 12, day = 25 } },
		{ theme = "leaves", from = { month = 9, day = 22 }, to = { month = 12, day = 20 } },
		{ theme = "snow", from = { month = 12, day = 21 }, to = { month = 3, day = 19 } },
		{ theme = "spring", from = { month = 3, day = 20 }, to = { month = 6, day = 20 } },
		{ theme = "summer", from = { month = 6, day = 21 }, to = { month = 9, day = 21 } },
	},
	max = 75, -- maximum number of drops on the screen
	interval = 100, -- every 150ms we update the drops
	screensaver = 1000 * 60 * 5, -- show after 5 minutes. Set to false, to disable
	filetypes = { "dashboard", "alpha", "ministarter" }, -- will enable/disable automatically for the following filetypes
	winblend = 100, -- winblend for the drop window
}
setup_plugin("drop", drop_defaults)

--─────────────────────────────────────────────────────────────────────────────
--──── pkm ────────────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- https://github.com/Hashino/doing.nvim
-- A minimal task manager for neovim
local doing_defaults = {
	message_timeout = 2000,
	doing_prefix = "Doing: ",

	-- doesn't display on buffers that match filetype/filename/filepath to
	-- entries. can be either a string array or a function that returns a
	-- string array. filepath can be relative to cwd or absolute
	ignored_buffers = { "NvimTree" },

	-- if should append "+n more" to the status when there's tasks remaining
	show_remaining = true,

	-- if should show messages on the status string
	show_messages = true,

	-- window configs of the floating tasks editor
	-- see :h nvim_open_win() for available options
	edit_win_config = {
		width = 50,
		height = 15,
		border = "rounded",
	},

	-- if plugin should manage the winbar
	winbar = { enabled = true },

	store = {
		-- name of tasks file
		file_name = ".tasks",
		-- if true, tasks file is always in sync with
		-- tasklist, otherwise, tasks get saved to file on
		-- closing neovim or changing cwd
		sync_tasks = false,
	},
}
setup_plugin("doing", function(doing)
	vim.api.nvim_set_hl(0, "WinBar", { link = "Search" })

	doing.setup(doing_defaults)

	map_explicit({
		mode = "n",
		sequence = "<leader>da",
		action = doing.add,
		opts = { desc = "[D]oing: [A]dd" },
	})
	map_explicit({
		mode = "n",
		sequence = "<leader>de",
		action = doing.edit,
		opts = { desc = "[D]oing: [E]dit" },
	})
	map_explicit({
		mode = "n",
		sequence = "<leader>dn",
		action = doing.done,
		opts = { desc = "[D]oing: Do[n]e" },
	})
	map_explicit({
		mode = "n",
		sequence = "<leader>dt",
		action = doing.toggle,
		opts = { desc = "[D]oing: [T]oggle" },
	})

	map_explicit({
		mode = "n",
		sequence = "<leader>ds",
		action = function()
			vim.notify(doing.status(true), vim.log.levels.INFO, { title = "Doing:", icon = "" })
		end,
		opts = { desc = "[D]oing: [S]tatus" },
	})
end)

-- https://github.com/vimwiki/vimwiki
-- Personal Wiki for Vim
utils.packadd("vimwiki", function()
	vim.cmd("set nocompatible")
	vim.cmd("filetype plugin on")
	vim.cmd("syntax on")

	vim.g.vimwiki_path = "~/vimwiki/"
	-- vim.g.vimwiki_syntax = 'markdown'
	-- vim.g.vimwiki_ext = "md"
end)

-- https://github.com/obsidian-nvim/obsidian.nvim
-- Obsidian 🤝 Neovim (actively maintained version)
local obsidian_defaults = {
	legacy_commands = false, -- this will be removed in 4.0.0
	workspaces = {
		{
			name = "personal",
			path = "~/vaults/personal",
		},
		{
			name = "work",
			path = "~/vaults/work",
		},
	},
}
setup_plugin("obsidian", obsidian_defaults)

-- https://github.com/nvim-orgmode/orgmode
-- Orgmode clone written in Lua for Neovim 0.11.0+
local orgmode_defaults = {
	org_agenda_files = "~/orgfiles/**/*",
	org_default_notes_file = "~/orgfiles/refile.org",
} -- TODO: check docs
setup_plugin("orgmode", orgmode_defaults)

-- https://github.com/ds1sqe/Calendar.nvim
-- require("calendar").getCalendar() -- this will returns you a calender string; no config needed
local Calendar_defaults = nil
setup_plugin("Calendar", Calendar_defaults)

-- https://github.com/Furkanzmc/zettelkasten.nvim
-- A Vim Philosophy Oriented Zettelkasten Note Taking Plugin
local zettelkasten_defaults = {
	notes_path = "",
	preview_command = "pedit",
	browseformat = "%f - %h [%r Refs] [%b B-Refs] %t",
	id_inference_location = M.TITLE,
	id_pattern = "%d+-%d+-%d+-%d+-%d+-%d+",
	id_format = "%Y-%m-%d-%H-%M-%S",
	filename_pattern = "%d+-%d+-%d+-%d+-%d+-%d+.md",
	title_pattern = "# %d+-%d+-%d+-%d+-%d+-%d+ .+",
}
setup_plugin("zettelkasten", zettelkasten_defaults)

-- https://github.com/JellyApple102/flote.nvim
-- Easily accessible, per-project markdown notes in Neovim.
local flote_defaults = {
	q_to_quit = true,
	window_style = "minimal",
	window_border = "solid",
	window_title = true,
	notes_dir = vim.fn.stdpath("cache") .. "/flote",
	files = {
		global = "flote-global.md",
		cwd = function()
			return vim.fn.getcwd()
		end,
		file_name = function(cwd)
			local base_name = vim.fs.basename(cwd)
			local parent_base_name = vim.fs.basename(vim.fs.dirname(cwd))
			return parent_base_name .. "_" .. base_name .. ".md"
		end,
	},
}
setup_plugin("flote", flote_defaults)

-- https://github.com/2kabhishek/tdo.nvim
-- Fast & Simple Notes in Neovim
local tdo_config = { with_lsp = false }
setup_plugin("tdo", tdo_defaults)
-- TODO: vendor/PR to fix old LspStart command -> new Lua LSP API
setup_plugin("scratch-buffer", function(scratch_buffer)
	scratch_buffer.setup(tdo_config)
end)

-- https://github.com/nyngwang/NeoWell.lua
-- Well... I will fix this line later
local neowell_defaults = { height = 10 }
setup_plugin("neowell-lua", function(neowell)
	neowell.setup(neowell_defaults)

	local NOREF_NOERR_TRUNC = { noremap = true, silent = true, nowait = true }

	map_explicit({
		mode = "n",
		sequence = "\\",
		action = function()
			vim.cmd("NeoWellToggle")
		end,
		opts = NOREF_NOERR_TRUNC,
	})
	map_explicit({
		mode = "n",
		sequence = "<Leader>/",
		action = function()
			vim.cmd("NeoWellAppend")
		end,
		opts = NOREF_NOERR_TRUNC,
	})
	map_explicit({
		mode = "n",
		sequence = "<CR>",
		action = function()
			-- vim.cmd('NeoZoomToggle') -- remove this if you don't know what it is
			vim.cmd("NeoWellJump")
		end,
		opts = NOREF_NOERR_TRUNC,
	})
	map_explicit({
		mode = "n",
		sequence = "<Leader>r",
		action = function()
			vim.cmd("NeoWellEdit")
		end,
		opts = NOREF_NOERR_TRUNC,
	})
	map_explicit({
		mode = "n",
		sequence = "<Leader>r",
		action = function()
			vim.cmd("NeoWellEdit")
		end,
		opts = NOREF_NOERR_TRUNC,
	})
	map_explicit({
		mode = "n",
		sequence = "<Leader>d",
		action = function()
			vim.cmd("NeoWellOut")
		end,
		opts = NOREF_NOERR_TRUNC,
	})
	map_explicit({
		mode = "n",
		sequence = "<Leader>D",
		action = function()
			vim.cmd("NeoWellWipeOut")
		end,
		opts = NOREF_NOERR_TRUNC,
	})
end)

-- https://github.com/RutaTang/quicknote.nvim
-- Quickly take notes, in-place
local quicknote_defaults = {
	{
		"RutaTang/quicknote.nvim",
		config = function()
			require("quicknote").setup({
				mode = "portable", -- "portable" | "resident", default to "portable"
				sign = "N", -- This is used for the signs on the left side (refer to ShowNoteSigns() api).
				-- You can change it to whatever you want (eg. some nerd fonts icon), 'N' is default
				filetype = "md",
				git_branch_recognizable = true, -- If true, quicknote will separate notes by git branch
				-- But it should only be used with resident mode,  it has not effect used with portable mode
			})
		end,
		dependencies = { "nvim-lua/plenary.nvim" },
	},
}
setup_plugin("quicknote", function(quicknote)
	quicknote.setup(quicknote_defaults)
	vim.api.nvim_set_keymap("n", "<leader>p", "<cmd>:lua require('quicknote').NewNoteAtCurrentLine()<cr>", {})
end)

--─────────────────────────────────────────────────────────────────────────────
--──── diagrams ───────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- TODO

--─────────────────────────────────────────────────────────────────────────────
--──── colors ─────────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- https://github.com/brenoprata10/nvim-highlight-colors
-- Highlight colors for neovim
local nvim_highlight_colors_defaults = {
	---Render style
	---@usage 'background'|'foreground'|'virtual'
	render = "background",

	---Set virtual symbol (requires render to be set to 'virtual')
	virtual_symbol = "■",

	---Set virtual symbol suffix (defaults to '')
	virtual_symbol_prefix = "",

	---Set virtual symbol suffix (defaults to ' ')
	virtual_symbol_suffix = " ",

	---Set virtual symbol position()
	---@usage 'inline'|'eol'|'eow'
	---inline mimics VS Code style
	---eol stands for `end of column` - Recommended to set `virtual_symbol_suffix = ''` when used.
	---eow stands for `end of word` - Recommended to set `virtual_symbol_prefix = ' ' and virtual_symbol_suffix = ''` when used.
	virtual_symbol_position = "inline",

	---Highlight hex colors, e.g. '#FFFFFF'
	enable_hex = true,

	---Highlight short hex colors e.g. '#fff'
	enable_short_hex = true,

	---Highlight rgb colors, e.g. 'rgb(0 0 0)'
	enable_rgb = true,

	---Highlight hsl colors, e.g. 'hsl(150deg 30% 40%)'
	enable_hsl = true,

	---Highlight ansi colors, e.g '\033[0;34m'
	enable_ansi = true,

	---Highlight xterm 256 (8bit) colors, e.g '\033[38;5;118m'
	enable_xterm256 = true,

	---Highlight xterm True Color (24bit) colors, e.g '\033[38;2;118;64;90m'
	enable_xtermTrueColor = true,

	-- Highlight hsl colors without function, e.g. '--foreground: 0 69% 69%;'
	enable_hsl_without_function = true,

	---Highlight CSS variables, e.g. 'var(--testing-color)'
	enable_var_usage = true,

	---Highlight named colors, e.g. 'green'
	enable_named_colors = true,

	---Highlight tailwind colors, e.g. 'bg-blue-500'
	enable_tailwind = false,

	---Set custom colors
	---Label must be properly escaped with '%' to adhere to `string.gmatch`
	--- :help string.gmatch
	custom_colors = {
		{ label = "%-%-theme%-primary%-color", color = "#0f1219" },
		{ label = "%-%-theme%-secondary%-color", color = "#5a5d64" },
	},

	-- Exclude filetypes or buftypes from highlighting e.g. 'exclude_buftypes = {'text'}'
	exclude_filetypes = {},
	exclude_buftypes = {},
	-- Exclude buffer from highlighting e.g. 'exclude_buffer = function(bufnr) return vim.fn.getfsize(vim.api.nvim_buf_get_name(bufnr)) > 1000000 end'
	exclude_buffer = function(bufnr) end,
}
setup_plugin("nvim-highlight-colors", nvim_highlight_colors_defaults)

-- https://github.com/svermeulen/text-to-colorscheme
-- Neovim colorschemes generated on the fly with a text prompt using ChatGPT
local text_to_colorscheme_defaults = {
	ai = {
		gpt_model = "gpt-4",
		openai_api_key = nil, -- Set your own OpenAI API key to this value
		green_darkening_amount = 0.85, -- Often, the generated theme results in green colors that seem to our human eyes to be more bright than it actually is, therefore this is a fudge factor to account for this, to darken greens to better match the brightness of other colors.  Enabled or disabled with auto_darken_greens flag
		auto_darken_greens = true,
		minimum_foreground_contrast = 0.4, -- This is used to touch up the generated theme to avoid generating foregrounds that match the background too closely.  Enabled or disabled with enable_minimum_foreground_contrast flag
		enable_minimum_foreground_contrast = true,
		temperature = 0, -- Set this to a value between 0 and 1, where 0 means it will generate similar looking color schemes every time, and 1 means that each time will be very different.  See openai docs for more information on this setting
	},
	disable_builtin_schemes = false, -- Set to true to disable all pre-generated color schemes, so that only your custom ones show in T2CSelect
	undercurl = true,
	underline = true,
	verbose_logs = false, -- When true, will output logs to echom, to help debugging issues with this plugin
	bold = true,
	italic = {
		strings = true,
		comments = true,
		operators = false,
		folds = true,
	},
	strikethrough = true,
	invert_selection = false,
	save_as_hsv = false, -- When true, T2CSave will save colors as HSV instead of hex
	invert_signs = false,
	invert_tabline = false,
	invert_intend_guides = false,
	inverse = true,
	dim_inactive = false,
	transparent_mode = false,
	hsv_palettes = {},
	hex_palettes = {},
	overrides = {},
	default_palette = "gruvbox",
}
setup_plugin("text-to-colorscheme", text_to_colorscheme_defaults)

-- https://github.com/nvzone/minty
-- Most Beautifully crafted color tools for Neovim
local minty_defaults = {
	huefy = {
		border = false,
		prompt = "   Enter color : ",

		-- func must return { row, col }
		position = "cursor", -- cursor | center | func(w, h)
	},
	shades = {
		border = true,
		prompt = "   Enter color : ",

		-- func must return { row, col }
		position = "cursor", -- cursor | center | func(w, h)
	},
}
setup_plugin("minty", minty_defaults)

-- https://github.com/ziontee113/color-picker.nvim
-- A powerful Neovim plugin that lets users choose & modify RGB/HSL/HEX colors.
local color_picker_defaults = { -- for changing icons & mappings
	-- ["icons"] = { "ﱢ", "" },
	-- ["icons"] = { "ﮊ", "" },
	-- ["icons"] = { "", "ﰕ" },
	-- ["icons"] = { "", "" },
	-- ["icons"] = { "", "" },
	["icons"] = { "ﱢ", "" },
	["border"] = "rounded", -- none | single | double | rounded | solid | shadow
	["keymap"] = { -- mapping example:
		["U"] = "<Plug>ColorPickerSlider5Decrease",
		["O"] = "<Plug>ColorPickerSlider5Increase",
	},
	["background_highlight_group"] = "Normal", -- default
	["border_highlight_group"] = "FloatBorder", -- default
	["text_highlight_group"] = "Normal", --default
}
setup_plugin("color-picker", function(color_picker)
	color_picker.setup(color_picker_defaults)

	local opts = { noremap = true, silent = true }

	map_explicit({
		mode = "n",
		sequence = "<C-c>",
		"<cmd>PickColor<cr>",
		action = opts,
	})
	map_explicit({
		mode = "i",
		sequence = "<C-c>",
		"<cmd>PickColorInsert<cr>",
		action = opts,
	})

	-- TODO
	-- map_explicit({
	-- 	mode = "n",
	-- 	sequence = "your_keymap",
	-- 	"<cmd>ConvertHEXandRGB<cr>",
	-- 	action = opts,
	-- })
	-- map_explicit({
	-- 	mode = "n",
	-- 	sequence = "your_keymap",
	-- 	"<cmd>ConvertHEXandHSL<cr>",
	-- 	action = opts,
	-- })

	vim.cmd([[hi FloatBorder guibg=NONE]]) -- if you don't want weird border background colors around the popup.
end)

-- TODO: set up with conjure
-- https://github.com/m00qek/baleia.nvim
-- Colorize text with ANSI escape sequences (8, 16, 256 or TrueColor)
local baleia_defaults = {
	strip_ansi_codes = true,
	line_starts_at = 1,
	namespace = "BaleiaColors",
	colors = {
		[00] = "Black",
		[01] = "DarkRed",
		[02] = "DarkGreen",
		[03] = "DarkYellow",
		[04] = "DarkBlue",
		[05] = "DarkMagenta",
		[06] = "DarkCyan",
		[07] = "LightGrey",
		[08] = "DarkGrey",
		[09] = "LightRed",
		[10] = "LightGreen",
		[11] = "LightYellow",
		[12] = "LightBlue",
		[13] = "LightMagenta",
		[14] = "LightCyan",
		[15] = "White",
	},
	async = true,
	chunk_size = 500,
	highlight_cache = {},
	name = "BaleiaColors",
}
setup_plugin("baleia", baleia_defaults)

-- https://github.com/neph-iap/easycolor.nvim
-- The easiest Neovim color picker in the world.
local easycolor_defaults = {
	ui = {
		border = "rounded", -- Border style of the window
		symbols = {
			selection = "󰆢", -- The symbol to draw over the selected color
			hue_arrow = "◀", -- The arrow to draw next to the selected hue
		},
		mappings = {
			q = "close_window", -- The action when q is pressed, close window by default.
			j = "move_cursor_down", -- The action when j is pressed, move cursor down by default.
			k = "move_cursor_up", -- The action when k is pressed, move cursor up by default.
			h = "move_cursor_left", -- The action when h is pressed, move cursor left by default.
			l = "move_cursor_right", -- The action when l is pressed, move cursor right by default.
			["<Down>"] = "hue_down", -- The action when <Down> is pressed, hue down by default.
			["<Up>"] = "hue_up", -- The action when <Up> is pressed, hue up by default.
			["<Enter>"] = "insert_color", -- The action when <Enter> is pressed, insert color by default.
			t = "edit_formatting_template", -- The action when t is pressed, edit formatting template by default.
		},
	},
	formatting = {
		default_format = "$X",
	},
}
setup_plugin("easycolor", easycolor_defaults)

-- https://github.com/jpe90/export-colorscheme.nvim
-- Generate CLI program colorschemes based on your vim colorscheme
setup_plugin("export-colorscheme", function(_) end)

if false then
	setup_plugin("bamboo", {})
	setup_plugin("kreative", function(_) end) -- https://github.com/katawful/kreative  A colorscheme creation tool for Neovim, written in Fennel with Aniseed
end

-- https://github.com/nvim-mini/mini.hipatterns
-- Highlight patterns in text. Part of 'mini.nvim' library.
local mini_hipatterns_defaults = {
	-- Table with highlighters (see |MiniHipatterns.config| for more details).
	-- Nothing is defined by default. Add manually for visible effect.
	highlighters = {},

	-- Delays (in ms) defining asynchronous highlighting process
	delay = {
		-- How much to wait for update after every text change
		text_change = 200,

		-- How much to wait for update after window scroll
		scroll = 50,
	},
}
local mini_hipatterns_example = {
	highlighters = {
		-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
		fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
		hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
		todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
		note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

		-- Highlight hex color strings (`#rrggbb`) using that color
		hex_color = hipatterns.gen_highlighter.hex_color(),
	},
}
setup_plugin("mini.hipatterns", mini_hipatterns_defaults)

-- https://github.com/folke/paint.nvim
-- Easily add additional highlights to your buffers
local paint_config = {
	---@type PaintHighlight[]
	highlights = {
		{
			-- filter can be a table of buffer options that should match,
			-- or a function called with buf as param that should return true.
			-- The example below will paint @something in comments with Constant
			filter = { filetype = "lua" },
			pattern = "%s*%-%-%-%s*(@%w+)",
			hl = "Constant",
		},
	},
}
setup_plugin("paint", paint_config)

--─────────────────────────────────────────────────────────────────────────────
--──── recording/display ──────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- https://github.com/ellisonleao/carbon-now.nvim
-- Create beautiful code snippets directly from your neovim terminal
local carbon_now_nvim_defaults = {
	base_url = "https://carbon.now.sh/",
	options = {
		bg = "gray",
		drop_shadow_blur = "68px",
		drop_shadow = false,
		drop_shadow_offset_y = "20px",
		font_family = "Hack",
		font_size = "18px",
		line_height = "133%",
		line_numbers = true,
		theme = "monokai",
		titlebar = "Made with carbon-now.nvim",
		watermark = false,
		width = "680",
		window_theme = "sharp",
		padding_horizontal = "0px",
		padding_vertical = "0px",
	},
}
setup_plugin("carbon-now-nvim", function(cn)
	cn.setup(carbon_now_nvim_defaults)
	map_explicit({
		mode = "v",
		sequence = "<leader>cn",
		action = ":CarbonNow<CR>",
		opts = { silent = true },
	})
end)

-- https://github.com/nvzone/showkeys
-- Minimal Eye-candy keys screencaster for Neovim 200 ~ LOC
local showkeys_defaults = {
	-- :h nvim_open_win params
	winopts = {
		-- focusable = false,
		relative = "editor",
		style = "minimal",
		border = "single",
		height = 1,
		row = 1,
		col = 0,
		zindex = 100,
	},

	winhl = "FloatBorder:Comment,Normal:Normal",

	timeout = 3, -- in secs
	maxkeys = 3,
	show_count = false,
	excluded_modes = {}, -- example: {"i"}

	-- bottom-left, bottom-right, bottom-center, top-left, top-right, top-center
	position = "bottom-right",

	keyformat = {
		["<BS>"] = "󰁮 ",
		["<CR>"] = "󰘌",
		["<Space>"] = "󱁐",
		["<Up>"] = "󰁝",
		["<Down>"] = "󰁅",
		["<Left>"] = "󰁍",
		["<Right>"] = "󰁔",
		["<PageUp>"] = "Page 󰁝",
		["<PageDown>"] = "Page 󰁅",
		["<M>"] = "Alt",
		["<C>"] = "Ctrl",
	},
}
setup_plugin("showkeys", showkeys_defaults)

--─────────────────────────────────────────────────────────────────────────────
--──── regex ──────────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- https://github.com/tomiis4/hypersonic.nvim
-- A Neovim plugin that provides an explanation for regular expressions.", {})
local hypersonic_defaults = {
	---@type 'none'|'single'|'double'|'rounded'|'solid'|'shadow'|table
	border = "rounded",
	---@type number 0-100
	winblend = 0,
	---@type boolean
	add_padding = true,
	---@type string
	hl_group = "Keyword",
	---@type string
	wrapping = '"',
	---@type boolean
	enable_cmdline = true,
}
setup_plugin("hypersonic", hypersonic_defaults)

-- https://github.com/bennypowers/nvim-regexplainer
-- Describe the regexp under the cursor
local regexplainer_defaults = {
	-- 'narrative', 'graphical'
	mode = "narrative",

	-- automatically show the explainer when the cursor enters a regexp
	auto = false,

	-- filetypes in which to activate regexplainer
	filetypes = {
		"html",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"ruby",
		"python",
		"go",
		"rust",
		"php",
		"java",
		"cs",
	},

	-- Whether to log debug messages
	debug = false,

	-- 'split', 'popup'
	display = "popup",

	mappings = {
		toggle = "gR",
		-- examples, not defaults:
		-- show = 'gS',
		-- hide = 'gH',
		-- show_split = 'gP',
		-- show_popup = 'gU',
	},

	narrative = {
		indendation_string = "> ", -- default '  '
	},

	graphical = {
		width = 800, -- image width in pixels
		height = 600, -- image height in pixels
		python_cmd = nil, -- python command (auto-detected)
	},

	deps = {
		auto_install = true, -- automatically install Python dependencies
		python_cmd = nil, -- python command (auto-detected)
		venv_path = nil, -- virtual environment path (auto-generated)
		check_interval = 3600, -- dependency check interval in seconds
	},
}
setup_plugin("regexplainer", regexplainer_defaults)

--─────────────────────────────────────────────────────────────────────────────
--──── docs ───────────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- https://github.com/mrjones2014/tldr.nvim
-- A Telescope previewer for tldr-pages
local tldr_defaults = {
	-- the shell command to use
	tldr_command = "tldr",
	-- a string of extra arguments to pass to `tldr`, e.g. tldr_args = '--color always'
	tldr_args = "",
}
setup_plugin("tldr", tldr_defaults)

-- https://github.com/emiasims/nvim-luaref
-- Add a vim :help reference for lua
local nvim_luaref_defaults = nil
setup_plugin("nvim-luaref", nvim_luaref_defaults)
-- :help lua_reference_toc
-- :help math.pi
-- :help coroutine.yield

-- https://github.com/jghauser/auto-pandoc.nvim
-- Use pandoc to convert markdown files according to options from a yaml block
utils.packadd("auto-pandoc", function(auto_pandoc)
	vim.api.nvim_create_autocmd("BufEnter", {
		pattern = "*.md",
		callback = function()
			keymap.set("n", "go", function()
				auto_pandoc.run_pandoc()
			end, { silent = true, buffer = 0 })
		end,
		group = vim.api.nvim_create_augroup("setAutoPandocKeymap", {}),
		desc = "Set keymap for auto-pandoc",
	})
end)

--─────────────────────────────────────────────────────────────────────────────
--──── fonts, characters, non-english, etc. ───────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- https://github.com/2KAbhishek/nerdy.nvim
-- Find Nerd Glyphs Easily
local nerdy_defaults = {
	max_recents = 30, -- Configure recent icons limit
	copy_to_clipboard = false, -- Copy glyph to clipboard instead of inserting
	copy_register = "+", -- Register to use for copying (if `copy_to_clipboard` is true)
}
setup_plugin("nerdy", function(nerdy)
	nerdy.setup(nerdy_defaults)
	map_explicit({
		mode = "n",
		sequence = "<leader>in",
		action = "<cmd>Nerdy list<CR>",
		desc = "Browse nerd icons",
	})
	map_explicit({
		mode = "n",
		sequence = "<leader>iN",
		action = "<cmd>Nerdy recents<CR>",
		desc = "Browse recent nerd icons",
	})
end)

-- https://github.com/nativerv/cyrillic.nvim
-- Adds some support for Cyrillic keyboard layouts in Neovim
local cyrillic_defaults = {
	no_cyrillic_abbrev = false, -- default
}
setup_plugin("cyrillic", cyrillic_defaults)

-- https://github.com/ivanesmantovich/xkbswitch.nvim
-- Smart automatic keyboard layout switching in 110 LOC
local xkbswitch_defaults = { events_get_focus = false }
setup_plugin("xkbswitch", xkbswitch_defaults)
--─────────────────────────────────────────────────────────────────────────────
--──── web utils ──────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- TODO: use vim.g.http_codes
-- https://forge.barrettruth.com/barrettruth/http-codes.nvim
-- Quickly investigate HTTP status codes with Mozilla, with telescope, fzf-lua, and snacks.nvim integrations.
setup_plugin("http-codes", function(http_codes) end)

-- TODO: use vim.g.live_server
-- https://forge.barrettruth.com/barrettruth/live-server.nvim
-- Live reload HTML, CSS, and JavaScript files inside Neovim. No external dependencies — the server runs entirely in Lua using Neovim's built-in libuv bindings.
setup_plugin("live-server", function(live_server) end)

-- TODO: add guigua as dependency
-- TODO: treesitter for json5
-- TODO: https://github.com/BrowserSync/browser-sync, https://hurl.dev/docs/installation.html, prettier, jq
-- https://github.com/ray-x/web-tools.nvim
-- Neovim plugin for web developers. Browser-sync | http/css lsp | hurl/curl | npm/yarn/npx
local web_tools_defaults = {
	keymaps = {
		rename = nil, -- by default use same setup of lspconfig
		repeat_rename = ".", -- . to repeat
	},
	hurl = { -- hurl default
		show_headers = false, -- do not show http headers
		floating = false, -- use floating windows (need guihua.lua)
		json5 = false, -- use json5 parser require json5 treesitter
		formatters = { -- format the result by filetype
			json = { "jq" },
			html = { "prettier", "--parser", "html" },
		},
	},
}
setup_plugin("web-tools", web_tools_defaults)

-- TODO: add lua deps and install cli deps
-- https://github.com/tlj/api-browser.nvim
-- Neovim plugin to open API endpoints directly in the editor
local api_browser_defaults = {
	keep_state = true, -- store state in sqlite db
	ripgrep = {
		-- if ripgrep is installed, use this command to find OpenAPI files
		command = "rg -l -g '*.yaml' -g '*.json' -e \"openapi.*3\"",
		no_ignore = false, -- set --no-ignore for ripgrep to search everything, use this in case you have your openapis in .gitignore
		-- if ripgrep is not installed, use globs to find matching files
		fallback_globs = { "**/*.yaml", "**/*.json" },
	},
}
setup_plugin("api-browser", api_browser_defaults)

--─────────────────────────────────────────────────────────────────────────────
--──── tracking/performance/training ──────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- https://github.com/mgerb/metrics.nvim
-- tracks time spent in your editor, logs locally to sqlite3 database
local metrics_defaults = { db_filename = "metrics.db" }
setup_plugin("metrics", metrics_defaults)

-- https://github.com/BooleanCube/keylab.nvim
-- Practice your nvim setup for a boost in productivity.
local keylab_defaults = {
	lines = 10,
	force_accuracy = true, -- true by default
	correct_fg = "#B8BB26",
	wrong_bg = "#FB4934",
}
setup_plugin("keylab", keylab_defaults)

-- https://github.com/pseudocc/nvim-apm
-- calculate your APM, also show your key strokes in a buffer.
local nvim_apm_defaults = nil
setup_plugin("nvim-apm", nvim_apm_defaults)

--─────────────────────────────────────────────────────────────────────────────
--──── other ──────────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- Neovim plugin for aligning bilingual parallel texts
-- https://github.com/tanloong/interlaced.nvim
-- Neovim plugin for aligning bilingual parallel texts
vim.g.interlaced = {
	keymaps = {
		{ "n", ",", "push_up" },
		{ "n", "<", "push_up_pair" },
		{ "n", "e", "push_up_left_part" },
		{ "n", ".", "pull_below" },
		{ "n", ">", "pull_below_pair" },
		{ "n", "d", "push_down_right_part" },
		{ "n", "D", "push_down" },
		{ "n", "s", "leave_alone" },
		{ "n", "[e", "swap_with_above" },
		{ "n", "]e", "swap_with_below" },
		{ "n", "U", "undo" },
		{ "n", "R", "redo" },
		{ "n", "J", "navigate_down" },
		{ "n", "K", "navigate_up" },
		{ "n", "md", "dump" },
		{ "n", "ml", "load" },
		{ "n", "gn", "next_unaligned" },
		{ "n", "gN", "prev_unaligned" },
		{ "n", "mt", "match_toggle" },
		{ "n", "m;", "list_matches" },
		{ "n", "ma", "match_add" },
		{ "v", "ma", "match_add_visual" },
	},
	setup_mappings_now = false,
	separators = { ["1"] = "", ["2"] = " " },
	lang_num = 2,
	enable_keybindings_hook = function()
		-- disable coc to avoid lag on :w
		if vim.g.did_coc_loaded ~= nil then
			vim.cmd([[CocDisable]])
		end
		-- disable the undo history saving, which is time-consuming and causes lag
		vim.opt_local.undofile = false
		-- pcall(vim.cmd.nunmap, "j")
		-- pcall(vim.cmd.nunmap, "k")
		-- pcall(vim.cmd.nunmap, "gj")
		-- pcall(vim.cmd.nunmap, "gk")
		-- vim.opt_local.undolevels = -1
		vim.opt_local.signcolumn = "no"
		vim.opt_local.relativenumber = false
		vim.opt_local.number = false
		require("interlaced").action.load()
		require("interlaced").ShowChunkNr()
	end,
	sound_feedback = false,
}
setup_plugin("interlaced", function(interlaced) end)

-- https://github.com/martineausimon/nvim-mail-merge
-- primarily designed to work with NeoMutt by default but also offers support for mailx. This plugin can send emails in either HTML format (neomutt only) or plain text
local nvmm_defaults = {
	mappings = {
		attachment = "<leader>a",
		config = "<leader>c",
		preview = "<leader>p",
		send_text = "<leader>st",
		send_html = "<leader>sh",
	},
	options = {
		mail_client = {
			text = "neomutt", -- or "mailx"
			html = "neomutt",
		},
		auto_break_md = true, -- line breaks without two spaces for markdown
		neomutt_config = "$HOME/.neomuttrc",
		mailx_account = nil, -- if you use different accounts in .mailrc
		save_log = true,
		log_file = "./nvmm.log",
		date_format = "%Y-%m-%d",
		pandoc_metadatas = { -- syntax with [['metadata']] is important
			[['title= ']],
			[['margin-top=0']],
			[['margin-left=0']],
			[['margin-right=0']],
			[['margin-bottom=0']],
			[['mainfont: sans-serif']],
		},
	},
}
setup_plugin("nvmm", nvmm_defaults)

-- https://github.com/glacambre/firenvim
-- Embed Neovim in Chrome, Firefox & others.
setup_plugin("firenvim", function(_) end)

-- https://github.com/Apeiros-46B/qalc.nvim
-- Neovim-integrated calculator based on Qalculate
local qalc_defaults = {
	-- extra command arguments for Qalculate
	-- do NOT use the option `-t`/`--terse`; it will break the plugin
	-- example: { '--set', 'angle deg' } to use degrees as the default angle unit
	cmd_args = {}, -- table

	-- default name of a newly opened buffer
	-- set to '' to open an unnamed buffer
	bufname = "", -- string

	-- the plugin will set all attached buffers to have this filetype
	-- set to '' to disable setting the filetype
	-- the default is provided for basic syntax highlighting
	set_ft = "config", -- string

	-- file extension to automatically attach qalc to
	-- set to '' to disable automatic attaching
	attach_extension = "*.qalc", -- string

	-- default register to yank results to
	-- default register = '@'
	-- clipboard        = '+'
	-- X11 selection    = '*'
	-- other registers not listed are also supported
	-- see `:h setreg()`
	yank_default_register = "@", -- string

	-- sign shown before result
	sign = "=", -- string

	-- whether or not to show a sign before the result
	show_sign = true, -- boolean

	-- whether or not to right align virtual text
	right_align = false, -- boolean

	-- highlight groups
	highlights = {
		sign = "@conceal", -- sign before result
		result = "@string", -- result in virtual text
	},

	-- diagnostic options
	-- set to nil to respect the options in your neovim configuration
	-- (see `:h vim.diagnostic.config()`)
	diagnostics = { -- table?
		underline = true,
		virtual_text = false,
		signs = true,
		update_in_insert = true,
		severity_sort = true,
	},

	-- use pty for job communication (MS Windows w/o WSL do not support pty)
	use_pty = not ((vim.fn.has("win32") == 1) and (vim.fn.has("wsl") == 0)),

	-- End-Of-File character (MS Windows uses ^Z (EOF), others use ^D (EOT))
	eof = string.char(((vim.fn.has("win32") == 1) and (vim.fn.has("wsl") == 0)) and 26 or 4),
}
setup_plugin("qalc", qalc_defaults)

-- https://github.com/alex-laycalvert/flashcards.nvim
-- A Neovim plugin for Flashcards written in Lua
local flashcards_defaults = {
	dir = home .. "/.config/flashcards",
	flashcards = {
		show_terms = true,
		mappings = {
			l = "next()",
			h = "prev()",
			n = "next()",
			b = "prev()",
			f = "flip()",
			q = "close()",
			a = "add()",
			e = "edit()",
			d = "delete()",
			g = "browse_cards()",
			o = "browse_subjects()",
			k = "know()",
			["<CR>"] = "flip()",
			[" "] = "flip()",
		},
	},
	subjects = {
		mappings = {
			j = "next()",
			k = "prev()",
			q = "close()",
			e = "edit()",
			a = "add()",
			d = "delete()",
			r = "reset()",
			["<CR>"] = "select()",
		},
	},
}
setup_plugin("flashcards", flashcards_defaults)

-- https://github.com/cfrt-dev/license.nvim
-- Simple plugin that generates a LICENSE file
local nvim_license_defaults = nil
setup_plugin("nvim-license", function(nvim_license) end)
-- TODO: If you have telescope, you can use '<leader>gl' to open the license list
--     and select the license you want to add to your project.

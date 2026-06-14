--─────────────────────────────────────────────────────────────────────────────
--──── to vendor ──────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- https://github.com/LunarVim/Launch.nvim
-- Launch.nvim is modular starter for Neovim.
local Launch_defaults = {} -- TODO
setup_plugin("Launch", Launch_defaults)

-- https://github.com/bagohart/minimal-narrow-region.nvim
-- Opinionated minimal implementation of Emacs' narrowing feature (https://www.gnu.org/software/emacs/manual/html_node/emacs/Narrowing.html)
local minimal_narrow_region_defaults = {} -- TODO
setup_plugin("minimal-narrow-region", function(mnr)
	-- No mappings by default, create them explicitly:
	vim.keymap.set("x", "<Leader><Leader>nr", mnr.NarrowRegionOpen)
	vim.keymap.set("n", "<Leader><Leader>NR", mnr.NarrowRegionClose)
end)

-- TODO: adapt for just/taskfile/etc.
-- https://github.com/ChSotiriou/nvim-telemake
-- nvim extension with nvim-telescope to select and run any Makefile target
local telemake_defaults = {} -- TODO
setup_plugin("telemake", telemake_defaults)

-- https://github.com/anuvyklack/nvim-api-wrappers
-- library with OOP wrappers around Neovim api.
--     This library itself depend on middleclass library.
local nvim_api_wrappers_defaults = nil
setup_plugin("nvim-api-wrappers", nvim_api_wrappers_defaults)

-- https://github.com/alonso-montero/k8vim.nvim
-- Kubernetes interface for nvim
local k8vim_defaults = nil
setup_plugin("k8vim", k8vim_defaults)

-- TODO: compare https://github.com/lukas-reineke/virt-column.nvim (may be better)
-- https://github.com/xiyaowong/virtcolumn.nvim
-- Display a line as the colorcolumn
local virtcolumn_defaults = {} -- TODO
setup_plugin("virtcolumn", function(virtcolumn)
	vim.g.virtcolumn_char = "▕" -- char to display the line
	vim.g.virtcolumn_priority = 10 -- priority of extmark
end)

-- https://github.com/lukas-reineke/virt-column.nvim
-- Display a character as the colorcolumn
local virt_column_defaults = {} -- TODO: https://github.com/lukas-reineke/virt-column.nvim/blob/master/lua/virt-column/config.lua
setup_plugin("virt-column", function(virt_column)
	virt_column.setup(virt_column_defaults)
end)

-- https://github.com/willothy/wezterm.nvim
-- Utilities for interacting with Wezterm from within Neovim
local wezterm_nvim_defaults = {} -- TODO
setup_plugin("wezterm-nvim", wezterm_nvim_defaults)

-- https://github.com/Mohammed-Taher/AdvancedNewFile.nvim
-- A simple plugin for neovim to create files and folders quickly.
local AdvancedNewFile_defaults = {} -- TODO
setup_plugin("AdvancedNewFile", AdvancedNewFile_defaults)

-- https://github.com/rewhile/fsread.nvim
-- Flow state reading in neovim
local fsread_defaults = {} -- TODO
setup_plugin("fsread", fsread_defaults)

-- TODO: move to modules?
-- https://github.com/notomo/tracebundler.nvim
-- Trace and bundle neovim lua for debugging
local tracebundler_defaults = {} -- TODO
setup_plugin("tracebundler", tracebundler_defaults)

-- https://github.com/chaitanyabsprip/present.nvim
-- Presentation plugin for neovim written in lua
local present_defaults = {} -- TODO
setup_plugin("present", present_defaults)
-- https://github.com/letieu/wezterm-move.nvim
-- https://github.com/mawkler/move-mode.nvim

--─────────────────────────────────────────────────────────────────────────────
--──── live preview ───────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- https://github.com/frabjous/knap
-- Neovim plugin for creating live-updating-as-you-type previews of LaTeX, markdown, and other files in the viewer of your choice.
local knap_defaults = {} -- TODO
setup_plugin("knap", knap_defaults)

--─────────────────────────────────────────────────────────────────────────────
--──── nvim-/lua-related ──────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- https://github.com/notomo/runtimetable.nvim
-- Create runtime files from lua table.
setup_plugin("runtimetable", function(_) end)

-- https://github.com/tastyep/structlog.nvim
-- Structured Logging for nvim, using Lua
local structlog_defaults = {} -- TODO
setup_plugin("structlog", structlog_defaults)

-- PROBABLY NOT, BUT WORTH A TRY
-- https://github.com/svermeulen/nvim-teal-maker
-- Neovim plugin that adds plugin support for teal language
local nvim_teal_maker_defaults = {} -- TODO
setup_plugin("nvim-teal-maker", nvim_teal_maker_defaults)

-- https://github.com/CWood-sdf/cmdTree.nvim
--  Declaratively make your neovim user commands
local cmdTree_defaults = {} -- TODO
setup_plugin("cmdTree", cmdTree_defaults)

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
local timerly_defaults = {} -- TODO
setup_plugin("timerly", timerly_defaults)

-- https://github.com/eliasCVII/timew.nvim
-- Run some timewarrior commands from neovim
local timew_defaults = {} -- TODO
setup_plugin("timew", timew_defaults)

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
-- A text-based schedule plugin for neovim
local sche_defaults = {} -- TODO
setup_plugin("sche", sche_defaults)

-- https://github.com/hugginsio/twig.nvim
-- taskwarrior integration
local twig_defaults = {} -- TODO
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
-- local function setup_dashboard()
-- 	utils.packadd("dashboard-nvim")
-- 	local dashboard = require("dashboard")
-- 	dashboard.setup()
-- end

-- https://github.com/MeanderingProgrammer/dashboard.nvim
--[[
Fully customizable header with reference for integrating with ascii art plugin
Provide directories and this plugin will:
  - Display them on the dashboard
  - Make them accessible with single letter hotkey
Input is ordered and hotkeys are generated sequentially, making for a consistent experience
--]]
local dashboard_defaults = {} -- TODO
setup_plugin("dashboard", dashboard_defaults)

-- https://github.com/jovanlanik/fsplash.nvim
-- Show a custom splash screen in a floating window
local fsplash_defaults = {} -- TODO
setup_plugin("fsplash", fsplash_defaults)

-- https://github.com/folke/drop.nvim
--  Fun little plugin that can be used as a screensaver and on your dashboard
local drop_defaults = {} -- TODO
setup_plugin("drop", drop_defaults)

--─────────────────────────────────────────────────────────────────────────────
--──── pkm ────────────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- https://github.com/Hashino/doing.nvim
-- A minimal task manager for neovim
local doing_defaults = {} -- TODO
setup_plugin("doing", doing_defaults)

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
local zettelkasten_defaults = {} -- TODO
setup_plugin("zettelkasten", zettelkasten_defaults)

-- https://github.com/JellyApple102/flote.nvim
-- Easily accessible, per-project markdown notes in Neovim.
local flote_defaults = {} -- TODO
setup_plugin("flote", flote_defaults)

-- https://github.com/2kabhishek/tdo.nvim
-- Fast & Simple Notes in Neovim
local tdo_defaults = {} -- TODO
setup_plugin("tdo", tdo_defaults)
-- TODO: vendor/PR to fix old LspStart command -> new Lua LSP API
setup_plugin("scratch-buffer", function(scratch_buffer)
	scratch_buffer.setup({ with_lsp = false })
end)

-- https://github.com/nyngwang/NeoWell.lua
-- Well... I will fix this line later
local neowell_lua_defaults = {} -- TODO
setup_plugin("neowell-lua", neowell_lua_defaults)

-- https://github.com/RutaTang/quicknote.nvim
-- Quickly take notes, in-place
local quicknote_defaults = {} -- TODO
setup_plugin("quicknote", quicknote_defaults)

--─────────────────────────────────────────────────────────────────────────────
--──── diagrams ───────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- TODO

--─────────────────────────────────────────────────────────────────────────────
--──── colors ─────────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- https://github.com/brenoprata10/nvim-highlight-colors
-- Highlight colors for neovim
local nvim_highlight_colors_defaults = {} -- TODO
setup_plugin("nvim-highlight-colors", nvim_highlight_colors_defaults)

-- https://github.com/svermeulen/text-to-colorscheme
-- Neovim colorschemes generated on the fly with a text prompt using ChatGPT
local text_to_colorscheme_defaults = {} -- TODO
setup_plugin("text-to-colorscheme", text_to_colorscheme_defaults)

-- https://github.com/nvzone/minty
-- Most Beautifully crafted color tools for Neovim
local minty_defaults = {} -- TODO
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

	vim.keymap.set("n", "<C-c>", "<cmd>PickColor<cr>", opts)
	vim.keymap.set("i", "<C-c>", "<cmd>PickColorInsert<cr>", opts)

	-- vim.keymap.set("n", "your_keymap", "<cmd>ConvertHEXandRGB<cr>", opts)
	-- vim.keymap.set("n", "your_keymap", "<cmd>ConvertHEXandHSL<cr>", opts)

	vim.cmd([[hi FloatBorder guibg=NONE]]) -- if you don't want weird border background colors around the popup.
end)

-- Colorize text with ANSI escape sequences (8, 16, 256 or TrueColor)
-- https://github.com/m00qek/baleia.nvim
-- Colorize text with ANSI escape sequences (8, 16, 256 or TrueColor)
local baleia_defaults = {} -- TODO
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
	vim.keymap.set("v", "<leader>cn", ":CarbonNow<CR>", { silent = true })
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
local hypersonic_defaults = {} -- TODO
setup_plugin("hypersonic", hypersonic_defaults)

-- https://github.com/bennypowers/nvim-regexplainer
-- Describe the regexp under the cursor
local regexplainer_defaults = {} -- TODO
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
local nvim_luaref_defaults = {} -- TODO
setup_plugin("nvim-luaref", nvim_luaref_defaults)

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
	vim.keymap.set("n", "<leader>in", "<cmd>Nerdy list<CR>", { desc = "Browse nerd icons" })
	vim.keymap.set("n", "<leader>iN", "<cmd>Nerdy recents<CR>", { desc = "Browse recent nerd icons" })
end)

-- https://github.com/nativerv/cyrillic.nvim
-- Adds some support for Cyrillic keyboard layouts in Neovim
local cyrillic_defaults = {
	no_cyrillic_abbrev = false, -- default
}
setup_plugin("cyrillic", cyrillic_defaults)

-- https://github.com/ivanesmantovich/xkbswitch.nvim
-- Smart automatic keyboard layout switching in 110 LOC
local xkbswitch_defaults = {} -- TODO
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
local nvim_apm_defaults = {} -- TODO
setup_plugin("nvim-apm", nvim_apm_defaults)

--─────────────────────────────────────────────────────────────────────────────
--──── other ──────────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- https://github.com/midoBB/nvim-quicktype
-- Generate types from JSON all inside Neovim
local nvim_quicktype_defaults = {} -- TODO
setup_plugin("nvim-quicktype", nvim_quicktype_defaults)

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
local qalc_defaults = {} -- TODO
setup_plugin("qalc", qalc_defaults)

-- https://github.com/alex-laycalvert/flashcards.nvim
-- A Neovim plugin for Flashcards written in Lua
local flashcards_defaults = {} -- TODO
setup_plugin("flashcards", flashcards_defaults)

-- https://github.com/cfrt-dev/license.nvim
-- Simple plugin that generates a LICENSE file
local nvim_license_defaults = {} -- TODO
setup_plugin("nvim-license", nvim_license_defaults)

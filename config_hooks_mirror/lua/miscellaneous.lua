--─────────────────────────────────────────────────────────────────────────────
--──── to vendor ──────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- https://github.com/LunarVim/Launch.nvim
-- Launch.nvim is modular starter for Neovim.
local Launch_defaults = {} -- TODO
setup_plugin("Launch", Launch_defaults)

-- LINK
-- DESC
local minimal_narrow_region_defaults = {} -- TODO
setup_plugin("minimal-narrow-region", minimal_narrow_region_defaults)

-- LINK
-- DESC
local telemake_defaults = {} -- TODO
setup_plugin("telemake", telemake_defaults)

-- LINK
-- DESC
local nvim_api_wrappers_defaults = {} -- TODO
setup_plugin("nvim-api-wrappers", nvim_api_wrappers_defaults)

-- LINK
-- DESC
local k8vim_defaults = {} -- TODO
setup_plugin("k8vim", k8vim_defaults)

-- LINK
-- DESC
local telemake_defaults = {} -- TODO
setup_plugin("telemake", telemake_defaults)

-- LINK
-- DESC
local virtcolumn_defaults = {} -- TODO
setup_plugin("virtcolumn", virtcolumn_defaults)

-- LINK
-- DESC
local wezterm_nvim_defaults = {} -- TODO
setup_plugin("wezterm-nvim", wezterm_nvim_defaults)

-- https://github.com/Mohammed-Taher/AdvancedNewFile.nvim
-- DESC
local AdvancedNewFile_defaults = {} -- TODO
setup_plugin("AdvancedNewFile", AdvancedNewFile_defaults)

-- (uses nvim-treesitter)
-- LINK
-- DESC
local spread_defaults = {} -- TODO
setup_plugin("spread", spread_defaults)

-- LINK
-- DESC
local fsread_defaults = {} -- TODO
setup_plugin("fsread", fsread_defaults)

-- LINK
-- DESC
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

setup_plugin("runtimetable", function(_) end)

-- LINK
-- DESC
local structlog_defaults = {} -- TODO
setup_plugin("structlog", structlog_defaults)

-- PROBABLY NOT, BUT WORTH A TRY
-- LINK
-- DESC
local nvim_teal_maker_defaults = {} -- TODO
setup_plugin("nvim-teal-maker", nvim_teal_maker_defaults)

-- https://github.com/CWood-sdf/cmdTree.nvim
--  Declaratively make your neovim user commands
local cmdTree_defaults = {} -- TODO
setup_plugin("cmdTree", cmdTree_defaults)

--─────────────────────────────────────────────────────────────────────────────
--──── timer, time tracking ───────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- LINK
-- DESC
local pommodoro_clock_defaults = {} -- TODO
setup_plugin("pommodoro-clock", pommodoro_clock_defaults)

-- LINK
-- DESC
local pomodoro_defaults = {} -- TODO
setup_plugin("pomodoro", pomodoro_defaults)

-- LINK
-- DESC
local timerly_defaults = {} -- TODO
setup_plugin("timerly", timerly_defaults)

-- LINK
-- DESC
local timew_defaults = {} -- TODO
setup_plugin("timew", timew_defaults)

-- LINK
-- DESC
local nomodoro_defaults = {} -- TODO
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

-- hacky, but works -> necessary due to name collision
-- local function setup_dashboard()
-- 	utils.packadd("dashboard-nvim")
-- 	local dashboard = require("dashboard")
-- 	dashboard.setup()
-- end

-- TODO: fix error
-- setup_plugin_explicit("dashboard-nvim", "dashboard", {})

-- LINK
-- DESC
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

-- LINK
-- DESC
local doing_defaults = {} -- TODO
setup_plugin("doing", doing_defaults)
utils.packadd("vimwiki")
setup_plugin("obsidian", { legacy_commands = false })

-- LINK
-- DESC
local orgmode_defaults = {} -- TODO
setup_plugin("orgmode", orgmode_defaults)

-- LINK
-- DESC
local Calendar_defaults = {} -- TODO
setup_plugin("Calendar", Calendar_defaults)

-- LINK
-- DESC
local zettelkasten_defaults = {} -- TODO
setup_plugin("zettelkasten", zettelkasten_defaults)

-- LINK
-- DESC
local flote_defaults = {} -- TODO
setup_plugin("flote", flote_defaults)

-- LINK
-- DESC
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

setup_plugin("better-digraphs", function(_) end)

-- LINK
-- DESC
local diagflow_defaults = {} -- TODO
setup_plugin("diagflow", diagflow_defaults)

--─────────────────────────────────────────────────────────────────────────────
--──── colors ─────────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- https://github.com/brenoprata10/nvim-highlight-colors
-- Highlight colors for neovim
local nvim_highlight_colors_defaults = {} -- TODO
setup_plugin("nvim-highlight-colors", nvim_highlight_colors_defaults)

-- LINK
-- DESC
local text_to_colorscheme_defaults = {} -- TODO
setup_plugin("text-to-colorscheme", text_to_colorscheme_defaults)

-- LINK
-- DESC
local minty_defaults = {} -- TODO
setup_plugin("minty", minty_defaults)

-- LINK
-- DESC
local color_picker_defaults = {} -- TODO
setup_plugin("color-picker", color_picker_defaults)

-- Colorize text with ANSI escape sequences (8, 16, 256 or TrueColor)
-- LINK
-- DESC
local baleia_defaults = {} -- TODO
setup_plugin("baleia", baleia_defaults)

-- LINK
-- DESC
local easycolor_defaults = {} -- TODO
setup_plugin("easycolor", easycolor_defaults)
setup_plugin("export-colorscheme", function(_) end)
if false then
	setup_plugin("bamboo", {})
	setup_plugin("kreative", function(_) end) -- https://github.com/katawful/kreative  A colorscheme creation tool for Neovim, written in Fennel with Aniseed
end

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
setup_plugin("mini.hipatterns", mini_hipatterns_defaults)

-- LINK
-- DESC
local paint_defaults = {} -- TODO
setup_plugin("paint", paint_defaults)

--─────────────────────────────────────────────────────────────────────────────
--──── recording/display ──────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- LINK
-- DESC
local carbon_now_nvim_defaults = {} -- TODO
setup_plugin("carbon-now-nvim", carbon_now_nvim_defaults)

-- https://github.com/nvzone/showkeys
-- DESC
local showkeys_defaults = {} -- TODO
setup_plugin("showkeys", showkeys_defaults)

--─────────────────────────────────────────────────────────────────────────────
--──── regex ──────────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- https://github.com/tomiis4/hypersonic.nvim
-- A Neovim plugin that provides an explanation for regular expressions.", {})
local hypersonic_defaults = {} -- TODO
setup_plugin("hypersonic", hypersonic_defaults)

-- LINK
-- DESC
local regex_vars_defaults = {} -- TODO
setup_plugin("regex-vars", regex_vars_defaults)

-- LINK
-- DESC
local regexplainer_defaults = {} -- TODO
setup_plugin("regexplainer", regexplainer_defaults)

--─────────────────────────────────────────────────────────────────────────────
--──── docs ───────────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- LINK
-- DESC
local tldr_defaults = {} -- TODO
setup_plugin("tldr", tldr_defaults)

-- https://github.com/emiasims/nvim-luaref
-- Add a vim :help reference for lua
local nvim_luaref_defaults = {} -- TODO
setup_plugin("nvim-luaref", nvim_luaref_defaults)

utils.packadd("auto-pandoc")

--─────────────────────────────────────────────────────────────────────────────
--──── fonts, characters, non-english, etc. ───────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- LINK
-- DESC
local nerdy_defaults = {} -- TODO
setup_plugin("nerdy", nerdy_defaults)

-- LINK
-- DESC
local cyrillic_defaults = {} -- TODO
setup_plugin("cyrillic", cyrillic_defaults)

-- LINK
-- DESC
local xkbswitch_defaults = {} -- TODO
setup_plugin("xkbswitch", xkbswitch_defaults)
--─────────────────────────────────────────────────────────────────────────────
--──── web utils ──────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────
setup_plugin("http-codes", function(http_codes) end) -- use vim.g.http_codes

setup_plugin("live-server", function(live_server) end) -- use vim.g.live_server

-- LINK
-- DESC
local web_tools_defaults = {} -- TODO
setup_plugin("web-tools", web_tools_defaults)

-- LINK
-- DESC
local api_browser_defaults = {} -- TODO
setup_plugin("api-browser", api_browser_defaults)

-- LINK
-- DESC
local spaceport_nvim_defaults = {} -- TODO
setup_plugin("spaceport-nvim", spaceport_nvim_defaults)

--─────────────────────────────────────────────────────────────────────────────
--──── tracking/performance ───────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- LINK
-- tracks time spent in your editor, logs locally to sqlite3 database
local metrics_defaults = {} -- TODO
setup_plugin("metrics", metrics_defaults)

-- https://github.com/BooleanCube/keylab.nvim
-- DESC
local keylab_defaults = {} -- TODO
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
-- LINK
-- DESC
local interlaced_defaults = {} -- TODO
setup_plugin("interlaced", interlaced_defaults)

-- LINK
-- nvim-mail-merge
local nvmm_defaults = {} -- TODO
setup_plugin("nvmm", nvmm_defaults)
setup_plugin("firenvim", function(_) end) -- https://github.com/glacambre/firenvim Embed Neovim in Chrome, Firefox & others.

-- https://github.com/Apeiros-46B/qalc.nvim
-- Neovim-integrated calculator based on Qalculate
local qalc_defaults = {} -- TODO
setup_plugin("qalc", qalc_defaults)

-- https://github.com/alex-laycalvert/flashcards.nvim
-- DESC
local flashcards_defaults = {} -- TODO
setup_plugin("flashcards", flashcards_defaults)

-- https://github.com/cfrt-dev/license.nvim
-- DESC
local nvim_license_defaults = {} -- TODO
setup_plugin("nvim-license", nvim_license_defaults)

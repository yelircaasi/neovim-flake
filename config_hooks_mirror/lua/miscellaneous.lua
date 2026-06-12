--─────────────────────────────────────────────────────────────────────────────
--──── to vendor ──────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────
setup_plugin("Launch", {}) -- https://github.com/LunarVim/Launch.nvim Launch.nvim is modular starter for Neovim.
setup_plugin("minimal-narrow-region", {})
setup_plugin("telemake", {})
setup_plugin("nvim-api-wrappers", {})
setup_plugin("k8vim", {})
setup_plugin("telemake", {})
setup_plugin("virtcolumn", {})
setup_plugin("wezterm-nvim", {})
setup_plugin("AdvancedNewFile", {}) -- https://github.com/Mohammed-Taher/AdvancedNewFile.nvim
setup_plugin("spread", {}) -- (uses nvim-treesitter)
setup_plugin("fsread", {})
setup_plugin("tracebundler", {})
setup_plugin("present", {}) -- https://github.com/chaitanyabsprip/present.nvim Presentation plugin for neovim written in lua
-- https://github.com/letieu/wezterm-move.nvim
-- https://github.com/mawkler/move-mode.nvim

--─────────────────────────────────────────────────────────────────────────────
--──── live preview ───────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

setup_plugin("knap", {}) -- https://github.com/frabjous/knap Neovim plugin for creating live-updating-as-you-type previews of LaTeX, markdown, and other files in the viewer of your choice.

--─────────────────────────────────────────────────────────────────────────────
--──── nvim-/lua-related ──────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

setup_plugin("runtimetable", function(_) end)
setup_plugin("structlog", {})
setup_plugin("nvim-teal-maker", {}) -- PROBABLY NOT, BUT WORTH A TRY
setup_plugin("cmdTree", {}) -- https://github.com/CWood-sdf/cmdTree.nvim  Declaratively make your neovim user commands

--─────────────────────────────────────────────────────────────────────────────
--──── timer, time tracking ───────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

setup_plugin("pommodoro-clock", {})
setup_plugin("pomodoro", {})
setup_plugin("timerly", {})
setup_plugin("timew", {})
setup_plugin("nomodoro", {})
setup_plugin("sche", {}) -- https://github.com/Cassin01/sche.nvim A text-based schedule plugin for neovim
setup_plugin("twig", {}) -- https://github.com/hugginsio/twig.nvim taskwarrior integration

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

setup_plugin("dashboard", {})

setup_plugin("fsplash", {}) -- https://github.com/jovanlanik/fsplash.nvim Show a custom splash screen in a floating window

setup_plugin("drop", {}) -- https://github.com/folke/drop.nvim  Fun little plugin that can be used as a screensaver and on your dashboard

--─────────────────────────────────────────────────────────────────────────────
--──── pkm ────────────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

setup_plugin("doing", {})
utils.packadd("vimwiki")
setup_plugin("obsidian", { legacy_commands = false })
setup_plugin("orgmode", {})
setup_plugin("Calendar", {})
setup_plugin("zettelkasten", {})
setup_plugin("flote", {})
setup_plugin("tdo", {})
-- TODO: vendor/PR to fix old LspStart command -> new Lua LSP API
setup_plugin("scratch-buffer", function(scratch_buffer)
	scratch_buffer.setup({ with_lsp = false })
end)
setup_plugin("neowell-lua", {}) -- https://github.com/nyngwang/NeoWell.lua Well... I will fix this line later
setup_plugin("quicknote", {}) -- https://github.com/RutaTang/quicknote.nvim Quickly take notes, in-place

--─────────────────────────────────────────────────────────────────────────────
--──── diagrams ───────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

setup_plugin("better-digraphs", function(_) end)

setup_plugin("diagflow", {})

--─────────────────────────────────────────────────────────────────────────────
--──── colors ─────────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

setup_plugin("nvim-highlight-colors", {}) -- https://github.com/brenoprata10/nvim-highlight-colors Highlight colors for neovim

setup_plugin("text-to-colorscheme", {})
setup_plugin("minty", {})
setup_plugin("color-picker", {})
setup_plugin("baleia", {}) -- Colorize text with ANSI escape sequences (8, 16, 256 or TrueColor)

setup_plugin("easycolor", {})
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
setup_plugin("paint", {})

--─────────────────────────────────────────────────────────────────────────────
--──── recording/display ──────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

setup_plugin("carbon-now-nvim", {})
setup_plugin("showkeys", {}) -- https://github.com/nvzone/showkeys

--─────────────────────────────────────────────────────────────────────────────
--──── regex ──────────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────
setup_plugin("hypersonic", {}) -- https://github.com/tomiis4/hypersonic.nvim A Neovim plugin that provides an explanation for regular expressions.", {})
setup_plugin("regex-vars", {})
setup_plugin("regexplainer", {})

--─────────────────────────────────────────────────────────────────────────────
--──── docs ───────────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

setup_plugin("tldr", {})

setup_plugin("nvim-luaref", {}) -- https://github.com/emiasims/nvim-luaref Add a vim :help reference for lua

utils.packadd("auto-pandoc")

--─────────────────────────────────────────────────────────────────────────────
--──── fonts, characters, non-english, etc. ───────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────
setup_plugin("nerdy", {})
setup_plugin("cyrillic", {})
setup_plugin("xkbswitch", {})
--─────────────────────────────────────────────────────────────────────────────
--──── web utils ──────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────
setup_plugin("http-codes", function(http_codes) end) -- use vim.g.http_codes

setup_plugin("live-server", function(live_server) end) -- use vim.g.live_server
setup_plugin("web-tools", {})

setup_plugin("api-browser", {})

setup_plugin("spaceport-nvim", {})

--─────────────────────────────────────────────────────────────────────────────
--──── tracking/performance ───────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

setup_plugin("metrics", {}) -- tracks time spent in your editor, logs locally to sqlite3 database
setup_plugin("keylab", {}) -- https://github.com/BooleanCube/keylab.nvim
setup_plugin("nvim-apm", {}) -- https://github.com/pseudocc/nvim-apm calculate your APM, also show your key strokes in a buffer.

--─────────────────────────────────────────────────────────────────────────────
--──── other ──────────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

setup_plugin("nvim-quicktype", {}) -- https://github.com/midoBB/nvim-quicktype Generate types from JSON all inside Neovim
setup_plugin("interlaced", {}) -- Neovim plugin for aligning bilingual parallel texts
setup_plugin("nvmm", {}) -- nvim-mail-merge
setup_plugin("firenvim", function(_) end) -- https://github.com/glacambre/firenvim Embed Neovim in Chrome, Firefox & others.
setup_plugin("qalc", {}) -- https://github.com/Apeiros-46B/qalc.nvim Neovim-integrated calculator based on Qalculate
setup_plugin("flashcards", {}) -- https://github.com/alex-laycalvert/flashcards.nvim
setup_plugin("nvim-license", {}) -- https://github.com/cfrt-dev/license.nvim

-- OLD utils.packadd("markdown-preview")
-- nix rebuild setup_plugin("mkdp", {})
-- nix rebuild setup_plugin("structlog", {})
setup_plugin("firenvim", function(_) end)
setup_plugin("render-markdown", {})
setup_plugin("jupytext", {})
setup_plugin("quarto", {})
utils.packadd("asyncrun") -- install as lua module

setup_plugin("schemastore", function(_) end)
setup_plugin("render-markdown", {})

-- TODO

-- hacky, but works -> necessary due to name collision
-- local function setup_dashboard()
-- 	utils.packadd("dashboard-nvim")
-- 	local dashboard = require("dashboard")
-- 	dashboard.setup()
-- end

-- TODO: fix error
-- setup_plugin_explicit("dashboard-nvim", "dashboard", {})

setup_plugin("dashboard", {})

---------------- time -------------
setup_plugin("pommodoro-clock", {})
setup_plugin("pomodoro", {})
setup_plugin("timerly", {})
setup_plugin("timew", {})
setup_plugin("nomodoro", {})

---------------- pkm -------------
utils.packadd("vimwiki")
setup_plugin("obsidian", { legacy_commands = false })
setup_plugin("orgmode", {})
setup_plugin("Calendar", {})
setup_plugin("zettelkasten", {})

---------------- performance -------------
setup_plugin("keylab", {}) -- https://github.com/BooleanCube/keylab.nvim
setup_plugin("nvim-apm", {})

---------------- colors -------------

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

-------------------------------------------------------------------------------
-- PROBABLY NOT, BUT WORTH A TRY: ------------------------------------------------
-------------------------------------------------------------------------------

setup_plugin("whichkey_setup", {}) -- PROBABLY NOT, BUT WORTH A TRY
setup_plugin("ts_context_commentstring", {}) -- PROBABLY NOT, BUT WORTH A TRY

utils.packadd("vim-wordmotion") -- PROBABLY NOT, BUT WORTH A TRY
setup_plugin("hop", {}) -- PROBABLY NOT, BUT WORTH A TRY
utils.packadd("clever-f.vim") -- PROBABLY NOT, BUT WORTH A TRY
setup_plugin("better-escape", {}) -- PROBABLY NOT, BUT WORTH A TRY
setup_plugin("hlsearch-nvim", {}) -- PROBABLY NOT, BUT WORTH A TRY
setup_plugin("improved-search-nvim", {}) -- PROBABLY NOT, BUT WORTH A TRY
utils.packadd("vim-edgemotion") -- PROBABLY NOT, BUT WORTH A TRY
setup_plugin("notify", {}) -- PROBABLY NOT, BUT WORTH A TRY (== nvim-notify ?)
setup_plugin("lsp_signature", {}) -- PROBABLY NOT, BUT WORTH A TRY
setup_plugin("nvim-teal-maker", {}) -- PROBABLY NOT, BUT WORTH A TRY
setup_plugin("nvim-rg", {}) -- PROBABLY NOT, BUT WORTH A TRY https://github.com/duane9/nvim-rg
setup_plugin("homerows", {}) -- PROBABLY NOT, BUT WORTH A TRY https://github.com/unode/homerow.vim/blob/master/autoload/homerow.vim

utils.packadd("vim-multiple-cursors") -- PROBABLY NOT, BUT WORTH A TRY

setup_plugin("savior", {}) -- PROBABLY NOT, BUT WORTH A TRY
utils.packadd("vim-auto-save") -- PROBABLY NOT, BUT WORTH A TRY

-------------------------------------------------------------------------------
-- DEFERRED: ---------------------------------------------------------------------
-------------------------------------------------------------------------------
setup_plugin("knap", {}) -- https://github.com/frabjous/knap Neovim plugin for creating live-updating-as-you-type previews of LaTeX, markdown, and other files in the viewer of your choice.
setup_plugin("nvmm", {}) -- nvim-mail-merge

setup_plugin("zpragmatic", {}) -- https://github.com/muhammadzkralla/zpragmatic.nvim  prompts you with alert dialog questions whenever you attempt to save changes in a file
setup_plugin("volt", function(_) end) -- https://github.com/nvzone/volt  Create blazing fast & beautiful reactive UI in Neovim

setup_plugin("qalc", {})
setup_plugin("xkbswitch", {})
setup_plugin("cyrillic", {})
setup_plugin("present", {})

setup_plugin("cmdTree", {}) -- https://github.com/CWood-sdf/cmdTree.nvim  Declaratively make your neovim user commands

setup_plugin("better-digraphs", function(_) end)

utils.packadd("vim-slime")

setup_plugin("carbon-now-nvim", {})
setup_plugin("showkeys", {}) -- https://github.com/nvzone/showkeys

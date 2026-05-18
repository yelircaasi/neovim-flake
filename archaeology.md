# Archaeology

Old files kept around for understanding / brainstorming / reference.

## plugins.jsonc

```jsonc
[
	//===================================================================================================================================
	//==== LAYER 0: foundation, colors, search, core navigation =========================================================================
	//===================================================================================================================================
	//------------------------------
	//------ core dependencies -----
	//------------------------------
	{ "name": "plenary",                      "id": "nvim-lua/plenary.nvim",         "source": "gh", "lazy": false },
	{ "name": "nio",                          "id": "nvim-neotest/nvim-nio",         "source": "gh", "lazy": false },
	{ "name": "nvim-web-devicons",            "id": "nvim-tree/nvim-web-devicons",   "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "nui",                          "id": "MunifTanjim/nui.nvim",          "source": "gh", "lazy": false, "notes": "needs nix" }, 
	//------------------------------
	//------ core setup and UI -----
	//------------------------------
	{ "name": "bamboo",                       "id": "ribru17/bamboo.nvim",           "source": "gh", "lazy": false },
	{ "name": "zen-mode",                     "id": "folke/zen-mode.nvim",           "source": "gh", "lazy": false },
	{ "name": "illuminate",                   "id": "RRethy/vim-illuminate",         "source": "gh", "lazy": false },
	{ "name": "lualine",                      "id": "nvim-lualine/lualine.nvim",     "source": "gh", "lazy": false },
	{ "name": "nvim-navic",                   "id": "SmiteshP/nvim-navic",           "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "bufferline",                   "id": "akinsho/bufferline.nvim",       "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "statuscol",                    "id": "luukvbaal/statuscol.nvim",      "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "nvim-treesitter",              "id": "nvim-treesitter/nvim-treesitter", "source": "gh", "lazy": false, "notes": "brew install tree-sitter; brew install tree-sitter-cli" }, 
	{ "name": "treesitter-modules",           "id": "MeanderingProgrammer/treesitter-modules.nvim", "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "dropbar",                      "id": "Bekaboo/dropbar.nvim",          "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "nvim-navbuddy",                "id": "SmiteshP/nvim-navbuddy",        "source": "gh", "lazy": false, "deps": ["nui"], "notes": "needs nix" }, 
	{ "name": "aerial",                       "id": "stevearc/aerial.nvim",          "source": "gh", "lazy": false, "notes": "needs nix" }, 
	//---------------------------------------------
	//------ file explorer (as central focus) -----
	//---------------------------------------------
	{ "name": "oil",                          "id": "stevearc/oil.nvim",             "source": "gh", "lazy": false },
	{ "name": "yazi",                         "id": "mikavilpas/yazi.nvim",          "source": "gh", "lazy": false },
	{ "name": "neo-tree",                     "id": "nvim-neo-tree/neo-tree.nvim",   "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "nvim-tree",                    "id": "nvim-tree/nvim-tree.lua",       "source": "gh", "lazy": false, "notes": "needs nix" }, 
	//----------------------------
	//------ picker / search -----
	//----------------------------
	{ "name": "pickme",                       "id": "2KAbhishek/pickme.nvim",        "source": "gh", "lazy": false },
	{ "name": "telescope",                    "id": "nvim-telescope/telescope.nvim", "source": "gh", "lazy": false },
	{ "name": "telescope-fzf-native",         "id": "nvim-telescope/telescope-fzf-native.nvim", "source": "gh", "lazy": false },
	{ "name": "fzf-lua",                      "id": "ibhagwan/fzf-lua",              "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "deck",                         "id": "hrsh7th/nvim-deck",             "source": "gh", "lazy": false, "notes": "needs nix" }, 
	//-------------------
	//------ suites -----
	//-------------------
	{ "name": "mini",                         "id": "nvim-mini/mini.nvim",           "source": "gh", "lazy": false },
	{ "name": "snacks",                       "id": "folke/snacks.nvim",             "source": "gh", "lazy": false },
	{ "name": "blink",                        "id": "saghen/blink.nvim",             "source": "gh", "lazy": false, "notes": "needs nix" }, 
	//-------------------
	//------ search -----
	//-------------------
	{ "name": "hlslens",                      "id": "kevinhwang91/nvim-hlslens",     "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "hlsearch",                     "id": "nvimdev/hlsearch.nvim",         "source": "gh", "lazy": false, "notes": "needs nix" }, 
	//-----------------------------
	//------ find-and-replace -----
	//-----------------------------
	{ "name": "grug-far",                     "id": "MagicDuck/grug-far.nvim",       "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "spectre",                      "id": "nvim-pack/nvim-spectre",        "source": "gh", "lazy": false, "notes": "needs nix" }, 
	//--------------------------------------------------
	//------ layout & window/buffer/tab navigation -----
	//--------------------------------------------------
	{ "name": "nvim_winpick",                 "id": "MarcusGrass/nvim_winpick",      "source": "gh", "lazy": false },
	{ "name": "flybuf",                       "id": "nvimdev/flybuf.nvim",           "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "stickybuf",                    "id": "stevearc/stickybuf.nvim",       "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "swm",                          "id": "hrsh7th/nvim-swm",              "source": "gh", "lazy": false, "notes": "needs nix" }, 
	//--------------------------------
	//------ wezterm integration -----
	//--------------------------------
	{ "name": "smart-splits",                 "id": "mrjones2014/smart-splits.nvim", "source": "gh", "lazy": false, "notes": "needs nix" }, 

	//===================================================================================================================================
	//==== LAYER 1: editing enhancements ================================================================================================ 1
	//===================================================================================================================================
	//------------------
	//------ folds -----
	//------------------
	{ "name": "ufo",                     "id": "kevinhwang91/nvim-ufo",         "source": "gh", "lazy": false, "notes": "needs nix" }, 
	//-------------------
	//------ macros -----
	//-------------------
	{ "name": "NeoComposer",                  "id": "lvim-tech/NeoComposer.nvim",    "source": "gh", "lazy": false },
	{ "name": "nvim-macros",                  "id": "kr40/nvim-macros",              "source": "gh", "lazy": false },
	{ "name": "recorder",                "id": "chrisgrieser/nvim-recorder",    "source": "gh", "lazy": false },
	//-------------------------
	//------ multi-cursor -----
	//-------------------------
	{ "name": "vim-visual-multi",             "id": "mg979/vim-visual-multi",        "source": "gh", "lazy": false },
	//-------------------
	//------ motion -----
	//-------------------
	{ "name": "leap",                         "id": "andyg/leap.nvim",               "source": "cb", "lazy": false, "notes": "needs nix" }, 
	{ "name": "flash",                        "id": "folke/flash.nvim",              "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "hop",                          "id": "smoka7/hop.nvim",               "source": "gh", "lazy": false, "notes": "needs nix" }, 
	//------------------
	//------ pairs -----
	//------------------
	{ "name": "rainbow-delimiters",           "id": "HiPhish/rainbow-delimiters.nvim", "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "nvim-autopairs",               "id": "windwp/nvim-autopairs",         "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "blink.pairs",                  "id": "saghen/blink.pairs",            "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "vim-sandwich",                 "id": "machakann/vim-sandwich",        "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "surround",                     "id": "kylechui/nvim-surround",        "source": "gh", "lazy": false, "notes": "needs nix" }, 
	//-----------------
	//------ undo -----
	//-----------------
	{ "name": "vim-mundo",                    "id": "simnalamburt/vim-mundo",        "source": "gh", "lazy": false, "notes": "needs nix" }, 
	//-------------------------------
	//------ keymapping-related -----
	//-------------------------------
	{ "name": "mini.keymap",                  "id": "nvim-mini/mini.keymap",         "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "hydra",                        "id": "nvimtools/hydra.nvim",          "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "nvim-insx",                    "id": "hrsh7th/nvim-insx",             "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "which-key",                    "id": "folke/which-key.nvim",          "source": "gh", "lazy": false },
	//------------------------------------
	//------ alignment / indentation -----
	//------------------------------------
	{ "name": "indentmini",                   "id": "nvimdev/indentmini.nvim",       "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "indent-blankline",             "id": "lukas-reineke/indent-blankline.nvim", "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "nvim-anydent",                 "id": "hrsh7th/nvim-anydent",          "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "mini.align",                   "id": "nvim-mini/mini.align",          "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "tabular",                      "id": "godlygeek/tabular",             "source": "gh", "lazy": false, "notes": " -- needs nix; https://devhints.io/tabular" }, 
	//------------------------
	//------ textobjects -----
	//------------------------
	{ "name": "nvim-treesitter-textobjects",  "id": "nvim-treesitter/nvim-treesitter-textobjects", "source": "gh", "lazy": false },
	{ "name": "nvim-various-textobjs",        "id": "chrisgrieser/nvim-various-textobjs", "source": "gh", "lazy": false, "notes": "needs nix" }, 
	//---------------------
	//------ comments -----
	//---------------------
	{ "name": "Comment",                      "id": "numToStr/Comment.nvim",         "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "todo-comments",                "id": "folke/todo-comments.nvim",      "source": "gh", "lazy": false },
	{ "name": "vim-commentary",               "id": "tpope/vim-commentary",          "source": "gh", "lazy": false, "notes": "needs nix" }, 
	//-------------------------
	//------ split / join -----
	//-------------------------
	{ "name": "treesj",                       "id": "Wansmer/treesj",                "source": "gh", "lazy": false, "notes": "needs nix" }, 
	//-------------------------------
	//------ value manipulation -----
	//-------------------------------
	{ "name": "dial",                         "id": "monaqa/dial.nvim",              "source": "gh", "lazy": false },
	//------------------
	//------ marks -----
	//------------------
	{ "name": "harpoon-core",                 "id": "MeanderingProgrammer/harpoon-core.nvim", "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "marks",                        "id": "chentoast/marks.nvim",          "source": "gh", "lazy": false },
	{ "name": "markit",                       "id": "2KAbhishek/markit.nvim",        "source": "gh", "lazy": false, "notes": "needs nix" }, 
	//-----------------------------------
	//------ yank/paste & clipboard -----
	//-----------------------------------
	{ "name": "nvim-pasta",                   "id": "hrsh7th/nvim-pasta",            "source": "gh", "lazy": false, "notes": "needs nix" }, 
	//--------------------------
	//------ miscellaneous -----
	//--------------------------
	{ "name": "beam",                         "id": "Piotr1215/beam.nvim",           "source": "gh", "lazy": false, "notes": "needs nix" }, 

	//===================================================================================================================================
	//==== LAYER 2: LSP, autocompletion, snippets ======================================================================================= 2
	//===================================================================================================================================
	//-----------------------------------
	//------ snippets, autocomplete -----
	//-----------------------------------
	{ "name": "blink.cmp",                    "id": "Saghen/blink.cmp",              "source": "gh", "lazy": false },
	{ "name": "nvim-cmp",                     "id": "hrsh7th/nvim-cmp",              "source": "gh", "lazy": false, "notes": "needs nix" }, 
	//-------------------------------------
	//------ snippets (as main focus) -----
	//-------------------------------------
	{ "name": "friendly-snippets",            "id": "rafamadriz/friendly-snippets",  "source": "gh", "lazy": false },
	{ "name": "ultisnips",                    "id": "SirVer/ultisnips",              "source": "gh", "lazy": false, "notes": "needs nix; https://ejmastnak.com/tutorials/vim-latex/ultisnips/" }, 
	{ "name": "LuaSnip",                      "id": "L3MON4D3/LuaSnip",              "source": "gh", "lazy": false },
	//------ completion sources -----
	{ "name": "cmp-nvim-lsp",                 "id": "hrsh7th/cmp-nvim-lsp",          "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "cmp-buffer",                   "id": "hrsh7th/cmp-buffer",            "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "cmp-path",                     "id": "hrsh7th/cmp-path",              "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "cmp-cmdline",                  "id": "hrsh7th/cmp-cmdline",           "source": "gh", "lazy": false, "notes": "needs nix" }, 
	//------------------------
	//------ LSP general -----
	//------------------------
	// (configure ruff, pyright, lua-language-server, haskell-language-server, rust-analyzer with built-in client)
	{ "name": "lsp-format",                   "id": "lukas-reineke/lsp-format.nvim", "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "lspkind",                      "id": "onsails/lspkind.nvim",          "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "efm",                          "id": "mattn/efm-langserver",          "source": "gh", "lazy": false },
	//------------------------------------------
	//------ LSP UI (see also fidget.nvim) -----
	//------------------------------------------
	{ "name": "lspsaga",                      "id": "nvimdev/lspsaga.nvim",          "source": "gh", "lazy": false, "notes": "needs nix" }, 
	//------ language-specific -----
	{ "name": "lazydev",                      "id": "folke/lazydev.nvim",            "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "rustaceanvim",                 "id": "mrcjkb/rustaceanvim",           "source": "gh", "lazy": false, "notes": "already lazy" }, 
	{ "name": "crates",                       "id": "saecki/crates.nvim",            "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "haskell-tools",                "id": "mrcjkb/haskell-tools.nvim",     "source": "gh", "lazy": false, "notes": "already lazy" }, 
	//------ LSP-adjacent -----
	{ "name": "none-ls",                      "id": "nvimtools/none-ls.nvim",        "source": "gh", "lazy": false, "notes": "needs nix" }, 

	//===================================================================================================================================
	// LAYER 3: formatting & linting ==================================================================================================== 3
	//===================================================================================================================================
	{ "name": "guard",                        "id": "nvimdev/guard.nvim",            "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "conform",                      "id": "stevearc/conform.nvim",         "source": "gh", "lazy": false, "notes": "ruff, rustfmt, stylua, fourmolu" }, 

	//===================================================================================================================================
	// LAYER 4: testing, debugging/quickfix, execution ================================================================================== 4
	//===================================================================================================================================
	//-------------------------------------------------
	//----- Code execution / task running / build -----
	//-------------------------------------------------
	{ "name": "overseer",                     "id": "stevearc/overseer.nvim",        "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "asyncrun",                     "id": "skywind3000/asyncrun.vim",      "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "compiler",                     "id": "Zeioth/compiler.nvim",          "source": "gh", "lazy": false },
	{ "name": "code_runner",                  "id": "CRAG666/code_runner.nvim",      "source": "gh", "lazy": false },
	{ "name": "sniprun",                      "id": "michaelb/sniprun",              "source": "gh", "lazy": false },
	{ "name": "yabs",                         "id": "pianocomposer321/officer.nvim", "source": "gh", "lazy": false },
	//-------------------
	//----- Testing -----
	//-------------------
	{ "name": "neotest-haskell",              "id": "MrcJkb/neotest-haskell",        "source": "gh", "lazy": false, "notes": "TODO" }, 
	{ "name": "neotest-python",               "id": "nvim-neotest/neotest-python",   "source": "gh", "lazy": false },
	{ "name": "neotest",                      "id": "nvim-neotest/neotest",          "source": "gh", "lazy": false },
	{ "name": "dap-python",                   "id": "mfussenegger/nvim-dap-python",  "source": "cb", "lazy": false, "notes": "needs nix; pipx install debugpy" }, 
	{ "name": "dapui",                        "id": "rcarriga/nvim-dap-ui",          "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "nvim-dap-virtual-text",        "id": "theHamsta/nvim-dap-virtual-text", "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "dap",                          "id": "mfussenegger/nvim-dap",         "source": "cb", "lazy": false, "notes": "needs nix" }, 
	{ "name": "mypy",                         "id": "feakuru/mypy.nvim",             "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "nvim-lint",                    "id": "mfussenegger/nvim-lint",        "source": "gh", "lazy": false, "notes": "needs nix" }, 
	//---------------------------
	//------ DAP/quickix UI -----
	//---------------------------
	{ "name": "trouble.nvim",                 "id": "folke/trouble.nvim",            "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "quicker",                      "id": "stevearc/quicker.nvim",         "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "nvim-bqf",                     "id": "kevinhwang91/nvim-bqf",         "source": "gh", "lazy": false },
	//---------------------
	//------ terminal -----
	//---------------------
	{ "name": "vim-floaterm",                 "id": "voldikss/vim-floaterm",         "source": "gh", "lazy": false },
	//===================================================================================================================================
	//==== LAYER 5: refactoring & code intelligence ===================================================================================== 5
	//===================================================================================================================================
	{ "name": "refactoring",                  "id": "ThePrimeagen/refactoring.nvim", "source": "gh", "lazy": false, "notes": "needs nix" }, 
	//-------------------------------
	//------ project management -----
	//-------------------------------
	{ "name": "project",                      "id": "ahmedkhalf/project.nvim",       "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "telescope-project",            "id": "nvim-telescope/telescope-project.nvim", "source": "gh", "lazy": false, "notes": "needs nix" }, 

	//===================================================================================================================================
	//==== LAYER 6: version control & collaboration ===================================================================================== 6
	//===================================================================================================================================
	{ "name": "jj",                           "id": "NicolasGB/jj.nvim",             "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "jujutsu",                      "id": "yannvanhalewyn/jujutsu.nvim",   "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "lazygit",                      "id": "kdheepak/lazygit.nvim",         "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "git-conflict",                 "id": "akinsho/git-conflict.nvim",     "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "neogit",                       "id": "NeogitOrg/neogit",              "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "jiejie",                       "id": "jceb/jiejie.nvim",              "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "diffview",                     "id": "sindrets/diffview.nvim",        "source": "gh", "lazy": false },
	{ "name": "gitsigns",                     "id": "lewis6991/gitsigns.nvim",       "source": "gh", "lazy": false },
	{ "name": "vim-fugitive",                 "id": "tpope/vim-fugitive",            "source": "gh", "lazy": false, "notes": "needs nix" }, 
	//----------------------
	//----- Git forges -----
	//----------------------
	{ "name": "octo",                         "id": "pwntester/octo.nvim",           "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "gitlab-nvim",                  "id": "harrisoncramer/gitlab.nvim",    "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "gitlab",                       "id": "gitlab-org/editor-extensions/gitlab.vim", "source": "gl", "lazy": false, "notes": "needs nix" }, 

	//===================================================================================================================================
	//==== LAYER 7: UI polish & productivity ============================================================================================ 7
	//===================================================================================================================================
	{ "name": "dashboard-nvim",               "id": "nvimdev/dashboard-nvim",        "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "dashboard",                    "id": "MeanderingProgrammer/dashboard.nvim", "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "noice",                        "id": "folke/noice.nvim",              "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "modes",                        "id": "mvllow/modes.nvim",             "source": "gh", "lazy": false, "notes": "needs nix" }, 
	//-----------------------------------
	//------ UI (important for LSP) -----
	//-----------------------------------
	{ "name": "fidget",                       "id": "j-hui/fidget.nvim",             "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "nvim-notify",                  "id": "rcarriga/nvim-notify",          "source": "gh", "lazy": false, "notes": "needs nix; see also mini.notify" }, 
	{ "name": "headlines",                    "id": "lukas-reineke/headlines.nvim",  "source": "gh", "lazy": false, "notes": "needs nix" }, 
	//-------------------------------
	//------ session management -----
	//-------------------------------
	{ "name": "auto-session",                 "id": "rmagatti/auto-session",         "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "persistence",                  "id": "folke/persistence.nvim",        "source": "gh", "lazy": false, "notes": "needs nix" }, 

	//===================================================================================================================================
	//==== LAYER 8: miscellaneous/advanced ============================================================================================== 8
	//===================================================================================================================================
	{ "name": "vimtex",                       "id": "lervag/vimtex",                 "source": "gh", "lazy": false, "notes": "needs nix; use vim.cmd.source or vim.fn.runtime" }, 
	{ "name": "texmagic",                     "id": "jakewvincent/texmagic.nvim",    "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "schemastore",                  "id": "b0o/SchemaStore.nvim",          "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "firenvim",                     "id": "glacambre/firenvim",            "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "render-markdown",              "id": "MeanderingProgrammer/render-markdown.nvim", "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "jupytext",                     "id": "GCBallesteros/jupytext.nvim",   "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "quarto",                       "id": "quarto-dev/quarto-nvim",        "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "markdown-preview",             "id": "iamcco/markdown-preview.nvim",  "source": "gh", "lazy": false, "notes": "needs nix" }, 
	//-----------------------------------
	//------ Lua / self-referential -----
	//-----------------------------------
	{ "name": "structlog",                    "id": "Tastyep/structlog.nvim",        "source": "gh", "lazy": false, "notes": "needs nix" }, 
	{ "name": "neorepl",                      "id": "ii14/neorepl.nvim",             "source": "gh", "lazy": false, "notes": "needs nix" } 
]

```

## declaration.lua

```lua
local PLUGIN_DECLARATION = {
	--===================================================================================================================================
	--==== LAYER 0: foundation, colors, search, core navigation =========================================================================
	--===================================================================================================================================
	------------------------------
	------ core dependencies -----
	------------------------------
	["plenary"]                                  = { id = "nvim-lua/plenary.nvim",         expander = gh, lazy = false },
	["nio"]                                      = { id = "nvim-neotest/nvim-nio",         expander = gh, lazy = false },
	["nvim-web-devicons"]                        = { id = "nvim-tree/nvim-web-devicons",   expander = gh, lazy = false }, -- needs nix
	["nui"]                                      = { id = "MunifTanjim/nui.nvim",          expander = gh, lazy = false }, -- needs nix
	-----------------------------─
	------ core setup and UI -----
	------------------------------
	["bamboo"]                                   = { id = "ribru17/bamboo.nvim",           expander = gh, lazy = false },
	["zen-mode"]                                 = { id = "folke/zen-mode.nvim",           expander = gh, lazy = false },
	["illuminate"]                               = { id = "RRethy/vim-illuminate",         expander = gh, lazy = false },
	["lualine"]                                  = { id = "nvim-lualine/lualine.nvim",     expander = gh, lazy = false },
	["nvim-navic"]                               = { id = "SmiteshP/nvim-navic",           expander = gh, lazy = false }, -- needs nix
	["bufferline"]                               = { id = "akinsho/bufferline.nvim",       expander = gh, lazy = false }, -- needs nix
	["statuscol"]                                = { id = "luukvbaal/statuscol.nvim",      expander = gh, lazy = false }, -- needs nix
	["nvim-treesitter"]                          = { id = "nvim-treesitter/nvim-treesitter", expander = gh, lazy = false }, -- brew install tree-sitter; brew install tree-sitter-cli
	["treesitter-modules"]                       = { id = "MeanderingProgrammer/treesitter-modules.nvim", expander = gh, lazy = false }, -- needs nix
	["dropbar"]                                  = { id = "Bekaboo/dropbar.nvim",          expander = gh, lazy = false }, -- needs nix
	["nvim-navbuddy"]                            = { id = "SmiteshP/nvim-navbuddy",        expander = gh, lazy = false, deps = { "nui" } }, -- needs nix
	["aerial"]                                   = { id = "stevearc/aerial.nvim",          expander = gh, lazy = false }, -- needs nix
	---------------------------------------------
	------ file explorer (as central focus) -----
	---------------------------------------------
	["oil"]                                      = { id = "stevearc/oil.nvim",             expander = gh, lazy = false },
	["yazi"]                                     = { id = "mikavilpas/yazi.nvim",          expander = gh, lazy = false },
	["neo-tree"]                                 = { id = "nvim-neo-tree/neo-tree.nvim",   expander = gh, lazy = false }, -- needs nix
	["nvim-tree"]                                = { id = "nvim-tree/nvim-tree.lua",       expander = gh, lazy = false }, -- needs nix
	----------------------------
	------ picker / search -----
	----------------------------
	["pickme"]                                   = { id = "2KAbhishek/pickme.nvim",        expander = gh, lazy = false },
	["telescope"]                                = { id = "nvim-telescope/telescope.nvim", expander = gh, lazy = false },
	["telescope-fzf-native"]                     = { id = "nvim-telescope/telescope-fzf-native.nvim", expander = gh, lazy = false },
	["fzf-lua"]                                  = { id = "ibhagwan/fzf-lua",              expander = gh, lazy = false }, -- needs nix
	["deck"]                                     = { id = "hrsh7th/nvim-deck",             expander = gh, lazy = false }, -- needs nix
	-------------------
	------ suites -----
	-------------------
	["mini"]                                     = { id = "nvim-mini/mini.nvim",           expander = gh, lazy = false },
	["snacks"]                                   = { id = "folke/snacks.nvim",             expander = gh, lazy = false },
	["blink"]                                    = { id = "saghen/blink.nvim",             expander = gh, lazy = false }, -- needs nix
	-------------------
	------ search -----
	-------------------
	["hlslens"]                                  = { id = "kevinhwang91/nvim-hlslens",     expander = gh, lazy = false }, -- needs nix
	["hlsearch"]                                 = { id = "nvimdev/hlsearch.nvim",         expander = gh, lazy = false }, -- needs nix
	-----------------------------
	------ find-and-replace -----
	-----------------------------
	["grug-far"]                                 = { id = "MagicDuck/grug-far.nvim",       expander = gh, lazy = false }, -- needs nix
	["spectre"]                                  = { id = "nvim-pack/nvim-spectre",        expander = gh, lazy = false }, -- needs nix
	--------------------------------------------------
	------ layout & window/buffer/tab navigation -----
	--------------------------------------------------
	["nvim_winpick"]                             = { id = "MarcusGrass/nvim_winpick",      expander = gh, lazy = false },
	["flybuf"]                                   = { id = "nvimdev/flybuf.nvim",           expander = gh, lazy = false }, -- needs nix
	["stickybuf"]                                = { id = "stevearc/stickybuf.nvim",       expander = gh, lazy = false }, -- needs nix
	["swm"]                                      = { id = "hrsh7th/nvim-swm",              expander = gh, lazy = false }, -- needs nix
	--------------------------------
	------ wezterm integration -----
	--------------------------------
	["smart-splits"]                             = { id = "mrjones2014/smart-splits.nvim", expander = gh, lazy = false }, -- needs nix

	--===================================================================================================================================
	--==== LAYER 1: editing enhancements ================================================================================================ 1
	--===================================================================================================================================
	------------------
	------ folds -----
	------------------
	["ufo"]                                 = { id = "kevinhwang91/nvim-ufo",         expander = gh, lazy = false }, -- needs nix
	-------------------
	------ macros -----
	-------------------
	["NeoComposer"]                              = { id = "lvim-tech/NeoComposer.nvim",    expander = gh, lazy = false },
	["nvim-macros"]                              = { id = "kr40/nvim-macros",              expander = gh, lazy = false },
	["recorder"]                            = { id = "chrisgrieser/nvim-recorder",    expander = gh, lazy = false },
	-------------------------
	------ multi-cursor -----
	-------------------------
	["vim-visual-multi"]                         = { id = "mg979/vim-visual-multi",        expander = gh, lazy = false },
	-------------------
	------ motion -----
	-------------------
	["leap"]                                     = { id = "andyg/leap.nvim",               expander = cb, lazy = false }, -- needs nix
	["flash"]                                    = { id = "folke/flash.nvim",              expander = gh, lazy = false }, -- needs nix
	["hop"]                                      = { id = "smoka7/hop.nvim",               expander = gh, lazy = false }, -- needs nix
	------------------
	------ pairs -----
	------------------
	["rainbow-delimiters"]                       = { id = "HiPhish/rainbow-delimiters.nvim", expander = gh, lazy = false }, -- needs nix
	["nvim-autopairs"]                           = { id = "windwp/nvim-autopairs",         expander = gh, lazy = false }, -- needs nix
	["blink.pairs"]                              = { id = "saghen/blink.pairs",            expander = gh, lazy = false }, -- needs nix
	["vim-sandwich"]                             = { id = "machakann/vim-sandwich",        expander = gh, lazy = false }, -- needs nix
	["surround"]                            = { id = "kylechui/nvim-surround",        expander = gh, lazy = false }, -- needs nix
	-----------------
	------ undo -----
	-----------------
	["vim-mundo"]                                = { id = "simnalamburt/vim-mundo",        expander = gh, lazy = false }, -- needs nix
	-------------------------------
	------ keymapping-related -----
	-------------------------------
	["mini.keymap"]                              = { id = "nvim-mini/mini.keymap",         expander = gh, lazy = false }, -- needs nix
	["hydra"]                                    = { id = "nvimtools/hydra.nvim",          expander = gh, lazy = false }, -- needs nix
	["nvim-insx"]                                = { id = "hrsh7th/nvim-insx",             expander = gh, lazy = false }, -- needs nix
	["which-key"]                                = { id = "folke/which-key.nvim",          expander = gh, lazy = false },
	------------------------------------
	------ alignment / indentation -----
	------------------------------------
	["indentmini"]                               = { id = "nvimdev/indentmini.nvim",       expander = gh, lazy = false }, -- needs nix
	["indent-blankline"]                         = { id = "lukas-reineke/indent-blankline.nvim", expander = gh, lazy = false }, -- needs nix
	["nvim-anydent"]                             = { id = "hrsh7th/nvim-anydent",          expander = gh, lazy = false }, -- needs nix
	["mini.align"]                               = { id = "nvim-mini/mini.align",          expander = gh, lazy = false }, -- needs nix
	["tabular"]                                  = { id = "godlygeek/tabular",             expander = gh, lazy = false }, --  -- needs nix; https://devhints.io/tabular
	------------------------
	------ textobjects -----
	------------------------
	["nvim-treesitter-textobjects"] = {
		id = "nvim-treesitter/nvim-treesitter-textobjects",
		expander = gh,
		lazy = false,
		name = "nvim-treesitter-textobjects",
	},
	["nvim-various-textobjs"]  = { id = "chrisgrieser/nvim-various-textobjs", expander = gh, lazy = false }, -- needs nix
	---------------------
	------ comments -----
	---------------------
	["Comment"]                                  = { id = "numToStr/Comment.nvim",         expander = gh, lazy = false }, -- needs nix
	["todo-comments"]                            = { id = "folke/todo-comments.nvim",      expander = gh, lazy = false },
	["vim-commentary"]                           = { id = "tpope/vim-commentary",          expander = gh, lazy = false }, -- needs nix
	-------------------------
	------ split / join -----
	-------------------------
	["treesj"]                                   = { id = "Wansmer/treesj",                expander = gh, lazy = false }, -- needs nix
	-------------------------------
	------ value manipulation -----
	-------------------------------
	["dial"]                                     = { id = "monaqa/dial.nvim",              expander = gh, lazy = false },
	------------------
	------ marks -----
	------------------
	["harpoon-core"]                             = { id = "MeanderingProgrammer/harpoon-core.nvim", expander = gh, lazy = false }, -- needs nix
	["marks"]                                    = { id = "chentoast/marks.nvim",          expander = gh, lazy = false },
	["markit"]                                   = { id = "2KAbhishek/markit.nvim",        expander = gh, lazy = false }, -- needs nix
	-----------------------------------
	------ yank/paste & clipboard -----
	-----------------------------------
	["nvim-pasta"]                               = { id = "hrsh7th/nvim-pasta",            expander = gh, lazy = false }, -- needs nix
	--------------------------
	------ miscellaneous -----
	--------------------------
	["beam"]                                     = { id = "Piotr1215/beam.nvim",           expander = gh, lazy = false }, -- needs nix

	--===================================================================================================================================
	--==== LAYER 2: LSP, autocompletion, snippets ======================================================================================= 2
	--===================================================================================================================================
	-----------------------------------
	------ snippets, autocomplete -----
	-----------------------------------
	["blink.cmp"]                                = { id = "Saghen/blink.cmp",              expander = gh, lazy = false },
	["nvim-cmp"]                                 = { id = "hrsh7th/nvim-cmp",              expander = gh, lazy = false }, -- needs nix
	-------------------------------------
	------ snippets (as main focus) -----
	-------------------------------------
	["friendly-snippets"]                        = { id = "rafamadriz/friendly-snippets",  expander = gh, lazy = false },
	["ultisnips"]                                = { id = "SirVer/ultisnips",              expander = gh, lazy = false }, -- needs nix; https://ejmastnak.com/tutorials/vim-latex/ultisnips/
	["LuaSnip"]                                  = { id = "L3MON4D3/LuaSnip",              expander = gh, lazy = false },
	------ completion sources -----
	["cmp-nvim-lsp"]                             = { id = "hrsh7th/cmp-nvim-lsp",          expander = gh, lazy = false }, -- needs nix
	["cmp-buffer"]                               = { id = "hrsh7th/cmp-buffer",            expander = gh, lazy = false }, -- needs nix
	["cmp-path"]                                 = { id = "hrsh7th/cmp-path",              expander = gh, lazy = false }, -- needs nix
	["cmp-cmdline"]                              = { id = "hrsh7th/cmp-cmdline",           expander = gh, lazy = false }, -- needs nix
	------------------------
	------ LSP general -----
	------------------------
	-- (configure ruff, pyright, lua-language-server, haskell-language-server, rust-analyzer with built-in client)
	["lsp-format"]                               = { id = "lukas-reineke/lsp-format.nvim", expander = gh, lazy = false }, -- needs nix
	["lspkind"]                                  = { id = "onsails/lspkind.nvim",          expander = gh, lazy = false }, -- needs nix
	["efm"]                                      = { id = "mattn/efm-langserver",          expander = gh, lazy = false },
	------------------------------------------
	------ LSP UI (see also fidget.nvim) -----
	------------------------------------------
	["lspsaga"]                                  = { id = "nvimdev/lspsaga.nvim",          expander = gh, lazy = false }, -- needs nix
	------ language-specific -----
	["lazydev"]                                  = { id = "folke/lazydev.nvim",            expander = gh, lazy = false }, -- needs nix
	["rustaceanvim"]                             = { id = "mrcjkb/rustaceanvim",           expander = gh, lazy = false }, -- already lazy
	["crates"]                                   = { id = "saecki/crates.nvim",            expander = gh, lazy = false }, -- needs nix
	["haskell-tools"]                            = { id = "mrcjkb/haskell-tools.nvim",     expander = gh, lazy = false }, -- already lazy
	------ LSP-adjacent -----
	["none-ls"]                                  = { id = "nvimtools/none-ls.nvim",        expander = gh, lazy = false }, -- needs nix

	--===================================================================================================================================
	-- LAYER 3: formatting & linting ==================================================================================================== 3
	--===================================================================================================================================
	["guard"]                                    = { id = "nvimdev/guard.nvim",            expander = gh, lazy = false }, -- needs nix
	["conform"]                                  = { id = "stevearc/conform.nvim",         expander = gh, lazy = false }, -- ruff, rustfmt, stylua, fourmolu

	--===================================================================================================================================
	-- LAYER 4: testing, debugging/quickfix, execution ================================================================================== 4
	--===================================================================================================================================
	-------------------------------------------------
	----- Code execution / task running / build -----
	-------------------------------------------------
	["overseer"]                                 = { id = "stevearc/overseer.nvim",        expander = gh, lazy = false }, -- needs nix
	["asyncrun"]                                 = { id = "skywind3000/asyncrun.vim",      expander = gh, lazy = false }, -- needs nix
	["compiler"]                                 = { id = "Zeioth/compiler.nvim",          expander = gh, lazy = false },
	["code_runner"]                              = { id = "CRAG666/code_runner.nvim",      expander = gh, lazy = false },
	["sniprun"]                                  = { id = "michaelb/sniprun",              expander = gh, lazy = false },
	["yabs"]                                     = { id = "pianocomposer321/officer.nvim", expander = gh, lazy = false },
	-------------------
	----- Testing -----
	-------------------
	["neotest-haskell"]                          = { id = "MrcJkb/neotest-haskell",        expander = gh, lazy = false }, -- TODO
	["neotest-python"]                           = { id = "nvim-neotest/neotest-python",   expander = gh, lazy = false },
	["neotest"]                                  = { id = "nvim-neotest/neotest",          expander = gh, lazy = false },
	["dap-python"]                               = { id = "mfussenegger/nvim-dap-python",  expander = cb, lazy = false }, -- needs nix; pipx install debugpy
	["dapui"]                                    = { id = "rcarriga/nvim-dap-ui",          expander = gh, lazy = false }, -- needs nix
	["nvim-dap-virtual-text"]                    = { id = "theHamsta/nvim-dap-virtual-text", expander = gh, lazy = false }, -- needs nix
	["dap"]                                      = { id = "mfussenegger/nvim-dap",         expander = cb, lazy = false }, -- needs nix
	["mypy"]                                     = { id = "feakuru/mypy.nvim",             expander = gh, lazy = false }, -- needs nix
	["nvim-lint"]                                = { id = "mfussenegger/nvim-lint",        expander = gh, lazy = false }, -- needs nix
	---------------------------
	------ DAP/quickix UI -----
	---------------------------
	["trouble.nvim"]                             = { id = "folke/trouble.nvim",            expander = gh, lazy = false }, -- needs nix
	["quicker"]                                  = { id = "stevearc/quicker.nvim",         expander = gh, lazy = false }, -- needs nix
	["nvim-bqf"]                                 = { id = "kevinhwang91/nvim-bqf",         expander = gh, lazy = false },
	---------------------
	------ terminal -----
	---------------------
	["vim-floaterm"]                             = { id = "voldikss/vim-floaterm",         expander = gh, lazy = false },
	--===================================================================================================================================
	--==== LAYER 5: refactoring & code intelligence ===================================================================================== 5
	--===================================================================================================================================
	["refactoring"]                              = { id = "ThePrimeagen/refactoring.nvim", expander = gh, lazy = false }, -- needs nix
	-------------------------------
	------ project management -----
	-------------------------------
	["project"]                                  = { id = "ahmedkhalf/project.nvim",       expander = gh, lazy = false }, -- needs nix
	["telescope-project"]                        = { id = "nvim-telescope/telescope-project.nvim", expander = gh, lazy = false }, -- needs nix

	--===================================================================================================================================
	--==== LAYER 6: version control & collaboration ===================================================================================== 6
	--===================================================================================================================================
	["jj"]                                       = { id = "NicolasGB/jj.nvim",             expander = gh, lazy = false }, -- needs nix
	["jujutsu"]                                  = { id = "yannvanhalewyn/jujutsu.nvim",   expander = gh, lazy = false }, -- needs nix
	["lazygit"]                                  = { id = "kdheepak/lazygit.nvim",         expander = gh, lazy = false }, -- needs nix
	["git-conflict"]                             = { id = "akinsho/git-conflict.nvim",     expander = gh, lazy = false }, -- needs nix
	["neogit"]                                   = { id = "NeogitOrg/neogit",              expander = gh, lazy = false }, -- needs nix
	["jiejie"]                                   = { id = "jceb/jiejie.nvim",              expander = gh, lazy = false }, -- needs nix
	["diffview"]                                 = { id = "sindrets/diffview.nvim",        expander = gh, lazy = false },
	["gitsigns"]                                 = { id = "lewis6991/gitsigns.nvim",       expander = gh, lazy = false },
	["vim-fugitive"]                             = { id = "tpope/vim-fugitive",            expander = gh, lazy = false }, -- needs nix
	----------------------
	----- Git forges -----
	----------------------
	["octo"]                                     = { id = "pwntester/octo.nvim",           expander = gh, lazy = false }, -- needs nix
	["gitlab-nvim"]                              = { id = "harrisoncramer/gitlab.nvim",    expander = gh, lazy = false }, -- needs nix
	["gitlab"]                                   = { id = "gitlab-org/editor-extensions/gitlab.vim", expander = gl, lazy = false }, -- needs nix

	--===================================================================================================================================
	--==== LAYER 7: UI polish & productivity ============================================================================================ 7
	--===================================================================================================================================
	["dashboard-nvim"]                           = { id = "nvimdev/dashboard-nvim",        expander = gh, lazy = false }, -- needs nix
	["dashboard"]                                = { id = "MeanderingProgrammer/dashboard.nvim", expander = gh, lazy = false }, -- needs nix
	["noice"]                                    = { id = "folke/noice.nvim",              expander = gh, lazy = false }, -- needs nix
	["modes"]                                    = { id = "mvllow/modes.nvim",             expander = gh, lazy = false }, -- needs nix
	-----------------------------------
	------ UI (important for LSP) -----
	-----------------------------------
	["fidget"]                                   = { id = "j-hui/fidget.nvim",             expander = gh, lazy = false }, -- needs nix
	["nvim-notify"]                              = { id = "rcarriga/nvim-notify",          expander = gh, lazy = false }, -- needs nix; see also mini.notify
	["headlines"]                                = { id = "lukas-reineke/headlines.nvim",  expander = gh, lazy = false }, -- needs nix
	-------------------------------
	------ session management -----
	-------------------------------
	["auto-session"]                             = { id = "rmagatti/auto-session",         expander = gh, lazy = false }, -- needs nix
	["persistence"]                              = { id = "folke/persistence.nvim",        expander = gh, lazy = false }, -- needs nix

	--===================================================================================================================================
	--==== LAYER 8: miscellaneous/advanced ============================================================================================== 8
	--===================================================================================================================================
	["vimtex"]                                   = { id = "lervag/vimtex",                 expander = gh, lazy = false }, -- needs nix; use vim.cmd.source or vim.fn.runtime
	["texmagic"]                                 = { id = "jakewvincent/texmagic.nvim",    expander = gh, lazy = false }, -- needs nix
	["schemastore"]                              = { id = "b0o/SchemaStore.nvim",          expander = gh, lazy = false }, -- needs nix
	["firenvim"]                                 = { id = "glacambre/firenvim",            expander = gh, lazy = false }, -- needs nix
	["render-markdown"]                          = { id = "MeanderingProgrammer/render-markdown.nvim", expander = gh, lazy = false }, -- needs nix
	["jupytext"]                                 = { id = "GCBallesteros/jupytext.nvim",   expander = gh, lazy = false }, -- needs nix
	["quarto"]                                   = { id = "quarto-dev/quarto-nvim",        expander = gh, lazy = false }, -- needs nix
	["markdown-preview"]                         = { id = "iamcco/markdown-preview.nvim",  expander = gh, lazy = false }, -- needs nix
	-----------------------------------
	------ Lua / self-referential -----
	-----------------------------------
	["structlog"]                                = { id = "Tastyep/structlog.nvim",        expander = gh, lazy = false }, -- needs nix
	["neorepl"]                                  = { id = "ii14/neorepl.nvim",             expander = gh, lazy = false }, -- needs nix
}

local add_plugin = function(name)
	local cfg = PLUGIN_DECLARATION[name]
	vim.pack.add({ { src = cfg.expander(cfg.id) } })
end

for _, name in ipairs(PLUGINS) do
	add_plugin(name)
end
```

## dependencies.lua

```lua
local M = {
   ["nvim-navbuddy"] = { "nui" },
   yazi = { "plenary" },
}
return M

```

## external_tools.lua

```lua
local M = {
   ruff = {
      path = "~/homebrew/bin/ruff",
      version = "0.14.14",
   },
   mypy = {
      path = "~/.pyenv/shims/mypy",
      version = "1.19.1",
   },
   pyright = {
      path = "~/homebrew/bin/pyright",
      version = "1.1.407",
   },
}
return M

```

## plugin_locations.lua

```lua
M = {
    ['oil.nvim'] = { path = "/nix/store/asdfsdfgkjasdhlkfjsadlkjalskh" },
    ['blink.cmp'] = { path = "/nix/store/asdfsdfgkjasdhlkasdffjsadlkjalskh" },
}
return M
```

## plugin_layers.lua

```lua
local plugins_by_layer = {
   [-1] = {
      [-1] = { "nvim-teal-maker" },
   },
   [0] = {
      [-1] = { "nui", "pathlib", "commons", "nvim-api-wrappers", "nvim-web-devicons", "nio", "plenary", "cosmic-ui", "cmdTree" },
      [0] = { "bafa", "nvim-treesitter-context", "treesitter-modules", "lualine", "cokeline", "statuscol", "nvim-navbuddy", "windline", "winbar", "virtcolumn", "illuminate", "nougat", "dropbar", "barbar", "TreePin", "galaxyline", "bufferline", "bamboo", "symbols", "staline", "smartcolumn", "minibar", "nvim-navic", "aerial", "nvim-treesitter", "heirline", "otter", "heirline-components" },
      [1] = { "neo-tree", "chadtree", "nvim-tree", "yazi", "oil", "telescope-file-browser" },
      [2] = { "ido", "pickme", "telescope-json-history", "telescope-repo", "deck", "telescope-smart-history", "telescope", "fzf-lua", "telescope-fzf-native" },
      [3] = { "blink", "snacks", "mini" },
      [4] = { "hlslens", "hlsearch", "clever-f.vim" },
      [5] = { "substitute", "nvim-rip-substitute", "spectre", "replacer", "ssr", "renamer", "grug-far", "inc-rename", "muren", "search-replace", "sad" },
      [6] = { "flybuf", "vuffers.nvim", "retrospect", "swm", "nvim_winpick", "windows", "stickybuf", "pragma.nvim" },
      [7] = { "smart-splits" },
   },
   [1] = {
      [-1] = { "leap", "ufo", "flash", "hydra", "multicursors", "mini.align", "indentmini", "whaler", "beam", "zpragmatic", "todo-comments", "vim-visual-multi", "nvim-surround", "vim-multiple-cursors", "lazyclip", "spider", "anydent", "nvim-various-textobjs", "vim-wordmotion", "unimpaired-which-key", "apm", "sort", "splitjoin.vim", "pasta", "splitjoin", "nvim-autopairs", "wf", "nvim-treesitter-textobjects", "mini.keymap", "treemonkey", "minimal-narrow-region", "vim-surround", "tabular", "keymapper", "vim-mundo", "spread", "wildfire", "indent-tools", "savior", "NeoComposer", "ax", "hop", "date-time-inserter", "moveline", "Comment", "neowords", "wrapping", "dotdot", "markit", "keytex", "rainbow-delimiters", "arrow", "vim-caser", "hierarchy", "which-key", "bullets", "blink.pairs", "dial", "navigator.lua", "yanky", "marks", "recorder", "vim-sandwich", "insx", "wastebin", "indent-blankline", "keylab", "keyseer", "vim-commentary", "vim-edgemotion", "vim-auto-save", "xkbswitch", "homerows", "vim-abolish", "harpoon-core", "spear", "wrapping-paper", "treesj", "switch.vim", "ts-context-commentstring", "nvim-macros", "showkeys", "nvim-whichkey-setup.lua", "cyrillic", "AdvancedNewFile" },
   },
   [2] = {
      [-1] = { "cmp-nvim-telekasten-tags", "cmp_bulma", "debugpy", "control-panel", "LuaSnip", "diagflow", "sortjson", "quicktype", "corn", "lazydev", "jvim", "pylsp-rope", "haskell-tools", "tree-sitter-just", "lightbulb", "crates", "jsonpath", "nvim-cmp-lua-latex-symbols", "yaml", "inlayhint-filler", "friendly-snippets", "lsp_signature", "error-jump", "ultisnips", "lspsaga", "lspkind", "dmap", "nvim-cmp-fonts", "lsp-format", "cmp-buffer", "rustaceanvim", "none-ls", "cmp", "cmp-cmdline", "efm", "ivy", "output-panel", "telescope-code-actions", "doc-window", "cmp-nvim-lsp-signature-help", "cmp-nvim-lsp", "cmp-path", "blink.cmp" },
   },
   [3] = {
      [0] = { "conform", "strict", "guard" },
   },
   [4] = {
      [-1] = { "code_runner", "coverage", "vim-floaterm", "xmake", "jaq-nvim", "termim", "neotest-haskell", "mypy", "actions-preview", "moonicipal", "live-command", "telemake", "quicker", "glance", "neotest-python", "dapui", "overseer", "bqf", "equals", "cmdbuf", "dap-python", "resin", "yabs", "channelot", "neotest", "repl", "nvim-dap-virtual-text", "trouble", "dap", "vim-slime", "compiler", "telescope-xc", "neomux", "neaterm", "conjure", "yarepl", "asyncrun", "tracebundler", "Launch", "sniprun", "lint" },
   },
   [5] = {
      [-1] = { "refactoring", "monorepos", "project", "projector", "telescope-project" },
   },
   [6] = {
      [-1] = { "jujutsu", "gitsigns", "jiejie", "gitlab-nvim", "forgit", "octo", "gitlab", "advanced-git-search", "g-worktree", "blame", "neogit", "octohub", "lazygit", "jj", "vim-fugitive", "git-conflict", "diffview", "telescope-github" },
   },
   [7] = {
      [-1] = { "bye-nerdfont", "persistence", "reactive", "modicator", "shade", "lvim-ui-config", "notify", "dashboard-nvim", "zen-mode", "modes", "auto-session", "fidget", "menu", "headlines", "sunglasses", "fsplash", "volt", "dashboard", "vimade", "noice" },
   },
   [8] = {
      [-1] = { "render-markdown", "flashcards", "neotest-plenary", "nvim-mail-merge", "tldr", "firenvim", "vale", "endpoint-previewer", "regexplainer", "web-tools", "vim-helm", "kubels", "present", "panvimdoc", "knap", "feed", "markdown-preview", "nerdy", "license", "structlog", "color-picker", "kreative", "kpops", "regex-vars", "ltex_extra", "drop", "nvim-highlight-colors", "qalc", "vimtex", "better-digraphs", "http-codes", "Hypersonic", "texmagic", "vim-pug", "auto-pandoc", "pre-commit", "neorepl", "kubernetes", "fsread", "paint", "schemastore", "Calendar", "live-server", "easycolor", "interlaced", "export-colorscheme", "runtimetable", "k8vim", "kubectl", "minty", "text-to-colorscheme", "urlview" },
   },
   [9] = {
      [0] = { "llm", "codecompanion", "sg", "vim-ai", "avante" },
   },
   [10] = {
      [0] = { "timew", "neorg-taskwarrior", "nomodoro", "twig", "obsidian", "doing", "daily-focus", "tdo", "sche", "orgmode", "metrics", "timerly", "baleia", "pommodoro-clock", "tktodo", "vim-twig", "zettelkasten", "pomodoro" },
      [1] = { "scratch-buffer", "flote", "neorg", "vimwiki", "quicknote" },
      [2] = { "edit-list" },
   },
}
return plugins_by_layer

```

## plugin_paths.lua

```lua
local M = {
   ["nvim-teal-maker"] = "/Users/ext_riley/.local/share/nvim-plugins/nvim-teal-maker",
   ["plenary"] = "/Users/ext_riley/.local/share/nvim-plugins/plenary",
   ["nio"] = "/Users/ext_riley/.local/share/nvim-plugins/nio",
   ["nvim-web-devicons"] = "/Users/ext_riley/.local/share/nvim-plugins/nvim-web-devicons",
   ["nui"] = "/Users/ext_riley/.local/share/nvim-plugins/nui",
   ["cosmic-ui"] = "/Users/ext_riley/.local/share/nvim-plugins/cosmic-ui",
   ["commons"] = "/Users/ext_riley/.local/share/nvim-plugins/commons",
   ["nvim-api-wrappers"] = "/Users/ext_riley/.local/share/nvim-plugins/nvim-api-wrappers",
   ["pathlib"] = "/Users/ext_riley/.local/share/nvim-plugins/pathlib",
   ["cmdTree"] = "/Users/ext_riley/.local/share/nvim-plugins/cmdTree",
   ["bamboo"] = "/Users/ext_riley/.local/share/nvim-plugins/bamboo",
   ["illuminate"] = "/Users/ext_riley/.local/share/nvim-plugins/illuminate",
   ["lualine"] = "/Users/ext_riley/.local/share/nvim-plugins/lualine",
   ["nvim-navic"] = "/Users/ext_riley/.local/share/nvim-plugins/nvim-navic",
   ["nvim-treesitter"] = "/Users/ext_riley/.local/share/nvim-plugins/nvim-treesitter",
   ["otter"] = "/Users/ext_riley/.local/share/nvim-plugins/otter",
   ["treesitter-modules"] = "/Users/ext_riley/.local/share/nvim-plugins/treesitter-modules",
   ["dropbar"] = "/Users/ext_riley/.local/share/nvim-plugins/dropbar",
   ["aerial"] = "/Users/ext_riley/.local/share/nvim-plugins/aerial",
   ["symbols"] = "/Users/ext_riley/.local/share/nvim-plugins/symbols",
   ["nvim-treesitter-context"] = "/Users/ext_riley/.local/share/nvim-plugins/nvim-treesitter-context",
   ["TreePin"] = "/Users/ext_riley/.local/share/nvim-plugins/TreePin",
   ["statuscol"] = "/Users/ext_riley/.local/share/nvim-plugins/statuscol",
   ["smartcolumn"] = "/Users/ext_riley/.local/share/nvim-plugins/smartcolumn",
   ["virtcolumn"] = "/Users/ext_riley/.local/share/nvim-plugins/virtcolumn",
   ["bufferline"] = "/Users/ext_riley/.local/share/nvim-plugins/bufferline",
   ["galaxyline"] = "/Users/ext_riley/.local/share/nvim-plugins/galaxyline",
   ["heirline"] = "/Users/ext_riley/.local/share/nvim-plugins/heirline",
   ["heirline-components"] = "/Users/ext_riley/.local/share/nvim-plugins/heirline-components",
   ["staline"] = "/Users/ext_riley/.local/share/nvim-plugins/staline",
   ["nvim-navbuddy"] = "/Users/ext_riley/.local/share/nvim-plugins/nvim-navbuddy",
   ["nougat"] = "/Users/ext_riley/.local/share/nvim-plugins/nougat",
   ["winbar"] = "/Users/ext_riley/.local/share/nvim-plugins/winbar",
   ["minibar"] = "/Users/ext_riley/.local/share/nvim-plugins/minibar",
   ["bafa"] = "/Users/ext_riley/.local/share/nvim-plugins/bafa",
   ["windline"] = "/Users/ext_riley/.local/share/nvim-plugins/windline",
   ["barbar"] = "/Users/ext_riley/.local/share/nvim-plugins/barbar",
   ["cokeline"] = "/Users/ext_riley/.local/share/nvim-plugins/cokeline",
   ["oil"] = "/Users/ext_riley/.local/share/nvim-plugins/oil",
   ["yazi"] = "/Users/ext_riley/.local/share/nvim-plugins/yazi",
   ["neo-tree"] = "/Users/ext_riley/.local/share/nvim-plugins/neo-tree",
   ["nvim-tree"] = "/Users/ext_riley/.local/share/nvim-plugins/nvim-tree",
   ["chadtree"] = "/Users/ext_riley/.local/share/nvim-plugins/chadtree",
   ["telescope-file-browser"] = "/Users/ext_riley/.local/share/nvim-plugins/telescope-file-browser",
   ["pickme"] = "/Users/ext_riley/.local/share/nvim-plugins/pickme",
   ["telescope"] = "/Users/ext_riley/.local/share/nvim-plugins/telescope",
   ["telescope-fzf-native"] = "/Users/ext_riley/.local/share/nvim-plugins/telescope-fzf-native",
   ["fzf-lua"] = "/Users/ext_riley/.local/share/nvim-plugins/fzf-lua",
   ["deck"] = "/Users/ext_riley/.local/share/nvim-plugins/deck",
   ["ido"] = "/Users/ext_riley/.local/share/nvim-plugins/ido",
   ["telescope-smart-history"] = "/Users/ext_riley/.local/share/nvim-plugins/telescope-smart-history",
   ["telescope-repo"] = "/Users/ext_riley/.local/share/nvim-plugins/telescope-repo",
   ["telescope-json-history"] = "/Users/ext_riley/.local/share/nvim-plugins/telescope-json-history",
   ["mini"] = "/Users/ext_riley/.local/share/nvim-plugins/mini",
   ["snacks"] = "/Users/ext_riley/.local/share/nvim-plugins/snacks",
   ["blink"] = "/Users/ext_riley/.local/share/nvim-plugins/blink",
   ["hlslens"] = "/Users/ext_riley/.local/share/nvim-plugins/hlslens",
   ["hlsearch"] = "/Users/ext_riley/.local/share/nvim-plugins/hlsearch",
   ["clever-f.vim"] = "/Users/ext_riley/.local/share/nvim-plugins/clever-f.vim",
   ["grug-far"] = "/Users/ext_riley/.local/share/nvim-plugins/grug-far",
   ["spectre"] = "/Users/ext_riley/.local/share/nvim-plugins/spectre",
   ["nvim-rip-substitute"] = "/Users/ext_riley/.local/share/nvim-plugins/nvim-rip-substitute",
   ["inc-rename"] = "/Users/ext_riley/.local/share/nvim-plugins/inc-rename",
   ["search-replace"] = "/Users/ext_riley/.local/share/nvim-plugins/search-replace",
   ["ssr"] = "/Users/ext_riley/.local/share/nvim-plugins/ssr",
   ["sad"] = "/Users/ext_riley/.local/share/nvim-plugins/sad",
   ["substitute"] = "/Users/ext_riley/.local/share/nvim-plugins/substitute",
   ["replacer"] = "/Users/ext_riley/.local/share/nvim-plugins/replacer",
   ["renamer"] = "/Users/ext_riley/.local/share/nvim-plugins/renamer",
   ["muren"] = "/Users/ext_riley/.local/share/nvim-plugins/muren",
   ["nvim_winpick"] = "/Users/ext_riley/.local/share/nvim-plugins/nvim_winpick",
   ["flybuf"] = "/Users/ext_riley/.local/share/nvim-plugins/flybuf",
   ["stickybuf"] = "/Users/ext_riley/.local/share/nvim-plugins/stickybuf",
   ["swm"] = "/Users/ext_riley/.local/share/nvim-plugins/swm",
   ["retrospect"] = "/Users/ext_riley/.local/share/nvim-plugins/retrospect",
   ["vuffers.nvim"] = "/Users/ext_riley/.local/share/nvim-plugins/vuffers.nvim",
   ["pragma.nvim"] = "/Users/ext_riley/.local/share/nvim-plugins/pragma.nvim",
   ["windows"] = "/Users/ext_riley/.local/share/nvim-plugins/windows",
   ["smart-splits"] = "/Users/ext_riley/.local/share/nvim-plugins/smart-splits",
   ["ufo"] = "/Users/ext_riley/.local/share/nvim-plugins/ufo",
   ["NeoComposer"] = "/Users/ext_riley/.local/share/nvim-plugins/NeoComposer",
   ["nvim-macros"] = "/Users/ext_riley/.local/share/nvim-plugins/nvim-macros",
   ["recorder"] = "/Users/ext_riley/.local/share/nvim-plugins/recorder",
   ["vim-visual-multi"] = "/Users/ext_riley/.local/share/nvim-plugins/vim-visual-multi",
   ["multicursors"] = "/Users/ext_riley/.local/share/nvim-plugins/multicursors",
   ["vim-multiple-cursors"] = "/Users/ext_riley/.local/share/nvim-plugins/vim-multiple-cursors",
   ["wildfire"] = "/Users/ext_riley/.local/share/nvim-plugins/wildfire",
   ["sort"] = "/Users/ext_riley/.local/share/nvim-plugins/sort",
   ["leap"] = "/Users/ext_riley/.local/share/nvim-plugins/leap",
   ["flash"] = "/Users/ext_riley/.local/share/nvim-plugins/flash",
   ["hop"] = "/Users/ext_riley/.local/share/nvim-plugins/hop",
   ["neowords"] = "/Users/ext_riley/.local/share/nvim-plugins/neowords",
   ["spider"] = "/Users/ext_riley/.local/share/nvim-plugins/spider",
   ["vim-wordmotion"] = "/Users/ext_riley/.local/share/nvim-plugins/vim-wordmotion",
   ["vim-edgemotion"] = "/Users/ext_riley/.local/share/nvim-plugins/vim-edgemotion",
   ["treemonkey"] = "/Users/ext_riley/.local/share/nvim-plugins/treemonkey",
   ["hierarchy"] = "/Users/ext_riley/.local/share/nvim-plugins/hierarchy",
   ["navigator.lua"] = "/Users/ext_riley/.local/share/nvim-plugins/navigator.lua",
   ["rainbow-delimiters"] = "/Users/ext_riley/.local/share/nvim-plugins/rainbow-delimiters",
   ["nvim-autopairs"] = "/Users/ext_riley/.local/share/nvim-plugins/nvim-autopairs",
   ["blink.pairs"] = "/Users/ext_riley/.local/share/nvim-plugins/blink.pairs",
   ["vim-sandwich"] = "/Users/ext_riley/.local/share/nvim-plugins/vim-sandwich",
   ["nvim-surround"] = "/Users/ext_riley/.local/share/nvim-plugins/nvim-surround",
   ["vim-surround"] = "/Users/ext_riley/.local/share/nvim-plugins/vim-surround",
   ["vim-mundo"] = "/Users/ext_riley/.local/share/nvim-plugins/vim-mundo",
   ["mini.keymap"] = "/Users/ext_riley/.local/share/nvim-plugins/mini.keymap",
   ["hydra"] = "/Users/ext_riley/.local/share/nvim-plugins/hydra",
   ["insx"] = "/Users/ext_riley/.local/share/nvim-plugins/insx",
   ["which-key"] = "/Users/ext_riley/.local/share/nvim-plugins/which-key",
   ["apm"] = "/Users/ext_riley/.local/share/nvim-plugins/apm",
   ["unimpaired-which-key"] = "/Users/ext_riley/.local/share/nvim-plugins/unimpaired-which-key",
   ["nvim-whichkey-setup.lua"] = "/Users/ext_riley/.local/share/nvim-plugins/nvim-whichkey-setup.lua",
   ["keymapper"] = "/Users/ext_riley/.local/share/nvim-plugins/keymapper",
   ["keyseer"] = "/Users/ext_riley/.local/share/nvim-plugins/keyseer",
   ["keytex"] = "/Users/ext_riley/.local/share/nvim-plugins/keytex",
   ["showkeys"] = "/Users/ext_riley/.local/share/nvim-plugins/showkeys",
   ["keylab"] = "/Users/ext_riley/.local/share/nvim-plugins/keylab",
   ["xkbswitch"] = "/Users/ext_riley/.local/share/nvim-plugins/xkbswitch",
   ["cyrillic"] = "/Users/ext_riley/.local/share/nvim-plugins/cyrillic",
   ["homerows"] = "/Users/ext_riley/.local/share/nvim-plugins/homerows",
   ["wf"] = "/Users/ext_riley/.local/share/nvim-plugins/wf",
   ["indentmini"] = "/Users/ext_riley/.local/share/nvim-plugins/indentmini",
   ["indent-blankline"] = "/Users/ext_riley/.local/share/nvim-plugins/indent-blankline",
   ["anydent"] = "/Users/ext_riley/.local/share/nvim-plugins/anydent",
   ["mini.align"] = "/Users/ext_riley/.local/share/nvim-plugins/mini.align",
   ["tabular"] = "/Users/ext_riley/.local/share/nvim-plugins/tabular",
   ["indent-tools"] = "/Users/ext_riley/.local/share/nvim-plugins/indent-tools",
   ["nvim-treesitter-textobjects"] = "/Users/ext_riley/.local/share/nvim-plugins/nvim-treesitter-textobjects",
   ["nvim-various-textobjs"] = "/Users/ext_riley/.local/share/nvim-plugins/nvim-various-textobjs",
   ["Comment"] = "/Users/ext_riley/.local/share/nvim-plugins/Comment",
   ["ts-context-commentstring"] = "/Users/ext_riley/.local/share/nvim-plugins/ts-context-commentstring",
   ["todo-comments"] = "/Users/ext_riley/.local/share/nvim-plugins/todo-comments",
   ["vim-commentary"] = "/Users/ext_riley/.local/share/nvim-plugins/vim-commentary",
   ["treesj"] = "/Users/ext_riley/.local/share/nvim-plugins/treesj",
   ["splitjoin"] = "/Users/ext_riley/.local/share/nvim-plugins/splitjoin",
   ["splitjoin.vim"] = "/Users/ext_riley/.local/share/nvim-plugins/splitjoin.vim",
   ["spread"] = "/Users/ext_riley/.local/share/nvim-plugins/spread",
   ["dial"] = "/Users/ext_riley/.local/share/nvim-plugins/dial",
   ["switch.vim"] = "/Users/ext_riley/.local/share/nvim-plugins/switch.vim",
   ["harpoon-core"] = "/Users/ext_riley/.local/share/nvim-plugins/harpoon-core",
   ["marks"] = "/Users/ext_riley/.local/share/nvim-plugins/marks",
   ["markit"] = "/Users/ext_riley/.local/share/nvim-plugins/markit",
   ["spear"] = "/Users/ext_riley/.local/share/nvim-plugins/spear",
   ["arrow"] = "/Users/ext_riley/.local/share/nvim-plugins/arrow",
   ["whaler"] = "/Users/ext_riley/.local/share/nvim-plugins/whaler",
   ["pasta"] = "/Users/ext_riley/.local/share/nvim-plugins/pasta",
   ["wastebin"] = "/Users/ext_riley/.local/share/nvim-plugins/wastebin",
   ["lazyclip"] = "/Users/ext_riley/.local/share/nvim-plugins/lazyclip",
   ["yanky"] = "/Users/ext_riley/.local/share/nvim-plugins/yanky",
   ["moveline"] = "/Users/ext_riley/.local/share/nvim-plugins/moveline",
   ["wrapping"] = "/Users/ext_riley/.local/share/nvim-plugins/wrapping",
   ["wrapping-paper"] = "/Users/ext_riley/.local/share/nvim-plugins/wrapping-paper",
   ["savior"] = "/Users/ext_riley/.local/share/nvim-plugins/savior",
   ["zpragmatic"] = "/Users/ext_riley/.local/share/nvim-plugins/zpragmatic",
   ["vim-auto-save"] = "/Users/ext_riley/.local/share/nvim-plugins/vim-auto-save",
   ["beam"] = "/Users/ext_riley/.local/share/nvim-plugins/beam",
   ["vim-abolish"] = "/Users/ext_riley/.local/share/nvim-plugins/vim-abolish",
   ["ax"] = "/Users/ext_riley/.local/share/nvim-plugins/ax",
   ["AdvancedNewFile"] = "/Users/ext_riley/.local/share/nvim-plugins/AdvancedNewFile",
   ["dotdot"] = "/Users/ext_riley/.local/share/nvim-plugins/dotdot",
   ["minimal-narrow-region"] = "/Users/ext_riley/.local/share/nvim-plugins/minimal-narrow-region",
   ["date-time-inserter"] = "/Users/ext_riley/.local/share/nvim-plugins/date-time-inserter",
   ["bullets"] = "/Users/ext_riley/.local/share/nvim-plugins/bullets",
   ["vim-caser"] = "/Users/ext_riley/.local/share/nvim-plugins/vim-caser",
   ["blink.cmp"] = "/Users/ext_riley/.local/share/nvim-plugins/blink.cmp",
   ["cmp"] = "/Users/ext_riley/.local/share/nvim-plugins/cmp",
   ["lsp_signature"] = "/Users/ext_riley/.local/share/nvim-plugins/lsp_signature",
   ["inlayhint-filler"] = "/Users/ext_riley/.local/share/nvim-plugins/inlayhint-filler",
   ["ivy"] = "/Users/ext_riley/.local/share/nvim-plugins/ivy",
   ["friendly-snippets"] = "/Users/ext_riley/.local/share/nvim-plugins/friendly-snippets",
   ["ultisnips"] = "/Users/ext_riley/.local/share/nvim-plugins/ultisnips",
   ["LuaSnip"] = "/Users/ext_riley/.local/share/nvim-plugins/LuaSnip",
   ["cmp-nvim-lsp"] = "/Users/ext_riley/.local/share/nvim-plugins/cmp-nvim-lsp",
   ["cmp-buffer"] = "/Users/ext_riley/.local/share/nvim-plugins/cmp-buffer",
   ["cmp-path"] = "/Users/ext_riley/.local/share/nvim-plugins/cmp-path",
   ["cmp-cmdline"] = "/Users/ext_riley/.local/share/nvim-plugins/cmp-cmdline",
   ["nvim-cmp-fonts"] = "/Users/ext_riley/.local/share/nvim-plugins/nvim-cmp-fonts",
   ["nvim-cmp-lua-latex-symbols"] = "/Users/ext_riley/.local/share/nvim-plugins/nvim-cmp-lua-latex-symbols",
   ["cmp-nvim-telekasten-tags"] = "/Users/ext_riley/.local/share/nvim-plugins/cmp-nvim-telekasten-tags",
   ["cmp_bulma"] = "/Users/ext_riley/.local/share/nvim-plugins/cmp_bulma",
   ["lsp-format"] = "/Users/ext_riley/.local/share/nvim-plugins/lsp-format",
   ["lspkind"] = "/Users/ext_riley/.local/share/nvim-plugins/lspkind",
   ["efm"] = "/Users/ext_riley/.local/share/nvim-plugins/efm",
   ["output-panel"] = "/Users/ext_riley/.local/share/nvim-plugins/output-panel",
   ["control-panel"] = "/Users/ext_riley/.local/share/nvim-plugins/control-panel",
   ["lspsaga"] = "/Users/ext_riley/.local/share/nvim-plugins/lspsaga",
   ["cmp-nvim-lsp-signature-help"] = "/Users/ext_riley/.local/share/nvim-plugins/cmp-nvim-lsp-signature-help",
   ["corn"] = "/Users/ext_riley/.local/share/nvim-plugins/corn",
   ["diagflow"] = "/Users/ext_riley/.local/share/nvim-plugins/diagflow",
   ["error-jump"] = "/Users/ext_riley/.local/share/nvim-plugins/error-jump",
   ["doc-window"] = "/Users/ext_riley/.local/share/nvim-plugins/doc-window",
   ["lightbulb"] = "/Users/ext_riley/.local/share/nvim-plugins/lightbulb",
   ["telescope-code-actions"] = "/Users/ext_riley/.local/share/nvim-plugins/telescope-code-actions",
   ["dmap"] = "/Users/ext_riley/.local/share/nvim-plugins/dmap",
   ["lazydev"] = "/Users/ext_riley/.local/share/nvim-plugins/lazydev",
   ["rustaceanvim"] = "/Users/ext_riley/.local/share/nvim-plugins/rustaceanvim",
   ["crates"] = "/Users/ext_riley/.local/share/nvim-plugins/crates",
   ["haskell-tools"] = "/Users/ext_riley/.local/share/nvim-plugins/haskell-tools",
   ["debugpy"] = "/Users/ext_riley/.local/share/nvim-plugins/debugpy",
   ["pylsp-rope"] = "/Users/ext_riley/.local/share/nvim-plugins/pylsp-rope",
   ["jvim"] = "/Users/ext_riley/.local/share/nvim-plugins/jvim",
   ["jsonpath"] = "/Users/ext_riley/.local/share/nvim-plugins/jsonpath",
   ["sortjson"] = "/Users/ext_riley/.local/share/nvim-plugins/sortjson",
   ["quicktype"] = "/Users/ext_riley/.local/share/nvim-plugins/quicktype",
   ["yaml"] = "/Users/ext_riley/.local/share/nvim-plugins/yaml",
   ["tree-sitter-just"] = "/Users/ext_riley/.local/share/nvim-plugins/tree-sitter-just",
   ["none-ls"] = "/Users/ext_riley/.local/share/nvim-plugins/none-ls",
   ["guard"] = "/Users/ext_riley/.local/share/nvim-plugins/guard",
   ["conform"] = "/Users/ext_riley/.local/share/nvim-plugins/conform",
   ["strict"] = "/Users/ext_riley/.local/share/nvim-plugins/strict",
   ["overseer"] = "/Users/ext_riley/.local/share/nvim-plugins/overseer",
   ["asyncrun"] = "/Users/ext_riley/.local/share/nvim-plugins/asyncrun",
   ["compiler"] = "/Users/ext_riley/.local/share/nvim-plugins/compiler",
   ["code_runner"] = "/Users/ext_riley/.local/share/nvim-plugins/code_runner",
   ["sniprun"] = "/Users/ext_riley/.local/share/nvim-plugins/sniprun",
   ["yabs"] = "/Users/ext_riley/.local/share/nvim-plugins/yabs",
   ["jaq-nvim"] = "/Users/ext_riley/.local/share/nvim-plugins/jaq-nvim",
   ["moonicipal"] = "/Users/ext_riley/.local/share/nvim-plugins/moonicipal",
   ["conjure"] = "/Users/ext_riley/.local/share/nvim-plugins/conjure",
   ["telemake"] = "/Users/ext_riley/.local/share/nvim-plugins/telemake",
   ["equals"] = "/Users/ext_riley/.local/share/nvim-plugins/equals",
   ["telescope-xc"] = "/Users/ext_riley/.local/share/nvim-plugins/telescope-xc",
   ["resin"] = "/Users/ext_riley/.local/share/nvim-plugins/resin",
   ["vim-slime"] = "/Users/ext_riley/.local/share/nvim-plugins/vim-slime",
   ["repl"] = "/Users/ext_riley/.local/share/nvim-plugins/repl",
   ["yarepl"] = "/Users/ext_riley/.local/share/nvim-plugins/yarepl",
   ["channelot"] = "/Users/ext_riley/.local/share/nvim-plugins/channelot",
   ["xmake"] = "/Users/ext_riley/.local/share/nvim-plugins/xmake",
   ["live-command"] = "/Users/ext_riley/.local/share/nvim-plugins/live-command",
   ["cmdbuf"] = "/Users/ext_riley/.local/share/nvim-plugins/cmdbuf",
   ["actions-preview"] = "/Users/ext_riley/.local/share/nvim-plugins/actions-preview",
   ["neotest"] = "/Users/ext_riley/.local/share/nvim-plugins/neotest",
   ["coverage"] = "/Users/ext_riley/.local/share/nvim-plugins/coverage",
   ["neotest-haskell"] = "/Users/ext_riley/.local/share/nvim-plugins/neotest-haskell",
   ["neotest-python"] = "/Users/ext_riley/.local/share/nvim-plugins/neotest-python",
   ["mypy"] = "/Users/ext_riley/.local/share/nvim-plugins/mypy",
   ["lint"] = "/Users/ext_riley/.local/share/nvim-plugins/lint",
   ["dap-python"] = "/Users/ext_riley/.local/share/nvim-plugins/dap-python",
   ["dapui"] = "/Users/ext_riley/.local/share/nvim-plugins/dapui",
   ["nvim-dap-virtual-text"] = "/Users/ext_riley/.local/share/nvim-plugins/nvim-dap-virtual-text",
   ["dap"] = "/Users/ext_riley/.local/share/nvim-plugins/dap",
   ["Launch"] = "/Users/ext_riley/.local/share/nvim-plugins/Launch",
   ["tracebundler"] = "/Users/ext_riley/.local/share/nvim-plugins/tracebundler",
   ["trouble"] = "/Users/ext_riley/.local/share/nvim-plugins/trouble",
   ["quicker"] = "/Users/ext_riley/.local/share/nvim-plugins/quicker",
   ["bqf"] = "/Users/ext_riley/.local/share/nvim-plugins/bqf",
   ["glance"] = "/Users/ext_riley/.local/share/nvim-plugins/glance",
   ["vim-floaterm"] = "/Users/ext_riley/.local/share/nvim-plugins/vim-floaterm",
   ["termim"] = "/Users/ext_riley/.local/share/nvim-plugins/termim",
   ["neaterm"] = "/Users/ext_riley/.local/share/nvim-plugins/neaterm",
   ["neomux"] = "/Users/ext_riley/.local/share/nvim-plugins/neomux",
   ["refactoring"] = "/Users/ext_riley/.local/share/nvim-plugins/refactoring",
   ["telescope-project"] = "/Users/ext_riley/.local/share/nvim-plugins/telescope-project",
   ["project"] = "/Users/ext_riley/.local/share/nvim-plugins/project",
   ["monorepos"] = "/Users/ext_riley/.local/share/nvim-plugins/monorepos",
   ["projector"] = "/Users/ext_riley/.local/share/nvim-plugins/projector",
   ["advanced-git-search"] = "/Users/ext_riley/.local/share/nvim-plugins/advanced-git-search",
   ["blame"] = "/Users/ext_riley/.local/share/nvim-plugins/blame",
   ["forgit"] = "/Users/ext_riley/.local/share/nvim-plugins/forgit",
   ["jj"] = "/Users/ext_riley/.local/share/nvim-plugins/jj",
   ["jujutsu"] = "/Users/ext_riley/.local/share/nvim-plugins/jujutsu",
   ["lazygit"] = "/Users/ext_riley/.local/share/nvim-plugins/lazygit",
   ["git-conflict"] = "/Users/ext_riley/.local/share/nvim-plugins/git-conflict",
   ["neogit"] = "/Users/ext_riley/.local/share/nvim-plugins/neogit",
   ["jiejie"] = "/Users/ext_riley/.local/share/nvim-plugins/jiejie",
   ["diffview"] = "/Users/ext_riley/.local/share/nvim-plugins/diffview",
   ["gitsigns"] = "/Users/ext_riley/.local/share/nvim-plugins/gitsigns",
   ["vim-fugitive"] = "/Users/ext_riley/.local/share/nvim-plugins/vim-fugitive",
   ["g-worktree"] = "/Users/ext_riley/.local/share/nvim-plugins/g-worktree",
   ["octo"] = "/Users/ext_riley/.local/share/nvim-plugins/octo",
   ["gitlab-nvim"] = "/Users/ext_riley/.local/share/nvim-plugins/gitlab-nvim",
   ["gitlab"] = "/Users/ext_riley/.local/share/nvim-plugins/gitlab",
   ["octohub"] = "/Users/ext_riley/.local/share/nvim-plugins/octohub",
   ["telescope-github"] = "/Users/ext_riley/.local/share/nvim-plugins/telescope-github",
   ["dashboard-nvim"] = "/Users/ext_riley/.local/share/nvim-plugins/dashboard-nvim",
   ["dashboard"] = "/Users/ext_riley/.local/share/nvim-plugins/dashboard",
   ["noice"] = "/Users/ext_riley/.local/share/nvim-plugins/noice",
   ["modes"] = "/Users/ext_riley/.local/share/nvim-plugins/modes",
   ["lvim-ui-config"] = "/Users/ext_riley/.local/share/nvim-plugins/lvim-ui-config",
   ["volt"] = "/Users/ext_riley/.local/share/nvim-plugins/volt",
   ["menu"] = "/Users/ext_riley/.local/share/nvim-plugins/menu",
   ["bye-nerdfont"] = "/Users/ext_riley/.local/share/nvim-plugins/bye-nerdfont",
   ["reactive"] = "/Users/ext_riley/.local/share/nvim-plugins/reactive",
   ["modicator"] = "/Users/ext_riley/.local/share/nvim-plugins/modicator",
   ["fsplash"] = "/Users/ext_riley/.local/share/nvim-plugins/fsplash",
   ["fidget"] = "/Users/ext_riley/.local/share/nvim-plugins/fidget",
   ["notify"] = "/Users/ext_riley/.local/share/nvim-plugins/notify",
   ["headlines"] = "/Users/ext_riley/.local/share/nvim-plugins/headlines",
   ["auto-session"] = "/Users/ext_riley/.local/share/nvim-plugins/auto-session",
   ["persistence"] = "/Users/ext_riley/.local/share/nvim-plugins/persistence",
   ["shade"] = "/Users/ext_riley/.local/share/nvim-plugins/shade",
   ["zen-mode"] = "/Users/ext_riley/.local/share/nvim-plugins/zen-mode",
   ["sunglasses"] = "/Users/ext_riley/.local/share/nvim-plugins/sunglasses",
   ["vimade"] = "/Users/ext_riley/.local/share/nvim-plugins/vimade",
   ["runtimetable"] = "/Users/ext_riley/.local/share/nvim-plugins/runtimetable",
   ["schemastore"] = "/Users/ext_riley/.local/share/nvim-plugins/schemastore",
   ["firenvim"] = "/Users/ext_riley/.local/share/nvim-plugins/firenvim",
   ["render-markdown"] = "/Users/ext_riley/.local/share/nvim-plugins/render-markdown",
   ["markdown-preview"] = "/Users/ext_riley/.local/share/nvim-plugins/markdown-preview",
   ["web-tools"] = "/Users/ext_riley/.local/share/nvim-plugins/web-tools",
   ["vim-pug"] = "/Users/ext_riley/.local/share/nvim-plugins/vim-pug",
   ["Calendar"] = "/Users/ext_riley/.local/share/nvim-plugins/Calendar",
   ["http-codes"] = "/Users/ext_riley/.local/share/nvim-plugins/http-codes",
   ["auto-pandoc"] = "/Users/ext_riley/.local/share/nvim-plugins/auto-pandoc",
   ["panvimdoc"] = "/Users/ext_riley/.local/share/nvim-plugins/panvimdoc",
   ["vale"] = "/Users/ext_riley/.local/share/nvim-plugins/vale",
   ["present"] = "/Users/ext_riley/.local/share/nvim-plugins/present",
   ["flashcards"] = "/Users/ext_riley/.local/share/nvim-plugins/flashcards",
   ["license"] = "/Users/ext_riley/.local/share/nvim-plugins/license",
   ["live-server"] = "/Users/ext_riley/.local/share/nvim-plugins/live-server",
   ["nvim-mail-merge"] = "/Users/ext_riley/.local/share/nvim-plugins/nvim-mail-merge",
   ["better-digraphs"] = "/Users/ext_riley/.local/share/nvim-plugins/better-digraphs",
   ["qalc"] = "/Users/ext_riley/.local/share/nvim-plugins/qalc",
   ["tldr"] = "/Users/ext_riley/.local/share/nvim-plugins/tldr",
   ["pre-commit"] = "/Users/ext_riley/.local/share/nvim-plugins/pre-commit",
   ["endpoint-previewer"] = "/Users/ext_riley/.local/share/nvim-plugins/endpoint-previewer",
   ["fsread"] = "/Users/ext_riley/.local/share/nvim-plugins/fsread",
   ["feed"] = "/Users/ext_riley/.local/share/nvim-plugins/feed",
   ["nerdy"] = "/Users/ext_riley/.local/share/nvim-plugins/nerdy",
   ["knap"] = "/Users/ext_riley/.local/share/nvim-plugins/knap",
   ["urlview"] = "/Users/ext_riley/.local/share/nvim-plugins/urlview",
   ["interlaced"] = "/Users/ext_riley/.local/share/nvim-plugins/interlaced",
   ["texmagic"] = "/Users/ext_riley/.local/share/nvim-plugins/texmagic",
   ["vimtex"] = "/Users/ext_riley/.local/share/nvim-plugins/vimtex",
   ["ltex_extra"] = "/Users/ext_riley/.local/share/nvim-plugins/ltex_extra",
   ["drop"] = "/Users/ext_riley/.local/share/nvim-plugins/drop",
   ["regex-vars"] = "/Users/ext_riley/.local/share/nvim-plugins/regex-vars",
   ["regexplainer"] = "/Users/ext_riley/.local/share/nvim-plugins/regexplainer",
   ["Hypersonic"] = "/Users/ext_riley/.local/share/nvim-plugins/Hypersonic",
   ["structlog"] = "/Users/ext_riley/.local/share/nvim-plugins/structlog",
   ["neorepl"] = "/Users/ext_riley/.local/share/nvim-plugins/neorepl",
   ["neotest-plenary"] = "/Users/ext_riley/.local/share/nvim-plugins/neotest-plenary",
   ["minty"] = "/Users/ext_riley/.local/share/nvim-plugins/minty",
   ["color-picker"] = "/Users/ext_riley/.local/share/nvim-plugins/color-picker",
   ["export-colorscheme"] = "/Users/ext_riley/.local/share/nvim-plugins/export-colorscheme",
   ["kreative"] = "/Users/ext_riley/.local/share/nvim-plugins/kreative",
   ["text-to-colorscheme"] = "/Users/ext_riley/.local/share/nvim-plugins/text-to-colorscheme",
   ["easycolor"] = "/Users/ext_riley/.local/share/nvim-plugins/easycolor",
   ["paint"] = "/Users/ext_riley/.local/share/nvim-plugins/paint",
   ["nvim-highlight-colors"] = "/Users/ext_riley/.local/share/nvim-plugins/nvim-highlight-colors",
   ["kubels"] = "/Users/ext_riley/.local/share/nvim-plugins/kubels",
   ["kubernetes"] = "/Users/ext_riley/.local/share/nvim-plugins/kubernetes",
   ["kpops"] = "/Users/ext_riley/.local/share/nvim-plugins/kpops",
   ["k8vim"] = "/Users/ext_riley/.local/share/nvim-plugins/k8vim",
   ["kubectl"] = "/Users/ext_riley/.local/share/nvim-plugins/kubectl",
   ["vim-helm"] = "/Users/ext_riley/.local/share/nvim-plugins/vim-helm",
   ["avante"] = "/Users/ext_riley/.local/share/nvim-plugins/avante",
   ["vim-ai"] = "/Users/ext_riley/.local/share/nvim-plugins/vim-ai",
   ["codecompanion"] = "/Users/ext_riley/.local/share/nvim-plugins/codecompanion",
   ["llm"] = "/Users/ext_riley/.local/share/nvim-plugins/llm",
   ["sg"] = "/Users/ext_riley/.local/share/nvim-plugins/sg",
   ["metrics"] = "/Users/ext_riley/.local/share/nvim-plugins/metrics",
   ["orgmode"] = "/Users/ext_riley/.local/share/nvim-plugins/orgmode",
   ["twig"] = "/Users/ext_riley/.local/share/nvim-plugins/twig",
   ["neorg-taskwarrior"] = "/Users/ext_riley/.local/share/nvim-plugins/neorg-taskwarrior",
   ["doing"] = "/Users/ext_riley/.local/share/nvim-plugins/doing",
   ["daily-focus"] = "/Users/ext_riley/.local/share/nvim-plugins/daily-focus",
   ["nomodoro"] = "/Users/ext_riley/.local/share/nvim-plugins/nomodoro",
   ["pommodoro-clock"] = "/Users/ext_riley/.local/share/nvim-plugins/pommodoro-clock",
   ["baleia"] = "/Users/ext_riley/.local/share/nvim-plugins/baleia",
   ["timew"] = "/Users/ext_riley/.local/share/nvim-plugins/timew",
   ["pomodoro"] = "/Users/ext_riley/.local/share/nvim-plugins/pomodoro",
   ["tdo"] = "/Users/ext_riley/.local/share/nvim-plugins/tdo",
   ["tktodo"] = "/Users/ext_riley/.local/share/nvim-plugins/tktodo",
   ["zettelkasten"] = "/Users/ext_riley/.local/share/nvim-plugins/zettelkasten",
   ["obsidian"] = "/Users/ext_riley/.local/share/nvim-plugins/obsidian",
   ["vim-twig"] = "/Users/ext_riley/.local/share/nvim-plugins/vim-twig",
   ["timerly"] = "/Users/ext_riley/.local/share/nvim-plugins/timerly",
   ["sche"] = "/Users/ext_riley/.local/share/nvim-plugins/sche",
   ["vimwiki"] = "/Users/ext_riley/.local/share/nvim-plugins/vimwiki",
   ["flote"] = "/Users/ext_riley/.local/share/nvim-plugins/flote",
   ["neorg"] = "/Users/ext_riley/.local/share/nvim-plugins/neorg",
   ["quicknote"] = "/Users/ext_riley/.local/share/nvim-plugins/quicknote",
   ["scratch-buffer"] = "/Users/ext_riley/.local/share/nvim-plugins/scratch-buffer",
   ["edit-list"] = "/Users/ext_riley/.local/share/nvim-plugins/edit-list",
}
return M

```

## plugin_paths.lua (alt)

```lua
M = {
    ["plenary"] = "/Users/ext_riley/.local/share/nvim-plugins/plenary"
	["nio"] = "/Users/ext_riley/.local/share/nvim-plugins/nio"
	["nvim-web-devicons"] = "/Users/ext_riley/.local/share/nvim-plugins/nvim-web-devicons"
	["nui"] = "/Users/ext_riley/.local/share/nvim-plugins/nui"
	["bamboo"] = "/Users/ext_riley/.local/share/nvim-plugins/bamboo"
	["zen-mode"] = "/Users/ext_riley/.local/share/nvim-plugins/zen-mode"
	["illuminate"] = "/Users/ext_riley/.local/share/nvim-plugins/illuminate"
	["lualine"] = "/Users/ext_riley/.local/share/nvim-plugins/lualine"
	["nvim-navic"] = "/Users/ext_riley/.local/share/nvim-plugins/nvim-navic"
	["bufferline"] = "/Users/ext_riley/.local/share/nvim-plugins/bufferline"
	["statuscol"] = "/Users/ext_riley/.local/share/nvim-plugins/statuscol"
	["nvim-treesitter"] = "/Users/ext_riley/.local/share/nvim-plugins/nvim-treesitter"
	["treesitter-modules"] = "/Users/ext_riley/.local/share/nvim-plugins/treesitter-modules"
	["dropbar"] = "/Users/ext_riley/.local/share/nvim-plugins/dropbar"
	["nvim-navbuddy"] = "/Users/ext_riley/.local/share/nvim-plugins/nvim-navbuddy"
	["aerial"] = "/Users/ext_riley/.local/share/nvim-plugins/aerial"
	["oil"] = "/Users/ext_riley/.local/share/nvim-plugins/oil"
	["yazi"] = "/Users/ext_riley/.local/share/nvim-plugins/yazi"
	["neo-tree"] = "/Users/ext_riley/.local/share/nvim-plugins/neo-tree"
	["nvim-tree"] = "/Users/ext_riley/.local/share/nvim-plugins/nvim-tree"
	["pickme"] = "/Users/ext_riley/.local/share/nvim-plugins/pickme"
	["telescope"] = "/Users/ext_riley/.local/share/nvim-plugins/telescope"
	["telescope-fzf-native"] = "/Users/ext_riley/.local/share/nvim-plugins/telescope-fzf-native"
	["fzf-lua"] = "/Users/ext_riley/.local/share/nvim-plugins/fzf-lua"
	["deck"] = "/Users/ext_riley/.local/share/nvim-plugins/deck"
	["mini"] = "/Users/ext_riley/.local/share/nvim-plugins/mini"
	["snacks"] = "/Users/ext_riley/.local/share/nvim-plugins/snacks"
	["blink"] = "/Users/ext_riley/.local/share/nvim-plugins/blink"
	["hlslens"] = "/Users/ext_riley/.local/share/nvim-plugins/hlslens"
	["hlsearch"] = "/Users/ext_riley/.local/share/nvim-plugins/hlsearch"
	["grug-far"] = "/Users/ext_riley/.local/share/nvim-plugins/grug-far"
	["spectre"] = "/Users/ext_riley/.local/share/nvim-plugins/spectre"
	["nvim_winpick"] = "/Users/ext_riley/.local/share/nvim-plugins/nvim_winpick"
	["flybuf"] = "/Users/ext_riley/.local/share/nvim-plugins/flybuf"
	["stickybuf"] = "/Users/ext_riley/.local/share/nvim-plugins/stickybuf"
	["swm"] = "/Users/ext_riley/.local/share/nvim-plugins/swm"
	["smart-splits"] = "/Users/ext_riley/.local/share/nvim-plugins/smart-splits"
	["ufo"] = "/Users/ext_riley/.local/share/nvim-plugins/ufo"
	["NeoComposer"] = "/Users/ext_riley/.local/share/nvim-plugins/NeoComposer"
	["nvim-macros"] = "/Users/ext_riley/.local/share/nvim-plugins/nvim-macros"
	["recorder"] = "/Users/ext_riley/.local/share/nvim-plugins/recorder"
	["vim-visual-multi"] = "/Users/ext_riley/.local/share/nvim-plugins/vim-visual-multi"
	["leap"] = "/Users/ext_riley/.local/share/nvim-plugins/leap"
	["flash"] = "/Users/ext_riley/.local/share/nvim-plugins/flash"
	["hop"] = "/Users/ext_riley/.local/share/nvim-plugins/hop"
	["rainbow-delimiters"] = "/Users/ext_riley/.local/share/nvim-plugins/rainbow-delimiters"
	["nvim-autopairs"] = "/Users/ext_riley/.local/share/nvim-plugins/nvim-autopairs"
	["blink.pairs"] = "/Users/ext_riley/.local/share/nvim-plugins/blink.pairs"
	["vim-sandwich"] = "/Users/ext_riley/.local/share/nvim-plugins/vim-sandwich"
	["surround"] = "/Users/ext_riley/.local/share/nvim-plugins/surround"
	["vim-mundo"] = "/Users/ext_riley/.local/share/nvim-plugins/vim-mundo"
	["mini.keymap"] = "/Users/ext_riley/.local/share/nvim-plugins/mini.keymap"
	["hydra"] = "/Users/ext_riley/.local/share/nvim-plugins/hydra"
	["nvim-insx"] = "/Users/ext_riley/.local/share/nvim-plugins/nvim-insx"
	["which-key"] = "/Users/ext_riley/.local/share/nvim-plugins/which-key"
	["indentmini"] = "/Users/ext_riley/.local/share/nvim-plugins/indentmini"
	["indent-blankline"] = "/Users/ext_riley/.local/share/nvim-plugins/indent-blankline"
	["nvim-anydent"] = "/Users/ext_riley/.local/share/nvim-plugins/nvim-anydent"
	["mini.align"] = "/Users/ext_riley/.local/share/nvim-plugins/mini.align"
	["tabular"] = "/Users/ext_riley/.local/share/nvim-plugins/tabular"
	["nvim-treesitter-textobjects"] = "/Users/ext_riley/.local/share/nvim-plugins/nvim-treesitter-textobjects"
	["nvim-various-textobjs"] = "/Users/ext_riley/.local/share/nvim-plugins/nvim-various-textobjs"
	["Comment"] = "/Users/ext_riley/.local/share/nvim-plugins/Comment"
	["todo-comments"] = "/Users/ext_riley/.local/share/nvim-plugins/todo-comments"
	["vim-commentary"] = "/Users/ext_riley/.local/share/nvim-plugins/vim-commentary"
	["treesj"] = "/Users/ext_riley/.local/share/nvim-plugins/treesj"
	["dial"] = "/Users/ext_riley/.local/share/nvim-plugins/dial"
	["harpoon-core"] = "/Users/ext_riley/.local/share/nvim-plugins/harpoon-core"
	["marks"] = "/Users/ext_riley/.local/share/nvim-plugins/marks"
	["markit"] = "/Users/ext_riley/.local/share/nvim-plugins/markit"
	["nvim-pasta"] = "/Users/ext_riley/.local/share/nvim-plugins/nvim-pasta"
	["beam"] = "/Users/ext_riley/.local/share/nvim-plugins/beam"
	["blink.cmp"] = "/Users/ext_riley/.local/share/nvim-plugins/blink.cmp"
	["nvim-cmp"] = "/Users/ext_riley/.local/share/nvim-plugins/nvim-cmp"
	["friendly-snippets"] = "/Users/ext_riley/.local/share/nvim-plugins/friendly-snippets"
	["ultisnips"] = "/Users/ext_riley/.local/share/nvim-plugins/ultisnips"
	["LuaSnip"] = "/Users/ext_riley/.local/share/nvim-plugins/LuaSnip"
	["cmp-nvim-lsp"] = "/Users/ext_riley/.local/share/nvim-plugins/cmp-nvim-lsp"
	["cmp-buffer"] = "/Users/ext_riley/.local/share/nvim-plugins/cmp-buffer"
	["cmp-path"] = "/Users/ext_riley/.local/share/nvim-plugins/cmp-path"
	["cmp-cmdline"] = "/Users/ext_riley/.local/share/nvim-plugins/cmp-cmdline"
	["lsp-format"] = "/Users/ext_riley/.local/share/nvim-plugins/lsp-format"
	["lspkind"] = "/Users/ext_riley/.local/share/nvim-plugins/lspkind"
	["efm"] = "/Users/ext_riley/.local/share/nvim-plugins/efm"
	["lspsaga"] = "/Users/ext_riley/.local/share/nvim-plugins/lspsaga"
	["lazydev"] = "/Users/ext_riley/.local/share/nvim-plugins/lazydev"
	["rustaceanvim"] = "/Users/ext_riley/.local/share/nvim-plugins/rustaceanvim"
	["crates"] = "/Users/ext_riley/.local/share/nvim-plugins/crates"
	["haskell-tools"] = "/Users/ext_riley/.local/share/nvim-plugins/haskell-tools"
	["none-ls"] = "/Users/ext_riley/.local/share/nvim-plugins/none-ls"
	["guard"] = "/Users/ext_riley/.local/share/nvim-plugins/guard"
	["conform"] = "/Users/ext_riley/.local/share/nvim-plugins/conform"
	["overseer"] = "/Users/ext_riley/.local/share/nvim-plugins/overseer"
	["asyncrun"] = "/Users/ext_riley/.local/share/nvim-plugins/asyncrun"
	["compiler"] = "/Users/ext_riley/.local/share/nvim-plugins/compiler"
	["code_runner"] = "/Users/ext_riley/.local/share/nvim-plugins/code_runner"
	["sniprun"] = "/Users/ext_riley/.local/share/nvim-plugins/sniprun"
	["yabs"] = "/Users/ext_riley/.local/share/nvim-plugins/yabs"
	["neotest-haskell"] = "/Users/ext_riley/.local/share/nvim-plugins/neotest-haskell"
	["neotest-python"] = "/Users/ext_riley/.local/share/nvim-plugins/neotest-python"
	["neotest"] = "/Users/ext_riley/.local/share/nvim-plugins/neotest"
	["dap-python"] = "/Users/ext_riley/.local/share/nvim-plugins/dap-python"
	["dapui"] = "/Users/ext_riley/.local/share/nvim-plugins/dapui"
	["nvim-dap-virtual-text"] = "/Users/ext_riley/.local/share/nvim-plugins/nvim-dap-virtual-text"
	["dap"] = "/Users/ext_riley/.local/share/nvim-plugins/dap"
	["mypy"] = "/Users/ext_riley/.local/share/nvim-plugins/mypy"
	["nvim-lint"] = "/Users/ext_riley/.local/share/nvim-plugins/nvim-lint"
	["trouble.nvim"] = "/Users/ext_riley/.local/share/nvim-plugins/trouble.nvim"
	["quicker"] = "/Users/ext_riley/.local/share/nvim-plugins/quicker"
	["nvim-bqf"] = "/Users/ext_riley/.local/share/nvim-plugins/nvim-bqf"
	["vim-floaterm"] = "/Users/ext_riley/.local/share/nvim-plugins/vim-floaterm"
	["refactoring"] = "/Users/ext_riley/.local/share/nvim-plugins/refactoring"
	["project"] = "/Users/ext_riley/.local/share/nvim-plugins/project"
	["telescope-project"] = "/Users/ext_riley/.local/share/nvim-plugins/telescope-project"
	["jj"] = "/Users/ext_riley/.local/share/nvim-plugins/jj"
	["jujutsu"] = "/Users/ext_riley/.local/share/nvim-plugins/jujutsu"
	["lazygit"] = "/Users/ext_riley/.local/share/nvim-plugins/lazygit"
	["git-conflict"] = "/Users/ext_riley/.local/share/nvim-plugins/git-conflict"
	["neogit"] = "/Users/ext_riley/.local/share/nvim-plugins/neogit"
	["jiejie"] = "/Users/ext_riley/.local/share/nvim-plugins/jiejie"
	["diffview"] = "/Users/ext_riley/.local/share/nvim-plugins/diffview"
	["gitsigns"] = "/Users/ext_riley/.local/share/nvim-plugins/gitsigns"
	["vim-fugitive"] = "/Users/ext_riley/.local/share/nvim-plugins/vim-fugitive"
	["octo"] = "/Users/ext_riley/.local/share/nvim-plugins/octo"
	["gitlab-nvim"] = "/Users/ext_riley/.local/share/nvim-plugins/gitlab-nvim"
	["gitlab"] = "/Users/ext_riley/.local/share/nvim-plugins/gitlab"
	["dashboard-nvim"] = "/Users/ext_riley/.local/share/nvim-plugins/dashboard-nvim"
	["dashboard"] = "/Users/ext_riley/.local/share/nvim-plugins/dashboard"
	["noice"] = "/Users/ext_riley/.local/share/nvim-plugins/noice"
	["modes"] = "/Users/ext_riley/.local/share/nvim-plugins/modes"
	["fidget"] = "/Users/ext_riley/.local/share/nvim-plugins/fidget"
	["nvim-notify"] = "/Users/ext_riley/.local/share/nvim-plugins/nvim-notify"
	["headlines"] = "/Users/ext_riley/.local/share/nvim-plugins/headlines"
	["auto-session"] = "/Users/ext_riley/.local/share/nvim-plugins/auto-session"
	["persistence"] = "/Users/ext_riley/.local/share/nvim-plugins/persistence"
	["vimtex"] = "/Users/ext_riley/.local/share/nvim-plugins/vimtex"
	["texmagic"] = "/Users/ext_riley/.local/share/nvim-plugins/texmagic"
	["schemastore"] = "/Users/ext_riley/.local/share/nvim-plugins/schemastore"
	["firenvim"] = "/Users/ext_riley/.local/share/nvim-plugins/firenvim"
	["render-markdown"] = "/Users/ext_riley/.local/share/nvim-plugins/render-markdown"
	["jupytext"] = "/Users/ext_riley/.local/share/nvim-plugins/jupytext"
	["quarto"] = "/Users/ext_riley/.local/share/nvim-plugins/quarto"
	["markdown-preview"] = "/Users/ext_riley/.local/share/nvim-plugins/markdown-preview"
	["structlog"] = "/Users/ext_riley/.local/share/nvim-plugins/structlog"
	["neorepl"] = "/Users/ext_riley/.local/share/nvim-plugins/neorepl"
}
return M
```

## plugin_paths.tl (Mac)

```lua
local paths: {string: string} = {
    ["nvim-teal-maker"] = "/Users/ext_riley/.local/share/nvim-plugins/nvim-teal-maker",
	["plenary"] = "/Users/ext_riley/.local/share/nvim-plugins/plenary",
	["nio"] = "/Users/ext_riley/.local/share/nvim-plugins/nio",
	["nvim-web-devicons"] = "/Users/ext_riley/.local/share/nvim-plugins/nvim-web-devicons",
	["nui"] = "/Users/ext_riley/.local/share/nvim-plugins/nui",
	["cosmic-ui"] = "/Users/ext_riley/.local/share/nvim-plugins/cosmic-ui",
	["commons"] = "/Users/ext_riley/.local/share/nvim-plugins/commons",
	["nvim-api-wrappers"] = "/Users/ext_riley/.local/share/nvim-plugins/nvim-api-wrappers",
	["pathlib"] = "/Users/ext_riley/.local/share/nvim-plugins/pathlib",
	["cmdTree"] = "/Users/ext_riley/.local/share/nvim-plugins/cmdTree",
	["bamboo"] = "/Users/ext_riley/.local/share/nvim-plugins/bamboo",
	["illuminate"] = "/Users/ext_riley/.local/share/nvim-plugins/illuminate",
	["lualine"] = "/Users/ext_riley/.local/share/nvim-plugins/lualine",
	["nvim-navic"] = "/Users/ext_riley/.local/share/nvim-plugins/nvim-navic",
	["nvim-treesitter"] = "/Users/ext_riley/.local/share/nvim-plugins/nvim-treesitter",
	["otter"] = "/Users/ext_riley/.local/share/nvim-plugins/otter",
	["treesitter-modules"] = "/Users/ext_riley/.local/share/nvim-plugins/treesitter-modules",
	["dropbar"] = "/Users/ext_riley/.local/share/nvim-plugins/dropbar",
	["aerial"] = "/Users/ext_riley/.local/share/nvim-plugins/aerial",
	["symbols"] = "/Users/ext_riley/.local/share/nvim-plugins/symbols",
	["nvim-treesitter-context"] = "/Users/ext_riley/.local/share/nvim-plugins/nvim-treesitter-context",
	["TreePin"] = "/Users/ext_riley/.local/share/nvim-plugins/TreePin",
	["statuscol"] = "/Users/ext_riley/.local/share/nvim-plugins/statuscol",
	["smartcolumn"] = "/Users/ext_riley/.local/share/nvim-plugins/smartcolumn",
	["virtcolumn"] = "/Users/ext_riley/.local/share/nvim-plugins/virtcolumn",
	["bufferline"] = "/Users/ext_riley/.local/share/nvim-plugins/bufferline",
	["galaxyline"] = "/Users/ext_riley/.local/share/nvim-plugins/galaxyline",
	["heirline"] = "/Users/ext_riley/.local/share/nvim-plugins/heirline",
	["heirline-components"] = "/Users/ext_riley/.local/share/nvim-plugins/heirline-components",
	["staline"] = "/Users/ext_riley/.local/share/nvim-plugins/staline",
	["nvim-navbuddy"] = "/Users/ext_riley/.local/share/nvim-plugins/nvim-navbuddy",
	["nougat"] = "/Users/ext_riley/.local/share/nvim-plugins/nougat",
	["winbar"] = "/Users/ext_riley/.local/share/nvim-plugins/winbar",
	["minibar"] = "/Users/ext_riley/.local/share/nvim-plugins/minibar",
	["bafa"] = "/Users/ext_riley/.local/share/nvim-plugins/bafa",
	["windline"] = "/Users/ext_riley/.local/share/nvim-plugins/windline",
	["barbar"] = "/Users/ext_riley/.local/share/nvim-plugins/barbar",
	["cokeline"] = "/Users/ext_riley/.local/share/nvim-plugins/cokeline",
	["oil"] = "/Users/ext_riley/.local/share/nvim-plugins/oil",
	["yazi"] = "/Users/ext_riley/.local/share/nvim-plugins/yazi",
	["neo-tree"] = "/Users/ext_riley/.local/share/nvim-plugins/neo-tree",
	["nvim-tree"] = "/Users/ext_riley/.local/share/nvim-plugins/nvim-tree",
	["chadtree"] = "/Users/ext_riley/.local/share/nvim-plugins/chadtree",
	["telescope-file-browser"] = "/Users/ext_riley/.local/share/nvim-plugins/telescope-file-browser",
	["pickme"] = "/Users/ext_riley/.local/share/nvim-plugins/pickme",
	["telescope"] = "/Users/ext_riley/.local/share/nvim-plugins/telescope",
	["telescope-fzf-native"] = "/Users/ext_riley/.local/share/nvim-plugins/telescope-fzf-native",
	["fzf-lua"] = "/Users/ext_riley/.local/share/nvim-plugins/fzf-lua",
	["deck"] = "/Users/ext_riley/.local/share/nvim-plugins/deck",
	["ido"] = "/Users/ext_riley/.local/share/nvim-plugins/ido",
	["telescope-smart-history"] = "/Users/ext_riley/.local/share/nvim-plugins/telescope-smart-history",
	["telescope-repo"] = "/Users/ext_riley/.local/share/nvim-plugins/telescope-repo",
	["telescope-json-history"] = "/Users/ext_riley/.local/share/nvim-plugins/telescope-json-history",
	["mini"] = "/Users/ext_riley/.local/share/nvim-plugins/mini",
	["snacks"] = "/Users/ext_riley/.local/share/nvim-plugins/snacks",
	["blink"] = "/Users/ext_riley/.local/share/nvim-plugins/blink",
	["hlslens"] = "/Users/ext_riley/.local/share/nvim-plugins/hlslens",
	["hlsearch"] = "/Users/ext_riley/.local/share/nvim-plugins/hlsearch",
	["clever-f.vim"] = "/Users/ext_riley/.local/share/nvim-plugins/clever-f.vim",
	["grug-far"] = "/Users/ext_riley/.local/share/nvim-plugins/grug-far",
	["spectre"] = "/Users/ext_riley/.local/share/nvim-plugins/spectre",
	["nvim-rip-substitute"] = "/Users/ext_riley/.local/share/nvim-plugins/nvim-rip-substitute",
	["inc-rename"] = "/Users/ext_riley/.local/share/nvim-plugins/inc-rename",
	["search-replace"] = "/Users/ext_riley/.local/share/nvim-plugins/search-replace",
	["ssr"] = "/Users/ext_riley/.local/share/nvim-plugins/ssr",
	["sad"] = "/Users/ext_riley/.local/share/nvim-plugins/sad",
	["substitute"] = "/Users/ext_riley/.local/share/nvim-plugins/substitute",
	["replacer"] = "/Users/ext_riley/.local/share/nvim-plugins/replacer",
	["renamer"] = "/Users/ext_riley/.local/share/nvim-plugins/renamer",
	["muren"] = "/Users/ext_riley/.local/share/nvim-plugins/muren",
	["nvim_winpick"] = "/Users/ext_riley/.local/share/nvim-plugins/nvim_winpick",
	["flybuf"] = "/Users/ext_riley/.local/share/nvim-plugins/flybuf",
	["stickybuf"] = "/Users/ext_riley/.local/share/nvim-plugins/stickybuf",
	["swm"] = "/Users/ext_riley/.local/share/nvim-plugins/swm",
	["retrospect"] = "/Users/ext_riley/.local/share/nvim-plugins/retrospect",
	["vuffers.nvim"] = "/Users/ext_riley/.local/share/nvim-plugins/vuffers.nvim",
	["pragma.nvim"] = "/Users/ext_riley/.local/share/nvim-plugins/pragma.nvim",
	["windows"] = "/Users/ext_riley/.local/share/nvim-plugins/windows",
	["smart-splits"] = "/Users/ext_riley/.local/share/nvim-plugins/smart-splits",
	["ufo"] = "/Users/ext_riley/.local/share/nvim-plugins/ufo",
	["NeoComposer"] = "/Users/ext_riley/.local/share/nvim-plugins/NeoComposer",
	["nvim-macros"] = "/Users/ext_riley/.local/share/nvim-plugins/nvim-macros",
	["recorder"] = "/Users/ext_riley/.local/share/nvim-plugins/recorder",
	["vim-visual-multi"] = "/Users/ext_riley/.local/share/nvim-plugins/vim-visual-multi",
	["multicursors"] = "/Users/ext_riley/.local/share/nvim-plugins/multicursors",
	["vim-multiple-cursors"] = "/Users/ext_riley/.local/share/nvim-plugins/vim-multiple-cursors",
	["wildfire"] = "/Users/ext_riley/.local/share/nvim-plugins/wildfire",
	["sort"] = "/Users/ext_riley/.local/share/nvim-plugins/sort",
	["leap"] = "/Users/ext_riley/.local/share/nvim-plugins/leap",
	["flash"] = "/Users/ext_riley/.local/share/nvim-plugins/flash",
	["hop"] = "/Users/ext_riley/.local/share/nvim-plugins/hop",
	["neowords"] = "/Users/ext_riley/.local/share/nvim-plugins/neowords",
	["spider"] = "/Users/ext_riley/.local/share/nvim-plugins/spider",
	["vim-wordmotion"] = "/Users/ext_riley/.local/share/nvim-plugins/vim-wordmotion",
	["vim-edgemotion"] = "/Users/ext_riley/.local/share/nvim-plugins/vim-edgemotion",
	["treemonkey"] = "/Users/ext_riley/.local/share/nvim-plugins/treemonkey",
	["hierarchy"] = "/Users/ext_riley/.local/share/nvim-plugins/hierarchy",
	["navigator.lua"] = "/Users/ext_riley/.local/share/nvim-plugins/navigator.lua",
	["rainbow-delimiters"] = "/Users/ext_riley/.local/share/nvim-plugins/rainbow-delimiters",
	["nvim-autopairs"] = "/Users/ext_riley/.local/share/nvim-plugins/nvim-autopairs",
	["blink.pairs"] = "/Users/ext_riley/.local/share/nvim-plugins/blink.pairs",
	["vim-sandwich"] = "/Users/ext_riley/.local/share/nvim-plugins/vim-sandwich",
	["nvim-surround"] = "/Users/ext_riley/.local/share/nvim-plugins/nvim-surround",
	["vim-surround"] = "/Users/ext_riley/.local/share/nvim-plugins/vim-surround",
	["vim-mundo"] = "/Users/ext_riley/.local/share/nvim-plugins/vim-mundo",
	["mini.keymap"] = "/Users/ext_riley/.local/share/nvim-plugins/mini.keymap",
	["hydra"] = "/Users/ext_riley/.local/share/nvim-plugins/hydra",
	["insx"] = "/Users/ext_riley/.local/share/nvim-plugins/insx",
	["which-key"] = "/Users/ext_riley/.local/share/nvim-plugins/which-key",
	["apm"] = "/Users/ext_riley/.local/share/nvim-plugins/apm",
	["unimpaired-which-key"] = "/Users/ext_riley/.local/share/nvim-plugins/unimpaired-which-key",
	["nvim-whichkey-setup.lua"] = "/Users/ext_riley/.local/share/nvim-plugins/nvim-whichkey-setup.lua",
	["keymapper"] = "/Users/ext_riley/.local/share/nvim-plugins/keymapper",
	["keyseer"] = "/Users/ext_riley/.local/share/nvim-plugins/keyseer",
	["keytex"] = "/Users/ext_riley/.local/share/nvim-plugins/keytex",
	["showkeys"] = "/Users/ext_riley/.local/share/nvim-plugins/showkeys",
	["keylab"] = "/Users/ext_riley/.local/share/nvim-plugins/keylab",
	["xkbswitch"] = "/Users/ext_riley/.local/share/nvim-plugins/xkbswitch",
	["cyrillic"] = "/Users/ext_riley/.local/share/nvim-plugins/cyrillic",
	["homerows"] = "/Users/ext_riley/.local/share/nvim-plugins/homerows",
	["wf"] = "/Users/ext_riley/.local/share/nvim-plugins/wf",
	["indentmini"] = "/Users/ext_riley/.local/share/nvim-plugins/indentmini",
	["indent-blankline"] = "/Users/ext_riley/.local/share/nvim-plugins/indent-blankline",
	["anydent"] = "/Users/ext_riley/.local/share/nvim-plugins/anydent",
	["mini.align"] = "/Users/ext_riley/.local/share/nvim-plugins/mini.align",
	["tabular"] = "/Users/ext_riley/.local/share/nvim-plugins/tabular",
	["indent-tools"] = "/Users/ext_riley/.local/share/nvim-plugins/indent-tools",
	["nvim-treesitter-textobjects"] = "/Users/ext_riley/.local/share/nvim-plugins/nvim-treesitter-textobjects",
	["nvim-various-textobjs"] = "/Users/ext_riley/.local/share/nvim-plugins/nvim-various-textobjs",
	["Comment"] = "/Users/ext_riley/.local/share/nvim-plugins/Comment",
	["ts-context-commentstring"] = "/Users/ext_riley/.local/share/nvim-plugins/ts-context-commentstring",
	["todo-comments"] = "/Users/ext_riley/.local/share/nvim-plugins/todo-comments",
	["vim-commentary"] = "/Users/ext_riley/.local/share/nvim-plugins/vim-commentary",
	["treesj"] = "/Users/ext_riley/.local/share/nvim-plugins/treesj",
	["splitjoin"] = "/Users/ext_riley/.local/share/nvim-plugins/splitjoin",
	["splitjoin.vim"] = "/Users/ext_riley/.local/share/nvim-plugins/splitjoin.vim",
	["spread"] = "/Users/ext_riley/.local/share/nvim-plugins/spread",
	["dial"] = "/Users/ext_riley/.local/share/nvim-plugins/dial",
	["switch.vim"] = "/Users/ext_riley/.local/share/nvim-plugins/switch.vim",
	["harpoon-core"] = "/Users/ext_riley/.local/share/nvim-plugins/harpoon-core",
	["marks"] = "/Users/ext_riley/.local/share/nvim-plugins/marks",
	["markit"] = "/Users/ext_riley/.local/share/nvim-plugins/markit",
	["spear"] = "/Users/ext_riley/.local/share/nvim-plugins/spear",
	["arrow"] = "/Users/ext_riley/.local/share/nvim-plugins/arrow",
	["whaler"] = "/Users/ext_riley/.local/share/nvim-plugins/whaler",
	["pasta"] = "/Users/ext_riley/.local/share/nvim-plugins/pasta",
	["wastebin"] = "/Users/ext_riley/.local/share/nvim-plugins/wastebin",
	["lazyclip"] = "/Users/ext_riley/.local/share/nvim-plugins/lazyclip",
	["yanky"] = "/Users/ext_riley/.local/share/nvim-plugins/yanky",
	["moveline"] = "/Users/ext_riley/.local/share/nvim-plugins/moveline",
	["wrapping"] = "/Users/ext_riley/.local/share/nvim-plugins/wrapping",
	["wrapping-paper"] = "/Users/ext_riley/.local/share/nvim-plugins/wrapping-paper",
	["savior"] = "/Users/ext_riley/.local/share/nvim-plugins/savior",
	["zpragmatic"] = "/Users/ext_riley/.local/share/nvim-plugins/zpragmatic",
	["vim-auto-save"] = "/Users/ext_riley/.local/share/nvim-plugins/vim-auto-save",
	["beam"] = "/Users/ext_riley/.local/share/nvim-plugins/beam",
	["vim-abolish"] = "/Users/ext_riley/.local/share/nvim-plugins/vim-abolish",
	["ax"] = "/Users/ext_riley/.local/share/nvim-plugins/ax",
	["AdvancedNewFile"] = "/Users/ext_riley/.local/share/nvim-plugins/AdvancedNewFile",
	["dotdot"] = "/Users/ext_riley/.local/share/nvim-plugins/dotdot",
	["minimal-narrow-region"] = "/Users/ext_riley/.local/share/nvim-plugins/minimal-narrow-region",
	["date-time-inserter"] = "/Users/ext_riley/.local/share/nvim-plugins/date-time-inserter",
	["bullets"] = "/Users/ext_riley/.local/share/nvim-plugins/bullets",
	["vim-caser"] = "/Users/ext_riley/.local/share/nvim-plugins/vim-caser",
	["blink.cmp"] = "/Users/ext_riley/.local/share/nvim-plugins/blink.cmp",
	["cmp"] = "/Users/ext_riley/.local/share/nvim-plugins/cmp",
	["lsp_signature"] = "/Users/ext_riley/.local/share/nvim-plugins/lsp_signature",
	["inlayhint-filler"] = "/Users/ext_riley/.local/share/nvim-plugins/inlayhint-filler",
	["ivy"] = "/Users/ext_riley/.local/share/nvim-plugins/ivy",
	["friendly-snippets"] = "/Users/ext_riley/.local/share/nvim-plugins/friendly-snippets",
	["ultisnips"] = "/Users/ext_riley/.local/share/nvim-plugins/ultisnips",
	["LuaSnip"] = "/Users/ext_riley/.local/share/nvim-plugins/LuaSnip",
	["cmp-nvim-lsp"] = "/Users/ext_riley/.local/share/nvim-plugins/cmp-nvim-lsp",
	["cmp-buffer"] = "/Users/ext_riley/.local/share/nvim-plugins/cmp-buffer",
	["cmp-path"] = "/Users/ext_riley/.local/share/nvim-plugins/cmp-path",
	["cmp-cmdline"] = "/Users/ext_riley/.local/share/nvim-plugins/cmp-cmdline",
	["nvim-cmp-fonts"] = "/Users/ext_riley/.local/share/nvim-plugins/nvim-cmp-fonts",
	["nvim-cmp-lua-latex-symbols"] = "/Users/ext_riley/.local/share/nvim-plugins/nvim-cmp-lua-latex-symbols",
	["cmp-nvim-telekasten-tags"] = "/Users/ext_riley/.local/share/nvim-plugins/cmp-nvim-telekasten-tags",
	["cmp_bulma"] = "/Users/ext_riley/.local/share/nvim-plugins/cmp_bulma",
	["lsp-format"] = "/Users/ext_riley/.local/share/nvim-plugins/lsp-format",
	["lspkind"] = "/Users/ext_riley/.local/share/nvim-plugins/lspkind",
	["efm"] = "/Users/ext_riley/.local/share/nvim-plugins/efm",
	["output-panel"] = "/Users/ext_riley/.local/share/nvim-plugins/output-panel",
	["control-panel"] = "/Users/ext_riley/.local/share/nvim-plugins/control-panel",
	["lspsaga"] = "/Users/ext_riley/.local/share/nvim-plugins/lspsaga",
	["cmp-nvim-lsp-signature-help"] = "/Users/ext_riley/.local/share/nvim-plugins/cmp-nvim-lsp-signature-help",
	["corn"] = "/Users/ext_riley/.local/share/nvim-plugins/corn",
	["diagflow"] = "/Users/ext_riley/.local/share/nvim-plugins/diagflow",
	["error-jump"] = "/Users/ext_riley/.local/share/nvim-plugins/error-jump",
	["doc-window"] = "/Users/ext_riley/.local/share/nvim-plugins/doc-window",
	["lightbulb"] = "/Users/ext_riley/.local/share/nvim-plugins/lightbulb",
	["telescope-code-actions"] = "/Users/ext_riley/.local/share/nvim-plugins/telescope-code-actions",
	["dmap"] = "/Users/ext_riley/.local/share/nvim-plugins/dmap",
	["lazydev"] = "/Users/ext_riley/.local/share/nvim-plugins/lazydev",
	["rustaceanvim"] = "/Users/ext_riley/.local/share/nvim-plugins/rustaceanvim",
	["crates"] = "/Users/ext_riley/.local/share/nvim-plugins/crates",
	["haskell-tools"] = "/Users/ext_riley/.local/share/nvim-plugins/haskell-tools",
	["debugpy"] = "/Users/ext_riley/.local/share/nvim-plugins/debugpy",
	["pylsp-rope"] = "/Users/ext_riley/.local/share/nvim-plugins/pylsp-rope",
	["jvim"] = "/Users/ext_riley/.local/share/nvim-plugins/jvim",
	["jsonpath"] = "/Users/ext_riley/.local/share/nvim-plugins/jsonpath",
	["sortjson"] = "/Users/ext_riley/.local/share/nvim-plugins/sortjson",
	["quicktype"] = "/Users/ext_riley/.local/share/nvim-plugins/quicktype",
	["yaml"] = "/Users/ext_riley/.local/share/nvim-plugins/yaml",
	["tree-sitter-just"] = "/Users/ext_riley/.local/share/nvim-plugins/tree-sitter-just",
	["none-ls"] = "/Users/ext_riley/.local/share/nvim-plugins/none-ls",
	["guard"] = "/Users/ext_riley/.local/share/nvim-plugins/guard",
	["conform"] = "/Users/ext_riley/.local/share/nvim-plugins/conform",
	["strict"] = "/Users/ext_riley/.local/share/nvim-plugins/strict",
	["overseer"] = "/Users/ext_riley/.local/share/nvim-plugins/overseer",
	["asyncrun"] = "/Users/ext_riley/.local/share/nvim-plugins/asyncrun",
	["compiler"] = "/Users/ext_riley/.local/share/nvim-plugins/compiler",
	["code_runner"] = "/Users/ext_riley/.local/share/nvim-plugins/code_runner",
	["sniprun"] = "/Users/ext_riley/.local/share/nvim-plugins/sniprun",
	["yabs"] = "/Users/ext_riley/.local/share/nvim-plugins/yabs",
	["jaq-nvim"] = "/Users/ext_riley/.local/share/nvim-plugins/jaq-nvim",
	["moonicipal"] = "/Users/ext_riley/.local/share/nvim-plugins/moonicipal",
	["conjure"] = "/Users/ext_riley/.local/share/nvim-plugins/conjure",
	["telemake"] = "/Users/ext_riley/.local/share/nvim-plugins/telemake",
	["equals"] = "/Users/ext_riley/.local/share/nvim-plugins/equals",
	["telescope-xc"] = "/Users/ext_riley/.local/share/nvim-plugins/telescope-xc",
	["resin"] = "/Users/ext_riley/.local/share/nvim-plugins/resin",
	["vim-slime"] = "/Users/ext_riley/.local/share/nvim-plugins/vim-slime",
	["repl"] = "/Users/ext_riley/.local/share/nvim-plugins/repl",
	["yarepl"] = "/Users/ext_riley/.local/share/nvim-plugins/yarepl",
	["channelot"] = "/Users/ext_riley/.local/share/nvim-plugins/channelot",
	["xmake"] = "/Users/ext_riley/.local/share/nvim-plugins/xmake",
	["live-command"] = "/Users/ext_riley/.local/share/nvim-plugins/live-command",
	["cmdbuf"] = "/Users/ext_riley/.local/share/nvim-plugins/cmdbuf",
	["actions-preview"] = "/Users/ext_riley/.local/share/nvim-plugins/actions-preview",
	["neotest"] = "/Users/ext_riley/.local/share/nvim-plugins/neotest",
	["coverage"] = "/Users/ext_riley/.local/share/nvim-plugins/coverage",
	["neotest-haskell"] = "/Users/ext_riley/.local/share/nvim-plugins/neotest-haskell",
	["neotest-python"] = "/Users/ext_riley/.local/share/nvim-plugins/neotest-python",
	["mypy"] = "/Users/ext_riley/.local/share/nvim-plugins/mypy",
	["lint"] = "/Users/ext_riley/.local/share/nvim-plugins/lint",
	["dap-python"] = "/Users/ext_riley/.local/share/nvim-plugins/dap-python",
	["dapui"] = "/Users/ext_riley/.local/share/nvim-plugins/dapui",
	["nvim-dap-virtual-text"] = "/Users/ext_riley/.local/share/nvim-plugins/nvim-dap-virtual-text",
	["dap"] = "/Users/ext_riley/.local/share/nvim-plugins/dap",
	["Launch"] = "/Users/ext_riley/.local/share/nvim-plugins/Launch",
	["tracebundler"] = "/Users/ext_riley/.local/share/nvim-plugins/tracebundler",
	["trouble"] = "/Users/ext_riley/.local/share/nvim-plugins/trouble",
	["quicker"] = "/Users/ext_riley/.local/share/nvim-plugins/quicker",
	["bqf"] = "/Users/ext_riley/.local/share/nvim-plugins/bqf",
	["glance"] = "/Users/ext_riley/.local/share/nvim-plugins/glance",
	["vim-floaterm"] = "/Users/ext_riley/.local/share/nvim-plugins/vim-floaterm",
	["termim"] = "/Users/ext_riley/.local/share/nvim-plugins/termim",
	["neaterm"] = "/Users/ext_riley/.local/share/nvim-plugins/neaterm",
	["neomux"] = "/Users/ext_riley/.local/share/nvim-plugins/neomux",
	["refactoring"] = "/Users/ext_riley/.local/share/nvim-plugins/refactoring",
	["telescope-project"] = "/Users/ext_riley/.local/share/nvim-plugins/telescope-project",
	["project"] = "/Users/ext_riley/.local/share/nvim-plugins/project",
	["monorepos"] = "/Users/ext_riley/.local/share/nvim-plugins/monorepos",
	["projector"] = "/Users/ext_riley/.local/share/nvim-plugins/projector",
	["advanced-git-search"] = "/Users/ext_riley/.local/share/nvim-plugins/advanced-git-search",
	["blame"] = "/Users/ext_riley/.local/share/nvim-plugins/blame",
	["forgit"] = "/Users/ext_riley/.local/share/nvim-plugins/forgit",
	["jj"] = "/Users/ext_riley/.local/share/nvim-plugins/jj",
	["jujutsu"] = "/Users/ext_riley/.local/share/nvim-plugins/jujutsu",
	["lazygit"] = "/Users/ext_riley/.local/share/nvim-plugins/lazygit",
	["git-conflict"] = "/Users/ext_riley/.local/share/nvim-plugins/git-conflict",
	["neogit"] = "/Users/ext_riley/.local/share/nvim-plugins/neogit",
	["jiejie"] = "/Users/ext_riley/.local/share/nvim-plugins/jiejie",
	["diffview"] = "/Users/ext_riley/.local/share/nvim-plugins/diffview",
	["gitsigns"] = "/Users/ext_riley/.local/share/nvim-plugins/gitsigns",
	["vim-fugitive"] = "/Users/ext_riley/.local/share/nvim-plugins/vim-fugitive",
	["g-worktree"] = "/Users/ext_riley/.local/share/nvim-plugins/g-worktree",
	["octo"] = "/Users/ext_riley/.local/share/nvim-plugins/octo",
	["gitlab-nvim"] = "/Users/ext_riley/.local/share/nvim-plugins/gitlab-nvim",
	["gitlab"] = "/Users/ext_riley/.local/share/nvim-plugins/gitlab",
	["octohub"] = "/Users/ext_riley/.local/share/nvim-plugins/octohub",
	["telescope-github"] = "/Users/ext_riley/.local/share/nvim-plugins/telescope-github",
	["dashboard-nvim"] = "/Users/ext_riley/.local/share/nvim-plugins/dashboard-nvim",
	["dashboard"] = "/Users/ext_riley/.local/share/nvim-plugins/dashboard",
	["noice"] = "/Users/ext_riley/.local/share/nvim-plugins/noice",
	["modes"] = "/Users/ext_riley/.local/share/nvim-plugins/modes",
	["lvim-ui-config"] = "/Users/ext_riley/.local/share/nvim-plugins/lvim-ui-config",
	["volt"] = "/Users/ext_riley/.local/share/nvim-plugins/volt",
	["menu"] = "/Users/ext_riley/.local/share/nvim-plugins/menu",
	["bye-nerdfont"] = "/Users/ext_riley/.local/share/nvim-plugins/bye-nerdfont",
	["reactive"] = "/Users/ext_riley/.local/share/nvim-plugins/reactive",
	["modicator"] = "/Users/ext_riley/.local/share/nvim-plugins/modicator",
	["fsplash"] = "/Users/ext_riley/.local/share/nvim-plugins/fsplash",
	["fidget"] = "/Users/ext_riley/.local/share/nvim-plugins/fidget",
	["notify"] = "/Users/ext_riley/.local/share/nvim-plugins/notify",
	["headlines"] = "/Users/ext_riley/.local/share/nvim-plugins/headlines",
	["auto-session"] = "/Users/ext_riley/.local/share/nvim-plugins/auto-session",
	["persistence"] = "/Users/ext_riley/.local/share/nvim-plugins/persistence",
	["shade"] = "/Users/ext_riley/.local/share/nvim-plugins/shade",
	["zen-mode"] = "/Users/ext_riley/.local/share/nvim-plugins/zen-mode",
	["sunglasses"] = "/Users/ext_riley/.local/share/nvim-plugins/sunglasses",
	["vimade"] = "/Users/ext_riley/.local/share/nvim-plugins/vimade",
	["runtimetable"] = "/Users/ext_riley/.local/share/nvim-plugins/runtimetable",
	["schemastore"] = "/Users/ext_riley/.local/share/nvim-plugins/schemastore",
	["firenvim"] = "/Users/ext_riley/.local/share/nvim-plugins/firenvim",
	["render-markdown"] = "/Users/ext_riley/.local/share/nvim-plugins/render-markdown",
	["markdown-preview"] = "/Users/ext_riley/.local/share/nvim-plugins/markdown-preview",
	["web-tools"] = "/Users/ext_riley/.local/share/nvim-plugins/web-tools",
	["vim-pug"] = "/Users/ext_riley/.local/share/nvim-plugins/vim-pug",
	["Calendar"] = "/Users/ext_riley/.local/share/nvim-plugins/Calendar",
	["http-codes"] = "/Users/ext_riley/.local/share/nvim-plugins/http-codes",
	["auto-pandoc"] = "/Users/ext_riley/.local/share/nvim-plugins/auto-pandoc",
	["panvimdoc"] = "/Users/ext_riley/.local/share/nvim-plugins/panvimdoc",
	["vale"] = "/Users/ext_riley/.local/share/nvim-plugins/vale",
	["present"] = "/Users/ext_riley/.local/share/nvim-plugins/present",
	["flashcards"] = "/Users/ext_riley/.local/share/nvim-plugins/flashcards",
	["license"] = "/Users/ext_riley/.local/share/nvim-plugins/license",
	["live-server"] = "/Users/ext_riley/.local/share/nvim-plugins/live-server",
	["nvim-mail-merge"] = "/Users/ext_riley/.local/share/nvim-plugins/nvim-mail-merge",
	["better-digraphs"] = "/Users/ext_riley/.local/share/nvim-plugins/better-digraphs",
	["qalc"] = "/Users/ext_riley/.local/share/nvim-plugins/qalc",
	["tldr"] = "/Users/ext_riley/.local/share/nvim-plugins/tldr",
	["pre-commit"] = "/Users/ext_riley/.local/share/nvim-plugins/pre-commit",
	["endpoint-previewer"] = "/Users/ext_riley/.local/share/nvim-plugins/endpoint-previewer",
	["fsread"] = "/Users/ext_riley/.local/share/nvim-plugins/fsread",
	["feed"] = "/Users/ext_riley/.local/share/nvim-plugins/feed",
	["nerdy"] = "/Users/ext_riley/.local/share/nvim-plugins/nerdy",
	["knap"] = "/Users/ext_riley/.local/share/nvim-plugins/knap",
	["urlview"] = "/Users/ext_riley/.local/share/nvim-plugins/urlview",
	["interlaced"] = "/Users/ext_riley/.local/share/nvim-plugins/interlaced",
	["texmagic"] = "/Users/ext_riley/.local/share/nvim-plugins/texmagic",
	["vimtex"] = "/Users/ext_riley/.local/share/nvim-plugins/vimtex",
	["ltex_extra"] = "/Users/ext_riley/.local/share/nvim-plugins/ltex_extra",
	["drop"] = "/Users/ext_riley/.local/share/nvim-plugins/drop",
	["regex-vars"] = "/Users/ext_riley/.local/share/nvim-plugins/regex-vars",
	["regexplainer"] = "/Users/ext_riley/.local/share/nvim-plugins/regexplainer",
	["Hypersonic"] = "/Users/ext_riley/.local/share/nvim-plugins/Hypersonic",
	["structlog"] = "/Users/ext_riley/.local/share/nvim-plugins/structlog",
	["neorepl"] = "/Users/ext_riley/.local/share/nvim-plugins/neorepl",
	["neotest-plenary"] = "/Users/ext_riley/.local/share/nvim-plugins/neotest-plenary",
	["minty"] = "/Users/ext_riley/.local/share/nvim-plugins/minty",
	["color-picker"] = "/Users/ext_riley/.local/share/nvim-plugins/color-picker",
	["export-colorscheme"] = "/Users/ext_riley/.local/share/nvim-plugins/export-colorscheme",
	["kreative"] = "/Users/ext_riley/.local/share/nvim-plugins/kreative",
	["text-to-colorscheme"] = "/Users/ext_riley/.local/share/nvim-plugins/text-to-colorscheme",
	["easycolor"] = "/Users/ext_riley/.local/share/nvim-plugins/easycolor",
	["paint"] = "/Users/ext_riley/.local/share/nvim-plugins/paint",
	["nvim-highlight-colors"] = "/Users/ext_riley/.local/share/nvim-plugins/nvim-highlight-colors",
	["kubels"] = "/Users/ext_riley/.local/share/nvim-plugins/kubels",
	["kubernetes"] = "/Users/ext_riley/.local/share/nvim-plugins/kubernetes",
	["kpops"] = "/Users/ext_riley/.local/share/nvim-plugins/kpops",
	["k8vim"] = "/Users/ext_riley/.local/share/nvim-plugins/k8vim",
	["kubectl"] = "/Users/ext_riley/.local/share/nvim-plugins/kubectl",
	["vim-helm"] = "/Users/ext_riley/.local/share/nvim-plugins/vim-helm",
	["avante"] = "/Users/ext_riley/.local/share/nvim-plugins/avante",
	["vim-ai"] = "/Users/ext_riley/.local/share/nvim-plugins/vim-ai",
	["codecompanion"] = "/Users/ext_riley/.local/share/nvim-plugins/codecompanion",
	["llm"] = "/Users/ext_riley/.local/share/nvim-plugins/llm",
	["sg"] = "/Users/ext_riley/.local/share/nvim-plugins/sg",
	["metrics"] = "/Users/ext_riley/.local/share/nvim-plugins/metrics",
	["orgmode"] = "/Users/ext_riley/.local/share/nvim-plugins/orgmode",
	["twig"] = "/Users/ext_riley/.local/share/nvim-plugins/twig",
	["neorg-taskwarrior"] = "/Users/ext_riley/.local/share/nvim-plugins/neorg-taskwarrior",
	["doing"] = "/Users/ext_riley/.local/share/nvim-plugins/doing",
	["daily-focus"] = "/Users/ext_riley/.local/share/nvim-plugins/daily-focus",
	["nomodoro"] = "/Users/ext_riley/.local/share/nvim-plugins/nomodoro",
	["pommodoro-clock"] = "/Users/ext_riley/.local/share/nvim-plugins/pommodoro-clock",
	["baleia"] = "/Users/ext_riley/.local/share/nvim-plugins/baleia",
	["timew"] = "/Users/ext_riley/.local/share/nvim-plugins/timew",
	["pomodoro"] = "/Users/ext_riley/.local/share/nvim-plugins/pomodoro",
	["tdo"] = "/Users/ext_riley/.local/share/nvim-plugins/tdo",
	["tktodo"] = "/Users/ext_riley/.local/share/nvim-plugins/tktodo",
	["zettelkasten"] = "/Users/ext_riley/.local/share/nvim-plugins/zettelkasten",
	["obsidian"] = "/Users/ext_riley/.local/share/nvim-plugins/obsidian",
	["vim-twig"] = "/Users/ext_riley/.local/share/nvim-plugins/vim-twig",
	["timerly"] = "/Users/ext_riley/.local/share/nvim-plugins/timerly",
	["sche"] = "/Users/ext_riley/.local/share/nvim-plugins/sche",
	["vimwiki"] = "/Users/ext_riley/.local/share/nvim-plugins/vimwiki",
	["flote"] = "/Users/ext_riley/.local/share/nvim-plugins/flote",
	["neorg"] = "/Users/ext_riley/.local/share/nvim-plugins/neorg",
	["quicknote"] = "/Users/ext_riley/.local/share/nvim-plugins/quicknote",
	["scratch-buffer"] = "/Users/ext_riley/.local/share/nvim-plugins/scratch-buffer",
	["edit-list"] = "/Users/ext_riley/.local/share/nvim-plugins/edit-list",
}
return paths

```

## plugins-lock.json (Mac)

```lua
{
    "plenary": {
        "location": "plenary",
        "url": "https://github.com/nvim-lua/plenary.nvim",
        "sha": "b9fd5226c2f76c951fc8ed5923d85e4de065e509",
        "cloned_on": "2026-03-07",
        "recency": "2025-07-26",
        "version": null
    },
    "nio": {
        "location": "nio",
        "url": "https://github.com/nvim-neotest/nvim-nio",
        "sha": "21f5324bfac14e22ba26553caf69ec76ae8a7662",
        "cloned_on": "2026-03-07",
        "recency": "2025-01-20",
        "version": null
    },
    "nvim-web-devicons": {
        "location": "nvim-web-devicons",
        "url": "https://github.com/nvim-tree/nvim-web-devicons",
        "sha": "737cf6c657898d0c697311d79d361288a1343d50",
        "cloned_on": "2026-03-07",
        "recency": "2026-02-26",
        "version": null
    },
    "nui": {
        "location": "nui",
        "url": "https://github.com/MunifTanjim/nui.nvim",
        "sha": "de740991c12411b663994b2860f1a4fd0937c130",
        "cloned_on": "2026-03-07",
        "recency": "2025-06-08",
        "version": null
    },
    "bamboo": {
        "location": "bamboo",
        "url": "https://github.com/ribru17/bamboo.nvim",
        "sha": "1309bc88bffcf1bedc3e84e7fa9004de93da774a",
        "cloned_on": "2026-03-07",
        "recency": "2025-11-24",
        "version": null
    },
    "zen-mode": {
        "location": "zen-mode",
        "url": "https://github.com/folke/zen-mode.nvim",
        "sha": "8564ce6d29ec7554eb9df578efa882d33b3c23a7",
        "cloned_on": "2026-03-07",
        "recency": "2025-10-28",
        "version": null
    },
    "illuminate": {
        "location": "illuminate",
        "url": "https://github.com/RRethy/vim-illuminate",
        "sha": "0d1e93684da00ab7c057410fecfc24f434698898",
        "cloned_on": "2026-03-07",
        "recency": "2025-05-24",
        "version": null
    },
    "lualine": {
        "location": "lualine",
        "url": "https://github.com/nvim-lualine/lualine.nvim",
        "sha": "47f91c416daef12db467145e16bed5bbfe00add8",
        "cloned_on": "2026-03-07",
        "recency": "2025-11-23",
        "version": null
    },
    "nvim-navic": {
        "location": "nvim-navic",
        "url": "https://github.com/SmiteshP/nvim-navic",
        "sha": "f5eba192f39b453675d115351808bd51276d9de5",
        "cloned_on": "2026-03-07",
        "recency": "2025-12-29",
        "version": null
    },
    "bufferline": {
        "location": "bufferline",
        "url": "https://github.com/akinsho/bufferline.nvim",
        "sha": "655133c3b4c3e5e05ec549b9f8cc2894ac6f51b3",
        "cloned_on": "2026-03-07",
        "recency": "2025-01-14",
        "version": null
    },
    "statuscol": {
        "location": "statuscol",
        "url": "https://github.com/luukvbaal/statuscol.nvim",
        "sha": "c46172d0911aa5d49ba5f39f4351d1bb7aa289cc",
        "cloned_on": "2026-03-07",
        "recency": "2025-06-02",
        "version": null
    },
    "nvim-treesitter": {
        "location": "nvim-treesitter",
        "url": "https://github.com/nvim-treesitter/nvim-treesitter",
        "sha": "544320a9cf5d6bf539ec1cc54d393064015670c4",
        "cloned_on": "2026-03-07",
        "recency": "2026-03-04",
        "version": null
    },
    "treesitter-modules": {
        "location": "treesitter-modules",
        "url": "https://github.com/MeanderingProgrammer/treesitter-modules.nvim",
        "sha": "0cc09da40061051b0186479203faa75052cddab6",
        "cloned_on": "2026-03-07",
        "recency": "2026-02-05",
        "version": null
    },
    "dropbar": {
        "location": "dropbar",
        "url": "https://github.com/Bekaboo/dropbar.nvim",
        "sha": "ce202248134e3949aac375fd66c28e5207785b10",
        "cloned_on": "2026-03-07",
        "recency": "2025-10-05",
        "version": null
    },
    "nvim-navbuddy": {
        "location": "NONEXISTENT",
        "url": "https://github.com/SmiteshP/nvim-navbuddy",
        "sha": "AAAAAAAAAAAAAAAA",
        "cloned_on": "2026-03-07",
        "recency": "1970-01-01",
        "version": null
    },
    "aerial": {
        "location": "aerial",
        "url": "https://github.com/stevearc/aerial.nvim",
        "sha": "645d108a5242ec7b378cbe643eb6d04d4223f034",
        "cloned_on": "2026-03-07",
        "recency": "2026-02-25",
        "version": null
    },
    "oil": {
        "location": "oil",
        "url": "https://github.com/stevearc/oil.nvim",
        "sha": "0fcc83805ad11cf714a949c98c605ed717e0b83e",
        "cloned_on": "2026-03-07",
        "recency": "2026-02-23",
        "version": null
    },
    "yazi": {
        "location": "yazi",
        "url": "https://github.com/mikavilpas/yazi.nvim",
        "sha": "30531c7283b16134cae28d5217b4341ac9486a06",
        "cloned_on": "2026-03-07",
        "recency": "2026-03-01",
        "version": null
    },
    "neo-tree": {
        "location": "neo-tree",
        "url": "https://github.com/nvim-neo-tree/neo-tree.nvim",
        "sha": "9d6826582a3e8c84787bd7355df22a2812a1ad59",
        "cloned_on": "2026-03-07",
        "recency": "2026-02-26",
        "version": null
    },
    "nvim-tree": {
        "location": "nvim-tree",
        "url": "https://github.com/nvim-tree/nvim-tree.lua",
        "sha": "4b30847c91d498446cb8440c03031359b045e050",
        "cloned_on": "2026-03-07",
        "recency": "2026-03-05",
        "version": null
    },
    "pickme": {
        "location": "pickme",
        "url": "https://github.com/2KAbhishek/pickme.nvim",
        "sha": "3bfd63fa0a1fa362afc9dfa86b83100e75903e6b",
        "cloned_on": "2026-03-07",
        "recency": "2025-12-24",
        "version": null
    },
    "telescope": {
        "location": "telescope",
        "url": "https://github.com/nvim-telescope/telescope.nvim",
        "sha": "5255aa27c422de944791318024167ad5d40aad20",
        "cloned_on": "2026-03-07",
        "recency": "2026-02-16",
        "version": null
    },
    "telescope-fzf-native": {
        "location": "telescope-fzf-native",
        "url": "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
        "sha": "6fea601bd2b694c6f2ae08a6c6fab14930c60e2c",
        "cloned_on": "2026-03-07",
        "recency": "2025-11-07",
        "version": null
    },
    "fzf-lua": {
        "location": "fzf-lua",
        "url": "https://github.com/ibhagwan/fzf-lua",
        "sha": "1eba927866251bae1b61dffc5b673b8dbd0f3f48",
        "cloned_on": "2026-03-07",
        "recency": "2026-03-04",
        "version": null
    },
    "deck": {
        "location": "deck",
        "url": "https://github.com/hrsh7th/nvim-deck",
        "sha": "280a8d4c7816a7f8b5417b97430b1a8c3f2ea512",
        "cloned_on": "2026-03-07",
        "recency": "2026-02-24",
        "version": null
    },
    "mini": {
        "location": "mini",
        "url": "https://github.com/nvim-mini/mini.nvim",
        "sha": "cad365c212fb1e332cb93fa8f72697125799d00a",
        "cloned_on": "2026-03-07",
        "recency": "2026-03-03",
        "version": null
    },
    "snacks": {
        "location": "snacks",
        "url": "https://github.com/folke/snacks.nvim",
        "sha": "9912042fc8bca2209105526ac7534e9a0c2071b2",
        "cloned_on": "2026-03-07",
        "recency": "2026-03-01",
        "version": null
    },
    "blink": {
        "location": "blink",
        "url": "https://github.com/saghen/blink.nvim",
        "sha": "d1e7c7c45d45c6b6a25427bf62db4db73b03ff3d",
        "cloned_on": "2026-03-07",
        "recency": "2025-10-21",
        "version": null
    },
    "hlslens": {
        "location": "hlslens",
        "url": "https://github.com/kevinhwang91/nvim-hlslens",
        "sha": "be2d7b2be01860b5445a007ff2bc72b29896db6b",
        "cloned_on": "2026-03-07",
        "recency": "2026-01-11",
        "version": null
    },
    "hlsearch": {
        "location": "hlsearch",
        "url": "https://github.com/nvimdev/hlsearch.nvim",
        "sha": "fdeb60b890d15d9194e8600042e5232ef8c29b0e",
        "cloned_on": "2026-03-07",
        "recency": "2024-01-10",
        "version": null
    },
    "grug-far": {
        "location": "grug-far",
        "url": "https://github.com/MagicDuck/grug-far.nvim",
        "sha": "ac52ee2d87399dfd7b0d59d5b1d2bbaf2a4028f1",
        "cloned_on": "2026-03-07",
        "recency": "2026-03-02",
        "version": null
    },
    "spectre": {
        "location": "spectre",
        "url": "https://github.com/nvim-pack/nvim-spectre",
        "sha": "72f56f7585903cd7bf92c665351aa585e150af0f",
        "cloned_on": "2026-03-07",
        "recency": "2025-05-13",
        "version": null
    },
    "nvim_winpick": {
        "location": "nvim_winpick",
        "url": "https://github.com/MarcusGrass/nvim_winpick",
        "sha": "18037e9f5ce417bd75d16ebbf70787bcc478c249",
        "cloned_on": "2026-03-07",
        "recency": "2025-06-30",
        "version": null
    },
    "flybuf": {
        "location": "flybuf",
        "url": "https://github.com/nvimdev/flybuf.nvim",
        "sha": "fe1fbd9699f6988a1db3b2e2ffa599154784c6e1",
        "cloned_on": "2026-03-07",
        "recency": "2023-03-25",
        "version": null
    },
    "stickybuf": {
        "location": "stickybuf",
        "url": "https://github.com/stevearc/stickybuf.nvim",
        "sha": "0c1e5f1a3eb36eea2cea57083828269cc62c58e4",
        "cloned_on": "2026-03-07",
        "recency": "2025-03-04",
        "version": null
    },
    "swm": {
        "location": "swm",
        "url": "https://github.com/hrsh7th/nvim-swm",
        "sha": "4ccb2b137b117092f3efa426261ddbef25111454",
        "cloned_on": "2026-03-07",
        "recency": "2025-02-11",
        "version": null
    },
    "smart-splits": {
        "location": "smart-splits",
        "url": "https://github.com/mrjones2014/smart-splits.nvim",
        "sha": "f4e4908fe901444d05feff0ad1cca146ec0be73f",
        "cloned_on": "2026-03-07",
        "recency": "2026-02-27",
        "version": null
    },
    "ufo": {
        "location": "ufo",
        "url": "https://github.com/kevinhwang91/nvim-ufo",
        "sha": "ab3eb124062422d276fae49e0dd63b3ad1062cfc",
        "cloned_on": "2026-03-07",
        "recency": "2026-01-11",
        "version": null
    },
    "NeoComposer": {
        "location": "NeoComposer",
        "url": "https://github.com/lvim-tech/NeoComposer.nvim",
        "sha": "83f78b23c4f6826b0f484a91869415b85f74b24f",
        "cloned_on": "2026-03-07",
        "recency": "2025-05-17",
        "version": null
    },
    "nvim-macros": {
        "location": "nvim-macros",
        "url": "https://github.com/kr40/nvim-macros",
        "sha": "f29d08ee7844ed6c9552699206e8c977d6936ee4",
        "cloned_on": "2026-03-07",
        "recency": "2024-02-16",
        "version": null
    },
    "recorder": {
        "location": "recorder",
        "url": "https://github.com/chrisgrieser/nvim-recorder",
        "sha": "cf2e07d1d60f225943b2f2457ecd8e2b3e4ee2d5",
        "cloned_on": "2026-03-07",
        "recency": "2026-02-06",
        "version": null
    },
    "vim-visual-multi": {
        "location": "vim-visual-multi",
        "url": "https://github.com/mg979/vim-visual-multi",
        "sha": "a6975e7c1ee157615bbc80fc25e4392f71c344d4",
        "cloned_on": "2026-03-07",
        "recency": "2024-09-01",
        "version": null
    },
    "leap": {
        "location": "leap",
        "url": "https://codeberg.org/andyg/leap.nvim",
        "sha": "b81866399072af08195ebfbcfea9d3dcab970972",
        "cloned_on": "2026-03-07",
        "recency": "2026-02-23",
        "version": null
    },
    "flash": {
        "location": "flash",
        "url": "https://github.com/folke/flash.nvim",
        "sha": "fcea7ff883235d9024dc41e638f164a450c14ca2",
        "cloned_on": "2026-03-07",
        "recency": "2025-10-28",
        "version": null
    },
    "hop": {
        "location": "hop",
        "url": "https://github.com/smoka7/hop.nvim",
        "sha": "707049feaca9ae65abb3696eff9aefc7879e66aa",
        "cloned_on": "2026-03-07",
        "recency": "2025-08-22",
        "version": null
    },
    "rainbow-delimiters": {
        "location": "rainbow-delimiters",
        "url": "https://github.com/HiPhish/rainbow-delimiters.nvim",
        "sha": "01993eb20c6cdc1d33e7e98252368840309f99b9",
        "cloned_on": "2026-03-07",
        "recency": "2026-02-24",
        "version": null
    },
    "nvim-autopairs": {
        "location": "nvim-autopairs",
        "url": "https://github.com/windwp/nvim-autopairs",
        "sha": "59bce2eef357189c3305e25bc6dd2d138c1683f5",
        "cloned_on": "2026-03-07",
        "recency": "2026-01-30",
        "version": null
    },
    "blink.pairs": {
        "location": "blink.pairs",
        "url": "https://github.com/saghen/blink.pairs",
        "sha": "c7986efb702d995fa8d937c23a0bd03c9d3e92b3",
        "cloned_on": "2026-03-07",
        "recency": "2026-03-04",
        "version": null
    },
    "vim-sandwich": {
        "location": "vim-sandwich",
        "url": "https://github.com/machakann/vim-sandwich",
        "sha": "74cf93d58ccc567d8e2310a69860f1b93af19403",
        "cloned_on": "2026-03-07",
        "recency": "2024-03-20",
        "version": null
    },
    "surround": {
        "location": "surround",
        "url": "https://github.com/kylechui/nvim-surround",
        "sha": "9488883f58161c1e302ae6bfa5ecd79ac828b36e",
        "cloned_on": "2026-03-07",
        "recency": "2026-03-04",
        "version": null
    },
    "vim-mundo": {
        "location": "vim-mundo",
        "url": "https://github.com/simnalamburt/vim-mundo",
        "sha": "2ceda8c65f7b3f9066820729fc02003a09df91f9",
        "cloned_on": "2026-03-07",
        "recency": "2023-12-15",
        "version": null
    },
    "mini.keymap": {
        "location": "mini.keymap",
        "url": "https://github.com/nvim-mini/mini.keymap",
        "sha": "c6f362c835914188d499694743fb89014a815e2c",
        "cloned_on": "2026-03-07",
        "recency": "2026-02-21",
        "version": null
    },
    "hydra": {
        "location": "hydra",
        "url": "https://github.com/nvimtools/hydra.nvim",
        "sha": "8c4a9f621ec7cdc30411a1f3b6d5eebb12b469dc",
        "cloned_on": "2026-03-07",
        "recency": "2025-05-03",
        "version": null
    },
    "nvim-insx": {
        "location": "nvim-insx",
        "url": "https://github.com/hrsh7th/nvim-insx",
        "sha": "fbba86031f3927ecbc11556217b4976a149c29c6",
        "cloned_on": "2026-03-07",
        "recency": "2025-06-10",
        "version": null
    },
    "which-key": {
        "location": "which-key",
        "url": "https://github.com/folke/which-key.nvim",
        "sha": "3aab2147e74890957785941f0c1ad87d0a44c15a",
        "cloned_on": "2026-03-07",
        "recency": "2025-10-28",
        "version": null
    },
    "indentmini": {
        "location": "indentmini",
        "url": "https://github.com/nvimdev/indentmini.nvim",
        "sha": "38572ce5a7a064a5deb89d6d861b7c40fc929ab1",
        "cloned_on": "2026-03-07",
        "recency": "2026-01-04",
        "version": null
    },
    "indent-blankline": {
        "location": "indent-blankline",
        "url": "https://github.com/lukas-reineke/indent-blankline.nvim",
        "sha": "d28a3f70721c79e3c5f6693057ae929f3d9c0a03",
        "cloned_on": "2026-03-07",
        "recency": "2026-02-17",
        "version": null
    },
    "nvim-anydent": {
        "location": "nvim-anydent",
        "url": "https://github.com/hrsh7th/nvim-anydent",
        "sha": "b6151bd50d5935522a71709202a0495a50681156",
        "cloned_on": "2026-03-07",
        "recency": "2026-01-22",
        "version": null
    },
    "mini.align": {
        "location": "mini.align",
        "url": "https://github.com/nvim-mini/mini.align",
        "sha": "4d45e0e4f1fd8baefb6ae52a44659704fe7ebe8b",
        "cloned_on": "2026-03-07",
        "recency": "2026-02-21",
        "version": null
    },
    "tabular": {
        "location": "tabular",
        "url": "https://github.com/godlygeek/tabular",
        "sha": "12437cd1b53488e24936ec4b091c9324cafee311",
        "cloned_on": "2026-03-07",
        "recency": "2024-07-03",
        "version": null
    },
    "nvim-treesitter-textobjects": {
        "location": "nvim-treesitter-textobjects",
        "url": "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
        "sha": "0bc4ef0a34d80fd6e67b59bd71fcbb0ef9ef4756",
        "cloned_on": "2026-03-07",
        "recency": "2026-03-04",
        "version": null
    },
    "nvim-various-textobjs": {
        "location": "nvim-various-textobjs",
        "url": "https://github.com/chrisgrieser/nvim-various-textobjs",
        "sha": "34ca4f6b54cf167554c5792cacc69c930b654136",
        "cloned_on": "2026-03-07",
        "recency": "2026-02-10",
        "version": null
    },
    "Comment": {
        "location": "Comment",
        "url": "https://github.com/numToStr/Comment.nvim",
        "sha": "e30b7f2008e52442154b66f7c519bfd2f1e32acb",
        "cloned_on": "2026-03-07",
        "recency": "2024-06-09",
        "version": null
    },
    "todo-comments": {
        "location": "todo-comments",
        "url": "https://github.com/folke/todo-comments.nvim",
        "sha": "31e3c38ce9b29781e4422fc0322eb0a21f4e8668",
        "cloned_on": "2026-03-07",
        "recency": "2025-11-10",
        "version": null
    },
    "vim-commentary": {
        "location": "vim-commentary",
        "url": "https://github.com/tpope/vim-commentary",
        "sha": "64a654ef4a20db1727938338310209b6a63f60c9",
        "cloned_on": "2026-03-07",
        "recency": "2024-10-21",
        "version": null
    },
    "treesj": {
        "location": "treesj",
        "url": "https://github.com/Wansmer/treesj",
        "sha": "186084dee5e9c8eec40f6e39481c723dd567cb05",
        "cloned_on": "2026-03-07",
        "recency": "2025-12-08",
        "version": null
    },
    "dial": {
        "location": "dial",
        "url": "https://github.com/monaqa/dial.nvim",
        "sha": "f2634758455cfa52a8acea6f142dcd6271a1bf57",
        "cloned_on": "2026-03-07",
        "recency": "2025-12-21",
        "version": null
    },
    "harpoon-core": {
        "location": "harpoon-core",
        "url": "https://github.com/MeanderingProgrammer/harpoon-core.nvim",
        "sha": "61ccd5f77cb70fef6f96ddd00fe2bf7a9a3670fa",
        "cloned_on": "2026-03-07",
        "recency": "2025-08-29",
        "version": null
    },
    "marks": {
        "location": "marks",
        "url": "https://github.com/chentoast/marks.nvim",
        "sha": "f353e8c08c50f39e99a9ed474172df7eddd89b72",
        "cloned_on": "2026-03-07",
        "recency": "2025-05-13",
        "version": null
    },
    "markit": {
        "location": "markit",
        "url": "https://github.com/2KAbhishek/markit.nvim",
        "sha": "c716195d5b0b21ef03a20a1facc46d33ca9f7c49",
        "cloned_on": "2026-03-07",
        "recency": "2025-10-09",
        "version": null
    },
    "nvim-pasta": {
        "location": "nvim-pasta",
        "url": "https://github.com/hrsh7th/nvim-pasta",
        "sha": "7cc66bcf7101e40a6184b46a37eff0d5a43bde8d",
        "cloned_on": "2026-03-07",
        "recency": "2024-10-24",
        "version": null
    },
    "beam": {
        "location": "beam",
        "url": "https://github.com/Piotr1215/beam.nvim",
        "sha": "78c0cb21b2ad026768d2ff96f1570c4c2d5d8087",
        "cloned_on": "2026-03-07",
        "recency": "2026-01-29",
        "version": null
    },
    "blink.cmp": {
        "location": "blink.cmp",
        "url": "https://github.com/Saghen/blink.cmp",
        "sha": "e9556f9b981f395e22a6bfd69fd5f3008a2a6cd9",
        "cloned_on": "2026-03-07",
        "recency": "2026-03-05",
        "version": null
    },
    "nvim-cmp": {
        "location": "nvim-cmp",
        "url": "https://github.com/hrsh7th/nvim-cmp",
        "sha": "da88697d7f45d16852c6b2769dc52387d1ddc45f",
        "cloned_on": "2026-03-07",
        "recency": "2026-01-23",
        "version": null
    },
    "friendly-snippets": {
        "location": "friendly-snippets",
        "url": "https://github.com/rafamadriz/friendly-snippets",
        "sha": "6cd7280adead7f586db6fccbd15d2cac7e2188b9",
        "cloned_on": "2026-03-07",
        "recency": "2026-01-23",
        "version": null
    },
    "ultisnips": {
        "location": "ultisnips",
        "url": "https://github.com/SirVer/ultisnips",
        "sha": "b22a86f9dcc5257624bff3c72d8b902eac468aad",
        "cloned_on": "2026-03-07",
        "recency": "2025-06-05",
        "version": null
    },
    "LuaSnip": {
        "location": "LuaSnip",
        "url": "https://github.com/L3MON4D3/LuaSnip",
        "sha": "dae4f5aaa3574bd0c2b9dd20fb9542a02c10471c",
        "cloned_on": "2026-03-07",
        "recency": "2026-01-19",
        "version": null
    },
    "cmp-nvim-lsp": {
        "location": "cmp-nvim-lsp",
        "url": "https://github.com/hrsh7th/cmp-nvim-lsp",
        "sha": "cbc7b02bb99fae35cb42f514762b89b5126651ef",
        "cloned_on": "2026-03-07",
        "recency": "2025-11-13",
        "version": null
    },
    "cmp-buffer": {
        "location": "cmp-buffer",
        "url": "https://github.com/hrsh7th/cmp-buffer",
        "sha": "b74fab3656eea9de20a9b8116afa3cfc4ec09657",
        "cloned_on": "2026-03-07",
        "recency": "2025-04-01",
        "version": null
    },
    "cmp-path": {
        "location": "cmp-path",
        "url": "https://github.com/hrsh7th/cmp-path",
        "sha": "c642487086dbd9a93160e1679a1327be111cbc25",
        "cloned_on": "2026-03-07",
        "recency": "2025-07-30",
        "version": null
    },
    "cmp-cmdline": {
        "location": "cmp-cmdline",
        "url": "https://github.com/hrsh7th/cmp-cmdline",
        "sha": "d126061b624e0af6c3a556428712dd4d4194ec6d",
        "cloned_on": "2026-03-07",
        "recency": "2025-05-18",
        "version": null
    },
    "lsp-format": {
        "location": "lsp-format",
        "url": "https://github.com/lukas-reineke/lsp-format.nvim",
        "sha": "42d1d3e407c846d95f84ea3767e72ed6e08f7495",
        "cloned_on": "2026-03-07",
        "recency": "2025-05-08",
        "version": null
    },
    "lspkind": {
        "location": "lspkind",
        "url": "https://github.com/onsails/lspkind.nvim",
        "sha": "c7274c48137396526b59d86232eabcdc7fed8a32",
        "cloned_on": "2026-03-07",
        "recency": "2026-01-29",
        "version": null
    },
    "efm": {
        "location": "efm",
        "url": "https://github.com/mattn/efm-langserver",
        "sha": "011a299e9e73e9f837ad477a74f201debe27e061",
        "cloned_on": "2026-03-07",
        "recency": "2026-02-21",
        "version": null
    },
    "lspsaga": {
        "location": "lspsaga",
        "url": "https://github.com/nvimdev/lspsaga.nvim",
        "sha": "562d9724e3869ffd1801c572dd149cc9f8d0cc36",
        "cloned_on": "2026-03-07",
        "recency": "2026-03-03",
        "version": null
    },
    "lazydev": {
        "location": "lazydev",
        "url": "https://github.com/folke/lazydev.nvim",
        "sha": "5231c62aa83c2f8dc8e7ba957aa77098cda1257d",
        "cloned_on": "2026-03-07",
        "recency": "2025-11-06",
        "version": null
    },
    "rustaceanvim": {
        "location": "rustaceanvim",
        "url": "https://github.com/mrcjkb/rustaceanvim",
        "sha": "f2f0c1231a5b019dbc1fd6dafac1751c878925a3",
        "cloned_on": "2026-03-07",
        "recency": "2026-03-04",
        "version": null
    },
    "crates": {
        "location": "crates",
        "url": "https://github.com/saecki/crates.nvim",
        "sha": "ac9fa498a9edb96dc3056724ff69d5f40b898453",
        "cloned_on": "2026-03-07",
        "recency": "2025-08-23",
        "version": null
    },
    "haskell-tools": {
        "location": "haskell-tools",
        "url": "https://github.com/mrcjkb/haskell-tools.nvim",
        "sha": "6e2016272ad21fdbe5c8bf8eb7f0342df8061672",
        "cloned_on": "2026-03-07",
        "recency": "2026-03-01",
        "version": null
    },
    "none-ls": {
        "location": "none-ls",
        "url": "https://github.com/nvimtools/none-ls.nvim",
        "sha": "f61f46ded0ca9edce7a09b674f8e162d10921426",
        "cloned_on": "2026-03-07",
        "recency": "2026-02-16",
        "version": null
    },
    "guard": {
        "location": "guard",
        "url": "https://github.com/nvimdev/guard.nvim",
        "sha": "addb8d2f40662b8b62d60dd7d18f503beb2332e7",
        "cloned_on": "2026-03-07",
        "recency": "2026-01-31",
        "version": null
    },
    "conform": {
        "location": "conform",
        "url": "https://github.com/stevearc/conform.nvim",
        "sha": "40dcec5555f960b0a04340d76eabdf4efe78599d",
        "cloned_on": "2026-03-07",
        "recency": "2026-03-01",
        "version": null
    },
    "overseer": {
        "location": "overseer",
        "url": "https://github.com/stevearc/overseer.nvim",
        "sha": "2802c15182dae2de71f9c82e918d7ba850b90c22",
        "cloned_on": "2026-03-07",
        "recency": "2026-02-23",
        "version": null
    },
    "asyncrun": {
        "location": "asyncrun",
        "url": "https://github.com/skywind3000/asyncrun.vim",
        "sha": "98d3c0fdeb983f0ef62fe3a49da440f6d2c045ce",
        "cloned_on": "2026-03-07",
        "recency": "2025-11-21",
        "version": null
    },
    "compiler": {
        "location": "compiler",
        "url": "https://github.com/Zeioth/compiler.nvim",
        "sha": "c09ab4e795b92378727d7377c03b0d5c2453957c",
        "cloned_on": "2026-03-07",
        "recency": "2025-08-14",
        "version": null
    },
    "code_runner": {
        "location": "code_runner",
        "url": "https://github.com/CRAG666/code_runner.nvim",
        "sha": "3be33a8d4ce36e453fc09258c9093f9ecf452964",
        "cloned_on": "2026-03-07",
        "recency": "2026-02-13",
        "version": null
    },
    "sniprun": {
        "location": "sniprun",
        "url": "https://github.com/michaelb/sniprun",
        "sha": "973acfe83cff35d13b95369a5606c47565b824fb",
        "cloned_on": "2026-03-07",
        "recency": "2026-02-26",
        "version": null
    },
    "yabs": {
        "location": "yabs",
        "url": "https://github.com/pianocomposer321/officer.nvim",
        "sha": "29df3cd138bbc453ab71303f8f64ff04a599fc90",
        "cloned_on": "2026-03-07",
        "recency": "2025-09-09",
        "version": null
    },
    "neotest-haskell": {
        "location": "neotest-haskell",
        "url": "https://github.com/MrcJkb/neotest-haskell",
        "sha": "732a258dd480b9dd71d76185600f3fc4426e92eb",
        "cloned_on": "2026-03-07",
        "recency": "2026-03-01",
        "version": null
    },
    "neotest-python": {
        "location": "neotest-python",
        "url": "https://github.com/nvim-neotest/neotest-python",
        "sha": "b0d3a861bd85689d8ed73f0590c47963a7eb1bf9",
        "cloned_on": "2026-03-07",
        "recency": "2025-10-13",
        "version": null
    },
    "neotest": {
        "location": "neotest",
        "url": "https://github.com/nvim-neotest/neotest",
        "sha": "deadfb1af5ce458742671ad3a013acb9a6b41178",
        "cloned_on": "2026-03-07",
        "recency": "2025-11-08",
        "version": null
    },
    "dap-python": {
        "location": "dap-python",
        "url": "https://codeberg.org/mfussenegger/nvim-dap-python",
        "sha": "1808458eba2b18f178f990e01376941a42c7f93b",
        "cloned_on": "2026-03-07",
        "recency": "2025-12-20",
        "version": null
    },
    "dapui": {
        "location": "dapui",
        "url": "https://github.com/rcarriga/nvim-dap-ui",
        "sha": "cf91d5e2d07c72903d052f5207511bf7ecdb7122",
        "cloned_on": "2026-03-07",
        "recency": "2025-07-09",
        "version": null
    },
    "nvim-dap-virtual-text": {
        "location": "nvim-dap-virtual-text",
        "url": "https://github.com/theHamsta/nvim-dap-virtual-text",
        "sha": "fbdb48c2ed45f4a8293d0d483f7730d24467ccb6",
        "cloned_on": "2026-03-07",
        "recency": "2025-05-25",
        "version": null
    },
    "dap": {
        "location": "dap",
        "url": "https://codeberg.org/mfussenegger/nvim-dap",
        "sha": "b516f20b487b0ac6a281e376dfac1d16b5040041",
        "cloned_on": "2026-03-07",
        "recency": "2026-02-26",
        "version": null
    },
    "mypy": {
        "location": "mypy",
        "url": "https://github.com/feakuru/mypy.nvim",
        "sha": "43f9e095441bbe7c7281b9a888728dc2d87ffc4f",
        "cloned_on": "2026-03-07",
        "recency": "2025-08-26",
        "version": null
    },
    "nvim-lint": {
        "location": "nvim-lint",
        "url": "https://github.com/mfussenegger/nvim-lint",
        "sha": "606b823a57b027502a9ae00978ebf4f5d5158098",
        "cloned_on": "2026-03-07",
        "recency": "2026-02-23",
        "version": null
    },
    "trouble.nvim": {
        "location": "trouble.nvim",
        "url": "https://github.com/folke/trouble.nvim",
        "sha": "bd67efe408d4816e25e8491cc5ad4088e708a69a",
        "cloned_on": "2026-03-07",
        "recency": "2025-10-31",
        "version": null
    },
    "quicker": {
        "location": "quicker",
        "url": "https://github.com/stevearc/quicker.nvim",
        "sha": "2d3f3276eab9352c7b212821c218aca986929f62",
        "cloned_on": "2026-03-07",
        "recency": "2026-02-22",
        "version": null
    },
    "nvim-bqf": {
        "location": "nvim-bqf",
        "url": "https://github.com/kevinhwang91/nvim-bqf",
        "sha": "f65fba733268ffcf9c5b8ac381287eca7c223422",
        "cloned_on": "2026-03-07",
        "recency": "2026-02-02",
        "version": null
    },
    "vim-floaterm": {
        "location": "vim-floaterm",
        "url": "https://github.com/voldikss/vim-floaterm",
        "sha": "0ab5eb8135dc884bc543a819ac7033c15e72a76b",
        "cloned_on": "2026-03-07",
        "recency": "2026-02-10",
        "version": null
    },
    "refactoring": {
        "location": "refactoring",
        "url": "https://github.com/ThePrimeagen/refactoring.nvim",
        "sha": "6784b54587e6d8a6b9ea199318512170ffb9e418",
        "cloned_on": "2026-03-07",
        "recency": "2025-10-21",
        "version": null
    },
    "project": {
        "location": "project",
        "url": "https://github.com/ahmedkhalf/project.nvim",
        "sha": "8c6bad7d22eef1b71144b401c9f74ed01526a4fb",
        "cloned_on": "2026-03-07",
        "recency": "2023-04-03",
        "version": null
    },
    "telescope-project": {
        "location": "telescope-project",
        "url": "https://github.com/nvim-telescope/telescope-project.nvim",
        "sha": "8e11df94419e444601c09828dadf70890484e443",
        "cloned_on": "2026-03-07",
        "recency": "2025-04-23",
        "version": null
    },
    "jj": {
        "location": "jj",
        "url": "https://github.com/NicolasGB/jj.nvim",
        "sha": "bbba4051c862473637e98277f284d12b050588ca",
        "cloned_on": "2026-03-07",
        "recency": "2026-02-24",
        "version": null
    },
    "jujutsu": {
        "location": "jujutsu",
        "url": "https://github.com/yannvanhalewyn/jujutsu.nvim",
        "sha": "348a208a92f054d70bc24b73dde11261f3b765c7",
        "cloned_on": "2026-03-07",
        "recency": "2026-02-05",
        "version": null
    },
    "lazygit": {
        "location": "lazygit",
        "url": "https://github.com/kdheepak/lazygit.nvim",
        "sha": "a04ad0dbc725134edbee3a5eea29290976695357",
        "cloned_on": "2026-03-07",
        "recency": "2025-12-19",
        "version": null
    },
    "git-conflict": {
        "location": "git-conflict",
        "url": "https://github.com/akinsho/git-conflict.nvim",
        "sha": "a1badcd070d176172940eb55d9d59029dad1c5a6",
        "cloned_on": "2026-03-07",
        "recency": "2024-12-27",
        "version": null
    },
    "neogit": {
        "location": "neogit",
        "url": "https://github.com/NeogitOrg/neogit",
        "sha": "7073f3aafc9030d457838995106784a9d1873b3b",
        "cloned_on": "2026-03-07",
        "recency": "2026-03-05",
        "version": null
    },
    "jiejie": {
        "location": "jiejie",
        "url": "https://github.com/jceb/jiejie.nvim",
        "sha": "6adaa521f91ecfc16ac254ee7a0c5a79e0829a35",
        "cloned_on": "2026-03-07",
        "recency": "2026-03-05",
        "version": null
    },
    "diffview": {
        "location": "diffview",
        "url": "https://github.com/sindrets/diffview.nvim",
        "sha": "4516612fe98ff56ae0415a259ff6361a89419b0a",
        "cloned_on": "2026-03-07",
        "recency": "2024-06-13",
        "version": null
    },
    "gitsigns": {
        "location": "gitsigns",
        "url": "https://github.com/lewis6991/gitsigns.nvim",
        "sha": "9f3c6dd7868bcc116e9c1c1929ce063b978fa519",
        "cloned_on": "2026-03-07",
        "recency": "2026-02-13",
        "version": null
    },
    "vim-fugitive": {
        "location": "vim-fugitive",
        "url": "https://github.com/tpope/vim-fugitive",
        "sha": "61b51c09b7c9ce04e821f6cf76ea4f6f903e3cf4",
        "cloned_on": "2026-03-07",
        "recency": "2025-07-15",
        "version": null
    },
    "octo": {
        "location": "octo",
        "url": "https://github.com/pwntester/octo.nvim",
        "sha": "c14f5b6ee92f0b2717efd525211bcb6cebf03fa6",
        "cloned_on": "2026-03-07",
        "recency": "2026-03-04",
        "version": null
    },
    "gitlab-nvim": {
        "location": "gitlab-nvim",
        "url": "https://github.com/harrisoncramer/gitlab.nvim",
        "sha": "3d2828a9504b87fc36ee2aca1b0f36cf75003edd",
        "cloned_on": "2026-03-07",
        "recency": "2026-01-30",
        "version": null
    },
    "gitlab": {
        "location": "gitlab",
        "url": "https://gitlab.com/gitlab-org/editor-extensions/gitlab.vim",
        "sha": "191eecd7f8a2f563054c6574b0f1969970dadb7d",
        "cloned_on": "2026-03-07",
        "recency": "2026-03-05",
        "version": null
    },
    "dashboard-nvim": {
        "location": "dashboard-nvim",
        "url": "https://github.com/nvimdev/dashboard-nvim",
        "sha": "0775e567b6c0be96d01a61795f7b64c1758262f6",
        "cloned_on": "2026-03-07",
        "recency": "2025-08-31",
        "version": null
    },
    "dashboard": {
        "location": "dashboard",
        "url": "https://github.com/MeanderingProgrammer/dashboard.nvim",
        "sha": "ba80a1e57feb278872c6bb5c2b1048a80b58e921",
        "cloned_on": "2026-03-07",
        "recency": "2025-10-13",
        "version": null
    },
    "noice": {
        "location": "noice",
        "url": "https://github.com/folke/noice.nvim",
        "sha": "7bfd942445fb63089b59f97ca487d605e715f155",
        "cloned_on": "2026-03-07",
        "recency": "2025-11-03",
        "version": null
    },
    "modes": {
        "location": "modes",
        "url": "https://github.com/mvllow/modes.nvim",
        "sha": "0932ba4e0bdc3457ac89a8aeed4d56ca0b36977a",
        "cloned_on": "2026-03-07",
        "recency": "2025-09-13",
        "version": null
    },
    "fidget": {
        "location": "fidget",
        "url": "https://github.com/j-hui/fidget.nvim",
        "sha": "7fa433a83118a70fe24c1ce88d5f0bd3453c0970",
        "cloned_on": "2026-03-07",
        "recency": "2026-01-13",
        "version": null
    },
    "nvim-notify": {
        "location": "nvim-notify",
        "url": "https://github.com/rcarriga/nvim-notify",
        "sha": "8701bece920b38ea289b457f902e2ad184131a5d",
        "cloned_on": "2026-03-07",
        "recency": "2025-09-06",
        "version": null
    },
    "headlines": {
        "location": "headlines",
        "url": "https://github.com/lukas-reineke/headlines.nvim",
        "sha": "bf17c96a836ea27c0a7a2650ba385a7783ed322e",
        "cloned_on": "2026-03-07",
        "recency": "2024-09-13",
        "version": null
    },
    "auto-session": {
        "location": "auto-session",
        "url": "https://github.com/rmagatti/auto-session",
        "sha": "62437532b38495551410b3f377bcf4aaac574ebe",
        "cloned_on": "2026-03-07",
        "recency": "2026-02-15",
        "version": null
    },
    "persistence": {
        "location": "persistence",
        "url": "https://github.com/folke/persistence.nvim",
        "sha": "b20b2a7887bd39c1a356980b45e03250f3dce49c",
        "cloned_on": "2026-03-07",
        "recency": "2025-10-28",
        "version": null
    },
    "vimtex": {
        "location": "vimtex",
        "url": "https://github.com/lervag/vimtex",
        "sha": "82d2305ff71dfb3bd91602534cc9bb9a195bcb38",
        "cloned_on": "2026-03-07",
        "recency": "2026-03-04",
        "version": null
    },
    "texmagic": {
        "location": "texmagic",
        "url": "https://github.com/jakewvincent/texmagic.nvim",
        "sha": "8172d2d974b444dcc996d87a9e05723348676d5e",
        "cloned_on": "2026-03-07",
        "recency": "2026-03-02",
        "version": null
    },
    "schemastore": {
        "location": "schemastore",
        "url": "https://github.com/b0o/SchemaStore.nvim",
        "sha": "e75f2362624698864957a694d80ca0c116bd24d3",
        "cloned_on": "2026-03-07",
        "recency": "2026-03-04",
        "version": null
    },
    "firenvim": {
        "location": "firenvim",
        "url": "https://github.com/glacambre/firenvim",
        "sha": "a18ef908ac06b52ad9333b70e3e630b0a56ecb3d",
        "cloned_on": "2026-03-07",
        "recency": "2025-09-30",
        "version": null
    },
    "render-markdown": {
        "location": "render-markdown",
        "url": "https://github.com/MeanderingProgrammer/render-markdown.nvim",
        "sha": "907505549edc2f90c82fc429348af03ee8c3a825",
        "cloned_on": "2026-03-07",
        "recency": "2026-03-05",
        "version": null
    },
    "jupytext": {
        "location": "jupytext",
        "url": "https://github.com/GCBallesteros/jupytext.nvim",
        "sha": "c8baf3ad344c59b3abd461ecc17fc16ec44d0f7b",
        "cloned_on": "2026-03-07",
        "recency": "2024-04-05",
        "version": null
    },
    "quarto": {
        "location": "quarto",
        "url": "https://github.com/quarto-dev/quarto-nvim",
        "sha": "d923bb7cfc2bde41143e1c531c28190f0fade3a2",
        "cloned_on": "2026-03-07",
        "recency": "2026-01-29",
        "version": null
    },
    "markdown-preview": {
        "location": "markdown-preview",
        "url": "https://github.com/iamcco/markdown-preview.nvim",
        "sha": "a923f5fc5ba36a3b17e289dc35dc17f66d0548ee",
        "cloned_on": "2026-03-07",
        "recency": "2023-10-17",
        "version": null
    },
    "structlog": {
        "location": "structlog",
        "url": "https://github.com/Tastyep/structlog.nvim",
        "sha": "45b26a2b1036bb93c0e83f4225e85ab3cee8f476",
        "cloned_on": "2026-03-07",
        "recency": "2023-01-08",
        "version": null
    },
    "neorepl": {
        "location": "neorepl",
        "url": "https://github.com/ii14/neorepl.nvim",
        "sha": "15f4c4e523e1fbec74766e1967e1c2491df013c9",
        "cloned_on": "2026-03-07",
        "recency": "2024-06-02",
        "version": null
    }
}
```
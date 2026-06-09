-- print("This ran before.")
-- print()
-- print(vim.inspect(vim.opt.runtimepath))
-- print(vim.inspect(vim.opt.packpath))

-- print(vim.o.runtimepath:find(vim.env.VIMRUNTIME) ~= nil)
-- -- vim.o.runtimepath:prepend(vim.env.VIMRUNTIME)
-- print(vim.o.runtimepath:find(vim.env.VIMRUNTIME) ~= nil)

-- print(vim.env.VIMRUNTIME)
-- vim.opt.runtimepath:prepend(vim.env.VIMRUNTIME)
-- print(vim.o.runtimepath:find(vim.env.VIMRUNTIME, 1, true) ~= nil)

-- print(vim.inspect(vim.opt.runtimepath))
-- print(vim.inspect(vim.opt.packpath))

VERBOSE = false
SAFE = false
LAYERS = nil

--[[

-------------------------------------------------------------------------------
NOW: --------------------------------------------------------------------------
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
SOON: -------------------------------------------------------------------------
-------------------------------------------------------------------------------




---------------- inception -------------



---------------- search/rename -------------


---------------- terminals -------------


---------------- k8s -------------




---------------- unsorted -------------
- neowell-lua
- control-panel
- date-time-inserter
- dmap
- doc-window
- doing
- dotdot
- easycolor
- edit-list
- equals
- export-colorscheme
- feed
- flashcards
- flote
- fsplash
- fsread
- hierarchy
- highlight-current-n-nvim
- http-codes
- ido
- indent-tools
- inlayhint-filler
- interlaced
- ivy
- jvim
- keymapper
- keyseer
- Launch
- license
- live-server
- lvim-ui-config
- menu
- metrics
- minimal-narrow-region
- moonicipal
- navigator
- neocomposer-nvim
- neotest-plenary
- neowords
- nerdy
- nvim_winpick
- nvim-api-wrappers
- nvim-cmp-fonts
- nvim-cmp-lua-latex-symbols
- nvim-genghis               | https://github.com/chrisgrieser/nvim-genghis Lightweight and quick file operations without being a full-blown file manager.
- output-panel
- paint
- pathlib
- pragma
- quicknote
- reactive
- regex-vars
- renamer
- resin
- retrospect
- runtimetable
- sche
- search-replace
- sentiment-nvim
- sg
- sort
- spaceport-nvim
- spear
- strict
- symbols
- tdo
- telescope-code-actions
- telescope-file-browser
- telescope-github
- telescope-json-history
- telescope-project
- telescope-repo
- telescope-smart-history
- telescope-xc
- tracebundler
- treemonkey
- TreePin
- twig
- ultimate-autopair-nvim
- vim-twig
- vuffers
- wastebin
- web-tools
- wf
- whaler
- wildfire
- windows

-------------------------------------------------------------------------------
VENDOR: -----------------------------------------------------------------------
-------------------------------------------------------------------------------

- k8vim
- telemake
- virtcolumn
- wezterm-nvim
- AdvancedNewFile  | https://github.com/Mohammed-Taher/AdvancedNewFile.nvim
- spread  (uses nvim-treesitter)

-------------------------------------------------------------------------------
DEFERRED: ---------------------------------------------------------------------
-------------------------------------------------------------------------------
- knap             | https://github.com/frabjous/knap
- zpragmatic       | https://github.com/muhammadzkralla/zpragmatic.nvim  prompts you with alert dialog questions whenever you attempt to save changes in a file
- commons
- volt             | https://github.com/nvzone/volt  Create blazing fast & beautiful reactive UI in Neovim

- panvimdoc
- qalc
- channelot
- nvim-mail-merge

- jaq-nvim         | https://github.com/is0n/jaq-nvim Just Another Quickrun Plugin for Neovim in Lua

- xkbswitch
- cyrillic
- present

- cmdTree          | https://github.com/CWood-sdf/cmdTree.nvim  Declaratively make your neovim user commands
- cmp_bulma
- cmp-nvim-lsp-signature-help
- cmp-nvim-telekasten-tags

- better-digraphs


- vim-slime

- keymap-amend-nvim        | https://github.com/anuvyklack/keymap-amend.nvim


- carbon-now-nvim
- showkeys           | https://github.com/nvzone/showkeys

- drop                | https://github.com/folke/drop.nvim  Fun little plugin that can be used as a screensaver and on your dashboard

- endpoint-previewer


---------------- time -------------
- pommodoro-clock
- pomodoro
- timerly
- timew
- nomodoro

---------------- pkm -------------
- vimwiki
- neorg
- neorg-taskwarrior
- obsidian
- orgmode
- Calendar
- zettelkasten
- tktodo          | https://github.com/tarting/tktodo.nvim  A telescope extension to toggle todo items in notes from the telekasten.nvim home directory.
- daily-focus

---------------- performance -------------
- keylab          | https://github.com/BooleanCube/keylab.nvim
- apm             | 

---------------- ai -------------
- avante          | https://github.com/yetone/avante.nvim
- codecompanion   | 
- llm
- vim-ai


---------------- alternative lines -------------
- cokeline
- galaxyline
- heirline
- heirline-components
- nougat
- staline
- tabby
- minibar
- winbar
- windline


---------------- alternative explorers -------------
- chadtree
- neo-tree

---------------- build -------------

- compiler
- compiler-nvim
- xmake
- yabs

---------------- color -------------
- text-to-colorscheme
- minty
- color-picker
- baleia         | Colorize text with ANSI escape sequences (8, 16, 256 or TrueColor)
- bamboo
- kreative               | https://github.com/katawful/kreative  A colorscheme creation tool for Neovim, written in Fennel with Aniseed

-------------------------------------------------------------------------------
IN MISCELLANEOUS: -------------------------------------------------------------
-------------------------------------------------------------------------------

- asyncrun
- markdown-preview
- dashboard
- dashboard-nvim
- schemastore
- vimtex
- render-markdown
- structlog
- texmagic



-------------------------------------------------------------------------------
PROBABLY NOT, BUT WORTH A TRY: ------------------------------------------------
-------------------------------------------------------------------------------

- ts-context-commentstring
- vim-wordmotion
- hop                     | 
- clever-f.vim            | 
- better-escape           | 
- hlsearch-nvim           | 
- improved-search-nvim    | 
- vim-edgemotion          | 
- efm                     | 
- notify                  | (== nvim-notify ?)
- lsp_signature           | 
- nvim-whichkey-setup.lua | 
- nvim-teal-maker         | 
- cmdbuf                  | https://github.com/notomo/cmdbuf.nvim
- nvim-rg                 | https://github.com/duane9/nvim-rg
- homerows                  | https://github.com/unode/homerow.vim/blob/master/autoload/homerow.vim

- vim-multiple-cursors

- savior
- vim-auto-save

- shade
- subglasses

-------------------------------------------------------------------------------
DECIDED AGAINST: --------------------------------------------------------------
-------------------------------------------------------------------------------
- guard
- nvim-treesitter
- splitjoin.vim    | kept lua version
- none-ls
- nvim-alt-substitute | archived; superseded by nvim-rip-substitute
- pylsp-rope
- tree-sitter-just

--]]

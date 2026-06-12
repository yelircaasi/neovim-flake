# neovim-flake

## Roadmap

Add cloud.lua

```lua
	-------------------------------------------------------------------------------
	-- DECIDED AGAINST: --------------------------------------------------------------
	-------------------------------------------------------------------------------
	-- utils.packadd("vim-twig")
	-- setup_plugin("tree-sitter-just", {})
	-- setup_plugin("guard", {})
	-- setup_plugin("nvim-treesitter", {})
	-- setup_plugin("splitjoin.vim", {})   -- kept lua version
	-- setup_plugin("none-ls", {})
	-- setup_plugin("nvim-alt-substitute", {})-- archived; superseded by nvim-rip-substitute
	-- setup_plugin("pylsp-rope", {})
```

More complicated installations:

```lua
  setup_plugin("ido", {}) -- 'fzy.lua' not found
  setup_plugin("ivy", {}) -- libivyrs.so not found
```

Set up `efm` as language server, not plugin

fix dependency: ts-context-commentstring
```lua
	setup_plugin("structlog", {})
```

Set up telescope extensions:

```lua
	setup_plugin("tktodo", {}) -- https://github.com/tarting/tktodo.nvim  A telescope extension to toggle todo items in notes from the telekasten.nvim home directory.
	setup_plugin("telescope-code-actions", {})
	setup_plugin("telescope-file-browser", {})
	setup_plugin("telescope-github", {})
	setup_plugin("telescope-json-history", {})
	setup_plugin("telescope-project", {})
	setup_plugin("telescope-repo", {})
	setup_plugin("telescope-smart-history", {})
	setup_plugin("telescope-xc", {})
```

Set up completion sources:

```lua
	setup_plugin("cmp_bulma", {})
	setup_plugin("cmp-nvim-lsp-signature-help", {})
	setup_plugin("cmp-nvim-telekasten-tags", {})
	setup_plugin("cmp-fonts", {})
	setup_plugin("cmp-lua-latex-symbols", {}) -- TODO: rebuild nix
```

Resolve neorg dependencies

- treesitter, pathlib, utils.lua, etc: https://github.com/nvim-neorg/neorg#neorg-kickstart

```lua
	setup_plugin("neorg", {})
	setup_plugin("neorg-taskwarrior", {})
```

neorg-taskwarrior behaves as a neorg plugin, not a top-level plugin

- VENDOR: -----------------------------------------------------------------------
  - https://github.com/letieu/wezterm-move.nvim
  - minimal-narrow-region
  - nvim-api-wrappers
  - k8vim
  - telemake
  - virtcolumn
  - wezterm-nvim
  - AdvancedNewFile  | https://github.com/Mohammed-Taher/AdvancedNewFile.nvim
  - spread  (uses nvim-treesitter)
  - fsread
  - tracebundler
  - https://github.com/mawkler/move-mode.nvim

- set up with at least minimal config: ------------------------------------------
  - [x] mypy
  - [x] lsp-format
  - [x] lspkind
  - [x] lspsaga
  - [x] trouble.nvim
  - [x] quicker
  - [x] null-ls
  - [x] nvim-lint
  - [x] refactoring
  - [x] NeoComposer
  - [x] recorder
  - [x] auto-session
  - [x] persistence
  - [x] project_nvim
  - [x] deck
  - [x] neotest-python
  - [x] rustaceanvim
  - [x] haskell-tools
  - [x] lazydev
  - [x] crates
  - [x] cargo
  - [x] neorepl

- LATER:
  - [ ] hydra
  - [ ] neotest-haskell
  - [ ] go
  - [ ] gopher
  - [ ] texmagic
  - [ ] vimtex
  - [ ] quarto
  - [ ] structlog
  - [ ] noice
  - [ ] modes
  - [ ] firenvim
  - [ ] schemastore

- https://github.com/skanehira/k8s.vim
- https://github.com/m00qek/baleia.nvim
- https://www.reddit.com/r/rust/comments/1efj1ci/is_it_possible_to_use_clippy_with_nvim_and_get/

- xit rewrite
- wezterm_send
- consilium

- add minvim: minimal nvim (or just vim?) executable+config with good colorscheme and nothing (or very little) else, for quick edits (like open nvim with wezterm visible)
- add jsregexp for luasnip
- load python snippets from various formats
-

- [ ] gather all nvim configs I have written, glean what
      is still usable, combine them here
- [x] fork dial, fix structure, write nix expression
- [ ] take care of compiling fzf-lua-native
- [ ] find what has  sqlite.lua as a dependency
- [ ] move last bits of plugin-set.nix into plugins-derivation.nix,
      make each into own derivation? -> pass through as output packages
- [ ] go through, clean up and pare down notes
- [ ] get Python LSP running properly

https://github.com/idris-community/idris2-nvim

https://ayats.org/blog/neovim-wrapper
https://github.com/calops/nix/tree/main/modules/home/programs/neovim

[ ] https://github.com/yelircaasi/neovim-flake
[ ] https://github.com/yelircaasi/nvim-pde-via-nix
[ ] https://github.com/yelircaasi/nvim-config-old
[ ] https://github.com/yelircaasi/neovim-ide-flake
[ ] https://github.com/yelircaasi/neovim-python-pde
[ ] 
[ ] https://github.com/youwen5/viminal2 *********
[ ] https://primamateria.github.io/blog/neovim-nix/
[ ] https://github.com/gvolpe/neovim-flake
[ ] https://github.com/jordanisaacs/neovim-flake
[ ] https://github.com/wiltaylor/neovim-flake
[ ] https://github.com/cwfryer/neovim-flake/
[ ] https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#plugin-template

- [ ] https://github.com/tpope/vim-unimpaired/
- [ ] https://github.com/fedepujol/move.nvim

- [ ] add custom syntax highlighting (later maybe even LSPs) for pictrix and kleidoukhos DSLs: analogous to,
      and using similar setups to, consilium DSLs -> write treesitter parsers someday

-[ ] install cooklang LSP and tooling

https://github.com/LuxVim/nvim-luxterm
https://github.com/luxvim/LuxVim

## Data Flow

`plugin-set.nix` gets plugins from `nixpkgs` and `self-packaged-plugins.nix`.

`plugins-derivation.nix` packages the plugins together in the standard directory structure.

`transpilation.nix` transforms the `.tl` code into Lua and writes it as a derivation.

`treesitter.nix` takes care of 

`tools.nix` handles the external tools.

`pde.nix` wires all of these parts together and exposes the executables.



## Old Roadmap

```txt
2026-03-21

==================
=== TO HACK ON ===
==================

oxi

===============
=== SOMEDAY ===
===============

compiler-explorer
dotbox
oceanic-material
quarto
render
telescope-file-history
trouble.nvim
typescript-tools
typst
vague
metals
neotest-scala
nfnl
BufEx
gopher
gruvbox-material
hologram
image_preview
jupytext
cloak

=================
=== TO VENDOR ===
=================

vim-capslock
vim-numbertoggle
vim-repeat
wb-only-current-line
nvim-trevJ.lua
git-blame.vim
dsf.vim
lastplace
local-yokel
checkupdate
editorconfig

```

https://www.youtube.com/watch?v=HLp879ZDhVc
https://www.youtube.com/playlist?list=PLPDVgSbOnt7LXQ8DTzu37UwCpA0elyD0V
- [ ] [USE] trouble.nvim
- [ ] [VENDOR] wezterm.nvim https://github.com/willothy/wezterm.nvim
- [ ] [VENDOR] wezterm-move.nvim https://github.com/letieu/wezterm-move.nvim
- [ ] [USE] conform.nvim
- [ ] [USE] lazydev.nvim
- [ ] [USE] fidget.nvim
- [ ] [USE] https://github.com/mrjones2014/smart-splits.nvim
- [ ] [TRY] luasnip
- [ ] [TRY] oil
- [ ] [TRY] blink.cmp
- [ ] [TRY] mini.nvim
- [ ] [TRY] flash.nvim
- [ ] [TRY] SmiteshP/nvim-navic
- [ ] [TRY] grug-far.nvim https://github.com/MagicDuck/grug-far.nvim
- [ ] [TRY] mfussenegger/nvim-dap and rcarriga/nvim-dap-ui
- [ ] [TRY] [lazygit](https://github.com/kdheepak/lazygit.nvim) / [neogit](https://github.com/NeogitOrg/neogit)
- [ ] [TRY] https://github.com/hrsh7th/nvim-deck
- [ ] [TRY] neo-tree.nvim
- [ ] [TRY] rainbow-delimiters.nvim
- [ ] [TRY] modes.nvim
- [ ] [TRY] render-markdown.nvim
- [ ] [TRY] telescope.nvim
- [ ] [TRY] hlsearch.nvim
- [ ] [TRY] https://github.com/nvimtools/none-ls.nvim/
- [ ] [TRY] https://github.com/b0o/schemastore.nvim
- [ ] [LATER] https://github.com/Tastyep/structlog.nvim
- [ ] [TRY] snacks.nvim
    - [ ] [] animate      Efficient animations including over 45 easing functions (library)    
    - [ ] [] bigfile      Deal with big files (extra config required!)
    - [ ] [] bufdelete    Delete buffers without disrupting window layout    
    - [ ] [] dashboard    Beautiful declarative dashboards (extra config required!)
    - [ ] [] debug        Pretty inspect & backtraces for debugging    
    - [ ] [] dim          Focus on the active scope by dimming the rest    
    - [ ] [] explorer     A file explorer (picker in disguise) (extra config required!)
    - [ ] [TRY] gh           GitHub CLI integration    
    - [ ] [TRY] git          Git utilities    
    - [ ] [TRY] gitbrowse    Open the current file, branch, commit, or repo in a browser (e.g. GitHub, GitLab, Bitbucket)    
    - [ ] [] image        Image viewer using Kitty Graphics Protocol, supported by kitty, wezterm and ghostty (extra config required!)
    - [ ] [] indent       Indent guides and scopes    
    - [ ] [] input        Better vim.ui.input (extra config required!)
    - [ ] [] keymap       Better vim.keymap with support for filetypes and LSP clients    
    - [ ] [] layout       Window layouts    
    - [ ] [] lazygit      Open LazyGit in a float, auto-configure colorscheme and integration with Neovim    
    - [ ] [] notifier     Pretty vim.notify (extra config required!)
    - [ ] [] notify       Utility functions to work with Neovim's vim.notify    
    - [ ] [] picker       Picker for selecting items (extra config required!)
    - [ ] [] profiler     Neovim lua profiler    
    - [ ] [TRY] quickfile    When doing nvim somefile.txt, it will render the file as quickly as possible, before loading your plugins. (extra config required!)
    - [ ] [TRY] rename       LSP-integrated file renaming with support for plugins like neo-tree.nvim and mini.files.    
    - [ ] [] scope        Scope detection, text objects and jumping based on treesitter or indent (extra config required!)
    - [ ] [] scratch      Scratch buffers with a persistent file    
    - [ ] [] scroll       Smooth scrolling (extra config required!)
    - [ ] [] statuscolumn Pretty status column (extra config required!)
    - [ ] [] terminal     Create and toggle floating/split terminals    
    - [ ] [] toggle       Toggle keymaps integrated with which-key icons / colors    
    - [ ] [] util         Utility functions for Snacks (library)    
    - [ ] [] win          Create and manage floating windows or splits    
    - [ ] [] words        Auto-show LSP references and quickly navigate between them (extra config required!)
    - [ ] [] zen          Zen mode • distraction-free coding
- [ ] go through [nvimdev](https://nvimdev.github.io)
    - [ ] [] [TRY] flybuf.nvim: Show buffers list in float window and quickly navigate between
    - [ ] [] [TRY] guard.nvim: Async format and linting utility for Neovim
    - [ ] [] [TRY] indentmini.nvim: A minimalist indent plugin https://github.com/nvimdev/indentmini.nvim
    - [ ] [] [TRY] mdashboard-nvim: Fancy Neovim start screen
    - [ ] [] [USE] lspsaga.nvim: Neovim LSP enhancement plugin
    - [ ] [] dbsession.nvim: A simple session management plugin
    - [ ] [] dyninput.nvim: Dynamically change input character
    - [ ] [] nerdicons.nvim: Search, copy, and paste Nerd Fonts icons
    - [ ] [] template.nvim: Template for Neovim
- [ ] go through [mini suite](https://nvim-mini.org/mini.nvim/)
    - [ ] [] editing
        - [ ] [] mini.ai          Extend and create a/i textobjects
        - [ ] [TRY] mini.align    Align text interactively
        - [ ] [] mini.comment    Comment lines
        - [ ] [] mini.completion    Completion and signature help
        - [ ] [TRY] mini.keymap    Special key mappings
        - [ ] [TRY] mini.move          Move any selection in any direction
        - [ ] [TRY] mini.operators    Text edit operators
        - [ ] [TRY] mini.pairs          Autopairs
        - [ ] [] mini.snippets    Manage and expand snippets
        - [ ] [] mini.splitjoin    Split and join arguments
        - [ ] [TRY] mini.surround    Surround actions
    - [ ] [] workflow
        - [ ] [] mini.basics    Common configuration presets
        - [ ] [] mini.bracketed    Go forward/backward with square brackets
        - [ ] [] mini.bufremove    Remove buffers
        - [ ] [] mini.clue          Show next key clues
        - [ ] [] mini.cmdline    Command line tweaks
        - [ ] [] mini.deps          Plugin manager
        - [ ] [TRY] mini.diff    Work with diff hunks
        - [ ] [] mini.extra          Extra ‘mini.nvim’ functionality
        - [ ] [TRY] mini.files    Navigate and manipulate file system
        - [ ] [] mini.git          Git integration
        - [ ] [] mini.jump          Jump to next/previous single character
        - [ ] [] mini.jump2d    Jump within visible lines
        - [ ] [] mini.misc          Miscellaneous functions
        - [ ] [TRY] mini.pick     Pick anything
        - [ ] [TRY] mini.sessions    Session management
        - [ ] [TRY] mini.visits    Track and reuse file system visits
    - [ ] [] appearance
        - [ ] [] mini.animate    Animate common Neovim actions
        - [ ] [] mini.base16    Base16 colorscheme creation
        - [ ] [] mini.colors    Tweak and save any color scheme
        - [ ] [] mini.cursorword    Autohighlight word under cursor
        - [ ] [] mini.hipatterns    Highlight patterns in text
        - [ ] [] mini.hues          Generate configurable color scheme
        - [ ] [] mini.icons       Icon provider
        - [ ] [] mini.indentscope    Visualize and work with indent scope
        - [ ] [] mini.map         Window with buffer text overview
        - [ ] [] mini.notify    Show notifications
        - [ ] [] mini.starter    Start screen
        - [ ] [] mini.statusline    Statusline
        - [ ] [] mini.tabline    Tabline
        - [ ] [USE] mini.trailspace    Trailspace (highlight and remove)
    - [ ] [] other
        - [ ] [] mini.doc    Generate Neovim help files
        - [ ] [TRY] mini.fuzzy    Fuzzy matching
        - [ ] [] mini.test    Test Neovim plugins

    - [ ] [] 
      




- [ ] https://openrouter.ai/
- [ ] https://github.com/Robitx/gp.nvim
- [ ] https://github.com/josh-le/openrouter.nvim
- [ ] https://github.com/frankroeder/parrot.nvim
- [ ] https://ludic.mataroa.blog/blog/i-will-fucking-piledrive-you-if-you-mention-ai-again/
- [ ] https://www.hermit-tech.com/











- [ ] go through [awesome-neovim](https://github.com/rockerBOO/awesome-neovim)
    - [ ] [lsp](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#lsp)
        - [neovim/nvim-lspconfig ](https://github.com/neovim/nvim-lspconfig) - use to copy references
        - [signup.nvim](https://github.com/Dan7h3x/signup.nvim/blob/main/lua/signup/init.lua) - experiment with
    - [ ] [lsp diagnostics](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#diagnostics)
    - [ ] [completion](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#completion)
    - [ ] [ai](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#ai)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#programming-languages-support)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#golang)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#yaml)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#web-development)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#markdown-and-latex)
    - [ ] typst
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#assembly)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#language)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#syntax)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#syntax)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#register)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#marks)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#search)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#fuzzy-finder)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#file-explorer)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#project)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#buffers)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#color)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#colorscheme)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#colorscheme-creation)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#colorscheme-switchers)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#bars-and-lines)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#statusline)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#tabline)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#cursorline)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#startup)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#icon)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#media)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#note-taking)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#utility)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#csv-files)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#animation)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#terminal-integration) see also wezterm plugins
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#debugging)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#quickfix)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#deployment)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#test)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#code-runner)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#neovim-lua-development)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#fennel)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#dependency-management)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#git)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#github)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#gitlab)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#motion)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#tree-sitter-based)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#keybinding)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#mouse)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#scrolling)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#scrollbar)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#editing-support)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#comment)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#folding)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#formatting)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#indent)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#command-line)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#session)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#remote-development)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#live-preview)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#split-and-window)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#tmux)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#game)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#competitive-programming)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#workflow)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#stats-tracking)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#automation)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#database)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#preconfigured-configuration)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#version-manager)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#boilerplate)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#os-specific)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#wishlist)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#ui)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#vim)
    - [ ] [](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#resource)
    - [ ] []()
    - [ ] []()
    - [ ] []()
    - [ ] []()
    - [ ] []()
    - [ ] []()
    - [ ] []()
    - [ ] []()
    - [ ] []()
    - [ ] []()
    - [ ] []()
    - [ ] []()
- [ ] review configs
    - [ ] https://github.com/hendrikmi/dotfiles/tree/main/nvim https://www.youtube.com/watch?v=e34qllePuoc
    - [ ] https://github.com/echasnovski/nvim
    - [ ] https://github.com/glepnir/nvim
    - [ ] https://github.com/NTBBloodbath/nvim
    - [ ] https://github.com/vhyrro/config
    - [ ] https://github.com/BirdeeHub/birdeevim
    - [ ] https://jitesh117.github.io/vim_stuff/walkthrough-of-my-neovim-config/
    - [ ] https://github.com/travisvroman/nvim-dotfiles  https://travisvroman.com/articles/vimsetup.html
    - [ ] https://rsdlt.github.io/posts/rust-nvim-ide-guide-walkthrough-development-debug/
    - [ ] 



## Old lazy-lock.json

```json
{
  "FixCursorHold.nvim": { "branch": "master", "commit": "1900f89dc17c603eec29960f57c00bd9ae696495" },
  "LuaSnip": { "branch": "master", "commit": "3732756842a2f7e0e76a7b0487e9692072857277" },
  "bamboo.nvim": { "branch": "master", "commit": "e74ac25613cd537f7d2d924a54ed479c88537a43" },
  "blink.cmp": { "branch": "main", "commit": "b19413d214068f316c78978b08264ed1c41830ec" },
  "cmp-buffer": { "branch": "main", "commit": "b74fab3656eea9de20a9b8116afa3cfc4ec09657" },
  "cmp-nvim-lsp": { "branch": "main", "commit": "cbc7b02bb99fae35cb42f514762b89b5126651ef" },
  "cmp-path": { "branch": "main", "commit": "c642487086dbd9a93160e1679a1327be111cbc25" },
  "cmp_luasnip": { "branch": "master", "commit": "98d9cb5c2c38532bd9bdb481067b20fea8f32e90" },
  "conform.nvim": { "branch": "master", "commit": "1bf8b5b9caee51507aa51eaed3da5b0f2595c6b9" },
  "copilot.lua": { "branch": "master", "commit": "4383e05a47493d7ff77b058c0548129eb38ec7fb" },
  "dial.nvim": { "branch": "master", "commit": "f97c0c7fa7d5111bc04a91d0f693900fb2d95861" },
  "diffview.nvim": { "branch": "main", "commit": "4516612fe98ff56ae0415a259ff6361a89419b0a" },
  "friendly-snippets": { "branch": "main", "commit": "572f5660cf05f8cd8834e096d7b4c921ba18e175" },
  "gitsigns.nvim": { "branch": "main", "commit": "cdafc320f03f2572c40ab93a4eecb733d4016d07" },
  "lazy.nvim": { "branch": "main", "commit": "85c7ff3711b730b4030d03144f6db6375044ae82" },
  "lualine.nvim": { "branch": "master", "commit": "47f91c416daef12db467145e16bed5bbfe00add8" },
  "markit.nvim": { "branch": "main", "commit": "c716195d5b0b21ef03a20a1facc46d33ca9f7c49" },
  "mini.nvim": { "branch": "main", "commit": "94cae4660a8b2d95dbbd56e1fbc6fcfa2716d152" },
  "neotest": { "branch": "master", "commit": "deadfb1af5ce458742671ad3a013acb9a6b41178" },
  "neotest-python": { "branch": "master", "commit": "b0d3a861bd85689d8ed73f0590c47963a7eb1bf9" },
  "nvim-bqf": { "branch": "main", "commit": "ba2b365969d7c2c6301d48e13aeee59568765529" },
  "nvim-cmp": { "branch": "main", "commit": "d97d85e01339f01b842e6ec1502f639b080cb0fc" },
  "nvim-nio": { "branch": "master", "commit": "21f5324bfac14e22ba26553caf69ec76ae8a7662" },
  "nvim-treesitter": { "branch": "master", "commit": "42fc28ba918343ebfd5565147a42a26580579482" },
  "nvim-treesitter-textobjects": { "branch": "master", "commit": "5ca4aaa6efdcc59be46b95a3e876300cfead05ef" },
  "pickme.nvim": { "branch": "main", "commit": "55ca0f1889ea2a4df4b45c77941327a590e025c5" },
  "plenary.nvim": { "branch": "master", "commit": "b9fd5226c2f76c951fc8ed5923d85e4de065e509" },
  "snacks.nvim": { "branch": "main", "commit": "fe7cfe9800a182274d0f868a74b7263b8c0c020b" },
  "telescope-fzf-native.nvim": { "branch": "main", "commit": "6fea601bd2b694c6f2ae08a6c6fab14930c60e2c" },
  "telescope.nvim": { "branch": "master", "commit": "83a3a713d6b2d2a408491a1b959e55a7fa8678e8" },
  "todo-comments.nvim": { "branch": "main", "commit": "31e3c38ce9b29781e4422fc0322eb0a21f4e8668" },
  "toggleterm.nvim": { "branch": "main", "commit": "50ea089fc548917cc3cc16b46a8211833b9e3c7c" },
  "vim-floaterm": { "branch": "master", "commit": "a11b930f55324e9b05e2ef16511fe713f1b456a7" },
  "vim-visual-multi": { "branch": "master", "commit": "a6975e7c1ee157615bbc80fc25e4392f71c344d4" },
  "wezterm.nvim": { "branch": "main", "commit": "032c33b621b96cc7228955b4352b48141c482098" },
  "which-key.nvim": { "branch": "main", "commit": "3aab2147e74890957785941f0c1ad87d0a44c15a" },
  "yazi.nvim": { "branch": "main", "commit": "3f81faf0cf838acb312f0f0d75ac1a8ac69166ed" },
  "zen-mode.nvim": { "branch": "main", "commit": "8564ce6d29ec7554eb9df578efa882d33b3c23a7" }
}
```

## Old nvim-pack-lock.json

```json
{
  "plugins": {
    "Comment.nvim": {
      "rev": "e30b7f2008e52442154b66f7c519bfd2f1e32acb",
      "src": "https://github.com/numToStr/Comment.nvim"
    },
    "LuaSnip": {
      "rev": "dae4f5aaa3574bd0c2b9dd20fb9542a02c10471c",
      "src": "https://github.com/L3MON4D3/LuaSnip"
    },
    "NeoComposer.nvim": {
      "rev": "83f78b23c4f6826b0f484a91869415b85f74b24f",
      "src": "https://github.com/lvim-tech/NeoComposer.nvim"
    },
    "SchemaStore.nvim": {
      "rev": "e75f2362624698864957a694d80ca0c116bd24d3",
      "src": "https://github.com/b0o/SchemaStore.nvim"
    },
    "aerial.nvim": {
      "rev": "7a6a42791eb2b54a7115c7db4488981f93471770",
      "src": "https://github.com/stevearc/aerial.nvim"
    },
    "asyncrun.vim": {
      "rev": "98d3c0fdeb983f0ef62fe3a49da440f6d2c045ce",
      "src": "https://github.com/skywind3000/asyncrun.vim"
    },
    "auto-session": {
      "rev": "62437532b38495551410b3f377bcf4aaac574ebe",
      "src": "https://github.com/rmagatti/auto-session"
    },
    "bamboo.nvim": {
      "rev": "1309bc88bffcf1bedc3e84e7fa9004de93da774a",
      "src": "https://github.com/ribru17/bamboo.nvim"
    },
    "beam.nvim": {
      "rev": "78c0cb21b2ad026768d2ff96f1570c4c2d5d8087",
      "src": "https://github.com/Piotr1215/beam.nvim"
    },
    "blink.cmp": {
      "rev": "f9e855c4d96e1264f7c818844f5a0166ad48c212",
      "src": "https://github.com/Saghen/blink.cmp"
    },
    "blink.nvim": {
      "rev": "d1e7c7c45d45c6b6a25427bf62db4db73b03ff3d",
      "src": "https://github.com/saghen/blink.nvim"
    },
    "blink.pairs": {
      "rev": "c7986efb702d995fa8d937c23a0bd03c9d3e92b3",
      "src": "https://github.com/saghen/blink.pairs"
    },
    "bufferline.nvim": {
      "rev": "655133c3b4c3e5e05ec549b9f8cc2894ac6f51b3",
      "src": "https://github.com/akinsho/bufferline.nvim"
    },
    "cmp-buffer": {
      "rev": "b74fab3656eea9de20a9b8116afa3cfc4ec09657",
      "src": "https://github.com/hrsh7th/cmp-buffer"
    },
    "cmp-cmdline": {
      "rev": "d126061b624e0af6c3a556428712dd4d4194ec6d",
      "src": "https://github.com/hrsh7th/cmp-cmdline"
    },
    "cmp-nvim-lsp": {
      "rev": "cbc7b02bb99fae35cb42f514762b89b5126651ef",
      "src": "https://github.com/hrsh7th/cmp-nvim-lsp"
    },
    "cmp-path": {
      "rev": "c642487086dbd9a93160e1679a1327be111cbc25",
      "src": "https://github.com/hrsh7th/cmp-path"
    },
    "code_runner.nvim": {
      "rev": "3be33a8d4ce36e453fc09258c9093f9ecf452964",
      "src": "https://github.com/CRAG666/code_runner.nvim"
    },
    "compiler.nvim": {
      "rev": "c09ab4e795b92378727d7377c03b0d5c2453957c",
      "src": "https://github.com/Zeioth/compiler.nvim"
    },
    "conform.nvim": {
      "rev": "c2526f1cde528a66e086ab1668e996d162c75f4f",
      "src": "https://github.com/stevearc/conform.nvim"
    },
    "crates.nvim": {
      "rev": "ac9fa498a9edb96dc3056724ff69d5f40b898453",
      "src": "https://github.com/saecki/crates.nvim"
    },
    "dashboard-nvim": {
      "rev": "0775e567b6c0be96d01a61795f7b64c1758262f6",
      "src": "https://github.com/nvimdev/dashboard-nvim"
    },
    "dashboard.nvim": {
      "rev": "ba80a1e57feb278872c6bb5c2b1048a80b58e921",
      "src": "https://github.com/MeanderingProgrammer/dashboard.nvim"
    },
    "dial.nvim": {
      "rev": "f2634758455cfa52a8acea6f142dcd6271a1bf57",
      "src": "https://github.com/monaqa/dial.nvim"
    },
    "diffview.nvim": {
      "rev": "4516612fe98ff56ae0415a259ff6361a89419b0a",
      "src": "https://github.com/sindrets/diffview.nvim"
    },
    "dropbar.nvim": {
      "rev": "ce202248134e3949aac375fd66c28e5207785b10",
      "src": "https://github.com/Bekaboo/dropbar.nvim"
    },
    "efm-langserver": {
      "rev": "011a299e9e73e9f837ad477a74f201debe27e061",
      "src": "https://github.com/mattn/efm-langserver"
    },
    "fidget.nvim": {
      "rev": "7fa433a83118a70fe24c1ce88d5f0bd3453c0970",
      "src": "https://github.com/j-hui/fidget.nvim"
    },
    "firenvim": {
      "rev": "a18ef908ac06b52ad9333b70e3e630b0a56ecb3d",
      "src": "https://github.com/glacambre/firenvim"
    },
    "flash.nvim": {
      "rev": "fcea7ff883235d9024dc41e638f164a450c14ca2",
      "src": "https://github.com/folke/flash.nvim"
    },
    "flybuf.nvim": {
      "rev": "fe1fbd9699f6988a1db3b2e2ffa599154784c6e1",
      "src": "https://github.com/nvimdev/flybuf.nvim"
    },
    "friendly-snippets": {
      "rev": "6cd7280adead7f586db6fccbd15d2cac7e2188b9",
      "src": "https://github.com/rafamadriz/friendly-snippets"
    },
    "fzf-lua": {
      "rev": "5921997472574fca3880b62949eb8679dc6f5afc",
      "src": "https://github.com/ibhagwan/fzf-lua"
    },
    "git-conflict.nvim": {
      "rev": "a1badcd070d176172940eb55d9d59029dad1c5a6",
      "src": "https://github.com/akinsho/git-conflict.nvim"
    },
    "gitlab.nvim": {
      "rev": "3d2828a9504b87fc36ee2aca1b0f36cf75003edd",
      "src": "https://github.com/harrisoncramer/gitlab.nvim"
    },
    "gitlab.vim": {
      "rev": "191eecd7f8a2f563054c6574b0f1969970dadb7d",
      "src": "https://gitlab.com/gitlab-org/editor-extensions/gitlab.vim"
    },
    "gitsigns.nvim": {
      "rev": "1ce96a464fdbc24208e24c117e2021794259005d",
      "src": "https://github.com/lewis6991/gitsigns.nvim"
    },
    "grug-far.nvim": {
      "rev": "275dbedc96e61a6b8d1dfb28ba51586ddd233dcf",
      "src": "https://github.com/MagicDuck/grug-far.nvim"
    },
    "guard.nvim": {
      "rev": "addb8d2f40662b8b62d60dd7d18f503beb2332e7",
      "src": "https://github.com/nvimdev/guard.nvim"
    },
    "harpoon-core.nvim": {
      "rev": "61ccd5f77cb70fef6f96ddd00fe2bf7a9a3670fa",
      "src": "https://github.com/MeanderingProgrammer/harpoon-core.nvim"
    },
    "haskell-tools.nvim": {
      "rev": "128a7e36331050603b3145b1efe1a219115464e8",
      "src": "https://github.com/mrcjkb/haskell-tools.nvim"
    },
    "headlines.nvim": {
      "rev": "bf17c96a836ea27c0a7a2650ba385a7783ed322e",
      "src": "https://github.com/lukas-reineke/headlines.nvim"
    },
    "hlsearch.nvim": {
      "rev": "fdeb60b890d15d9194e8600042e5232ef8c29b0e",
      "src": "https://github.com/nvimdev/hlsearch.nvim"
    },
    "hop.nvim": {
      "rev": "707049feaca9ae65abb3696eff9aefc7879e66aa",
      "src": "https://github.com/smoka7/hop.nvim"
    },
    "hydra.nvim": {
      "rev": "8c4a9f621ec7cdc30411a1f3b6d5eebb12b469dc",
      "src": "https://github.com/nvimtools/hydra.nvim"
    },
    "indent-blankline.nvim": {
      "rev": "d28a3f70721c79e3c5f6693057ae929f3d9c0a03",
      "src": "https://github.com/lukas-reineke/indent-blankline.nvim"
    },
    "indentmini.nvim": {
      "rev": "38572ce5a7a064a5deb89d6d861b7c40fc929ab1",
      "src": "https://github.com/nvimdev/indentmini.nvim"
    },
    "jiejie.nvim": {
      "rev": "6adaa521f91ecfc16ac254ee7a0c5a79e0829a35",
      "src": "https://github.com/jceb/jiejie.nvim"
    },
    "jj.nvim": {
      "rev": "bbba4051c862473637e98277f284d12b050588ca",
      "src": "https://github.com/NicolasGB/jj.nvim"
    },
    "jujutsu.nvim": {
      "rev": "348a208a92f054d70bc24b73dde11261f3b765c7",
      "src": "https://github.com/yannvanhalewyn/jujutsu.nvim"
    },
    "jupytext.nvim": {
      "rev": "c8baf3ad344c59b3abd461ecc17fc16ec44d0f7b",
      "src": "https://github.com/GCBallesteros/jupytext.nvim"
    },
    "lazydev.nvim": {
      "rev": "5231c62aa83c2f8dc8e7ba957aa77098cda1257d",
      "src": "https://github.com/folke/lazydev.nvim"
    },
    "lazygit.nvim": {
      "rev": "a04ad0dbc725134edbee3a5eea29290976695357",
      "src": "https://github.com/kdheepak/lazygit.nvim"
    },
    "leap.nvim": {
      "rev": "b81866399072af08195ebfbcfea9d3dcab970972",
      "src": "https://codeberg.org/andyg/leap.nvim"
    },
    "lsp-format.nvim": {
      "rev": "42d1d3e407c846d95f84ea3767e72ed6e08f7495",
      "src": "https://github.com/lukas-reineke/lsp-format.nvim"
    },
    "lspkind.nvim": {
      "rev": "c7274c48137396526b59d86232eabcdc7fed8a32",
      "src": "https://github.com/onsails/lspkind.nvim"
    },
    "lspsaga.nvim": {
      "rev": "562d9724e3869ffd1801c572dd149cc9f8d0cc36",
      "src": "https://github.com/nvimdev/lspsaga.nvim"
    },
    "lualine.nvim": {
      "rev": "47f91c416daef12db467145e16bed5bbfe00add8",
      "src": "https://github.com/nvim-lualine/lualine.nvim"
    },
    "markdown-preview.nvim": {
      "rev": "a923f5fc5ba36a3b17e289dc35dc17f66d0548ee",
      "src": "https://github.com/iamcco/markdown-preview.nvim"
    },
    "markit.nvim": {
      "rev": "c716195d5b0b21ef03a20a1facc46d33ca9f7c49",
      "src": "https://github.com/2KAbhishek/markit.nvim"
    },
    "marks.nvim": {
      "rev": "f353e8c08c50f39e99a9ed474172df7eddd89b72",
      "src": "https://github.com/chentoast/marks.nvim"
    },
    "mini.align": {
      "rev": "4d45e0e4f1fd8baefb6ae52a44659704fe7ebe8b",
      "src": "https://github.com/nvim-mini/mini.align"
    },
    "mini.keymap": {
      "rev": "c6f362c835914188d499694743fb89014a815e2c",
      "src": "https://github.com/nvim-mini/mini.keymap"
    },
    "mini.nvim": {
      "rev": "8c40d95931cbe6138391af9180e59439ed2e69df",
      "src": "https://github.com/nvim-mini/mini.nvim"
    },
    "mini.pick": {
      "rev": "7c0a674f620ddc701903b887b2dade836b23ea79",
      "src": "https://github.com/nvim-mini/mini.pick"
    },
    "modes.nvim": {
      "rev": "0932ba4e0bdc3457ac89a8aeed4d56ca0b36977a",
      "src": "https://github.com/mvllow/modes.nvim"
    },
    "mypy.nvim": {
      "rev": "43f9e095441bbe7c7281b9a888728dc2d87ffc4f",
      "src": "https://github.com/feakuru/mypy.nvim"
    },
    "neo-tree.nvim": {
      "rev": "1d682ea4b77890e4cdb7e6da17368a46ebdd6fb2",
      "src": "https://github.com/nvim-neo-tree/neo-tree.nvim"
    },
    "neogit": {
      "rev": "7073f3aafc9030d457838995106784a9d1873b3b",
      "src": "https://github.com/NeogitOrg/neogit"
    },
    "neorepl.nvim": {
      "rev": "15f4c4e523e1fbec74766e1967e1c2491df013c9",
      "src": "https://github.com/ii14/neorepl.nvim"
    },
    "neotest": {
      "rev": "deadfb1af5ce458742671ad3a013acb9a6b41178",
      "src": "https://github.com/nvim-neotest/neotest"
    },
    "neotest-haskell": {
      "rev": "14106f0bc345fdb1273ff38935bc770fd55ca38c",
      "src": "https://github.com/MrcJkb/neotest-haskell"
    },
    "neotest-python": {
      "rev": "b0d3a861bd85689d8ed73f0590c47963a7eb1bf9",
      "src": "https://github.com/nvim-neotest/neotest-python"
    },
    "noice.nvim": {
      "rev": "7bfd942445fb63089b59f97ca487d605e715f155",
      "src": "https://github.com/folke/noice.nvim"
    },
    "none-ls.nvim": {
      "rev": "f61f46ded0ca9edce7a09b674f8e162d10921426",
      "src": "https://github.com/nvimtools/none-ls.nvim"
    },
    "nui.nvim": {
      "rev": "de740991c12411b663994b2860f1a4fd0937c130",
      "src": "https://github.com/MunifTanjim/nui.nvim"
    },
    "nvim-anydent": {
      "rev": "b6151bd50d5935522a71709202a0495a50681156",
      "src": "https://github.com/hrsh7th/nvim-anydent"
    },
    "nvim-autopairs": {
      "rev": "59bce2eef357189c3305e25bc6dd2d138c1683f5",
      "src": "https://github.com/windwp/nvim-autopairs"
    },
    "nvim-bqf": {
      "rev": "f65fba733268ffcf9c5b8ac381287eca7c223422",
      "src": "https://github.com/kevinhwang91/nvim-bqf"
    },
    "nvim-cmp": {
      "rev": "da88697d7f45d16852c6b2769dc52387d1ddc45f",
      "src": "https://github.com/hrsh7th/nvim-cmp"
    },
    "nvim-dap": {
      "rev": "db321947bb289a2d4d76a32e76e4d2bd6103d7df",
      "src": "https://codeberg.org/mfussenegger/nvim-dap"
    },
    "nvim-dap-python": {
      "rev": "1808458eba2b18f178f990e01376941a42c7f93b",
      "src": "https://codeberg.org/mfussenegger/nvim-dap-python"
    },
    "nvim-dap-ui": {
      "rev": "cf91d5e2d07c72903d052f5207511bf7ecdb7122",
      "src": "https://github.com/rcarriga/nvim-dap-ui"
    },
    "nvim-dap-virtual-text": {
      "rev": "fbdb48c2ed45f4a8293d0d483f7730d24467ccb6",
      "src": "https://github.com/theHamsta/nvim-dap-virtual-text"
    },
    "nvim-deck": {
      "rev": "d6939d41d45bdff4f2ef02db3046608c93c6fc0e",
      "src": "https://github.com/hrsh7th/nvim-deck"
    },
    "nvim-hlslens": {
      "rev": "be2d7b2be01860b5445a007ff2bc72b29896db6b",
      "src": "https://github.com/kevinhwang91/nvim-hlslens"
    },
    "nvim-insx": {
      "rev": "fbba86031f3927ecbc11556217b4976a149c29c6",
      "src": "https://github.com/hrsh7th/nvim-insx"
    },
    "nvim-lint": {
      "rev": "606b823a57b027502a9ae00978ebf4f5d5158098",
      "src": "https://github.com/mfussenegger/nvim-lint"
    },
    "nvim-lspconfig": {
      "rev": "3f58aeca0c6ece8a9fb8782ea3fcb6024f285be3",
      "src": "https://github.com/neovim/nvim-lspconfig"
    },
    "nvim-macros": {
      "rev": "f29d08ee7844ed6c9552699206e8c977d6936ee4",
      "src": "https://github.com/kr40/nvim-macros"
    },
    "nvim-navbuddy": {
      "rev": "a34786c77a528519f6b8a142db7609f6e387842d",
      "src": "https://github.com/SmiteshP/nvim-navbuddy"
    },
    "nvim-navic": {
      "rev": "f5eba192f39b453675d115351808bd51276d9de5",
      "src": "https://github.com/SmiteshP/nvim-navic"
    },
    "nvim-nio": {
      "rev": "21f5324bfac14e22ba26553caf69ec76ae8a7662",
      "src": "https://github.com/nvim-neotest/nvim-nio"
    },
    "nvim-notify": {
      "rev": "8701bece920b38ea289b457f902e2ad184131a5d",
      "src": "https://github.com/rcarriga/nvim-notify"
    },
    "nvim-pasta": {
      "rev": "7cc66bcf7101e40a6184b46a37eff0d5a43bde8d",
      "src": "https://github.com/hrsh7th/nvim-pasta"
    },
    "nvim-recorder": {
      "rev": "cf2e07d1d60f225943b2f2457ecd8e2b3e4ee2d5",
      "src": "https://github.com/chrisgrieser/nvim-recorder"
    },
    "nvim-spectre": {
      "rev": "72f56f7585903cd7bf92c665351aa585e150af0f",
      "src": "https://github.com/nvim-pack/nvim-spectre"
    },
    "nvim-surround": {
      "rev": "9488883f58161c1e302ae6bfa5ecd79ac828b36e",
      "src": "https://github.com/kylechui/nvim-surround"
    },
    "nvim-swm": {
      "rev": "4ccb2b137b117092f3efa426261ddbef25111454",
      "src": "https://github.com/hrsh7th/nvim-swm"
    },
    "nvim-tree.lua": {
      "rev": "fa3c45875f9b1f56ace57711c6f2ac22484ed956",
      "src": "https://github.com/nvim-tree/nvim-tree.lua"
    },
    "nvim-treesitter": {
      "rev": "4967fa48b0fe7a7f92cee546c76bb4bb61bb14d5",
      "src": "https://github.com/nvim-treesitter/nvim-treesitter"
    },
    "nvim-treesitter-textobjects": {
      "rev": "a0e182ae21fda68c59d1f36c9ed45600aef50311",
      "src": "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
    },
    "nvim-ufo": {
      "rev": "ab3eb124062422d276fae49e0dd63b3ad1062cfc",
      "src": "https://github.com/kevinhwang91/nvim-ufo"
    },
    "nvim-various-textobjs": {
      "rev": "34ca4f6b54cf167554c5792cacc69c930b654136",
      "src": "https://github.com/chrisgrieser/nvim-various-textobjs"
    },
    "nvim-web-devicons": {
      "rev": "746ffbb17975ebd6c40142362eee1b0249969c5c",
      "src": "https://github.com/nvim-tree/nvim-web-devicons"
    },
    "nvim_winpick": {
      "rev": "18037e9f5ce417bd75d16ebbf70787bcc478c249",
      "src": "https://github.com/MarcusGrass/nvim_winpick"
    },
    "octo.nvim": {
      "rev": "c14f5b6ee92f0b2717efd525211bcb6cebf03fa6",
      "src": "https://github.com/pwntester/octo.nvim"
    },
    "officer.nvim": {
      "rev": "29df3cd138bbc453ab71303f8f64ff04a599fc90",
      "src": "https://github.com/pianocomposer321/officer.nvim"
    },
    "oil.nvim": {
      "rev": "f55b25e493a7df76371cfadd0ded5004cb9cd48a",
      "src": "https://github.com/stevearc/oil.nvim"
    },
    "overseer.nvim": {
      "rev": "2802c15182dae2de71f9c82e918d7ba850b90c22",
      "src": "https://github.com/stevearc/overseer.nvim"
    },
    "persistence.nvim": {
      "rev": "b20b2a7887bd39c1a356980b45e03250f3dce49c",
      "src": "https://github.com/folke/persistence.nvim"
    },
    "pickme.nvim": {
      "rev": "3bfd63fa0a1fa362afc9dfa86b83100e75903e6b",
      "src": "https://github.com/2KAbhishek/pickme.nvim"
    },
    "plenary.nvim": {
      "rev": "b9fd5226c2f76c951fc8ed5923d85e4de065e509",
      "src": "https://github.com/nvim-lua/plenary.nvim"
    },
    "project.nvim": {
      "rev": "8c6bad7d22eef1b71144b401c9f74ed01526a4fb",
      "src": "https://github.com/ahmedkhalf/project.nvim"
    },
    "quarto-nvim": {
      "rev": "d923bb7cfc2bde41143e1c531c28190f0fade3a2",
      "src": "https://github.com/quarto-dev/quarto-nvim"
    },
    "quicker.nvim": {
      "rev": "2d3f3276eab9352c7b212821c218aca986929f62",
      "src": "https://github.com/stevearc/quicker.nvim"
    },
    "rainbow-delimiters.nvim": {
      "rev": "01993eb20c6cdc1d33e7e98252368840309f99b9",
      "src": "https://github.com/HiPhish/rainbow-delimiters.nvim"
    },
    "refactoring.nvim": {
      "rev": "6784b54587e6d8a6b9ea199318512170ffb9e418",
      "src": "https://github.com/ThePrimeagen/refactoring.nvim"
    },
    "render-markdown.nvim": {
      "rev": "bd482f9a4827c9422231a7db1439c5cff1e69ae0",
      "src": "https://github.com/MeanderingProgrammer/render-markdown.nvim"
    },
    "rustaceanvim": {
      "rev": "3ace64feb1ce3cf3c63e6297e1378a82fe548618",
      "src": "https://github.com/mrcjkb/rustaceanvim"
    },
    "smart-splits.nvim": {
      "rev": "b9d563ea52c4926a4d91e5e795c68bb8f89f8ba0",
      "src": "https://github.com/mrjones2014/smart-splits.nvim"
    },
    "snacks.nvim": {
      "rev": "fe7cfe9800a182274d0f868a74b7263b8c0c020b",
      "src": "https://github.com/folke/snacks.nvim"
    },
    "sniprun": {
      "rev": "973acfe83cff35d13b95369a5606c47565b824fb",
      "src": "https://github.com/michaelb/sniprun"
    },
    "statuscol.nvim": {
      "rev": "c46172d0911aa5d49ba5f39f4351d1bb7aa289cc",
      "src": "https://github.com/luukvbaal/statuscol.nvim"
    },
    "stickybuf.nvim": {
      "rev": "0c1e5f1a3eb36eea2cea57083828269cc62c58e4",
      "src": "https://github.com/stevearc/stickybuf.nvim"
    },
    "structlog.nvim": {
      "rev": "45b26a2b1036bb93c0e83f4225e85ab3cee8f476",
      "src": "https://github.com/Tastyep/structlog.nvim"
    },
    "tabular": {
      "rev": "12437cd1b53488e24936ec4b091c9324cafee311",
      "src": "https://github.com/godlygeek/tabular"
    },
    "telescope-fzf-native.nvim": {
      "rev": "6fea601bd2b694c6f2ae08a6c6fab14930c60e2c",
      "src": "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
    },
    "telescope-project.nvim": {
      "rev": "8e11df94419e444601c09828dadf70890484e443",
      "src": "https://github.com/nvim-telescope/telescope-project.nvim"
    },
    "telescope.nvim": {
      "rev": "ad7d9580338354ccc136e5b8f0aa4f880434dcdc",
      "src": "https://github.com/nvim-telescope/telescope.nvim"
    },
    "texmagic.nvim": {
      "rev": "8172d2d974b444dcc996d87a9e05723348676d5e",
      "src": "https://github.com/jakewvincent/texmagic.nvim"
    },
    "todo-comments.nvim": {
      "rev": "31e3c38ce9b29781e4422fc0322eb0a21f4e8668",
      "src": "https://github.com/folke/todo-comments.nvim"
    },
    "toggleterm.nvim": {
      "rev": "9a88eae817ef395952e08650b3283726786fb5fb",
      "src": "https://github.com/akinsho/toggleterm.nvim"
    },
    "treesitter-modules.nvim": {
      "rev": "0cc09da40061051b0186479203faa75052cddab6",
      "src": "https://github.com/MeanderingProgrammer/treesitter-modules.nvim"
    },
    "treesj": {
      "rev": "186084dee5e9c8eec40f6e39481c723dd567cb05",
      "src": "https://github.com/Wansmer/treesj"
    },
    "trouble.nvim": {
      "rev": "bd67efe408d4816e25e8491cc5ad4088e708a69a",
      "src": "https://github.com/folke/trouble.nvim"
    },
    "typst-preview.nvim": {
      "rev": "bf5d5eaf23bbfcca9f98a24ed29bd084abf89bf2",
      "src": "https://github.com/chomosuke/typst-preview.nvim"
    },
    "ultisnips": {
      "rev": "b22a86f9dcc5257624bff3c72d8b902eac468aad",
      "src": "https://github.com/SirVer/ultisnips"
    },
    "vague.nvim": {
      "rev": "30d2239ecf8adab9bc0d07d42e7a07283879dab6",
      "src": "https://github.com/vague2k/vague.nvim"
    },
    "vim-commentary": {
      "rev": "64a654ef4a20db1727938338310209b6a63f60c9",
      "src": "https://github.com/tpope/vim-commentary"
    },
    "vim-floaterm": {
      "rev": "a11b930f55324e9b05e2ef16511fe713f1b456a7",
      "src": "https://github.com/voldikss/vim-floaterm"
    },
    "vim-fugitive": {
      "rev": "61b51c09b7c9ce04e821f6cf76ea4f6f903e3cf4",
      "src": "https://github.com/tpope/vim-fugitive"
    },
    "vim-illuminate": {
      "rev": "0d1e93684da00ab7c057410fecfc24f434698898",
      "src": "https://github.com/RRethy/vim-illuminate"
    },
    "vim-mundo": {
      "rev": "2ceda8c65f7b3f9066820729fc02003a09df91f9",
      "src": "https://github.com/simnalamburt/vim-mundo"
    },
    "vim-sandwich": {
      "rev": "74cf93d58ccc567d8e2310a69860f1b93af19403",
      "src": "https://github.com/machakann/vim-sandwich"
    },
    "vim-visual-multi": {
      "rev": "a6975e7c1ee157615bbc80fc25e4392f71c344d4",
      "src": "https://github.com/mg979/vim-visual-multi"
    },
    "vimtex": {
      "rev": "95b93a24740f7b89dd8331326b41bdd1337d79f6",
      "src": "https://github.com/lervag/vimtex"
    },
    "which-key.nvim": {
      "rev": "3aab2147e74890957785941f0c1ad87d0a44c15a",
      "src": "https://github.com/folke/which-key.nvim"
    },
    "yazi.nvim": {
      "rev": "0181178a3ca490cb32d8d2bcb4be0292c0cb8180",
      "src": "https://github.com/mikavilpas/yazi.nvim"
    },
    "zen-mode.nvim": {
      "rev": "8564ce6d29ec7554eb9df578efa882d33b3c23a7",
      "src": "https://github.com/folke/zen-mode.nvim"
    }
  }
}
```
# Neovim Roadmap

I'll help you create a well-structured roadmap for your Neovim IDE setup. This layered approach ensures you have a working editor at each stage while progressively adding more advanced features.

## 🗺️ Neovim IDE Roadmap for Python & Rust

### Layer 0: Foundation & Core Navigation

Basic but comfortable editing environment

#### Essential Plugins:

<!-- - Plugin Manager: `folke/lazy.nvim` (modern, fast) -->

- Basic Utilities: `nvim-lua/plenary.nvim` (dependency for many plugins)

- File Navigation: `nvim-tree/nvim-tree.lua` or `stevearc/oil.nvim`

- File Finding: `nvim-telescope/telescope.nvim` (with `fzf` extension)

- Syntax Highlighting: `nvim-treesitter/nvim-treesitter` (with Python & Rust parsers)

- Status Line: `nvim-lualine/lualine.nvim`

- Buffer Management: `akinsho/bufferline.nvim`

#### Configuration Goals at this layer:

- Basic keymaps for navigation

- Fuzzy finding files, grep search

- File tree with proper icons (install `nvim-tree/nvim-web-devicons`)

- Treesitter for better syntax highlighting and code understanding

### Layer 1: Editing Enhancements

Make editing and navigation smoother

#### Plugins:

- Commenting: `numToStr/Comment.nvim`

- Pairs Management: `windwp/nvim-autopairs`

- Surround Editing: `kylechui/nvim-surround` or `tpope/vim-surround`

- Indentation Guides: `lukas-reineke/indent-blankline.nvim`

- Which Key: `folke/which-key.nvim` (keymap discovery)

- Motion & Selection: `ggandor/leap.nvim` (fast cursor movement)

- Multi-cursor: `mg979/vim-visual-multi` (optional but powerful)

#### Configuration Goals:

- Intelligent auto-pairing and surround editing

- Visual guides for code structure

- Fast navigation within files

- Context-aware key binding hints

### Layer 2: LSP & Autocompletion

Core IDE features - language support

#### Plugins:

- LSP Manager: `neovim/nvim-lspconfig`

- Completion Engine: `hrsh7th/nvim-cmp`

- Completion Sources:
  - `hrsh7th/cmp-nvim-lsp` (LSP suggestions)
  - `hrsh7th/cmp-buffer` (buffer words)
  - `hrsh7th/cmp-path` (file paths)
  - `hrsh7th/cmp-cmdline` (command line)

- Snippets: `L3MON4D3/LuaSnip` + `rafamadriz/friendly-snippets`

- LSP UI Enhancements: 
  - `nvimdev/lspsaga.nvim` or `glepnir/lspsaga.nvim` (better LSP UI)
  - `j-hui/fidget.nvim` (LSP progress)
  - `onsails/lspkind.nvim` (icons in completion)

- Language-Specific Setup:
  - Python: `pyright` (LSP) or `jedi-language-server`
  - Rust: `rust-analyzer` (built-in with `rustup component add rust-analyzer`)

#### Configuration Goals:

- Working LSP with diagnostics, go-to-definition, hover info

- Autocompletion with snippets

- Signature help

- Code actions

### Layer 3: Formatting & Linting

Code quality automation

#### Plugins:

- Formatting: `stevearc/conform.nvim`

- Linting: `mfussenegger/nvim-lint`

- Language-Specific Formatters:
  - Python: `ruff`
  - Rust: `rustfmt` (built-in)

- LSP-Based Formatting: Integrated through `lspconfig`

- MyPy: [nvim-lint](https://github.com/mfussenegger/nvim-lint/blob/master/lua/lint/linters/mypy.lua) 
  or [mypy.nvim](https://github.com/feakuru/mypy.nvim)

#### Configuration Goals:

- Auto-format on save

- Linting with diagnostic integration

- Organize imports (Python with `isort` or `ruff`, Rust with `rust-analyzer`)

### Layer 4: Testing, Debugging/Quickfix, Code Execution

Quality assurance tools

#### Plugins:

- Testing:
  - `nvim-neotest/neotest`
  - `nvim-neotest/neotest-python` (pytest/unittest)
  - superceded by rustaceanvim: `nvim-neotest/neotest-rust` (cargo test)

- Debugging:
  - `mfussenegger/nvim-dap`
  - `rcarriga/nvim-dap-ui`
  - `theHamsta/nvim-dap-virtual-text` (inline variable values)
  - `mfussenegger/nvim-dap-python` (debugpy)
  - `mrcjkb/rustaceanvim` (Rust DAP integration with `lldb`)

#### Configuration Goals:

- Run tests from Neovim with test output

- Set breakpoints, step through code

- View variables and call stack

- Debug console integration

### Layer 5: Refactoring & Code Intelligence

Advanced code manipulation

#### Plugins:

- Refactoring:
  - `ThePrimeagen/refactoring.nvim` (LSP-based refactoring)
  - `Wansmer/treesj` (split/join blocks)

- Project Management: 
  - `ahmedkhalf/project.nvim` or `nvim-telescope/telescope-project.nvim`

- Language-Specific Tools:
  - Python: `python-lsp-server` with [`pylsp-mypy`](https://github.com/python-lsp/pylsp-mypy), [`pylsp-rope`](https://github.com/python-rope/pylsp-rope) (enhanced refactoring)
  - Rust: `mrcjkb/rustaceanvim` (Rust-analyzer enhancements)

#### Configuration Goals:

- Extract function/variable

- Rename across files

- Smart code actions

- Project-aware navigation

### Layer 6: Version Control & Collaboration

Git integration and team features

#### Plugins:

- Git Integration:
  - `lewis6991/gitsigns.nvim` (inline git blame, hunks)
  - `NeogitOrg/neogit` (Magit-like interface) or `tpope/vim-fugitive`
  - `sindrets/diffview.nvim` (diff viewer)

- GitHub/GitLab Integration:
  - `pwntester/octo.nvim` (GitHub PRs/issues)

#### Configuration Goals:

- Git blame inline

- Stage/unstage hunks

- Commit from Neovim

- Review PRs

### Layer 7: UI Polish & Productivity

Final touches for a seamless experience

#### Plugins:

- UI Enhancements:
  - `folke/noice.nvim` (improved UI for messages, cmdline)
  - `rcarriga/nvim-notify` (better notifications)
  - `folke/todo-comments.nvim` (highlight TO_DOs/FIXMEs)
  - `kevinhwang91/nvim-ufo` (better code folding)

- Wezterm Integration:
  - `willothy/wezterm.nvim` (Wezterm integration)
  - Custom keybindings for terminal splits

- Session Management: `rmagatti/auto-session` or `folke/persistence.nvim`

- Markdown Preview: `iamcco/markdown-preview.nvim` (for docs)

#### Configuration Goals:

- Beautiful, consistent UI

- Session persistence

- Terminal integration with Wezterm

- Better notifications and messages

## 🎯 Implementation Strategy

1. Start with Layer 0 - Get basic navigation working

2. Add Layer 1 - Improve editing experience

3. Layer 2 is critical - Get LSP and completion working perfectly before moving on

4. Layer 3-5 - Add quality-of-life features incrementally

5. Layer 6-7 - Polish and optimize

## 💡 Pro Tips

- Configuration Structure: Organize your config in modules (e.g., `plugins/`, `lsp/`, `keymaps/`)

- Lazy Loading: Use `lazy.nvim` to load plugins only when needed

- Mason: Consider `williamboman/mason.nvim` with `mason-lspconfig` for easier LSP/DAP installation

- Backup: Commit each working layer to git

- Test Incrementally: After each layer, use your config for a day to ensure stability

## 🔧 Additional Considerations for Python & Rust

Python Specific:

- see [marimo](https://docs.marimo.io/guides/editor_features/watching/#marimo-run-watch)

- Consider `python-lsp-server` with plugins for a more feature-rich experience

- `jupytext.nvim` if you work with Jupyter notebooks

- `Vimpyter` for notebook-like experience

Rust Specific:

- `crates.nvim` for managing Rust dependencies

- `mrcjkb/rustaceanvim` is the most comprehensive Rust plugin

This roadmap gives you a stable, working editor at each step and builds toward a complete Python/Rust IDE. Remember to customize keybindings to your preferences and gradually learn the features as you add them!

---

## Old Roadmap

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


# TASK_RUNNERS.md

The "state-of-the-art" in Neovim task running has shifted away from simple shell wrappers toward **asynchronous, UI-rich engines** that can parse project-specific files (like `Taskfile.yml` or `justfile`) and present them in searchable menus.

As of 2026, there are three primary contenders, each with a different philosophy.

---

### 1. Overseer.nvim (The Heavyweight)

**Overseer** is currently considered the most powerful and extensible task runner. It doesn't just run commands; it manages them as a life-cycle, complete with status icons, output buffers, and a searchable sidebar.

* **Logic:** It uses "Templates" to detect tasks.
* **Compatibility:** It has built-in or community templates for almost everything.
* **Just/Taskfile:** You can easily define a provider that parses your `justfile` or `Taskfile.yml` and populates the Overseer menu.

```lua
-- Example: Using Overseer to trigger a Just task
require('overseer').setup({
  templates = { "builtin", "my_custom_just_provider" },
})

```

### 2. Neotest (The Logic-Engine)

While primarily a testing framework, **Neotest** is the state-of-the-art for anything that requires a "tree" view of executable items. If your "tasks" are actually granular build steps or tests, Neotest is more precise than a general task runner.

### 3. Sky.nvim / Toggleterm (The "Workflow" Runners)

If you prefer a more "terminal-first" approach, many power users combine **Toggleterm.lua** with a custom picker (like Telescope) to trigger tasks.

---

### Compatibility with Taskfile and Just

Since **Just** and **Taskfile** are CLI-first, Neovim plugins usually interface with them in one of two ways:

#### A. The "Steptest / Neotest" Approach

There are specific adapters for Neotest and Overseer that parse your `justfile` or `Taskfile.yml`.

* **[just.nvim]():** A dedicated plugin for `just` that provides a Telescope picker for your just tasks.
* **[Task.nvim]():** A structured task runner that plays well with external YAML-based task definitions.

#### B. The Telescope/Fzf-lua Integration (Fastest)

The most common "pro" setup is to use **Telescope** to parse the output of `just --list` or `task --list-all` and execute the selection in a floating terminal.

**Example: A "State-of-the-art" Just Picker in Lua**

```lua
local function run_just_task()
    local opts = {}
    -- Use vim.system to get just tasks as a table
    local obj = vim.system({"just", "--summary"}, { text = true }):wait()
    local tasks = vim.split(obj.stdout, " ")

    vim.ui.select(tasks, { prompt = "Run Just Task:" }, function(choice)
        if choice then
            -- Run in a floating terminal (using toggleterm or built-in)
            vim.cmd("TermExec cmd='just " .. choice .. "'")
        end
    end)
end

```

---

### Comparison Table

| Plugin | Complexity | Best For | Compatibility |
| --- | --- | --- | --- |
| **Overseer.nvim** | High | Complex build pipelines, background tasks. | Excellent (via templates) |
| **just.nvim** | Low | Dedicated `just` users. | Native `just` |
| **Toggleterm** | Medium | Simple shell scripts, interactive tasks. | Manual |
| **Resession.nvim** | Medium | Saving task states across sessions. | Generic |

---

### Recommendation

If you want the "all-in-one" powerful experience: Go with **Overseer.nvim**. It is the only one that feels like a modern IDE's task runner (like VS Code's `tasks.json`) but with the extensibility of Neovim.

**Would you like me to help you write a custom Overseer template that automatically detects a `justfile` and lists the tasks in your project?**


Integrating **Taskfile** (go-task) into Neovim as a state-of-the-art workflow typically involves using **Overseer.nvim** as the engine. It provides the background process management, while a custom template handles the parsing of your `Taskfile.yml`.

### 1. The Strategy: The Overseer Template

The most powerful way to do this is to define an Overseer "provider." This script will:

1. Check if a `Taskfile.yml` or `Taskfile.yaml` exists in the project root.
2. Run `task --list-all --json` to get the tasks.
3. Expose them to the Overseer `TaskLauncher`.

### 2. The Implementation (Lua)

Add this to your configuration (or a separate `lua/plugins/tasks.lua` file). This uses the `vim.system` API we discussed to fetch tasks asynchronously.

```lua
local overseer = require("overseer")

overseer.register_template({
  name = "Taskfile Runner",
  generator = function(opts, cb)
    -- 1. Check for Taskfile
    local taskfile = vim.fs.find({ "Taskfile.yml", "Taskfile.yaml" }, { upward = true, path = opts.dir })[1]
    if not taskfile then
      cb({})
      return
    end

    -- 2. Fetch tasks via CLI
    vim.system({ "task", "--list-all", "--json" }, { text = true }, function(obj)
      if obj.code ~= 0 then
        cb({})
        return
      end

      local data = vim.json.decode(obj.stdout)
      local tasks = {}

      -- 3. Map JSON tasks to Overseer format
      for _, task in ipairs(data.tasks or {}) do
        table.insert(tasks, overseer.wrap_template({
          name = task.name,
          desc = task.desc or "Taskfile task",
          params = {},
          builder = function()
            return {
              cmd = { "task" },
              args = { task.name },
              components = { "default", "on_result_diagnostics" },
            }
          end,
        }, { name = task.name }))
      end

      cb(tasks)
    end)
  end,
  condition = {
    callback = function(opts)
      return vim.fs.find({ "Taskfile.yml", "Taskfile.yaml" }, { upward = true, path = opts.dir })[1] ~= nil
    end,
  },
})

```

---

### 3. Usage & Workflow

Once this is registered, your workflow becomes very streamlined:

* **Run a Task:** Call `:OverseerRun`. You will see all tasks from your `Taskfile.yml` listed.
* **Monitor:** Open `:OverseerToggle` to see a sidebar with running/failed/passed tasks.
* **Action:** You can restart, edit, or view logs for each task individually.

---

### 4. Alternative: The Telescope "Quick Pick"

If you don't need the full management features of Overseer and just want to trigger a task and see it in a terminal, you can use a simple **Telescope** picker. This is much "lighter" and requires less setup.

```lua
local function taskfile_picker()
    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local conf = require("telescope.config").values
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")

    -- Get tasks from Taskfile
    local handle = io.popen("task --list-all --summary")
    local result = handle:read("*a")
    handle:close()

    local tasks = {}
    for line in result:gmatch("[^\r\n]+") do
        local name = line:match("^%* ([%w%-_]+):")
        if name then table.insert(tasks, name) end
    end

    pickers.new({}, {
        prompt_title = "Taskfile Tasks",
        finder = finders.new_table({ results = tasks }),
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                -- Execute in a terminal
                vim.cmd("split | term task " .. selection[1])
            end)
            return true
        end,
    }):find()
end

vim.keymap.set("n", "<leader>tk", taskfile_picker, { desc = "Pick Taskfile task" })

```

### Why this is "State-of-the-Art"

* **JSON Integration:** Using `task --json` ensures that even if task names have spaces or complex characters, the parser won't break.
* **Non-blocking:** By using `vim.system` (callback-based), your UI remains fluid even if the `Taskfile` is massive.
* **Process Lifecycle:** Overseer handles the cleanup of processes, so you don't end up with "ghost" shell tasks if you close Neovim unexpectedly.

**Would you like me to refine the Overseer template to include "Task Parameters" (e.g., if you have a task that takes variable inputs)?**

To implement parameters for **Taskfile** tasks in **Overseer.nvim**, you need to define a `params` schema in the template. This allows Neovim to prompt you for input (like a version number, a filename, or a flag) before the task actually starts.

Since `go-task` handles variables using the `var=value` syntax (e.g., `task build VERSION=1.0.0`), we can map Overseer parameters directly to these CLI arguments.

### 1. The Parameterized Taskfile Template

Here is the updated template. I’ve added a logic block that checks if a task description contains specific keywords to trigger a parameter prompt, but you can also define them globally.

```lua
local overseer = require("overseer")

overseer.register_template({
  name = "Taskfile (with Params)",
  generator = function(opts, cb)
    local taskfile = vim.fs.find({ "Taskfile.yml", "Taskfile.yaml" }, { upward = true, path = opts.dir })[1]
    if not taskfile then return cb({}) end

    vim.system({ "task", "--list-all", "--json" }, { text = true }, function(obj)
      if obj.code ~= 0 then return cb({}) end
      local data = vim.json.decode(obj.stdout)
      local tasks = {}

      for _, task in ipairs(data.tasks or {}) do
        table.insert(tasks, overseer.wrap_template({
          name = task.name,
          desc = task.desc,
          -- Define parameters here
          params = {
            args = {
              type = "string",
              name = "Extra Arguments",
              desc = "Vars to pass (e.g. VERSION=1.0)",
              optional = true,
            },
          },
          builder = function(params)
            local cmd_args = { task.name }
            if params.args and params.args ~= "" then
              table.insert(cmd_args, params.args)
            end
            
            return {
              cmd = { "task" },
              args = cmd_args,
              components = { 
                "default", 
                { "display_duration", detail_level = 2 },
                "on_output_summarize",
                "on_exit_set_status" 
              },
            }
          end,
        }, { name = task.name }))
      end
      cb(tasks)
    end)
  end,
})

```

### 2. Why this is the "State-of-the-Art" workflow

Using Overseer this way provides a "Task Runner Console" experience similar to JetBrains or VS Code, but with Vim's speed.

* **Prompting:** When you select a task with `params`, Overseer opens a small floating window asking for the "Extra Arguments."
* **Status Tracking:** Instead of just a terminal scrolling by, you get a status line in your buffer or a side-panel showing exactly which tasks are running.
* **Components:** The `components` table in the builder allows you to add features like `on_result_diagnostics` which can automatically populate your **Quickfix list** if a Taskfile command (like a linter) fails.

---

### 3. Pro-Tip: Integrating with Neovim 0.12's `vim.ui.select`

If you want to keep your config "pure" without too many plugins, you can wrap the Taskfile logic in `vim.ui.select`. This uses the built-in system menu (or Telescope if you have `telescope-ui-select` installed).

```lua
local function run_task_with_ui()
  vim.system({"task", "--list-all", "--summary"}, {text = true}, function(obj)
    local tasks = {}
    for line in obj.stdout:gmatch("[^\r\n]+") do
      local name = line:match("^%* ([%w%-_]+):")
      if name then table.insert(tasks, name) end
    end

    vim.schedule(function()
      vim.ui.select(tasks, { prompt = "Execute Task:" }, function(choice)
        if not choice then return end
        -- Run in a background job or terminal
        vim.cmd("vsplit | term task " .. choice)
      end)
    end)
  end)
end

```

### Next Step

To make this really powerful, would you like me to show you how to add a **"Watcher"** component? This allows Neovim to automatically re-run a specific Taskfile task every time you save a `.py` or `.lua` file.

To implement a **Watcher** in Overseer, we leverage the plugin's "Components." This is what separates a basic script from a professional IDE-like task runner. By adding the `on_save_reload` component, you can keep a build or test task running in the background that reacts to your file changes.

### 1. The Watcher-Enabled Taskfile Template

This version of the template adds a `watch` parameter. If you toggle it to `true` when starting the task, Overseer will monitor your project directory and re-trigger the `task` command every time you save a file.

```lua
local overseer = require("overseer")

overseer.register_template({
  name = "Taskfile (with Watcher)",
  generator = function(opts, cb)
    local taskfile = vim.fs.find({ "Taskfile.yml", "Taskfile.yaml" }, { upward = true, path = opts.dir })[1]
    if not taskfile then return cb({}) end

    vim.system({ "task", "--list-all", "--json" }, { text = true }, function(obj)
      if obj.code ~= 0 then return cb({}) end
      local data = vim.json.decode(obj.stdout)
      local tasks = {}

      for _, task in ipairs(data.tasks or {}) do
        table.insert(tasks, overseer.wrap_template({
          name = task.name,
          desc = task.desc,
          params = {
            args = { type = "string", name = "Vars", optional = true },
            watch = { type = "boolean", name = "Watch files?", default = false },
          },
          builder = function(params)
            local cmd_args = { task.name }
            if params.args and params.args ~= "" then
              table.insert(cmd_args, params.args)
            end
            
            local components = { "default" }
            if params.watch then
              -- This component tells Overseer to restart the task on save
              table.insert(components, { "on_save_reload", delay = 500 })
            end

            return {
              cmd = { "task" },
              args = cmd_args,
              components = components,
            }
          end,
        }, { name = task.name }))
      end
      cb(tasks)
    end)
  end,
})

```

---

### 2. How the Watcher Works

Overseer doesn't just run a shell loop. It uses Neovim's internal **autocmd** system (`BufWritePost`) to detect when you've written to a buffer that belongs to the same project as the Taskfile.

1. **Selection:** You run `:OverseerRun`, pick a task, and set `Watch files?` to `true`.
2. **Execution:** The task runs once and stays in the Overseer list (usually marked with a "waiting" or "watching" icon).
3. **Trigger:** You edit a Python file and `:w`.
4. **Reaction:** Overseer immediately kills the previous process (if still running) and spawns a new one.

---

### 3. State-of-the-art UI: The Statusline

To make this workflow truly elite, you should display your task status in your statusline (e.g., Lualine). This way, you don't even have to open a side-panel to know if your background Taskfile command passed or failed.

**Example Lualine integration:**

```lua
require('lualine').setup({
  sections = {
    lualine_x = {
      {
        "overseer",
        label = 'Tasks: ', -- Prefix for the section
        unique = true,     -- Only show one representative icon per state
      }
    }
  }
})

```

### 4. Directing Output to the Quickfix List

If your Taskfile is running a compiler or a linter (like `ruff` or `pyright`), you can add the `on_result_diagnostics` component to the `builder` in the code above. This will parse the output and put errors directly into your **Quickfix list** (`:copen`), allowing you to jump straight to the broken line.

---

### One Final Caveat for Mac Users

Since you are on macOS, ensure you have `fswatch` installed (`brew install fswatch`). While Neovim has built-in file watching, some complex project structures work better with a dedicated library, and plugins like Overseer can hook into it for better performance.

**Would you like me to help you set up a custom "Diagnostic Provider" so that Taskfile errors show up as red squiggly lines directly in your code?**


To make Taskfile errors appear as **red squiggly lines (Diagnostics)** in your editor, we need to bridge the gap between the task's output and Neovim's internal `vim.diagnostic` engine.

In 2026, the most robust way to do this is using the **`on_result_diagnostics`** component in Overseer. This component uses an `errorformat` (a string that tells Neovim how to parse lines of text) to extract file paths, line numbers, and error messages.

### 1. The Diagnostic-Enabled Template

Update your `Taskfile` template to include an `errorformat`. Since you are working in Python, I'll use a standard Python error format, but you can change this depending on what your Taskfile runs (e.g., `ruff`, `flake8`, or `pytest`).

```lua
local overseer = require("overseer")

overseer.register_template({
  name = "Taskfile with Diagnostics",
  generator = function(opts, cb)
    local taskfile = vim.fs.find({ "Taskfile.yml", "Taskfile.yaml" }, { upward = true, path = opts.dir })[1]
    if not taskfile then return cb({}) end

    vim.system({ "task", "--list-all", "--json" }, { text = true }, function(obj)
      if obj.code ~= 0 then return cb({}) end
      local data = vim.json.decode(obj.stdout)
      local tasks = {}

      for _, task in ipairs(data.tasks or {}) do
        table.insert(tasks, overseer.wrap_template({
          name = task.name,
          params = {
            watch = { type = "boolean", name = "Watch files?", default = false },
          },
          builder = function(params)
            local components = { "default" }
            if params.watch then
              table.insert(components, { "on_save_reload", delay = 500 })
            end

            -- ADDED: This component parses the output into diagnostics
            table.insert(components, {
              "on_result_diagnostics",
              remove_on_restart = true,
              -- Standard Python error format (adjust as needed)
              errorformat = [[%f:%l:%c: %t%*[^ ] %m,%f:%l: %t%*[^ ] %m]],
            })

            return {
              cmd = { "task" },
              args = { task.name },
              components = components,
            }
          end,
        }, { name = task.name }))
      end
      cb(tasks)
    end)
  end,
})

```

---

### 2. How the "Squiggles" Appear

Once you run a task with this template:

1. Overseer captures the **stdout** of the task.
2. The `errorformat` scans the text. For example, if your task runs a linter that outputs `main.py:10:5: E error message`, the component recognizes `main.py` at line `10`.
3. Overseer calls `vim.diagnostic.set()`.
4. **Instant Feedback:** Red squiggles appear in your buffer on line 10. If you have a Watcher active, the squiggles will vanish automatically as soon as you fix the code and save (because the task re-runs and the output is now clean).

---

### 3. Tuning the `errorformat`

The `errorformat` (often abbreviated as `efm`) is a powerful but cryptic syntax inherited from Vim. Here are common strings for Taskfile projects:

* **Python (Ruff/Flake8):** `%f:%l:%c: %m`
* **Go (golangci-lint):** `%f:%l:%c: %m`
* **Generic (File:Line:Msg):** `%f:%l: %m`

### 4. Why this is better than standard LSP

While an LSP (like `pyright`) is great, sometimes your **Taskfile** runs complex integration tests or specialized linters that an LSP doesn't see. By turning your task runner into a diagnostic provider, you get a "Single Source of Truth." If the `task` fails, the editor shows it, regardless of whether the LSP thinks the code is "valid."

### Next Step

Since you are experimenting on Mac with a path toward Nix, would you like me to show you how to wrap this whole setup into a **Neovim Command** (like `:Task build --watch`) so you don't even have to use the Overseer UI?

----- error handling in Lua

# Error handling in Lua

for notes: https://docs.drools.org/8.39.0.Final/drools-docs/docs-website/drools/language-reference/index.html

### 1. Basic "Try-Catch" with `pcall`

`pcall` (protected call) executes a function. If an error occurs, it catches it and returns `false` plus the error message. If it succeeds, it returns `true` plus any values returned by the function.

```lua
-- Standard pcall pattern
local success, result = pcall(function()
    -- This code is "protected"
    local data = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    error("Something went wrong!") -- Manual trigger for example
    return data
end)

if success then
    print("Success! Data length: " .. #result)
else
    -- 'result' contains the error message if success is false
    print("Caught an error: " .. result)
end

```

---

### 2. Advanced "Try-Catch" with `xpcall`

`xpcall` (extended protected call) is the same as `pcall`, but it allows you to pass a **message handler** function. This handler runs *before* the stack is unwound, which is essential if you want a full **stack trace** (using `debug.traceback`).

```lua
local function my_function()
    error("Oops!")
end

local function my_handler(err)
    return "Custom Error Handler: " .. debug.traceback(err)
end

local status, err_msg = xpcall(my_function, my_handler)

if not status then
    print(err_msg) -- Will print the error + the line-by-line stack trace
end

```

---

### 3. The "Neovim Way": Guard Clauses

While `pcall` is useful for "risky" operations (like network calls or parsing JSON), most Neovim power users prefer **Guard Clauses** (conditionals) for ergonomics. This prevents the "callback hell" of wrapping everything in functions.

**Avoid this:**

```lua
pcall(function()
    require('telescope').setup()
end)

```

**Do this instead:**

```lua
local status, telescope = pcall(require, "telescope")
if not status then
    return -- Silently exit if plugin isn't installed
end

telescope.setup({ ... })

```

---

### Summary Table

| Feature | Lua Equivalent | Notes |
| --- | --- | --- |
| **`try`** | `pcall(function() ... end)` | Wraps code in an anonymous function. |
| **`except` / `catch**` | `if not success then` | Checks the boolean return of `pcall`. |
| **`throw`** | `error("msg")` | Interrupts execution and bubbles up to the nearest `pcall`. |
| **`finally`** | *None* | You must manually handle cleanup after the `if/else` block. |

### When to use what?

* **Use `pcall**` when calling `require` or external commands that might fail.
* **Use `assert(condition, message)**` for simple validation where you *want* the script to stop if something is wrong.
* **Use `vim.validate**` (Neovim-specific) to check the types of function arguments cleanly.

-----

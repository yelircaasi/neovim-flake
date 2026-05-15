# neovim-flake

## Roadmap

- [ ] gather all nvim configs I have written, glean what
      is still usable, combine them here
- [x] fork dial, fix structure, write nix expression
- [ ] take care of compiling fzf-lua-native
- [ ] find what has  sqlite.lua as a dependency
- [ ] move last bits of plugin-set.nix into plugins-derivation.nix,
      make each into own derivation? -> pass through as output packages
- [ ] go through, clean up and pare down notes
- [ ] get Python LSP running properly

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
[ ] 

## Data Flow

`plugin-set.nix` gets plugins from `nixpkgs` and `self-packaged-plugins.nix`.

`plugins-derivation.nix` packages the plugins together in the standard directory structure.

`transpilation.nix` transforms the `.tl` code into Lua and writes it as a derivation.

`treesitter.nix` takes care of 

`tools.nix` handles the external tools.

`pde.nix` wires all of these parts together and exposes the executables.



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




# neovim-flake

## Roadmap

### Next

- [ ] plugins from last good working config

- [ ] [USE] trouble.nvim
- [ ] [VENDOR] [wezterm.nvim](https://github.com/willothy/wezterm.nvim)
- [ ] [VENDOR] [wezterm-move.nvim](https://github.com/letieu/wezterm-move.nvim)
- [ ] [VENDOR] [shade.nvim](https://github.com/sunjon/shade.nvim)
- [ ] [USE] conform.nvim
- [ ] [USE] lazydev.nvim
- [ ] [USE] fidget.nvim
- [ ] [USE] https://github.com/mrjones2014/smart-splits.nvim
  - [ ] FixCursorHold.nvim
  - [ ] LuaSnip
  - [ ] bamboo.nvim
  - [ ] blink.cmp
  - [ ] cmp-buffer
  - [ ] cmp-nvim-lsp
  - [ ] cmp-path
  - [ ] cmp_luasnip
  - [ ] conform.nvim
  - [ ] copilot.lua
  - [ ] dial.nvim
  - [ ] diffview.nvim
  - [ ] friendly-snippets
  - [ ] gitsigns.nvim
  - [ ] lazy.nvim
  - [ ] lualine.nvim
  - [ ] markit.nvim
  - [ ] mini.nvim
  - [ ] neotest
  - [ ] neotest-python
  - [ ] nvim-bqf
  - [ ] nvim-cmp
  - [ ] nvim-nio
  - [ ] nvim-treesitter-textobjects
  - [ ] pickme.nvim
  - [x] plenary.nvim
  - [ ] snacks.nvim
  - [ ] telescope-fzf-native.nvim
  - [ ] telescope.nvim
  - [ ] todo-comments.nvim
  - [ ] toggleterm.nvim
  - [ ] vim-floaterm
  - [ ] vim-visual-multi
  - [ ] wezterm.nvim
  - [ ] which-key.nvim
  - [ ] yazi.nvim
  - [ ] zen-mode.nvim

- [ ] Add cloud.lua
- [ ] add factory functions and `make_setup_function` and `make_packadd` in utils to simplify 
      toggling plugin setup and passing around (wrapped) setup calls, adding them to keymaps and commands, etc
- [ ] Add basedpyright to nix-config, along with other language servers I want available from anywhere. 

- [ ] gather all nvim configs I have written, glean what
      is still usable, combine them here
- [x] fork dial, fix structure, write nix expression
- [ ] take care of compiling fzf-lua-native
- [ ] find what has sqlite.lua as a dependency -> install sqlite.lua as a module?
- [ ] move last bits of plugin-set.nix into plugins-derivation.nix,
      make each into own derivation? -> pass through as output packages
- [ ] go through, clean up and pare down notes
- [ ] get Python LSP running properly

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

#### Longer Plugin List

- [ ] [TRY] luasnip
- [ ] [TRY] oil
- [ ] [TRY] blink.cmp
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
    - [ ] [TRY] gh        GitHub CLI integration    
    - [ ] [TRY] git       Git utilities    
    - [ ] [TRY] gitbrowse Open the current file, branch, commit, or repo in a browser (e.g. GitHub, GitLab, Bitbucket)    
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
    - [ ] [TRY] quickfile When doing nvim somefile.txt, it will render the file as quickly as possible, before loading your plugins. (extra config required!)
    - [ ] [TRY] rename    LSP-integrated file renaming with support for plugins like neo-tree.nvim and mini.files.    
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
        - [ ] [] mini.ai           Extend and create a/i textobjects
        - [ ] [TRY] mini.align     Align text interactively
        - [ ] [] mini.comment      Comment lines
        - [ ] [] mini.completion   Completion and signature help
        - [ ] [TRY] mini.keymap    Special key mappings
        - [ ] [TRY] mini.move      Move any selection in any direction
        - [ ] [TRY] mini.operators Text edit operators
        - [ ] [TRY] mini.pairs     Autopairs
        - [ ] [] mini.snippets     Manage and expand snippets
        - [ ] [] mini.splitjoin    Split and join arguments
        - [ ] [TRY] mini.surround  Surround actions
    - [ ] [] workflow
        - [ ] [] mini.basics       Common configuration presets
        - [ ] [] mini.bracketed    Go forward/backward with square brackets
        - [ ] [] mini.bufremove    Remove buffers
        - [ ] [] mini.clue         Show next key clues
        - [ ] [] mini.cmdline      Command line tweaks
        - [ ] [] mini.deps         Plugin manager
        - [ ] [TRY] mini.diff      Work with diff hunks
        - [ ] [] mini.extra        Extra ‘mini.nvim’ functionality
        - [ ] [TRY] mini.files     Navigate and manipulate file system
        - [ ] [] mini.git          Git integration
        - [ ] [] mini.jump         Jump to next/previous single character
        - [ ] [] mini.jump2d       Jump within visible lines
        - [ ] [] mini.misc         Miscellaneous functions
        - [ ] [TRY] mini.pick      Pick anything
        - [ ] [TRY] mini.sessions  Session management
        - [ ] [TRY] mini.visits    Track and reuse file system visits
    - [ ] [] appearance
        - [ ] [] mini.animate      Animate common Neovim actions
        - [ ] [] mini.base16       Base16 colorscheme creation
        - [ ] [] mini.colors       Tweak and save any color scheme
        - [ ] [] mini.cursorword   Autohighlight word under cursor
        - [ ] [] mini.hipatterns   Highlight patterns in text
        - [ ] [] mini.hues         Generate configurable color scheme
        - [ ] [] mini.icons        Icon provider
        - [ ] [] mini.indentscope  Visualize and work with indent scope
        - [ ] [] mini.map          Window with buffer text overview
        - [ ] [] mini.notify       Show notifications
        - [ ] [] mini.starter      Start screen
        - [ ] [] mini.statusline   Statusline
        - [ ] [] mini.tabline      Tabline
        - [ ] [USE] mini.trailspace Trailspace (highlight and remove)
    - [ ] [] other
        - [ ] [] mini.doc          Generate Neovim help files
        - [ ] [TRY] mini.fuzzy     Fuzzy matching
        - [ ] [] mini.test         Test Neovim plugins

#### === TO HACK ON ===

- [ ] oxi

#### === SOMEDAY ===

- [ ] compiler-explorer
- [ ] dotbox
- [ ] oceanic-material
- [ ] quarto
- [ ] render
- [ ] telescope-file-history
- [ ] trouble.nvim
- [ ] typescript-tools
- [ ] typst
- [ ] vague
- [ ] metals
- [ ] neotest-scala
- [ ] nfnl
- [ ] BufEx
- [ ] gopher
- [ ] gruvbox-material
- [ ] hologram
- [ ] image_preview
- [ ] jupytext
- [ ] cloak

#### === TO VENDOR ===

- [ ] vim-capslock
- [ ] vim-numbertoggle
- [ ] vim-repeat
- [ ] wb-only-current-line
- [ ] nvim-trevJ.lua
- [ ] git-blame.vim
- [ ] dsf.vim
- [ ] lastplace
- [ ] local-yokel
- [ ] checkupdate
- [ ] editorconfig

#### More complicated installations:

```lua
  setup_plugin("ido", {}) -- 'fzy.lua' not found
  setup_plugin("ivy", {}) -- libivyrs.so not found
```

#### Fix dependency: ts-context-commentstring
```lua
	setup_plugin("structlog", {})
```

#### Set up telescope extensions:

```lua
  -- https://github.com/tarting/tktodo.nvim
  -- A telescope extension to toggle todo items in notes from the telekasten.nvim home directory.
	setup_plugin("tktodo", {}) 
	setup_plugin("telescope-code-actions", {})
	setup_plugin("telescope-file-browser", {})
	setup_plugin("telescope-github", {})
	setup_plugin("telescope-json-history", {})
	setup_plugin("telescope-project", {})
	setup_plugin("telescope-repo", {})
	setup_plugin("telescope-smart-history", {})
	setup_plugin("telescope-xc", {})
```

#### Set up completion sources:

```lua
	setup_plugin("cmp_bulma", {})
	setup_plugin("cmp-nvim-lsp-signature-help", {})
	setup_plugin("cmp-nvim-telekasten-tags", {})
	setup_plugin("cmp-fonts", {})
	setup_plugin("cmp-lua-latex-symbols", {}) -- TODO: rebuild nix
```

#### Resolve neorg dependencies

- treesitter, pathlib, utils.lua, etc: https://github.com/nvim-neorg/neorg#neorg-kickstart

```lua
	setup_plugin("neorg", {})
	setup_plugin("neorg-taskwarrior", {})
```

neorg-taskwarrior behaves as a neorg plugin, not a top-level plugin

### Reading / Theory

- [ ] https://neovim.io/doc/user/lsp/#vim.lsp.buf.typehierarchy()

- [ ] https://docs.rockylinux.org/10/books/nvchad/ *********

- [ ] go through [awesome-neovim](https://github.com/rockerBOO/awesome-neovim)

- [ ] https://www.hermit-tech.com/

- [ ] https://ludic.mataroa.blog/blog/i-will-fucking-piledrive-you-if-you-mention-ai-again/

- [ ] https://www.youtube.com/watch?v=HLp879ZDhVc

- [ ] https://www.youtube.com/playlist?list=PLPDVgSbOnt7LXQ8DTzu37UwCpA0elyD0V

### Remove from Nix plugins

- [ ] "vim-twig"
- [ ] "tree-sitter-just"
- [ ] "guard"
- [ ] "nvim-treesitter"
- [ ] "splitjoin.vim (kept lua version)
- [ ] "none-ls"
- [ ] "nvim-alt-substitute" (archived; superseded by nvim-rip-substitute)
- [ ] "pylsp-rope"
- [ ] "vim-multiple-cursors"
- [ ] https://github.com/Slyces/hierarchy.nvim
      Neovim plugin providing an attempt to « hack around » the lack of support
      (in clients & servers) for the type hierarchy LSP protocol.

### CLI / non-plugin tools

- [ ] https://github.com/atiladefreitas/dooing

### Development

- [ ] xit rewrite
- [ ] wezterm_send
- [ ] consilium

### Features

- [ ] https://www.reddit.com/r/rust/comments/1efj1ci/is_it_possible_to_use_clippy_with_nvim_and_get/
- [x] add jsregexp for luasnip
- [ ] load python snippets from various formats
- [ ] add minvim: minimal nvim (or just vim?) executable+config with good colorscheme and nothing
      (or very little) else, for quick edits (like open nvim with wezterm visible)
- [ ] add custom syntax highlighting (later maybe even LSPs) for pictrix and kleidoukhos DSLs: analogous to,
      and using similar setups to, consilium DSLs -> write treesitter parsers someday
- [ ] install cooklang LSP and tooling

### Configs to check out

- [ ] https://github.com/luxvim/LuxVim
- [ ] https://github.com/akinsho/dotfiles

- [ ] https://github.com/hendrikmi/dotfiles/tree/main/nvim https://www.youtube.com/watch?v=e34qllePuoc
- [ ] https://github.com/echasnovski/nvim
- [ ] https://github.com/glepnir/nvim
- [ ] https://github.com/NTBBloodbath/nvim
- [ ] https://github.com/vhyrro/config
- [ ] https://github.com/BirdeeHub/birdeevim
- [ ] https://jitesh117.github.io/vim_stuff/walkthrough-of-my-neovim-config/
- [ ] https://github.com/travisvroman/nvim-dotfiles  https://travisvroman.com/articles/vimsetup.html
- [ ] https://rsdlt.github.io/posts/rust-nvim-ide-guide-walkthrough-development-debug/

### Nix config

- [ ] https://ayats.org/blog/neovim-wrapper
- [ ] https://github.com/calops/nix/tree/main/modules/home/programs/neovim

- [ ] https://github.com/yelircaasi/neovim-flake
- [ ] https://github.com/yelircaasi/nvim-pde-via-nix
- [ ] https://github.com/yelircaasi/nvim-config-old
- [ ] https://github.com/yelircaasi/neovim-ide-flake
- [ ] https://github.com/yelircaasi/neovim-python-pde

- [ ] https://github.com/youwen5/viminal2 *********
- [ ] https://primamateria.github.io/blog/neovim-nix/
- [ ] https://github.com/gvolpe/neovim-flake
- [ ] https://github.com/jordanisaacs/neovim-flake
- [ ] https://github.com/wiltaylor/neovim-flake
- [ ] https://github.com/cwfryer/neovim-flake/
- [ ] https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#plugin-template

### Plugins to check out

- [ ] ********* https://git.laack.co/flashcards.nvim/log.html
- [ ] https://github.com/nvimtools  -> check out repos
- [ ] https://github.com/nvzone/volt  --> check examples in README

- [ ] https://github.com/LuxVim/nvim-luxterm

- [ ] https://github.com/mistweaverco/juu.nvim

- [ ] https://github.com/AlexandrosAlexiou/kotlin.nvim *********

- [ ] https://github.com/va9iff/lil
- [ ] https://github.com/uga-rosa/ccc.nvim
- [ ] https://github.com/eero-lehtinen/oklch-color-picker.nvim

- [ ] https://github.com/antosha417/nvim-compare-with-clipboard
- [ ] https://github.com/tpope/vim-unimpaired/
- [ ] https://github.com/fedepujol/move.nvim
- [ ] https://github.com/ptdewey/pendulum-nvim

- [ ] https://github.com/skanehira/k8s.vim
- [ ] https://github.com/m00qek/baleia.nvim
- [ ] https://github.com/bullets-vim/bullets.vim

- [ ] https://github.com/h4ckm1n-dev/kube-utils-nvim
- [ ] https://github.com/numtostr/navigator.nvim

- [ ] https://github.com/GCBallesteros/NotebookNavigator.nvim/
- [ ] https://github.com/GR3YH4TT3R93/licenses.nvim
- [ ] https://github.com/tjdevries/present.nvim
- [ ] https://github.com/rareitems/anki.nvim
- [ ] https://github.com/idris-community/idris2-nvim
- [ ] https://github.com/jake-stewart/multicursor.nvim

- [ ] https://github.com/codeasashu/oas.nvim
- [ ] https://github.com/tlj/api-browser.nvim
- [ ] https://github.com/rusagaib/oas-preview.nvim

- [ ] https://github.com/mistweaverco/floaterm.nvim

- [ ] https://github.com/Robitx/gp.nvim
- [ ] https://openrouter.ai/ + https://github.com/josh-le/openrouter.nvim
- [ ] https://github.com/frankroeder/parrot.nvim
## Data Flow

`plugin-set.nix` gets plugins from `nixpkgs` and `self-packaged-plugins.nix`.

`plugins-derivation.nix` packages the plugins together in the standard directory structure.

`transpilation.nix` transforms the `.tl` code into Lua and writes it as a derivation.

`treesitter.nix` takes care of 

`tools.nix` handles the external tools.

`pde.nix` wires all of these parts together and exposes the executables.

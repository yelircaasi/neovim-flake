# neovim-flake

This flake is designed to handle installation (nvim, plugins, lua modules,
treesitter, etc.) and provide a default configuration with a global `utils`
module and my current preferred plugins and settings. It also provides two
hooks that allow me to iterate quickly and add features ad hoc:

- `$HOME/.config/nvim/after_init.lua`

- `$HOME/.config/nvim/after_init.lua`

The key design choice here is to cleanly separate installation from
configuration, while striking a comfortable balance between declarativity and
flexibility.

## Roadmap

1. [ ] 

2. [ ] set up efm-langserver with LSP
3. [ ] 
4. [ ] 
5. [ ] 
6. [ ] 

### Mappings (key knowledge)

Use localleader as a different key from leader (conventionally for local mappings,
but not required to be). Other conventions:

- `]` as a namespace (already conventional for "next" operations)
- `[` for "prev"
- `g` for "go to"
- `z` for fold/view operations
- use `<leader>t` for test, `<leader>g` for git, etc.

Use `{ buffer = true }` for buffer-local mappings.

Set `vim.opt.timeoutlen = 300`  -- ms to wait for a key sequence to complete

The built-in prefix keys (wait for another key by default):

- `g`: extended motion/operation namespace
- `z`: fold/view/spell namespace
- `[` / `]`: prev/next pairs
- `"`: register selection
- `'` / `` ` ``: mark jumping
- `<C-w>`: window operations
- `c` / `d` / `y`: operator (wait for motion)
- `>` / `<` / `=`: indent operators

Self-contained keys (act immediately in normal mode):

- `h`/`j`/`k`/`l`: motion
- `x`: delete char
- `p` / `P`: put
- `u` / `<C-r>`: undo/redo
- `i`/`a`/`o`/`O`: enter insert
- `v`/`V`/`<C-v>`: enter visual
- `r`: replace char (technically waits for one key)
- `~`: toggle case
- `J`: join lines
- `n`/`N`: search next/prev

`->` Explore these with `:Telescope keymaps` (or `fzf-lua`'s equivalent `fzf.keymaps()`) to fuzzy-search all active mappings and see exactly what each key does.

### Desired Mappings / Features

#### --- NAVIGATION ---

- [ ] windows:
  - navigate up: `<Ctrl-w>k`
  - navigate down: `<Ctrl-w>j`
  - navigate left: `<Ctrl-w>h`
  - navigate right: `<Ctrl-w>l`
  - move up: ``fzf menu
  - move down: ``
  - move left: ``
  - move right: ``
- [ ] rg menu
- [ ] file picker
- [ ] menu navigation (up down)
- [ ] tabs: up down left right, fzf menu, menu navigation (up down), move/rearrange
- [ ] buffers: up down left right, fzf menu, menu navigation (up down), move/rearrange

#### --- SORT ---

- [ ] open quickfix window
- [ ] open floating terminal
- [ ] copy selection to new file
- [ ] jump to reference (next, previous)
- [ ] jump to definition
- [ ] open search and replace (with preview)
- [ ] fold block
- [ ] fold/unfold all of given level
- [ ] toggle value under cursor
- [ ] rename everywhere (optionally with preview)
- [ ] search pattern/regex in given files -> save results list & use it to navigate
- [ ] show keybinds available
- [ ] add/view/edit comment/annotation pointing to given location
- [ ] view/navigate TODOs and comments
- [ ] insert snippet
- [ ] format code (optionally only under selection)
- [ ] edit selection in new buffer
- [ ] dull colors outside of selection
- [ ] edit filesystem as a buffer (oil.nvim?)
- [ ] get autocomplete suggestion
- [ ] check spelling in file (ONLY on command!)
- [ ] view diff (with saved, last commit, etc.)
- [ ] file tree view
- [ ] navigate between search results
- [ ] toggle to light colors (or even lighten/darken colors, increase contrast -> write plugin?)
- [ ] jump to next syntactic object
- [ ] command to run changed tests (use testmon or analogous)
- [ ] get LLM feedback
- [ ] unified preview_+accept/reject framework
- [ ] multi-line / multi-location edits

#### AUTOMATIC/TOGGLABLE FUNCTIONALITIES
- [ ] --> dull colors everywhere except in active block (via treesitter?)
- [ ] --> custom syntax highlighting for my special formats (from consilium-notes: jn, ...)

### Next

- [x] add <leader>wq, <leader>qq, etc
- [ ] plugins from last good working config

- [X] Add cloud.lua
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

- [x] [USING] [lazygit](https://github.com/kdheepak/lazygit.nvim) / [neogit](https://github.com/NeogitOrg/neogit)
- [x] [USING] auto-session
- [x] [USING] blink.cmp
- [x] [USING] cargo
- [x] [USING] conform.nvim
- [x] [USING] copilot.lua
- [x] [USING] crates
- [x] [USING] deck
- [x] [USING] dial.nvim
- [x] [USING] diffview.nvim
- [x] [USING] fidget.nvim
- [x] [USING] flash.nvim
- [x] [USING] friendly-snippets
- [x] [USING] gitsigns.nvim
- [x] [USING] grug-far.nvim https://github.com/MagicDuck/grug-far.nvim
- [x] [USING] haskell-tools
- [x] [USING] hlsearch.nvim
- [x] [USING] https://github.com/b0o/schemastore.nvim
- [x] [USING] https://github.com/hrsh7th/nvim-deck
- [x] [USING] https://github.com/mrjones2014/smart-splits.nvim
- [x] [USING] https://github.com/Tastyep/structlog.nvim
- [x] [USING] lazydev
- [x] [USING] lazydev.nvim
- [x] [USING] lsp-format
- [x] [USING] lspkind
- [x] [USING] lspsaga
- [x] [USING] lualine.nvim
- [x] [USING] luasnip
- [x] [USING] LuaSnip
- [x] [USING] markit.nvim
- [x] [USING] mfussenegger/nvim-dap and rcarriga/nvim-dap-ui
- [x] [USING] mini.nvim
- [x] [USING] modes.nvim
- [x] [USING] mypy
- [x] [USING] neo-tree.nvim
- [x] [USING] NeoComposer 
- [x] [USING] neorepl
- [x] [USING] neotest
- [x] [USING] neotest-python
- [x] [USING] null-ls
- [x] [USING] nvim-bqf
- [x] [USING] nvim-lint
- [x] [USING] nvim-nio
- [x] [USING] nvim-treesitter-textobjects
- [x] [USING] oil
- [x] [USING] persistence
- [x] [USING] pickme.nvim
- [x] [USING] plenary.nvim
- [x] [USING] project_nvim
- [x] [USING] quicker
- [x] [USING] rainbow-delimiters.nvim
- [x] [USING] recorder
- [x] [USING] refactoring
- [x] [USING] render-markdown.nvim
- [x] [USING] rustaceanvim
- [x] [USING] SmiteshP/nvim-navic
- [x] [USING] snacks.nvim
- [x] [USING] telescope-fzf-native.nvim
- [x] [USING] telescope.nvim
- [x] [USING] todo-comments.nvim
- [x] [USING] toggleterm.nvim
- [x] [USING] trouble.nvim
- [x] [USING] vim-floaterm
- [x] [USING] vim-visual-multi
- [x] [USING] which-key.nvim
- [x] [USING] yazi.nvim
- [x] [USING] zen-mode.nvim

#### Plugin Suites

- [ ] [LATER] https://github.com/nvimtools/none-ls.nvim/
- [ ] [USING] snacks.nvim
    - [ ] [LATER] animate      Efficient animations including over 45 easing functions (library)    
    - [ ] [LATER] bigfile      Deal with big files (extra config required!)
    - [ ] [LATER] bufdelete    Delete buffers without disrupting window layout    
    - [x] [USING] dashboard    Beautiful declarative dashboards (extra config required!)
    - [ ] [LATER] debug        Pretty inspect & backtraces for debugging    
    - [ ] [LATER] dim          Focus on the active scope by dimming the rest    
    - [ ] [LATER] explorer     A file explorer (picker in disguise) (extra config required!)
    - [ ] [LATER] gh           GitHub CLI integration    
    - [ ] [LATER] git          Git utilities
    - [ ] [LATER] gitbrowse    Open the current file, branch, commit, or repo in a browser 
                               (e.g. GitHub, GitLab, Bitbucket)
    - [ ] [LATER] image        Image viewer using Kitty Graphics Protocol, supported by kitty,
                               wezterm and ghostty (extra config required!)
    - [ ] [LATER] indent       Indent guides and scopes
    - [ ] [LATER] input        Better vim.ui.input (extra config required!)
    - [ ] [LATER] keymap       Better vim.keymap with support for filetypes and LSP clients
    - [ ] [LATER] layout       Window layouts
    - [ ] [LATER] lazygit      Open LazyGit in a float, auto-configure colorscheme and integration
                               with Neovim
    - [ ] [LATER] notifier     Pretty vim.notify (extra config required!)
    - [ ] [LATER] notify       Utility functions to work with Neovim's vim.notify
    - [x] [USING] picker       Picker for selecting items (extra config required!)
    - [ ] [LATER] profiler     Neovim lua profiler
    - [ ] [LATER] quickfile    When doing nvim somefile.txt, it will render the file as quickly as
                               possible, before loading your plugins. (extra config required!)
    - [ ] [LATER] rename       LSP-integrated file renaming with support for plugins like
                               neo-tree.nvim and mini.files.
    - [ ] [LATER] scope        Scope detection, text objects and jumping based on treesitter or
                               indent (extra config required!)
    - [ ] [LATER] scratch      Scratch buffers with a persistent file
    - [ ] [LATER] scroll       Smooth scrolling (extra config required!)
    - [ ] [LATER] statuscolumn Pretty status column (extra config required!)
    - [ ] [LATER] terminal     Create and toggle floating/split terminals
    - [ ] [LATER] toggle       Toggle keymaps integrated with which-key icons / colors
    - [ ] [LATER] util         Utility functions for Snacks (library)
    - [ ] [LATER] win          Create and manage floating windows or splits
    - [ ] [LATER] words        Auto-show LSP references and quickly navigate between them 
                               (extra config required!)
    - [ ] [LATER] zen          Zen mode • distraction-free coding
- [ ] go through [nvimdev](https://nvimdev.github.io)
    - [x] [USING] flybuf.nvim: Show buffers list in float window and quickly navigate between
    - [x] [USING] indentmini.nvim: A minimalist indent plugin https://github.com/nvimdev/indentmini.nvim
    - [x] [USING] lspsaga.nvim: Neovim LSP enhancement plugin
    - [ ] [LATER] dashboard-nvim: Fancy Neovim start screen
    - [ ] [LATER] dbsession.nvim: A simple session management plugin
    - [ ] [LATER] dyninput.nvim: Dynamically change input character
    - [ ] [LATER] nerdicons.nvim: Search, copy, and paste Nerd Fonts icons
    - [ ] [LATER] template.nvim: Template for Neovim
    - [ ] [REJECTED] guard.nvim: Async format and linting utility for Neovim
- [ ] go through [mini suite](https://nvim-mini.org/mini.nvim/)
    - [ ] [] editing
        - [x] [USING] mini.align        Align text interactively
        - [ ] [LATER] mini.ai           Extend and create a/i textobjects
        - [ ] [LATER] mini.comment      Comment lines
        - [ ] [LATER] mini.completion   Completion and signature help
        - [ ] [LATER] mini.keymap       Special key mappings
        - [ ] [LATER] mini.move         Move any selection in any direction
        - [ ] [LATER] mini.operators    Text edit operators
        - [ ] [LATER] mini.pairs        Autopairs
        - [ ] [LATER] mini.snippets     Manage and expand snippets
        - [ ] [LATER] mini.splitjoin    Split and join arguments
        - [ ] [LATER] mini.surround     Surround actions
    - [ ] [] workflow
        - [ ] [LATER] mini.basics       Common configuration presets
        - [ ] [LATER] mini.bracketed    Go forward/backward with square brackets
        - [ ] [LATER] mini.bufremove    Remove buffers
        - [ ] [LATER] mini.clue         Show next key clues
        - [ ] [LATER] mini.cmdline      Command line tweaks
        - [ ] [LATER] mini.deps         Plugin manager
        - [ ] [LATER] mini.diff         Work with diff hunks
        - [ ] [LATER] mini.extra        Extra ‘mini.nvim’ functionality
        - [ ] [LATER] mini.files        Navigate and manipulate file system
        - [ ] [LATER] mini.git          Git integration
        - [ ] [LATER] mini.jump         Jump to next/previous single character
        - [ ] [LATER] mini.jump2d       Jump within visible lines
        - [ ] [LATER] mini.misc         Miscellaneous functions
        - [ ] [LATER] mini.pick         Pick anything
        - [ ] [LATER] mini.sessions     Session management
        - [ ] [LATER] mini.visits       Track and reuse file system visits
    - [ ] [LATER] appearance
        - [ ] [LATER] mini.animate      Animate common Neovim actions
        - [ ] [LATER] mini.base16       Base16 colorscheme creation
        - [ ] [LATER] mini.colors       Tweak and save any color scheme
        - [ ] [LATER] mini.cursorword   Autohighlight word under cursor
        - [ ] [LATER] mini.hipatterns   Highlight patterns in text
        - [ ] [LATER] mini.hues         Generate configurable color scheme
        - [ ] [LATER] mini.icons        Icon provider
        - [ ] [LATER] mini.indentscope  Visualize and work with indent scope
        - [ ] [LATER] mini.map          Window with buffer text overview
        - [ ] [LATER] mini.notify       Show notifications
        - [ ] [LATER] mini.starter      Start screen
        - [ ] [LATER] mini.statusline   Statusline
        - [ ] [LATER] mini.tabline      Tabline
        - [ ] [USE] mini.trailspace     Trailspace (highlight and remove)
    - [ ] [LATER] other
        - [ ] [LATER] mini.doc          Generate Neovim help files
        - [ ] [LATER] mini.fuzzy        Fuzzy matching
        - [ ] [LATER] mini.test         Test Neovim plugins

#### === TO HACK ON ===

- [ ] [LATER] oxi

#### === REJECTED ===

- [ ] [REJECTED] FixCursorHold.nvim
- [ ] [REJECTED] cmp_luasnip
- [ ] [REJECTED] cmp-buffer
- [ ] [REJECTED] cmp-nvim-lsp
- [ ] [REJECTED] cmp-path
- [ ] [REJECTED] lazy.nvim
- [ ] [REJECTED] nvim-cmp

#### === SOMEDAY ===

- [ ] compiler-explorer
- [ ] dotbox
- [ ] oceanic-material
- [ ] quarto
- [ ] render
- [ ] telescope-file-history
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
- [x] jupytext
- [ ] cloak
- [ ] [ivy](https://github.com/AdeAttwood/ivy.nvim)

#### === TO VENDOR ===

- [ ] [VENDOR] [jvim](https://github.com/ThePrimeagen/jvim.nvim) JSON navigation
- [ ] [VENDOR] [shade.nvim](https://github.com/sunjon/shade.nvim)
- [ ] [VENDOR] [wezterm-move.nvim](https://github.com/letieu/wezterm-move.nvim)
- [ ] [VENDOR] [wezterm.nvim](https://github.com/willothy/wezterm.nvim)
- [ ] [VENDOR] bamboo.nvim
- [ ] [VENDOR] wezterm.nvim
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

#### Fix dependency: ts-context-commentstring

- structlog

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

#### Remove old completion sources (when blink.cmp is working):

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

### Wezterm Config

- [ ] wezterm desiderata:
  - [ ] select and copy terminal output
  - [ ] unicode working right
  - [ ] rearrange terminal layout
  - [ ] default pane layout
  - [ ] history
  - [ ] different shells
  - [ ] open path in output in X (new pane, current pane, new tab)
  - [ ] proper handling of url
  - [ ] vim keybindings for line editing (provided by wezterm or shell?
        or simply open minimal vim editor to edit command)
  - [ ] comfortable switching between different shells (bash, nushell, xonsh, elvish, etc)

- TODO: `enable_osc52 = true` ?

#### wezterm-integration.nvim

- [ ] make shell-highlighted scratch buffer that sends the command to wezterm and collects the output
- [ ] wezterm: TODO: vendor
  - [ ] https://github.com/willothy/wezterm.nvim
  - [ ] https://github.com/ianhomer/wezterm.nvim
  - [ ] https://github.com/aca/wezterm.nvim (in Go)
  - [ ] https://github.com/letieu/wezterm-move.nvim
  - [ ] https://github.com/jonboh/wezterm-mux.nvim -> https://github.com/mrjones2014/smart-splits.nvim

### Reading / Theory

- [ ] Learning the vi and Vim Editors

- [ ] [Neovim Registers: Work Smarter, Not Harder](https://www.youtube.com/watch?v=jSy8WjSyMAE)

- [ ] [Registers Explained - Vim Tips & Tricks - Stop Losing Text in Vim](https://www.youtube.com/watch?v=bBU7gVNqVFw)

- [ ] https://samuellawrentz.com/hacks/neovim/demystifying-buffers-windows-tabs-neovim/

- [ ] https://samuellawrentz.com/hacks/neovim/boost-your-coding-efficiency/

- [ ] https://samuellawrentz.com/hacks/neovim/best-practices-for-optimizing-setup/

- [ ] https://samuellawrentz.com/hacks/neovim/exploring-neovim-next-generation-vim-editor/

- [ ] https://neovim.io/doc/user/lsp/#vim.lsp.buf.typehierarchy()

- [ ] https://docs.rockylinux.org/10/books/nvchad/ *********

- [ ] go through [awesome-neovim](https://github.com/rockerBOO/awesome-neovim)

- [ ] https://www.hermit-tech.com/

- [ ] https://ludic.mataroa.blog/blog/i-will-fucking-piledrive-you-if-you-mention-ai-again/

- [ ] https://www.youtube.com/watch?v=HLp879ZDhVc

- [ ] https://www.youtube.com/playlist?list=PLPDVgSbOnt7LXQ8DTzu37UwCpA0elyD0V

- [ ] https://www.reddit.com/r/neovim/comments/1afw5tc/rustaceanvim_now_with_neotest_integration/

- [ ] look at https://github.com/yochem/lazy-vimpack

### Remove from Nix plugins

- [x] zellij.nvim
- [x] "vim-twig"
- [x] "tree-sitter-just"
- [x] "guard"
- [x] "nvim-treesitter"
- [x] "splitjoin.vim (kept lua version)
- [ ] "none-ls"
- [x] "nvim-alt-substitute" (archived; superseded by nvim-rip-substitute)
- [ ] "pylsp-rope"
- [x] "vim-multiple-cursors"
- [x] https://github.com/Slyces/hierarchy.nvim
      Neovim plugin providing an attempt to « hack around » the lack of support
      (in clients & servers) for the type hierarchy LSP protocol.

### CLI / non-plugin tools

- [ ] https://github.com/atiladefreitas/dooing

### LSP Servers

- [ ] additional LSPs:
  - [ ] https://github.com/latex-lsp/texlab
  - [ ] jsonls and yamlls
  - [ ] https://www.npmjs.com/package/vscode-json-languageserver
  - [ ] https://github.com/redhat-developer/yaml-language-server
  - [ ] write my own LSP(s) for consilium

- [ ] install language servers:
  - [ ] ruff
  - [ ] lua-language-server
  - [ ] rust-analyzer
  - [ ] haskell-language-server

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

# Neovim Paths

## Core behavior directories

- `ftplugin/`: filetype plugins:
  Vimscript/Lua files named after filetypes (e.g. `python.vim`, `rust.vim`) that run automatically
  when a buffer of that type is opened. Used for filetype-specific settings like `shiftwidth`,
  `commentstring`, `omnifunc`, etc. Unlike `plugin/`, these are loadedper-buffer and can be loaded
  multiple times.

- `indent/`: filetype indent rules:
  Same loading mechanic as `ftplugin/` but narrowly focused on indentation logic: `indentexpr`,
  `indentkeys`, etc. Kept separate so indent behavior can be overridden without touching the rest
  of the filetype plugin.

- `syntax/`: syntax highlighting definitions:
  Legacy Vimscript-based syntax files, one per filetype. Still widely used for filetypes not yet
  covered by Tree-sitter grammars. When both exist, Tree-sitter typically wins if
  `vim.treesitter.start()` is called.

- `compiler/`: compiler definitions:
  Files loaded by `:compiler <name>`: they set `makeprg` and `errorformat` so `:make` knows how to
  invoke a build tool and parse its output into the quickfix list. Examples:
  - `gcc.vim`
  - `cargo.vim`
  - `pytest.vim`.

### Plugin loading directories

- `plugin/`: global plugins:
  Vimscript/Lua files here are sourced once at startup, unconditionally, for all filetypes.
  This is where built-in "always-on" functionality lives (e.g. `netrw`, `matchparen`).

- `autoload/`: lazy-loaded functions:
  The classic Vimscript demand-loading mechanism. A function `foo#bar#baz()` is automatically
  sourced from `autoload/foo/bar.vim` the first time it's called. Reduces startup time by deferring
  code until it's actually needed. Less relevant in Lua-first plugins but still heavily used by
  older plugins.

- `pack/`: packages:
  Neovim's built-in package manager directory, following Vim's `packages` spec.
  The layout is `pack/<name>/start/<plugin>` (auto-loaded) and `pack/<name>/opt/<plugin>`
  (loaded on demand with `:packadd`).
  In a Nix derivation, bundled plugins are typically installed here.

### Lua runtime

- `lua/`: Lua runtime modules:
  Anything here is on `package.path` and importable via `require()`.
  Neovim's own Lua standard library lives here
  (`vim.lsp`, `vim.treesitter`, `vim.diagnostic`, etc.).
  `lua/` in `runtimepath` works the same way.

### Tree-sitter

- `queries/`: Tree-sitter query files:
  Organized as `queries/<language>/*.scm`. The `.scm` files define Tree-sitter queries for
  highlights (`highlights.scm`), indentation (`indents.scm`), folds (`folds.scm`),
  injections (`injections.scm`), and text objects (`textobjects.scm`).
  These are what actually drive Tree-sitter-based highlighting and structural editing.

### Miscellaneous

- `keymap/`: Keyboard layout keymaps:
  Used with `:set keymap=<name>` for input method support: e.g. typing in Greek, Hebrew, or Russian
  using a Latin keyboard. Very niche; most users never touch this.

- `colors/`: Colorschemes:
  Files loaded by `:colorscheme <name>`. Each file sets highlight groups. Built-in schemes like
  `desert`, `haiku`, `lunaperche` live here.

- `scripts/`: Filetype detection scripts:
  Primarily `script.vim` (and similar), which is consulted during filetype detection when the
  filename alone isn't enough: it inspects file content (shebangs, magic bytes, modelines) to
  determine the filetype. Part of the `filetype.lua`/`filetype.vim` detection chain.

### Loading order summary

```
startup
  |-- plugin/          | always, once
  |-- pack/*/start/    | always, once (packages)
       |-- plugin/     | each package's plugins

on buffer open
  |-- ftplugin/        | per filetype, per buffer
  |-- indent/          | per filetype, per buffer
  |-- syntax/          | per filetype (if not using TS)
  |-- queries/         | per filetype (Tree-sitter)

on demand
  |-- autoload/        | when function first called
  |-- colors/          | on :colorscheme
  |-- compiler/        | on :compiler
  |-- keymap/          | on :set keymap=
```


## `pack/` Directory

The `pack/` directory implements Vim's packages spec (introduced in Vim 8, inherited by Neovim).
The full layout looks like this:

```
pack/
|-- <collection>/
    ├── start/
    │   |-- <plugin>/
    │       ├── plugin/
    │       ├── autoload/
    │       ├── lua/
    │       ├── ftplugin/
    │       ├── syntax/
    │       ├── queries/
    │       |-- ...
    |-- opt/
        |-- <plugin>/
            |-- ...
```

### The `<collection>` level

The first level is an arbitrary namespace; it groups packages but has no semantic meaning to Neovim
itself. Neovim just globs `pack/*/start/` and `pack/*/opt/` regardless of what `*` is. I might see
names like:

- `vendor/` — a catch-all for third-party plugins
- `nvim/` — Neovim's own bundled plugins
- `myconfig/` — a personal convention
- The plugin manager's name — e.g. `packer/`, `lazy/`

In a Nix derivation, the collection name is typically something like `nixvim` or the derivation
name,since the whole thing is generated. It doesn't matter what it's called.

### `start/` — auto-loaded plugins

Every directory directly under `start/` is added to `runtimepath` automatically at startup, BEFORE
my `init.lua`/`init.vim` runs. This means:

- its `plugin/*.vim` and `plugin/*.lua` files are sourced
- its `lua/` directory becomes available to `require()`
- its `ftplugin/`, `syntax/`, `queries/`, etc. become active

The plugin directory name (e.g. `start/nvim-treesitter/`) is conventional but also doesn't matter
to Neovim. It just needs to be a directory.

Startup order nuance: `start/` packages are added to `runtimepath` early, but their `plugin/` files
are sourced AFTER the local `init.lua` finishes. So I can `require()` a plugin's Lua modules from
`init.lua`, but the plugin's own `plugin/` bootstrapping hasn't fired yet — which is why most
plugins require an explicit `require('foo').setup({})` call.

### `opt/` — optional plugins

Directories under `opt/` are not added to `runtimepath` at startup.
They sit dormant until explicitly loaded with:

```vim
:packadd <plugin-name>
```

or in Lua:

```lua
vim.cmd('packadd <plugin-name>')
```

`:packadd` does three things:
1. Adds the plugin directory to `runtimepath`
2. Sources any `plugin/` files inside it
3. Sources any `after/plugin/` files inside it

Common uses for `opt/`:

- donditional loading — load a plugin only if some condition is met
  (binary exists, filetype detected, etc.)
- lazy loading — defer heavy plugins until they're needed
- debugging — keep a plugin installed but disabled until I explicitly want it

### Each plugin's internal structure

Once a plugin directory is on `runtimepath` (either via `start/` or `:packadd`), Neovim treats it
exactly like any other `runtimepath` entry. It can contain any of the subdirectories from above:
- `plugin/`
- `lua/`
- `ftplugin/`
- `syntax/`
- `queries/`
- `autoload/`
- etc.

There's nothing special about being inside `pack/`; the package system is purely a loading
mechanism that manages `runtimepath` entries.

### The `after/` variant

Each plugin can also have an `after/` subdirectory:

```
start/
|-- my-plugin/
    ├── plugin/
    │   |-- my-plugin.vim      ← sourced in normal pass
    |-- after/
        |-- plugin/
            |-- my-plugin.vim  ← sourced after all other plugin/ files
```

`after/` subdirectories are added to the end of `runtimepath`, so they fire after all non-`after`
runtime files. This lets a plugin (or my own config) override defaults set by other plugins or
by Neovim's built-in runtime.

### In a Nix derivation specifically

Nix typically builds a single merged derivation where all plugins are symlinked into one
`pack/<name>/start/` tree, rather than having separate per-plugin store paths on `runtimepath`.
This is because Neovim has a limit on `runtimepath` length in some contexts, and it simplifies
the store structure.

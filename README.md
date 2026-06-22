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

## Data Flow

`plugin-set.nix` gets plugins from `nixpkgs` and `self-packaged-plugins.nix`.

`plugins-derivation.nix` packages the plugins together in the standard directory structure.

`transpilation.nix` transforms the `.tl` code into Lua and writes it as a derivation.

`treesitter.nix` takes care of treesitter installation (parsers and queries).

`tools.nix` handles the external tools (not currently included).

`pde.nix` wires all of these parts together and exposes the executables.

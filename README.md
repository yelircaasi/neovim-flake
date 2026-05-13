# neovim-flake

## Roadmap

- [ ] fork dial, fix structure, write nix expression
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

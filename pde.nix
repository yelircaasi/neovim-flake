{
  pkgs,
  # neovim-nightly,
  nix-treesitter,
  ...
}: let
  custom = import ./self-packaged-plugins.nix {inherit pkgs;};
  treesitter = pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [nix-treesitter.tree-sitter-xit]);

  files = import ./lua-writer.nix {inherit pkgs custom configDir treesitter;};
  configDir = "config";
  argCatcher = ''"\$@"'';
in
  pkgs.stdenv.mkDerivation rec {
    name = "pde";
    src = ./.;

    # Use the neovim-nightly package and dependencies
    buildInputs = [
      # neovim-nightly
      pkgs.neovim
      pkgs.python3
      pkgs.nodejs
      pkgs.ruby
      # treesitter
    ];

    # Set up configuration during build
    buildPhase = ''
      mkdir -p $out/bin
      mkdir -p $out/config/
      mkdir -p $out/config/lua/
      export VIMINIT='let &swapfile = 0'
    '';

    # Add aliases and links for neovim
    installPhase = ''
      cp -L ${files.colors} $out/config/_colors.lua
      cp -L ${files.python} $out/config/python.lua
      cp -L ${files.init} $out/config/init.lua
      echo "#!${pkgs.runtimeShell}" > $out/bin/pde
      echo "LUA_PATH=\"\" ${pkgs.neovim}/bin/nvim -u $out/config/init.lua ${argCatcher}" >> $out/bin/pde
      cp -L $out/bin/pde $out/bin/nvim
      chmod +x $out/bin/pde $out/bin/nvim
    '';

    # Embed custom configuration and aliases
  }
# {
#   enable = true;
#   defaultEditor = true;
#   withPython3 = true;
#   withNodeJs = true;
#   withRuby = true;
#   package = neovim-nightly;
#   viAlias = false;
#   vimAlias = false;
#   vimdiffAlias = true;
#   inherit plugins;
#   configure = {
#     customRC = ''
#       set number
#       set cc=80
#       set list
#       set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»
#       if &diff
#         colorscheme blue
#       endif
#     '';
#   };
# }


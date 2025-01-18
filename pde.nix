{
  pkgs,
  neovim-nightly,
  nix-treesitter,
}: let
  custom = import ./self-packaged-plugins.nix {inherit pkgs;};
  treesitter = pkgs.vimPlugins.nvim-treesitter.withAllGrammars; #withPlugins (p: [nix-treesitter.tree-sitter-xit]);

  files = import ./lua-writer.nix {inherit pkgs custom configDir treesitter;};
  configDir = "config";
in
  pkgs.stdenv.mkDerivation rec {
    name = "pde";
    src = ./.;

    # Use the neovim-nightly package and dependencies
    buildInputs = [
      neovim-nightly
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

    '';

    # Add aliases and links for neovim
    installPhase = ''
      cp ${files.colors} $out/config/lua/colors.lua
      cp ${files.python} $out/config/lua/python.lua
      cp ${files.init} $out/config/init.lua
      echo ${pde} > $out/bin/pde
      chmod +x $out/bin/pde
    '';

    pde = ''
      #!${pkgs.runtimeShell}
      ${pkgs.neovim}/bin/nvim -u $out/config/init.lua "$@"
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


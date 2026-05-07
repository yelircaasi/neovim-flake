{
  pkgs,
  neovim-nightly,
  nix-treesitter,
  ...
}: let
  /*

  

  files = import ./lua-writer.nix {inherit pkgs custom configDir treesitter nix-treesitter;};
  */

  custom = import ./self-packaged-plugins.nix {inherit pkgs;};

  treesitter = pkgs.vimPlugins.nvim-treesitter.withPlugins (plugins:
    pkgs.vimPlugins.nvim-treesitter.allGrammars
    ++ [
      custom.tsgrammar-just
      custom.tsgrammar-xit
      nix-treesitter.tree-sitter-xit
    ]
    ++ plugins);

  configDir = "config";
  argCatcher = ''"\$@"'';

  transpiled = import ./transpilation.nix {inherit pkgs;};
in
  pkgs.stdenv.mkDerivation rec {
    name = "pde";
    src = ./.;

    propagatedBuildInputs = import ./tools.nix {inherit pkgs;};

    buildInputs =
      [
        neovim-nightly
        treesitter
        custom.xit-nvim
        pkgs.ruff

        pkgs.python3
        pkgs.nodejs
        pkgs.ruby
        pkgs.luajit
      ]
      ++ (
        with pkgs.vimPlugins;
          [
            lualine-nvim
            nvim-navic
            nvim-lspconfig
          ]
          ++ (with pkgs.python312Packages; [
            python-lsp-server # alt: node.pyright
            pylsp-mypy
            pyls-isort
            python-lsp-black
            pylsp-rope
            python-lsp-ruff
            pytest
            pylint
            pytest-cov
            coverage
            pynvim
          ])
      );

    buildPhase = ''
      mkdir -p $out
      mkdir -p $out/bin
      export VIMINIT='let &swapfile = 0'
    '';

    # Add aliases and links for neovim
    installPhase = ''

      cp -rL ${transpiled}/config/ $out/

      cp -L ${pkgs.python312Packages.python-lsp-server}/bin/pylsp $out/bin/pylsp
      cp -L ${pkgs.ruff}/bin/ruff $out/bin/ruff

      echo "#!${pkgs.runtimeShell}" > $out/bin/pde
      echo "LUA_PATH=\"\" ${neovim-nightly}/bin/nvim -u $out/config/init.lua ${argCatcher}" >> $out/bin/pde
      echo "#!${pkgs.runtimeShell}" > $out/bin/nvim
      echo "LUA_PATH=\"\" ${neovim-nightly}/bin/nvim -u \$HOME/.config/nvim/init.lua ${argCatcher}" >> $out/bin/nvim
      chmod +x $out/bin/pde $out/bin/nvim

      # cp -L ${pkgs.python3}/bin/python $out/bin/python
      # cp -L ${pkgs.python3}/bin/python3 $out/bin/python3
      # cp -L ${pkgs.luajit}/bin/lua $out/bin/lua
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


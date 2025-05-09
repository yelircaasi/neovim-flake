{
  pkgs,
  # neovim-nightly,
  nix-treesitter,
  ...
}: let
  custom = import ./self-packaged-plugins.nix {inherit pkgs;};

  treesitter = pkgs.vimPlugins.nvim-treesitter.withPlugins (plugins:
    pkgs.vimPlugins.nvim-treesitter.allGrammars
    ++ [
      custom.tsgrammar-just
      custom.tsgrammar-xit
      nix-treesitter.tree-sitter-xit
    ]
    ++ plugins);

  files = import ./lua-writer.nix {inherit pkgs custom configDir treesitter nix-treesitter;};
  configDir = "config";
  argCatcher = ''"\$@"'';
in
  pkgs.stdenv.mkDerivation rec {
    name = "pde";
    src = ./.;

    # Use the neovim-nightly package and dependencies
    buildInputs =
      [
        pkgs.neovim
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

    # Set up configuration during build
    buildPhase = ''
      mkdir -p $out/bin
      mkdir -p $out/config/
      mkdir -p $out/config/lua/
      mkdir -p $out/config/languages/
      mkdir -p $out/config/features/
      export VIMINIT='let &swapfile = 0'
    '';

    # Add aliases and links for neovim
    installPhase = ''


      cp -L ${files.init} $out/config/init.lua
      cp -L ${files.colors} $out/config/_colors.lua
      cp -L ${files.options} $out/config/options.lua
      cp -L ${files.mappings} $out/config/mappings.lua
      cp -L ${files.commands} $out/config/commands.lua

      cp -L ${files.python} $out/config/languages/python.lua
      cp -L ${files.xit} $out/config/languages/xit.lua

      cp -L ${files.statusLine} $out/config/features/status_line.lua
      cp -L ${files.fileBrowserTree} $out/config/features/file_browser_tree.lua

      cp -L ${pkgs.python312Packages.python-lsp-server}/bin/pylsp $out/bin/pylsp
      cp -L ${pkgs.ruff}/bin/ruff $out/bin/ruff

      echo "#!${pkgs.runtimeShell}" > $out/bin/pde
      echo "LUA_PATH=\"\" ${pkgs.neovim}/bin/nvim -u $out/config/init.lua ${argCatcher}" >> $out/bin/pde
      cp -L $out/bin/pde $out/bin/nvim
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


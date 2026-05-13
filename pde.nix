{
  pkgs,
  neovim-nightly,
  nix-treesitter,
  ...
}: let
  custom = import ./self-packaged-plugins.nix {inherit pkgs;};
  pluginDerivation = (import ./plugins-derivation.nix {inherit pkgs;}).nvimPlugins;

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

  derefCopy = "cp -L";
  derefCopyDir = "cp -rL";
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

    installPhase = ''
      ${derefCopyDir} ${transpiled}/config/ $out/
      ${derefCopyDir} ${pluginDerivation}/meta/ $out/

      # Copy the entire pack tree — one directory, native pack layout
      mkdir -p $out/pack
      cp -rL ${pluginDerivation}/pack/. $out/pack

      ${derefCopy} ${pkgs.python312Packages.python-lsp-server}/bin/pylsp $out/bin/pylsp
      ${derefCopy} ${pkgs.ruff}/bin/ruff $out/bin/ruff

      chmod -R u+w $out/config
      cat > $out/config/prepend.lua << EOF
      vim.opt.runtimepath:prepend("${pluginDerivation}/pack/bundle/opt")
      vim.opt.packpath:prepend("${pluginDerivation}")
      EOF

      echo "#!${pkgs.runtimeShell}" > $out/bin/pde
      echo "LUA_PATH=\"\" ${neovim-nightly}/bin/nvim \
        --cmd 'set packpath^=$out' \
        -u $out/config/init.lua ${argCatcher}" >> $out/bin/pde

      echo "#!${pkgs.runtimeShell}" > $out/bin/nvim
      echo "LUA_PATH=\"\" ${neovim-nightly}/bin/nvim \
        --cmd 'set packpath^=$out' \
        -u \$HOME/.config/nvim/init.lua ${argCatcher}" >> $out/bin/nvim

      chmod +x $out/bin/pde $out/bin/nvim
    '';

    OLD_installPhase = ''
      ${derefCopyDir} ${transpiled}/config/ $out/
      ${derefCopyDir} ${pluginDerivation}/plugins/ $out/
      ${derefCopyDir} ${pluginDerivation}/meta/ $out/

      ${derefCopy} ${pkgs.python312Packages.python-lsp-server}/bin/pylsp $out/bin/pylsp
      ${derefCopy} ${pkgs.ruff}/bin/ruff $out/bin/ruff

      echo "#!${pkgs.runtimeShell}" > $out/bin/pde
      echo "LUA_PATH=\"\" ${neovim-nightly}/bin/nvim -u $out/config/init.lua ${argCatcher}" >> $out/bin/pde
      echo "#!${pkgs.runtimeShell}" > $out/bin/nvim
      echo "LUA_PATH=\"\" ${neovim-nightly}/bin/nvim -u \$HOME/.config/nvim/init.lua ${argCatcher}" >> $out/bin/nvim
      chmod +x $out/bin/pde $out/bin/nvim

      # ${derefCopy} ${pkgs.python3}/bin/python $out/bin/python
      # ${derefCopy} ${pkgs.python3}/bin/python3 $out/bin/python3
      # ${derefCopy} ${pkgs.luajit}/bin/lua $out/bin/lua
    '';
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


{
  pkgs,
  neovim-nightly,
  nix-treesitter,
  ...
}: let
  custom = import ./self-packaged-plugins.nix {inherit pkgs;};
  pluginDerivation = (import ./plugins-derivation.nix {inherit pkgs;}).nvimPlugins;

  treesitterDerivations = (import ./treesitter.nix {inherit pkgs;});

  configDir = "config";
  argCatcher = ''"\$@"'';

  transpiled = import ./transpilation.nix {inherit pkgs;};

  derefCopy = "cp -L";
  derefCopyDir = "cp -rL";

  pythonEnv = pkgs.python3.withPackages (ps:
    with ps; [
      pynvim
    ]);

  pyEnvSnippet = ''--cmd 'let g:python3_host_prog=\"${pythonEnv}/bin/python3\"' '';

  nodeEnvSnippet = ''--cmd 'let g:node_host_prog=\"${pkgs.neovim-node-client}/bin/neovim-node-host\"' '';
in
  pkgs.stdenv.mkDerivation rec {
    name = "pde";
    src = ./.;

    propagatedBuildInputs = import ./tools.nix {inherit pkgs;};

    buildInputs =
      [
        neovim-nightly
        pkgs.ruff

        pkgs.python3
        pkgs.nodejs
        pkgs.ruby
        pkgs.luajit
      ];
      # ++ (
      #   with pkgs.vimPlugins;
      #     [
      #       lualine-nvim
      #       nvim-navic
      #       nvim-lspconfig
      #     ]
      #     ++ (with pkgs.python312Packages; [
      #       python-lsp-server # alt: node.pyright
      #       pylsp-mypy
      #       pyls-isort
      #       python-lsp-black
      #       pylsp-rope
      #       python-lsp-ruff
      #       pytest
      #       pylint
      #       pytest-cov
      #       coverage
      #       pynvim
      #     ])
      # );

    buildPhase = ''
      mkdir -p $out
      mkdir -p $out/bin
      export VIMINIT='let &swapfile = 0'
    '';

    installPhase = ''
      ${derefCopyDir} ${transpiled}/config/ $out/
      ${derefCopyDir} ${pluginDerivation}/meta/ $out/
      ${derefCopyDir} ${treesitterDerivations.allParsers}/parser/ $out/
      ${derefCopyDir} ${treesitterDerivations.queries}/queries $out/queries

      mkdir -p $out/pack
      ${derefCopyDir} ${pluginDerivation}/pack/. $out/pack

      ln -s ${pkgs.nodejs}/bin/node $out/bin/node

      chmod -R u+w $out/config
      echo "#!${pkgs.runtimeShell}" > $out/bin/pde
      echo "PATH=\$PATH:$out/bin ${neovim-nightly}/bin/nvim \
        ${pyEnvSnippet} \
        ${nodeEnvSnippet} \
        -u $out/config/init.lua ${argCatcher}" >> $out/bin/pde

      echo "#!${pkgs.runtimeShell}" > $out/bin/nvim
      echo "PATH=\$PATH:$out/bin ${neovim-nightly}/bin/nvim \
        ${pyEnvSnippet} \
        ${nodeEnvSnippet} \
        -u \$HOME/.config/nvim/init.lua ${argCatcher}" >> $out/bin/nvim

      chmod +x $out/bin/pde $out/bin/nvim
    '';
  }

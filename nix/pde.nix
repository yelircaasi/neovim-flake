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
  argCatcher = ''\$@'';

  transpiled = import ./transpilation.nix {inherit pkgs;};

  derefCopy = "cp -L";
  derefCopyDir = "cp -rL";

  pythonEnv = pkgs.python3.withPackages (ps:
    with ps; [
      pynvim
    ]);

  pyEnvSnippet = ''--cmd 'let g:python3_host_prog="${pythonEnv}/bin/python3"' '';

  nodeEnvSnippet = ''--cmd 'let g:node_host_prog="${pkgs.neovim-node-client}/bin/neovim-node-host"' '';

  jsregexp = pkgs.luajitPackages.jsregexp;
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
        pkgs.luajit  # .withPackages (ps: [ ps.jsregexp ])
        jsregexp
      ];

    buildPhase = ''
      mkdir -p $out
      mkdir -p $out/bin
      mkdir -p $out/share/lua/5.1
      mkdir -p $out/lib/lua/5.1
      export VIMINIT='let &swapfile = 0'
    '';

    installPhase = ''
      ${derefCopyDir} ${transpiled}/config/ $out/
      ${derefCopyDir} ${pluginDerivation}/meta/ $out/
      ${derefCopyDir} ${treesitterDerivations.allParsers}/parser/ $out/
      ${derefCopyDir} ${treesitterDerivations.queries}/queries $out/queries

      # jsregexp (LuaSnip dependency)

      ${derefCopyDir} ${jsregexp}/share/lua/5.1/* $out/share/lua/5.1/
      ${derefCopyDir} ${jsregexp}/lib/lua/5.1/* $out/lib/lua/5.1/

      mkdir -p $out/pack
      ${derefCopyDir} ${pluginDerivation}/pack/. $out/pack

      ln -s ${pkgs.nodejs}/bin/node $out/bin/node

      chmod -R u+w $out/config

      cat > $out/bin/pde << EOF
      #!${pkgs.runtimeShell}
      PATH=\$PATH:$out/bin ${neovim-nightly}/bin/nvim \\
        ${pyEnvSnippet} \\
        ${nodeEnvSnippet} \\
        --cmd 'set rtp+=$out' \\
        -u $out/config/init.lua "\$@"
      EOF

      cat > $out/bin/nvim << EOF
      #!${pkgs.runtimeShell}
      PATH=\$PATH:$out/bin ${neovim-nightly}/bin/nvim \
        ${pyEnvSnippet} \\
        ${nodeEnvSnippet} \\
        --cmd 'set rtp+=$out' \\
        -u \$HOME/.config/nvim/init.lua "\$@"
      EOF

      chmod +x $out/bin/pde $out/bin/nvim
    '';
  }

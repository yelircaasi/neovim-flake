{pkgs}: ''
#!${pkgs.runtimeShell}

${pkgs.neovim}/bin/nvim -u $out/share/nvim/runtime/init.vim "$@"
''
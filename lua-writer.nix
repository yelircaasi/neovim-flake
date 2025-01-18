{
  pkgs,
  custom,
  configDir,
  treesitter,
}: rec {
  init = pkgs.writeTextFile {
    name = "init.lua";
    text = builtins.replaceStrings [''TREESITTER''] ["${treesitter}"] (builtins.readFile ./config/init.lua);
  };
  colors = pkgs.writeTextFile {
    name = "colors.lua";
    text = builtins.readFile ./config/lua/colors.lua;
  };
  xit = pkgs.writeTextFile {
    name = "xit";
    text = ''
      #!${pkgs.runtimeShell}
      echo ${treesitter}
      echo ${custom.xit-nvim}
    '';
  };
  python = pkgs.writeTextFile {
    name = "python.lua";
    text = builtins.replaceStrings [''TREESITTER''] ["${treesitter}"] (builtins.readFile ./config/lua/languages/python.lua);
  };
}

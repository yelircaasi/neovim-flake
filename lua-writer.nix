{
  pkgs,
  custom,
  configDir,
  treesitter,
  nix-treesitter,
  ...
}: rec {
  init = pkgs.writeTextFile {
    name = "init.lua";
    text = builtins.replaceStrings [''$TREESITTER''] ["${treesitter}"] (builtins.readFile ./config/init.lua);
  };
  mappings = pkgs.writeTextFile {
    name = "init.lua";
    text = builtins.readFile ./config/lua/mappings.lua;
  };
  options = pkgs.writeTextFile {
    name = "init.lua";
    text = builtins.readFile ./config/lua/options.lua;
  };
  colors = pkgs.writeTextFile {
    name = "colors.lua";
    text = builtins.readFile ./config/lua/colors.lua;
  };
  xit = pkgs.writeTextFile {
    name = "xit.lua";
    text = builtins.replaceStrings [''$TREESITTER'' ''$XIT'' ''$TSXIT''] ["${treesitter}" "${custom.xit-nvim}" "${custom.tsgrammar-xit}"] (builtins.readFile ./config/lua/languages/xit.lua);
  };
  python = pkgs.writeTextFile {
    name = "python.lua";
    text = builtins.replaceStrings [''$LSPCONFIG''] ["${pkgs.vimPlugins.nvim-lspconfig}"] (builtins.readFile ./config/lua/languages/python.lua);
  };
  commands = pkgs.writeTextFile {
    name = "commands.lua";
    text = builtins.readFile ./config/lua/commands.lua;
  };
  statusLine = pkgs.writeTextFile {
    name = "status_line.lua";
    text = builtins.replaceStrings [''$LUALINE'' ''$NAVIC''] (with pkgs.vimPlugins; ["${lualine-nvim}" "${nvim-navic}"]) (builtins.readFile ./config/lua/features/status_line.lua);
  };
  fileBrowserTree = pkgs.writeTextFile {
    name = "file_browser_tree.lua";
    text =
      builtins.replaceStrings
      [''$NVIMTREE'']
      (with pkgs.vimPlugins; ["${nvim-tree-lua}"])
      (builtins.readFile ./config/lua/features/file_browser_tree.lua);
  };
  # fileBrowserTree = pkgs.writeTextFile {
  #   name = "file_browser_tree.lua";
  #   text = builtins.replaceStrings
  #     [''$NEOTREE'' ''$WEBDEVICONS'' ''$PLENARY'' ''$NUI'']
  #     (with pkgs.vimPlugins; ["${neo-tree-nvim}" "${nvim-web-devicons}" "${plenary-nvim}" "${nui-nvim}"])
  #     (builtins.readFile ./config/lua/features/file_browser_tree.lua);
  # };
}

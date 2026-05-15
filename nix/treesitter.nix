{pkgs}: let
  # grammarList = pkgs.vimPlugins.nvim-treesitter.allGrammars;
  grammarList = [
    "haskell"
    "javascript"
    "json"
    "lua"
    "markdown"
    "nix"
    "python"
    "rust"
    "toml"
    "typescript"
    "yaml"
    "zig"
    "go"
    "xit"
    "just"
  ];

  tsGrammars =
    pkgs.vimPlugins.nvim-treesitter.withPlugins (p:
      with p; grammarList);

  customGrammars = {
    just = pkgs.neovimUtils.grammarToPlugin (pkgs.tree-sitter.buildGrammar {
      language = "just";
      version = "8af0aab";
      src = pkgs.fetchFromGitHub {
        owner = "IndianBoy42";
        repo = "tree-sitter-just";
        rev = "8af0aab79854aaf25b620a52c39485849922f766";
        sha256 = "sha256-hYKFidN3LHJg2NLM1EiJFki+0nqi1URnoLLPknUbFJY=";
      };
    });
    xit = pkgs.neovimUtils.grammarToPlugin (pkgs.tree-sitter.buildGrammar {
      language = "xit";
      version = "0.2";
      src = pkgs.fetchFromGitHub {
        owner = "synaptiko";
        repo = "tree-sitter-xit";
        rev = "a4fad351bfa5efdcb379b40c36671413fbe9caac";
        sha256 = "sha256-wTr7YyGnz/dWfA5oecRqxeR8Unoob6isGnQg4/iu+MI=";
      };
    });
  };

  grammars = pkgs.vimPlugins.nvim-treesitter.grammarPlugins // customGrammars;
in {
  allParsers = pkgs.runCommand "nvim-ts-parsers" {} ''
    mkdir -p $out/parser
    ${pkgs.lib.concatMapStrings (name: ''
        ln -s ${grammars.${name}}/parser/${name}.so $out/parser/
      '')
      grammarList}
  '';
}

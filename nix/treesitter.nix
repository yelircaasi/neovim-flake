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

  # tsGrammars =
  #   pkgs.vimPlugins.nvim-treesitter.withPlugins (p:
  #     with p; grammarList);

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
    org = pkgs.neovimUtils.grammarToPlugin (pkgs.tree-sitter.buildGrammar {
      language = "org";
      version = "2.0.4";
      src = pkgs.fetchFromGitHub {
        owner = "nvim-orgmode";
        repo = "tree-sitter-org";
        rev = "219c0b27fdb2c0aeb43841f23f03d6f54657f288";
        sha256 = pkgs.lib.fakeHash; # replace with actual hash after first build
      };
      meta = {
        homepage = "https://github.com/nvim-orgmode/tree-sitter-org";
        license = pkgs.lib.licenses.mit;
      };
    });
  };

  # grammars = pkgs.vimPlugins.nvim-treesitter.grammarPlugins // customGrammars;
  grammars = pkgs.vimPlugins.nvim-treesitter-parsers // customGrammars;
in {
  allParsers = pkgs.runCommand "nvim-ts-parsers" {} ''
    mkdir -p $out/parser
    ${pkgs.lib.concatMapStrings (name: ''
        ln -s ${grammars.${name}}/parser/${name}.so $out/parser/
      '')
      grammarList}
  '';
  queries = pkgs.fetchFromGitHub {
    owner = "yelircaasi";
    repo = "treesitter-queries";
    rev = "cc2d454397e7f7e05007739ea8d1438cc0dc7dc6";
    hash = "sha256-v1zWxFX2I/ze0IKDuBNcZdt03a0KbdCmsPSZdteCD5I=";
  };
}

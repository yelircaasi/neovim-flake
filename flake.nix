{
  description = "Nix flake offering a custom Neovim PDE";

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    neovim-nightly-overlay,
    nix-treesitter,
    ...
  } @ inputs:
    flake-utils.lib.eachDefaultSystem (
      system: let
        neovim-nightly = inputs.neovim-nightly-overlay.packages.${system}.neovim;
        nix-treesitter = inputs.nix-treesitter.packages.${system};
        pkgs = import inputs.nixpkgs {
          inherit system;
          # overlays = [neovim-nightly nix-treesitter];
        };
        pde = import ./pde.nix {inherit pkgs neovim-nightly nix-treesitter;};
      in rec {
        apps = {
          default = {
            type = "app";
            program = "${packages.default}/bin/pde";
          };
        };
        packages = {
          default = pde;
        };
      }
    );

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/f7542cb59c3215123304811023035d4470751b2f";
    };

    flake-utils = {
      url = "github:numtide/flake-utils/11707dc2f618dd54ca8739b309ec4fc024de578b";
    };

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay/31c50a1318f9ba2e7236e150dce28189c5d8fc31";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-treesitter = {
      url = "github:ratson/nix-treesitter/b6311f2c4567c7f59e879ee12dabef72df8c3bb6";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}

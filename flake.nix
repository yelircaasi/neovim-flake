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
      url = "github:nixos/nixpkgs/98d4992121235f3642ffc3ab29bd6777a6447bcd";
    };

    flake-utils = {
      url = "github:numtide/flake-utils/11707dc2f618dd54ca8739b309ec4fc024de578b";
    };

    neovim-nightly-overlay = {
      # NEWER: url = "github:nix-community/neovim-nightly-overlay/3fe45a5c38a9dfe182f20079ebdab9b20670197e";
      url = "github:nix-community/neovim-nightly-overlay/31c50a1318f9ba2e7236e150dce28189c5d8fc31";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-treesitter = {
      url = "github:ratson/nix-treesitter/d9d35e37a5b2aee2f3f4d14c66e2bf0604dae4ce";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}

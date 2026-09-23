{
  description = "Nix flake offering a custom Neovim PDE";

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    neovim-nightly-overlay,
    ...
  } @ inputs:
    flake-utils.lib.eachDefaultSystem (
      system: let
        blink-lib = inputs.blink-lib.packages.${system}.default;
        neovim-nightly = inputs.neovim-nightly-overlay.packages.${system}.default;
        pkgs = import inputs.nixpkgs {
          inherit system;
          # overlays = [neovim-nightly];
          config.allowUnfree = true;
        };
        pdeDerivation = import ./nix/pde.nix {inherit pkgs neovim-nightly blink-lib;}; # neovim-nightly ;};
      in {
        apps = rec {
          default = pde;
          pde = {
            type = "app";
            program = "${pdeDerivation}/bin/pde";
          };
        };
        packages = rec {
          default = pde;
          pde = pdeDerivation;
        };
        devShells = rec {
          default = pde;
          pde = pkgs.mkShell {
            name = "pde-dev-shell";
            buildInputs = [
              pdeDerivation
              pkgs.python3
              pkgs.luajit
            ];
          };
        };
      }
    );

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/5bacb6c43c4f82f7265acab8e1437660cc752a97"; # updated 09-2026
    };

    flake-utils = {
      url = "github:numtide/flake-utils/11707dc2f618dd54ca8739b309ec4fc024de578b";
    };

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay/47394c8e8ad56c63181864924d781045f602e472";  # updated 09-2026
      inputs.nixpkgs.follows = "nixpkgs";
    };

    blink-lib = {
      url = "github:saghen/blink.lib/fd9a48ebbe6ec30d5dfcc5b42c243941ccdca1aa"; # updated 09-2026
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}

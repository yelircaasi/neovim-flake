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
        neovim-nightly = inputs.neovim-nightly-overlay.packages.${system}.default;
        nix-treesitter = inputs.nix-treesitter.packages.${system}.default;
        pkgs = import inputs.nixpkgs {
          inherit system;
          # overlays = [neovim-nightly];
        };
        pdeDerivation = import ./nix/pde.nix {inherit pkgs nix-treesitter neovim-nightly;}; # neovim-nightly ;};
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
      url = "github:nixos/nixpkgs/91849ded6ed12d309e6697bea17e0bda5fdc7ad3";
    };

    flake-utils = {
      url = "github:numtide/flake-utils/11707dc2f618dd54ca8739b309ec4fc024de578b";
    };

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay/80b1f16dba171a70c44c2ee6ec9529876152a7f5";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-treesitter = {
      # TODO: use or delete
      url = "github:ratson/nix-treesitter/d9d35e37a5b2aee2f3f4d14c66e2bf0604dae4ce";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}

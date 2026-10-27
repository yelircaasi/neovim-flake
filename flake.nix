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
      url = "github:nixos/nixpkgs/c57a028c30068aa2a7e00fa87300804dab748ff5";  # updated 2026-10-27
    };

    flake-utils = {
      url = "github:numtide/flake-utils/b7a79d3fea1e214f6d668d521cecec0c01e26544";  # updated 2026-10-27
    };

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay/ca14eed2583453aab3c37e5ba711ccea22f5299b";  # updated 2026-10-27
      inputs.nixpkgs.follows = "nixpkgs";
    };

    blink-lib = {
      url = "github:saghen/blink.lib/fd9a48ebbe6ec30d5dfcc5b42c243941ccdca1aa";  # updated 2026-10-27
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}

{
  description = "Neovim with 2 plugins - packages, devShells, and home-manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    home-manager,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
        neovimWithPlugins = pkgs.neovim.override {
          configure = {
            customRC = ''
              set number
              set expandtab
              set tabstop=2
              set shiftwidth=2
            '';
            packages.myPlugins = with pkgs.vimPlugins; {
              start = [
                plenary-nvim
                telescope-nvim
              ];
            };
          };
        };
      in {
        # Packages output - buildable with `nix build .#default`
        packages = {
          default = neovimWithPlugins;
          neovim = neovimWithPlugins;
        };

        # Dev shell - enterable with `nix flake enter`
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            neovim
            lua
            stylua
          ];
          shellHook = ''
            echo "Neovim dev environment loaded"
          '';
        };
      }
    )
    // {
      # Home-manager module - imported in your home-manager config
      # Not system-dependent, so it's at top level
      homeManagerModules = {
        default = self.homeManagerModules.neovim;

        neovim = {
          config,
          lib,
          pkgs,
          ...
        }:
          with lib; {
            options.programs.neovimCustom = {
              enable = mkEnableOption "Neovim with custom plugins";

              package = mkOption {
                type = types.package;
                default = pkgs.neovim;
                description = "The Neovim package to use";
              };

              plugins = mkOption {
                type = types.listOf types.package;
                default = with pkgs.vimPlugins; [
                  plenary-nvim
                  telescope-nvim
                ];
                description = "Vim plugins to install";
              };

              extraConfig = mkOption {
                type = types.str;
                default = ''
                  set number
                  set expandtab
                  set tabstop=2
                  set shiftwidth=2
                '';
                description = "Extra Neovim configuration";
              };
            };

            config = mkIf config.programs.neovimCustom.enable {
              programs.neovim = {
                enable = true;
                inherit (config.programs.neovimCustom) package plugins;
                defaultEditor = true;
                extraConfig = config.programs.neovimCustom.extraConfig;
              };
            };
          };
      };
    };
}

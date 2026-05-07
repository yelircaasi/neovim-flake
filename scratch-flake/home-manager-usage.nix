# Example: How to use the homeManagerModules output in your home-manager config
# This goes in your home.nix or flake.nix's homeConfiguration
# Option 1: Using the module directly in a flake
# flake.nix:
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    nvim-flake.url = "path:./nvim-flake"; # your neovim flake
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nvim-flake,
  }: {
    homeConfigurations.your-user = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      modules = [
        # Import the module from the flake
        nvim-flake.homeManagerModules.default

        # Your home-manager configuration
        {
          home.username = "isaac";
          home.homeDirectory = "/home/isaac";
          home.stateVersion = "24.11";

          # Enable and configure Neovim using the module
          programs.neovimCustom = {
            enable = true;

            # Override defaults if desired
            extraConfig = ''
              set number
              set relativenumber
              set expandtab
              set tabstop=2
              set shiftwidth=2
              let mapleader = " "
            '';

            # plugins already defaults to plenary + telescope
            # but you can override:
            # plugins = with pkgs.vimPlugins; [
            #   plenary-nvim
            #   telescope-nvim
            #   nvim-lspconfig
            # ];
          };

          # Standard home-manager stuff
          programs.git.enable = true;
        }
      ];
    };
  };
}
# ---
# Option 2: If you prefer using the standard home-manager programs.neovim
# (simpler, no custom module needed):
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      plenary-nvim
      telescope-nvim
    ];
    extraConfig = ''
      set number
      set expandtab
    '';
  };
}

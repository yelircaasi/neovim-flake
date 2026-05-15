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

    nix-treesitter = {  # TODO: use or delete
      url = "github:ratson/nix-treesitter/d9d35e37a5b2aee2f3f4d14c66e2bf0604dae4ce";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}

/*


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

*/


/* HM USAGE

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

*/


# HM options (?)
#   enable = true;
#   defaultEditor = true;
#   withPython3 = true;
#   withNodeJs = true;
#   withRuby = true;
#   package = neovim-nightly;
#   viAlias = false;
#   vimAlias = false;
#   vimdiffAlias = true;
#   inherit plugins;



/* NOTES
### **nvim-flake.nix** — The complete flake
- **`packages`**: Buildable Neovim with plenary-nvim + telescope-nvim
- **`devShells`**: Dev environment with neovim, lua, and stylua
- **`homeManagerModules`**: The key part you were unsure about

### **homeManagerModules Breakdown**

The crucial difference: `homeManagerModules` is **not** wrapped in `eachDefaultSystem`. It lives at the top level because:

1. It's **not a build artifact** — it's a declaration of how to configure your home
2. The system is determined **by where it's imported**, not by the flake itself
3. It returns a module with `options` (what users can configure) and `config` (what gets applied)

### **home-manager-usage.nix** — Two ways to use it

**Option 1** (Complex, for custom behavior):
```nix
modules = [ nvim-flake.homeManagerModules.default ];
programs.neovimCustom.enable = true;
```

**Option 2** (Simple, uses home-manager's built-in):
```nix
programs.neovim = {
  enable = true;
  plugins = with pkgs.vimPlugins; [ plenary-nvim telescope-nvim ];
};
```

The explanation doc covers why these differ and when to use each output type.




# Understanding homeManagerModules in Nix Flakes

## Three Output Types Explained

### 1. `packages` (system-dependent)
```nix
packages.default = pkgs.neovim.override { ... };
```
- Built with `nix build` 
- Varies per system (x86_64-linux, aarch64-darwin, etc.)
- Wrapped in `eachDefaultSystem` because it needs `pkgs` which is system-specific

### 2. `devShells` (system-dependent)
```nix
devShells.default = pkgs.mkShell { ... };
```
- Entered with `nix flake enter` or `nix develop`
- Also wrapped in `eachDefaultSystem`
- Provides build tools, dependencies, etc. for the flake itself

### 3. `homeManagerModules` (system-agnostic)
```nix
homeManagerModules.default = { config, lib, pkgs, ... }: { 
  options = { ... };
  config = mkIf condition { ... };
};
```
- **NOT** wrapped in `eachDefaultSystem` - lives at top level
- System is determined by the home-manager host using the module
- Returns a NixOS/home-manager module with standard structure

## Why homeManagerModules is Different

A home-manager module is:
1. **A function** that takes `{ config, lib, pkgs, ... }`
2. **Returns an attribute set** with `options` and `config` keys
3. **Declarative** - describes what *should* be configured, not what to build
4. **Reusable** - can be imported by any home-manager configuration on any system

Example flow:
```
Your flake's homeManagerModules
        ↓
Imported into your home.nix
        ↓
home-manager evaluates it on your specific system
        ↓
Creates symlinks, config files, environment
```

## Minimal vs Full Examples

### Minimal (without custom module)
```nix
{
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [ plenary-nvim telescope-nvim ];
    extraConfig = "set number";
  };
}
```
Just use home-manager's built-in `programs.neovim` directly.

### Full (with custom module)
Define your own module for:
- Custom options (e.g., `programs.neovimCustom.enable`)
- Conditional logic
- Composition of other modules
- Reusability across configurations

## Using the Module in Your home.nix

If your neovim flake is at `path:./nvim-flake`:

```nix
homeConfigurations.you = home-manager.lib.homeManagerConfiguration {
  pkgs = nixpkgs.legacyPackages.x86_64-linux;
  modules = [
    nvim-flake.homeManagerModules.default  # ← Import here
    {
      home.username = "isaac";
      programs.neovimCustom.enable = true;
    }
  ];
};
```

## Key Insight: When to Use Each

- **packages** → "What can I build and run?"
- **devShells** → "What environment do I need for development?"
- **homeManagerModules** → "How do I declaratively configure my home?"

For neovim in home-manager, you're saying:
"Here's a module that, when enabled, configures neovim with these plugins and settings"
rather than
"Here's the built neovim binary"



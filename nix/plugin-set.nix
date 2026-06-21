{
  pkgs,
  blink-lib,
}: let
  nvim_winpick_src = pkgs.fetchFromGitHub {
    owner = "MarcusGrass";
    repo = "nvim_winpick";
    rev = "18037e9f5ce417bd75d16ebbf70787bcc478c249";
    hash = "sha256-YXwM0hzqyIob6wMumkqqsPp2nRMuPxYnrHW4ihU6htw=";
  };

  nvim_winpick_native = pkgs.rustPlatform.buildRustPackage {
    pname = "nvim_winpick-native";
    version = "2025-06-30"; # updated 2026-06

    src = nvim_winpick_src;

    cargoHash = "sha256-qwOvEcwpw8PkzZOyUaJGFIR5z1RlC9tLCsoo4E2eNgs=";

    # buildAndTestSubdir = "integration-tests";

    doCheck = false;

    installPhase = ''
      mkdir -p $out/lua

      ext="${pkgs.stdenv.hostPlatform.extensions.sharedLibrary}"
      
      lib=$(find target -type f -name "libnvim_winpick$ext" | head -n 1)

      echo "Found: $lib"

      # rename to .so (Neovim requires .so for Lua modules on all platforms)
      cp "$lib" $out/lua/nvim_winpick.so
    '';
  };
in rec {
  oldCustom = {
    # jvim = pkgs.vimUtils.buildVimPlugin {  # vendor
    #   pname = "jvim";
    #   version = "2022-02-19";
    #   src = pkgs.fetchFromGitHub {
    #     owner = "ThePrimeagen";
    #     repo = "jvim.nvim";
    #     rev = "9fb5c4bea3c765ec4321f8ab837d55e126a2efac";
    #     hash = "sha256-nk3fxGij+mlR0x8dDnG6lmlLSOj2kJnDAByQMfVi6X8=";
    #   };
    #   doCheck = false;
    #   meta = {
    #     homepage = "https://github.com/ThePrimeagen/jvim.nvim";
    #     description = "";
    #   };
    # };
    # none-ls = pkgs.vimUtils.buildVimPlugin {
    #   pname = "none-ls.nvim";
    #   version = "2024-01-19";
    #   src = pkgs.fetchFromGitHub {
    #     owner = "nvimtools";
    #     repo = "none-ls.nvim";
    #     rev = "e64f03f3f77bd6854c3b3c5cfffcc806a0c0f66a";
    #     sha256 = "sha256-0aFJDvmGf9lJNNmSP/w/0tnq8ZANvAZhpYFgczswJho=";
    #   };
    #   meta.homepage = "https://github.com/nvimtools/none-ls.nvim/";
    # };
    # neotest = pkgs.vimUtils.buildVimPlugin {
    #   pname = "neotest";
    #   version = "2024-01-15";
    #   src = pkgs.fetchFromGitHub {
    #     owner = "nvim-neotest";
    #     repo = "neotest";
    #     rev = "dcdb40ea48f9c7b67a5576f6bb2e5f63ec15f2c0";
    #     sha256 = "sha256-bHM+5NP4O1O6sbNdtYVB1ymfF1YZmL+OYNzxwPKoiVo=";
    #   };
    #   meta.homepage = "ihttps://github.com/nvim-neotest/neotest";
    # };
    # yanky-nvim = pkgs.vimUtils.buildVimPlugin {
    #   # last updated: _
    #   pname = "yanky.nvim";
    #   version = "2023-11-27";
    #   src = pkgs.fetchFromGitHub {
    #     owner = "gbprod";
    #     repo = "yanky.nvim";
    #     rev = "6bb9ffd3cad4c9876bda54e19d0659de28a4f84f";
    #     sha256 = "sha256-/Ecclr/5zQH2NlNhrXdPlKgcjAUPoKmJ6gnyxF9P7QY=";
    #   };
    #   meta.homepage = "https://github.com/gbprod/yanky.nvim";
    # };
    # taskwarrior-nvim = pkgs.vimUtils.buildVimPlugin {
    #   pname = "taskwarrior.nvim";
    #   version = "2023-12-14";
    #   src = pkgs.fetchFromGitHub {
    #     owner = "ribelo";
    #     repo = "taskwarrior.nvim";
    #     rev = "d0a61b6d07fec0e187a4a788b85493af1cd7c455";
    #     sha256 = "sha256-znxx39dsHS4KPqNypnbefNDidpM5CSJE/HUYxLJth8w=";
    #   };
    #   meta.homepage = "https://github.com/ribelo/taskwarrior.nvim";
    # };
    # projectmgr-nvim = pkgs.vimUtils.buildVimPlugin {
    #   pname = "projectmgr.nvim";
    #   version = "2023-08-26";
    #   src = pkgs.fetchFromGitHub {
    #     owner = "charludo";
    #     repo = "projectmgr.nvim";
    #     rev = "2d29b21b5afefa7a1690854c56db9b43195d9a10";
    #     sha256 = "sha256-/H3rX8EjwCEM4/mtvzLqa0+LzMYTnE+il7R639/BJx4=";
    #   };
    #   meta.homepage = "https://github.com/charludo/projectmgr.nvim";
    # };
    # memento-nvim = pkgs.vimUtils.buildVimPlugin {
    #   pname = "memento.nvim";
    #   version = "2022-03-18";
    #   src = pkgs.fetchFromGitHub {
    #     owner = "gaborvecsei";
    #     repo = "memento.nvim";
    #     rev = "7e5e5a86ccaec2892fc2d8197fc01a25d1cf8951";
    #     sha256 = "sha256-PIK+ESmsMw/ttl4897hOnt56kFR+yQG8UBFo4LJM57s=";
    #   };
    #   meta.homepage = "https://github.com/gaborvecsei/memento.nvim";
    # };
    # git-sessions-nvim = pkgs.vimUtils.buildVimPlugin {
    #   pname = "git-sessions.nvim";
    #   version = "2023-02-01";
    #   src = pkgs.fetchFromGitHub {
    #     owner = "TimotheeSai";
    #     repo = "git-sessions.nvim";
    #     rev = "22020e9195fdd73d2c7b5dd0315a3d7cb373588d";
    #     sha256 = "sha256-D9Go8kT8WmZdG3zTlHi6kgyq/gtKopgr+JdU9CG0ubc=";
    #   };
    #   nvimRequireCheck = false;
    #   meta.homepage = "https://github.com/TimotheeSai/git-sessions.nvim";
    # };
    # codegpt-nvim = pkgs.vimUtils.buildVimPlugin {
    #   pname = "codegpt.nvim";
    #   version = "2023-05-01";
    #   src = pkgs.fetchFromGitHub {
    #     owner = "dpayne";
    #     repo = "CodeGPT.nvim";
    #     rev = "6e3714e8d336aea4a205081d44ed8b2e3505dee2";
    #     sha256 = "sha256-JpZJz4ZmbL+tfYUSOQ9K7YUld7zTzAI11fw9sRaJzPA=";
    #   };
    #   meta.homepage = "https://github.com/dpayne/CodeGPT.nvim";
    # };
    # code-runner-nvim = pkgs.vimUtils.buildVimPlugin {
    #   pname = "code_runner.nvim";
    #   version = "2023-11-18";
    #   src = pkgs.fetchFromGitHub {
    #     owner = "CRAG666";
    #     repo = "code_runner.nvim";
    #     rev = "701807c4f181cd00d4fad0280bbc821324cbe3c1";
    #     sha256 = "sha256-hF1G75vAHoqGoUonmsr00oFYjlQNGGrInn546S8OtU0=";
    #   };
    #   meta.homepage = "https://github.com/CRAG666/code_runner.nvim";
    # };
    # nvim-regexplainer = pkgs.vimUtils.buildVimPlugin {
    #   pname = "nvim-regexplainer";
    #   version = "2023-10-15";
    #   src = pkgs.fetchFromGitHub {
    #     owner = "bennypowers";
    #     repo = "nvim-regexplainer";
    #     rev = "78fff711edcb986a05a03253c28a90e32c4ce31f";
    #     sha256 = "sha256-B65k8i2gBPaXvZS1HiI3Mk4UuHbW0QQyYci7HLaPN6I=";
    #   };
    #   meta.homepage = "https://github.com/bennypowers/nvim-regexplainer";
    # };
    # quicknote-nvim = pkgs.vimUtils.buildVimPlugin {
    #   pname = "quicknote.nvim";
    #   version = "2023-10-13";
    #   src = pkgs.fetchFromGitHub {
    #     owner = "RutaTang";
    #     repo = "quicknote.nvim";
    #     rev = "530ee1f74b0ef191a3a8110b5f9d4bdffc7bfd6c";
    #     sha256 = "sha256-WVS7OUMeb2At+6THVvdbrW0JoKQaA7nIXg9JOaamUd4=";
    #   };
    #   meta.homepage = "https://github.com/RutaTang/quicknote.nvim";
    # };
    # search-nvim = pkgs.vimUtils.buildVimPlugin {
    #   pname = "search.nvim";
    #   version = "2023-12-04";
    #   src = pkgs.fetchFromGitHub {
    #     owner = "FabianWirth";
    #     repo = "search.nvim";
    #     rev = "860f7673744e139d00d416d11552533835bfdd2d";
    #     sha256 = "sha256-lEa7RMzqzGWOFC5mzT7J+HMYmYw12Xym+QhP7HXd2wY=";
    #   };
    #   meta.homepage = "https://github.com/FabianWirth/search.nvim";
    # };
    # telescope-alternate-nvim = pkgs.vimUtils.buildVimPlugin {
    #   pname = "telescope-alternate.nvim";
    #   version = "2024-01-04";
    #   src = pkgs.fetchFromGitHub {
    #     owner = "otavioschwanck";
    #     repo = "telescope-alternate.nvim";
    #     rev = "89ca203921e4f9282f1e1b72d600077be87d3770";
    #     sha256 = "sha256-3+mUSYzAAn9XZ+98OdQob2lLNyL5Bh2o3zCn5DC1Gqo=";
    #   };
    #   meta.homepage = "https://github.com/otavioschwanck/telescope-alternate.nvim";
    # };
    # muren-nvim = pkgs.vimUtils.buildVimPlugin {
    #   pname = "muren.nvim";
    #   version = "2023-08-26";
    #   src = pkgs.fetchFromGitHub {
    #     owner = "AckslD";
    #     repo = "muren.nvim";
    #     rev = "818c09097dba1322b2ca099e35f7471feccfef93";
    #     sha256 = "sha256-KDXytsyvUQVZoKdr6ieoUE3e0v5NT2gf3M1d15aYVFs=";
    #   };
    #   meta.homepage = "https://github.com/AckslD/muren.nvim";
    # };
    # sad-nvim = pkgs.vimUtils.buildVimPlugin {
    #   pname = "sad.nvim";
    #   version = "2023-03-13";
    #   src = pkgs.fetchFromGitHub {
    #     owner = "ray-x";
    #     repo = "sad.nvim";
    #     rev = "869c7f3ca3dcd28fd78023db6a7e1bf8af0f4714";
    #     sha256 = "sha256-uwXldYA7JdZHqoB4qfCnZcQW9YBjlRWmiz8mKb9jHuI=";
    #   };
    #   meta.homepage = "https://github.com/ray-x/sad.nvim";
    # };
    # toggletasks-nvim = pkgs.vimUtils.buildVimPlugin {
    #   pname = "toggletasks.nvim";
    #   version = "2023-03-08";
    #   src = pkgs.fetchFromGitHub {
    #     owner = "jedrzejboczar";
    #     repo = "toggletasks.nvim";
    #     rev = "7138dda86bd4ec908ef5342e78c60bfbd23f4506";
    #     sha256 = "sha256-/WGoo6g5UCRnE+AzkAH1R/T2t2UuJNn9Fh49tGe+Jr4=";
    #   };
    #   meta.homepage = "https://github.com/jedrzejboczar/toggletasks.nvim";
    # };
    # nvim-treesitter = pkgs.vimUtils.buildVimPlugin {  # TODO: remove
    #   pname = "nvim-treesitter";
    #   version = "2026-03-23";  # updated:
    #   src = pkgs.fetchFromGitHub {
    #     owner = "nvim-treesitter";
    #     repo = "nvim-treesitter";
    #     rev = "6620ae1c44dfa8623b22d0cbf873a9e8d073b849";
    #     hash = "sha256-Md10P3QJ1q8SYOF2CpvOMCGrbgobU0lOIFnrT26ikJg=";
    #   };
    #   doCheck = false;
    #   meta = {
    #     homepage = "https://github.com/nvim-treesitter/nvim-treesitter";
    #     description = "";
    #   };
    # };
    # code_runner = pkgs.vimUtils.buildVimPlugin {
    #   pname = "code_runner";
    #   version = "2026-03-21";
    #   src = pkgs.fetchFromGitHub {
    #     owner = "CRAG666";
    #     repo = "code_runner.nvim";
    #     rev = "eed10eb4953bc172d7652f30d289a4e575028a98";
    #     hash = "sha256-ziMJXtyqgYDRzoCI1Ms29f1mw4ws/q3a5aKU9eA0+Z0=";
    #   };
    #   meta = {
    #     homepage = "https://github.com/CRAG666/code_runner.nvim";
    #     description = "";
    #   };
    # };
    # fsread = pkgs.vimUtils.buildVimPlugin {
    #   pname = "fsread";
    #   version = "2023-02-20";
    #   src = pkgs.fetchFromGitHub {
    #     owner = "nullchilly";
    #     repo = "fsread.nvim";
    #     rev = "a637bf048f733def7c5c46f5bf482f93a8311b29";
    #     hash = "sha256-CsyBn8iAx5m1rhHW+HfbUSbtyTCaSG6/mgyrh+5KOqo=";
    #   };
    #   doCheck = false;
    #   meta = {
    #     homepage = "https://github.com/nullchilly/fsread.nvim";
    #     description = "";
    #   };
    # };
  };
  customPlugins = {
    nvim_winpick = pkgs.vimUtils.buildVimPlugin {
      pname = "nvim_winpick";
      version = "2025-06-30"; # updated 2026-06
      src = nvim_winpick_src;
      doCheck = false;

      postInstall = ''
        cp ${nvim_winpick_native}/lua/nvim_winpick.so $out/lua/
      '';
    };
    hawtkeys-nvim = pkgs.vimUtils.buildVimPlugin {
      pname = "hawtkeys.nvim";
      version = "2026-02-27"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "tris203";
        repo = "hawtkeys.nvim";
        rev = "27495e633c071ab0881d337e0f59bfbbb19e0ac2";
        sha256 = "sha256-NJHvxR068KzBeHV6BGt408zAgZMbUfVq/Emh9Ai4cLg=";
      };
      doCheck = false;
      meta.homepage = "https://github.com/tris203/hawtkeys.nvim";
    };
    cargo = pkgs.vimUtils.buildVimPlugin {
      pname = "cargo.nvim";
      version = "2026-05-27"; # updated: 2026-06

      src = pkgs.fetchFromGitHub {
        owner = "nwiizo";
        repo = "cargo.nvim";
        rev = "921a3ad364125d08c23a401a911841dd8f89db2c";
        sha256 = "sha256-0VOFyrUfKzFVIRUdznQ2aWeTHIZr219Jw1rD6KTpvks=";
      };

      meta = {
        description = "Neovim plugin for Cargo integration";
        homepage = "https://github.com/nwiizo/cargo.nvim";
        license = pkgs.lib.licenses.mit;
      };
    };
    keymap-amend-nvim = pkgs.vimUtils.buildVimPlugin {
      pname = "keymap-amend.nvim";
      version = "2022-09-22"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "anuvyklack";
        repo = "keymap-amend.nvim";
        rev = "b8bf9d820878d5497fdd11d6de55dea82872d98e";
        sha256 = "sha256-fjhZLetXo+chDywxukJtuMv15gJgi4c3lwYx+ubOUr4=";
      };
      meta.homepage = "https://github.com/anuvyklack/keymap-amend.nvim";
    };
    utils = pkgs.vimUtils.buildVimPlugin {
      pname = "utils.nvim";
      version = "2025-07-27"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "2KAbhishek";
        repo = "utils.nvim";
        rev = "8950622bd6861f2257364e5027c5613f29225e17";
        sha256 = "sha256-A7SpGhI+ui8uCwgOJyiYFUg2LhLRwBlNn/CzjY00v5o=";
      };
      doCheck = false;
      meta.homepage = "https://github.com/2KAbhishek/utils.nvim";
    };
    coop = pkgs.vimUtils.buildVimPlugin {
      pname = "coop.nvim";
      version = "2026-04-20"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "gregorias";
        repo = "coop.nvim";
        rev = "b156e541316aee14be4ae64c93ed8bddb6d03bc1";
        sha256 = "sha256-S6iGmdakI714Im0tetgfASbe0K4/olYsjj26+WP+rSU=";
      };
      meta.homepage = "https://github.com/gregorias/coop.nvim";
    };
    qfview-nvim = pkgs.vimUtils.buildVimPlugin {
      pname = "qfview.nvim";
      version = "2023-09-09"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "ashfinal";
        repo = "qfview.nvim";
        rev = "f7a4fd8d700d02f6c1274f02115fa4e68e63aa54";
        sha256 = "sha256-a8htbp3o/QBvdLDOTt8k+O0JmjqczpaY0CkojfbZYG8=";
      };
      meta.homepage = "https://github.com/ashfinal/qfview.nvim";
    };
    neowell-lua = pkgs.vimUtils.buildVimPlugin {
      pname = "NeoWell.lua";
      version = "2023-05-11"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "nyngwang";
        repo = "NeoWell.lua";
        rev = "48e8776c73644de1b77122c97d530a9364a3b2db";
        sha256 = "sha256-1BkCQrTF1Mku2zonFsLLKsWCAxmLxpXARAL4Ph3xcTw=";
      };
      meta.homepage = "https://github.com/nyngwang/NeoWell.lua";
    };
    nvim-genghis = pkgs.vimUtils.buildVimPlugin {
      pname = "nvim-genghis";
      version = "2026-05-05"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "chrisgrieser";
        repo = "nvim-genghis";
        rev = "e6fd1f42736b15e63c0c703457c5ca162228a2f3";
        sha256 = "sha256-UG3yDZJ/j4Z+fDm5/qrVuUUA8rU4oc4chqFJK25jjYw=";
      };
      meta.homepage = "https://github.com/chrisgrieser/nvim-genghis";
    };
    windex-nvim = pkgs.vimUtils.buildVimPlugin {
      pname = "windex.nvim";
      version = "2022-07-13"; # updated 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "declancm";
        repo = "windex.nvim";
        rev = "1e86cba6f6f55ced60d17d6c6ebd51388a637b86";
        sha256 = "sha256-mkBfIrltEXw6o8eygg60cwcJyVfS5y8Hx7vtagvF3Vo=";
      };
      meta.homepage = "https://github.com/declancm/windex.nvim";
    };
    wezterm-nvim = pkgs.vimUtils.buildVimPlugin {
      pname = "wezterm.nvim";
      version = "2023-11-02"; # # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "willothy";
        repo = "wezterm.nvim";
        rev = "2aacd6405c52ef4b865a7baf2598fa3d7b0bc25c";
        sha256 = "sha256-ZWaDL614A9LpDHGydSpDE2TyyiP76FTmNvlVdpyHg7w=";
      };
      meta.homepage = "https://github.com/willothy/wezterm.nvim";
    };
    nvim-luaref = pkgs.vimUtils.buildVimPlugin {
      pname = "nvim-luaref";
      version = "2022-02-17"; # # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "milisims";
        repo = "nvim-luaref";
        rev = "9cd3ed50d5752ffd56d88dd9e395ddd3dc2c7127";
        sha256 = "sha256-nmsKg1Ah67fhGzevTFMlncwLX9gN0JkR7Woi0T5On34=";
      };
      meta.homepage = "https://github.com/milisims/nvim-luaref";
    };
    hlargs-nvim = pkgs.vimUtils.buildVimPlugin {
      pname = "hlargs.nvim";
      version = "2026-06-05"; # # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "m-demare";
        repo = "hlargs.nvim";
        rev = "05f3d1789642d5e1807121c05c42a5e883ba46d3";
        sha256 = "sha256-daCx0OHqsGNasfnxHxVO2309aS8LYZIxbeaZ/pEtNFU=";
      };
      meta.homepage = "https://github.com/m-demare/hlargs.nvim";
    };
    dropbar = pkgs.vimUtils.buildVimPlugin {
      pname = "dropbar.nvim";
      version = "2026-05-31"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "Bekaboo";
        repo = "dropbar.nvim";
        rev = "808ba31cde89aec8833e9789f5e04557cd31c9e1";
        sha256 = "sha256-S9TD5PkHKHoo2jfjOXkQoNtyr/PNtR/eljXB+8PtGU8=";
      };
      doCheck = false;
      meta.homepage = "https://github.com/Bekaboo/dropbar.nvim";
    };
    iron-nvim = pkgs.vimUtils.buildVimPlugin {
      pname = "iron.nvim";
      version = "2026-02-21"; # # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "Vigemus";
        repo = "iron.nvim";
        rev = "88cd340407b959f1168af2a6ae5a3d180e6df32c";
        sha256 = "sha256-I2o1H9iRgGHmLA0v2U508hKWFCFrvZxXGWUOLtke7Do=";
      };
      meta.homepage = "https://github.com/Vigemus/iron.nvim";
    };
    sibling-swap = pkgs.vimUtils.buildVimPlugin {
      pname = "sibling-swap.nvim";
      version = "2026-04-06"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "Wansmer";
        repo = "sibling-swap.nvim";
        rev = "ae5aef7e62faf16228d570757e97ca92bf49f849";
        sha256 = "sha256-aVah6/JFd0fDo+z6Jj4o5fHtjPWj9l4HJj2BETyVMXg=";
      };
      meta.homepage = "https://github.com/Wansmer/sibling-swap.nvim";
    };
    move = pkgs.vimUtils.buildVimPlugin {
      pname = "move.nvim";
      version = "2025-05-13"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "fedepujol";
        repo = "move.nvim";
        rev = "599b14047b82e92874b9a408e4df228b965c3a1d";
        sha256 = "sha256-LO6MT0gSZzmgUnV6CyRCvl9ibvJRTffTBjgBaKyA5u8=";
      };
      meta.homepage = "https://github.com/fedepujol/move.nvim";
    };
    carbon-now-nvim = pkgs.vimUtils.buildVimPlugin {
      pname = "carbon-now.nvim";
      version = "2025-11-05"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "ellisonleao";
        repo = "carbon-now.nvim";
        rev = "2440d007633a5d436ebc9d2b5ef74e4fddd83f15";
        sha256 = "sha256-SWCkScgsOVT4oJIlKErtJDzdkDd3f59hdVsqnsezXzU=";
      };
      meta.homepage = "https://github.com/ellisonleao/carbon-now.nvim";
    };
    gx-extended-nvim = pkgs.vimUtils.buildVimPlugin {
      pname = "gx-extended.nvim";
      version = "2026-04-13"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "rmagatti";
        repo = "gx-extended.nvim";
        rev = "68032ffb37c8e53316eba69b51655d854479fdc1";
        sha256 = "sha256-r0zUFPvvYFbNBti1VCkFJNCe2cTC2sCg/WvboJzWC88=";
      };
      meta.homepage = "https://github.com/rmagatti/gx-extended.nvim";
    };
    ultimate-autopair = pkgs.vimUtils.buildVimPlugin {
      pname = "ultimate-autopair.nvim";
      version = "2026-03-14"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "altermo";
        repo = "ultimate-autopair.nvim";
        rev = "6b58234de921437836efe27714b2026ed2ee235a";
        sha256 = "sha256-JEL6ansTFn4930gz6i7zUyvCaSxHJImz8hdwoQmX7qM=";
      };
      meta.homepage = "https://github.com/altermo/ultimate-autopair.nvim";
    };
    spaceport-nvim = pkgs.vimUtils.buildVimPlugin {
      pname = "spaceport.nvim";
      version = "2026-05-19"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "CWood-sdf";
        repo = "spaceport.nvim";
        rev = "dfcf395f10451058fffe26f297f413428e3c1ab5";
        sha256 = "sha256-5zBqxH4ivbvzgjLFXwmYMvMoNk8Xl5o59oiYVXsJiXI=";
      };
      doCheck = false;
      meta.homepage = "https://github.com/CWood-sdf/spaceport.nvim";
    };
    improved-search-nvim = pkgs.vimUtils.buildVimPlugin {
      pname = "improved-search.nvim";
      version = "2023-12-21"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "backdround";
        repo = "improved-search.nvim";
        rev = "9480bfb0e05f990a1658464c1d349dd2acfb9c34";
        sha256 = "sha256-k35uJZfarjRskS9MgCjSQ3gfl57d+r8vWvw0Uq16Z30=";
      };
      meta.homepage = "https://github.com/backdround/improved-search.nvim";
    };
    highlight-current-n-nvim = pkgs.vimUtils.buildVimPlugin {
      pname = "highlight-current-n.nvim";
      version = "2023-06-26"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "rktjmp";
        repo = "highlight-current-n.nvim";
        rev = "1225d1ad3fee74c3e6a6d258f25a1952b927cb76";
        sha256 = "sha256-Bel83ytJCgQ6MK4qWKU557b+OI/HdMSriFoqYoCgpzA=";
      };
      meta.homepage = "https://github.com/rktjmp/highlight-current-n.nvim";
    };
    hlsearch-nvim = pkgs.vimUtils.buildVimPlugin {
      pname = "hlsearch.nvim";
      version = "2024-01-10"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "nvimdev";
        repo = "hlsearch.nvim";
        rev = "fdeb60b890d15d9194e8600042e5232ef8c29b0e";
        sha256 = "sha256-ibizMO16T/SwZIcl+zckbpDHMYQovKPEB5iO2YBRj74=";
      };
      meta.homepage = "https://github.com/nvimdev/hlsearch.nvim";
    };
    rgflow-nvim = pkgs.vimUtils.buildVimPlugin {
      pname = "rgflow.nvim";
      version = "2025-08-11"; # # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "mangelozzi";
        repo = "rgflow.nvim";
        rev = "c97daadc871aad548cb717b04bbaa948dd2f0fea";
        sha256 = "sha256-05RhTf2zJnsOMHBa0gPhiD+d+Yq0o1l5rtsD2XOmVdg=";
      };
      meta.homepage = "https://github.com/mangelozzi/rgflow.nvim";
    };
    nvim-rg = pkgs.vimUtils.buildVimPlugin {
      pname = "nvim-rg";
      version = "2026-05-18"; # # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "duane9";
        repo = "nvim-rg";
        rev = "52651d1bdaa1166e43d09ba44cc2df67d475cf4e";
        sha256 = "sha256-USvXVEWoDH72e0qxkVPmYU80n5NcnIr9Zaf1AuONoYo=";
      };
      meta.homepage = "https://github.com/duane9/nvim-rg";
    };
    nvim-various-textobjs = pkgs.vimUtils.buildVimPlugin {
      pname = "nvim-various-textobjs";
      version = "2026-04-13"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "chrisgrieser";
        repo = "nvim-various-textobjs";
        rev = "ad78e9d925c95d675b32dd7ba6d253f96ce063fe";
        sha256 = "sha256-FZKW7/9Y6MRxEbd00HBt9eGpJWbAP8GNM6p8M9s/3ts=";
      };
      meta.homepage = "https://github.com/chrisgrieser/nvim-various-textobjs";
    };

    # CURRENTLY USED
    # xit = pkgs.vimUtils.buildVimPlugin {
    #   pname = "xit.nvim";
    #   version = "2026-04-09";  # updated: 2026-05
    #   dependencies = [
    #     # pkgs.vimPlugins.nvim-treesitter
    #   ];
    #   doCheck = false;
    #   src = pkgs.fetchFromGitHub {
    #     owner = "yelircaasi";
    #     repo = "xit.nvim";
    #     rev = "24ab4b043915103a36f42ea9451b70ef16bed061";
    #     sha256 = "sha256-O08kZVDgpuqSxc8CY8D5yPq/Q1O0ZAr1AKx0qht/UQU=";
    #   };
    #   meta.homepage = "https://github.com/yelircaasi/xit.nvim";
    # };
    cosmic-ui = pkgs.vimUtils.buildVimPlugin {
      pname = "cosmic-ui";
      version = "2026-06-15"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "CosmicNvim";
        repo = "cosmic-ui";
        rev = "8bbe62b59234066a03c4780ac9c2ffcb5cac6b18";
        hash = "sha256-RaNanmU2cLZsUVbT0g9RqhZo1w04oUDhLTtktzRupzY=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/CosmicNvim/cosmic-ui";
        description = "";
      };
    };
    nvim-api-wrappers = pkgs.vimUtils.buildVimPlugin {
      pname = "nvim-api-wrappers";
      version = "2022-12-22"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "anuvyklack";
        repo = "nvim-api-wrappers";
        rev = "57085c898b2f6cd8a735f05c945b92f20a3c364d";
        hash = "sha256-R9SHVbYpZR2qsXwDTTeaTk7wicqMGncNd42yvNt9dKY=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/anuvyklack/nvim-api-wrappers";
        description = "";
      };
    };
    cmdTree = pkgs.vimUtils.buildVimPlugin {
      pname = "cmdTree";
      version = "2024-12-29"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "CWood-sdf";
        repo = "cmdTree.nvim";
        rev = "5b689e6c288057236aa4ea53b517c4722ae6c0dc";
        hash = "sha256-Qf/4x5LtHnX1r3ltNb44nPWCDvIuEdVWPERuEiG/G6k=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/CWood-sdf/cmdTree.nvim";
        description = "";
      };
    };
    symbols = pkgs.vimUtils.buildVimPlugin {
      pname = "symbols";
      version = "2025-08-19"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "oskarrrrrrr";
        repo = "symbols.nvim";
        rev = "b22e987c69749adcf1342e8040312e9318083d4a";
        hash = "sha256-d70H2zsQb1KbbgWAYkr14xQ52lvhweYzGN6KURl4hj8=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/oskarrrrrrr/symbols.nvim";
        description = "";
      };
    };
    TreePin = pkgs.vimUtils.buildVimPlugin {
      pname = "TreePin";
      version = "2023-07-20"; # # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "KaitlynEthylia";
        repo = "TreePin";
        rev = "e9063721edb2bae0b16433e7c1ee562ce1ac1597";
        hash = "sha256-bxIX86gk0sbozSJau0jUmIt8u/ClutVs5JyidFoka1U=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/KaitlynEthylia/TreePin";
        description = "";
      };
    };
    virtcolumn = pkgs.vimUtils.buildVimPlugin {
      pname = "virtcolumn";
      version = "2023-12-15"; # # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "xiyaowong";
        repo = "virtcolumn.nvim";
        rev = "4d385b4aa42aa3af6fa2cb8527462fa4badbd163";
        hash = "sha256-4Q7dbgu/YxpHTLrMgGzJ2DaAuaH9VhkVTrtlbFmPYZY=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/xiyaowong/virtcolumn.nvim";
        description = "";
      };
    };
    heirline-components = pkgs.vimUtils.buildVimPlugin {
      pname = "heirline-components";
      version = "2026-02-25"; # # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "Zeioth";
        repo = "heirline-components.nvim";
        rev = "5ea9a16286c01b7c36d58c91903d1f8ff0b7ddeb";
        hash = "sha256-M86mP8Xr7tIFi9mM8icHWIzbWTR3W2xdSgzXhxNLMj4=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/Zeioth/heirline-components.nvim";
        description = "";
      };
    };
    nougat = pkgs.vimUtils.buildVimPlugin {
      pname = "nougat";
      version = "2024-01-07"; # # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "MunifTanjim";
        repo = "nougat.nvim";
        rev = "1c1cde6e53d7d7c2242d125fe67552b00e235876";
        hash = "sha256-0IM2P0SVYidknOei67DFOL+aPGQVsqTdIgZnyUHo4AU=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/MunifTanjim/nougat.nvim";
        description = "";
      };
    };
    winbar = pkgs.vimUtils.buildVimPlugin {
      pname = "winbar";
      version = "2022-11-23"; # # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "Alighorab";
        repo = "winbar.nvim";
        rev = "38a92be23ceee9909aa775e7048159ada7a94fe9";
        hash = "sha256-iaF1fzSoiN/YEZ4S++/kF5ZxLYCuIxthYNubI1U/9GU=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/Alighorab/winbar.nvim";
        description = "";
      };
    };
    minibar = pkgs.vimUtils.buildVimPlugin {
      pname = "minibar";
      version = "2023-01-06"; # # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "aktersnurra";
        repo = "minibar.nvim";
        rev = "353ca4efaf7fff1566bb02e0d7cb51133c41f660";
        hash = "sha256-jQwC2EYUdNOVR0NkPvIT3y36rgfSRNJPsjeZ9HRDRig=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/aktersnurra/minibar.nvim";
        description = "";
      };
    };
    bafa = pkgs.vimUtils.buildVimPlugin {
      pname = "bafa";
      version = "2026-05-19"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "mistweaverco";
        repo = "bafa.nvim";
        rev = "87968d01e72660826bce00f9956515bd1d0d5b74";
        hash = "sha256-8MdtU/L17TBkNyMl2XWiKrkHeKblJfooIKePP6keVhw=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/mistweaverco/bafa.nvim";
        description = "";
      };
    };
    windline = pkgs.vimUtils.buildVimPlugin {
      pname = "windline";
      version = "2025-10-22"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "windwp";
        repo = "windline.nvim";
        rev = "2e83922bf289ffd30fbd7f7028fdb4711592dd92";
        hash = "sha256-WFN6RsJeXm2FcfB6DIxe6SXqvqncqV9GaE+Oxmfdt1k=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/windwp/windline.nvim";
        description = "";
      };
    };
    pickme = pkgs.vimUtils.buildVimPlugin {
      pname = "pickme";
      version = "2026-06-12"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "2KAbhishek";
        repo = "pickme.nvim";
        rev = "80a2540cda81be76c8c80b47dc37f87738ddf696";
        hash = "sha256-RTM7oka5/COo8rYbrxDvvFc9Kaq/QyqLbAc6VJ+AveE=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/2KAbhishek/pickme.nvim";
        description = "";
      };
    };
    deck = pkgs.vimUtils.buildVimPlugin {
      pname = "deck";
      version = "2026-06-17"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "hrsh7th";
        repo = "nvim-deck";
        rev = "d31bbd074afd9866c81eb45a81623784e80af829";
        hash = "sha256-k+VMBnHqPgzyzdGmjvQYoUER0MTip53UR997S5Z7jFo=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/hrsh7th/nvim-deck";
        description = "";
      };
    };
    ido = pkgs.vimUtils.buildVimPlugin {
      pname = "ido";
      version = "2026-04-01"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "shoumodip";
        repo = "ido.nvim";
        rev = "850d1a324ec0a992b4f95b8613582f8cca1e9467";
        hash = "sha256-rh1ug9GGCPYNXajbmufQvQD+KZmxLNv//WEj/XEOlVc=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/shoumodip/ido.nvim";
        description = "";
      };
    };
    telescope-repo = pkgs.vimUtils.buildVimPlugin {
      pname = "telescope-repo";
      version = "2026-05-24"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "cljoly";
        repo = "telescope-repo.nvim";
        rev = "1f3d40352891b46ee27c0eea2ece767de7f1adfa";
        hash = "sha256-Z2nt3ANK+vEqZygC21N3OJxoWqbvQw/SGbB0k6yU4Mw=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/cljoly/telescope-repo.nvim";
        description = "";
      };
    };
    telescope-json-history = pkgs.vimUtils.buildVimPlugin {
      pname = "telescope-json-history";
      version = "2023-02-09"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "cosminadrianpopescu";
        repo = "telescope-json-history.nvim";
        rev = "04d592e441b5723d445046e1467270f6bd48d978";
        hash = "sha256-Ot47ockIDYd4gmjCFbwDYWWtq+YG52BiInlHnJbFmTs=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/cosminadrianpopescu/telescope-json-history.nvim";
        description = "";
      };
    };
    blink = pkgs.vimUtils.buildVimPlugin {
      pname = "blink"; # TODO: need to separate packages?
      version = "2025-10-21"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "saghen";
        repo = "blink.nvim";
        rev = "d1e7c7c45d45c6b6a25427bf62db4db73b03ff3d";
        hash = "sha256-FSfk8RF/yZqgT3OcRHkNnO+oM5YA7H0Cd6C4rGHV1uI=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/saghen/blink.nvim";
        description = "";
      };
    };
    hlsearch = pkgs.vimUtils.buildVimPlugin {
      pname = "hlsearch";
      version = "2024-01-10"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "nvimdev";
        repo = "hlsearch.nvim";
        rev = "fdeb60b890d15d9194e8600042e5232ef8c29b0e";
        hash = "sha256-ibizMO16T/SwZIcl+zckbpDHMYQovKPEB5iO2YBRj74=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/nvimdev/hlsearch.nvim";
        description = "";
      };
    };
    search-replace = pkgs.vimUtils.buildVimPlugin {
      pname = "search-replace";
      version = "2026-01-26"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "mosheavni";
        repo = "search-replace.nvim";
        rev = "06ebf663fca3f3b3d1b73bbca695f0c9eb7c7309";
        hash = "sha256-s5ayWMzoH9pihUtnMZcyaGSNts4RkHpS9M344RVIHXw=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/mosheavni/search-replace.nvim";
        description = "";
      };
    };
    sad = pkgs.vimUtils.buildVimPlugin {
      pname = "sad";
      version = "2025-05-01"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "ray-x";
        repo = "sad.nvim";
        rev = "e7511767b59fcff237cc7209d47d08aba64b9f63";
        hash = "sha256-CBX1EAch/cAE432g8/Tt8QqU8tIkTviXVdRyOwRyNEo=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/ray-x/sad.nvim";
        description = "";
      };
    };
    flybuf = pkgs.vimUtils.buildVimPlugin {
      pname = "flybuf";
      version = "2023-03-25"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "nvimdev";
        repo = "flybuf.nvim";
        rev = "fe1fbd9699f6988a1db3b2e2ffa599154784c6e1";
        hash = "sha256-dZWRc7p7g4q/F+bF6VVmz5bfN9kItSiWdBusm9yHz2w=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/nvimdev/flybuf.nvim";
        description = "";
      };
    };
    stickybuf = pkgs.vimUtils.buildVimPlugin {
      pname = "stickybuf";
      version = "2025-05-24"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "stevearc";
        repo = "stickybuf.nvim";
        rev = "9e00edfd94baef4a78b4248ae8309a2d4943f118";
        hash = "sha256-WuT3gaYW4bV3hWoQ9Gj1uXkH+/W1hoLsTnh+j27otIo=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/stevearc/stickybuf.nvim";
        description = "";
      };
    };
    swm = pkgs.vimUtils.buildVimPlugin {
      pname = "swm";
      version = "2025-02-11"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "hrsh7th";
        repo = "nvim-swm";
        rev = "4ccb2b137b117092f3efa426261ddbef25111454";
        hash = "sha256-9BAFWSnKO/UAY7z/01i4I6B12yfAInjgo6UOCZBtD0U=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/hrsh7th/nvim-swm";
        description = "";
      };
    };
    retrospect = pkgs.vimUtils.buildVimPlugin {
      pname = "retrospect";
      version = "2025-11-05"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "mrquantumcodes";
        repo = "retrospect.nvim";
        rev = "0818a59c9bd12bfa3e79b50858d1da988b032842";
        hash = "sha256-BXmYoou/5rCbx4buF5jSWwQNsvkyQSGXx82C/UixxcU=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/mrquantumcodes/retrospect.nvim";
        description = "";
      };
    };
    vuffers = pkgs.vimUtils.buildVimPlugin {
      pname = "vuffers";
      version = "2026-05-20"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "Hajime-Suzuki";
        repo = "vuffers.nvim";
        rev = "4da32925b5c2728892a456e04b09ccde8d82a16d";
        hash = "sha256-85rNNBQG9t2FxXaNmY1yWPmyqo6ja/aoLAiL+lyfsww=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/Hajime-Suzuki/vuffers.nvim";
        description = "";
      };
    };
    pragma = pkgs.vimUtils.buildVimPlugin {
      pname = "pragma";
      version = "2024-11-28"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "DrKGD";
        repo = "pragma.nvim";
        rev = "1f2b4e6f9a567d3852354d9d124e07bd0c19f25b";
        hash = "sha256-BlaxFUdZzAIyhqvoXHI5bB7Ka01HXDyApcYBFcjkBb0=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/DrKGD/pragma.nvim";
        description = "";
      };
    };
    wrapping-paper = pkgs.vimUtils.buildVimPlugin {
      pname = "wrapping-paper";
      version = "2025-04-02"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "benlubas";
        repo = "wrapping-paper.nvim";
        rev = "661d026455deea984b45e1ae8677da19d0ecb389";
        hash = "sha256-Q7KvOmC0vOnMKxGbyg2UHC3QWoavkJ3kqA6Mt9up2DE=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/benlubas/wrapping-paper.nvim";
        description = "";
      };
    };
    savior = pkgs.vimUtils.buildVimPlugin {
      pname = "savior";
      version = "2025-05-09"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "willothy";
        repo = "savior.nvim";
        rev = "ad8878c929bd759c8fac64744306f6e6c1e15e7d";
        hash = "sha256-BtI7PAs5TrwGYTo+duM9ZiDxu7WWnvkm0mmnnUBAqlE=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/willothy/savior.nvim";
        description = "";
      };
    };
    zpragmatic = pkgs.vimUtils.buildVimPlugin {
      pname = "zpragmatic";
      version = "2024-11-26"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "muhammadzkralla";
        repo = "zpragmatic.nvim";
        rev = "95dc3e54f2b00278a7363451f11daacc75ea8844";
        hash = "sha256-rZd+iMC6VOM/4SIG+8qCxyO/zMslQqOQlIMg6QMniQg=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/muhammadzkralla/zpragmatic.nvim";
        description = "";
      };
    };
    neowords = pkgs.vimUtils.buildVimPlugin {
      pname = "neowords";
      version = "2024-09-04"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "backdround";
        repo = "neowords.nvim";
        rev = "47a38cd4aa3118a6be3f64ac4987a8483bd2e98a";
        hash = "sha256-Q0JpvOi4jpPJl4JODFJG+vG+aTvDyD+vc0DXWOmNtIY=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/backdround/neowords.nvim";
        description = "";
      };
    };
    vim-edgemotion = pkgs.vimUtils.buildVimPlugin {
      pname = "vim-edgemotion";
      version = "2017-12-26"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "haya14busa";
        repo = "vim-edgemotion";
        rev = "8d16bd92f6203dfe44157d43be7880f34fd5c060";
        hash = "sha256-CFDU+q1CLbKgCwed5Qx728olgTpCTpYDzz6LefjEdvA=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/haya14busa/vim-edgemotion";
        description = "";
      };
    };
    treemonkey = pkgs.vimUtils.buildVimPlugin {
      pname = "treemonkey";
      version = "2026-06-09"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "atusy";
        repo = "treemonkey.nvim";
        rev = "fabec4c39a13e7d98f15ee0446c33770c7fb4719";
        hash = "sha256-R+BmeKp404NOw7JMK3vQYM2ZQNc+U9WNlHxK0OOfKnU=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/atusy/treemonkey.nvim";
        description = "";
      };
    };
    navigator = pkgs.vimUtils.buildVimPlugin {
      pname = "navigator";
      version = "2026-05-19"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "ray-x";
        repo = "navigator.lua";
        rev = "cdf118b21a2b7c05a6e8e6d57acbe7a41d4ea41b";
        hash = "sha256-f2Cq+aUVCgA4WxKWjJP5GrwbEq6vnNwfGnhRjtL3BBM=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/ray-x/navigator.lua";
        description = "";
      };
    };
    insx = pkgs.vimUtils.buildVimPlugin {
      pname = "insx";
      version = "2025-06-10"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "hrsh7th";
        repo = "nvim-insx";
        rev = "fbba86031f3927ecbc11556217b4976a149c29c6";
        hash = "sha256-6ZDu1B4L9NESAd5Suh/NUKCkssRtLEYtf0+/ipR+7Ic=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/hrsh7th/nvim-insx";
        description = "";
      };
    };
    nvim-apm = pkgs.vimUtils.buildVimPlugin {
      pname = "nvim-apm";
      version = "2023-03-04"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "pseudocc";
        repo = "nvim-apm";
        rev = "0e96b6222f322377063d1940648bd78a15cf55e9";
        hash = "sha256-ewEjvS3K5rQbv/eSZuY/zbKW61vH2QxBka3bo5Mn2ck=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/pseudocc/nvim-apm";
        description = "";
      };
    };
    nvim-keymapper = pkgs.vimUtils.buildVimPlugin {
      pname = "nvim-keymapper";
      version = "2022-11-10"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "bgrohman";
        repo = "nvim-keymapper";
        rev = "7e23f4b38a38d2c125763bdf456f464dbbd64fbb";
        hash = "sha256-ipDz9p9q2HXBJdG1nFGh7igjg5OI/vXnh1JfuShKxZI=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/bgrohman/nvim-keymapper";
        description = "";
      };
    };
    keyseer = pkgs.vimUtils.buildVimPlugin {
      pname = "keyseer";
      version = "2026-06-13"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "jokajak";
        repo = "keyseer.nvim";
        rev = "44b07c371cfce8b4eadd71888ba64220af2b4921";
        hash = "sha256-whJ4entPT/fg7EuToPlGmuH3i4VjYhVIE48HSGS3qds=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/jokajak/keyseer.nvim";
        description = "";
      };
    };
    keytex = pkgs.vimUtils.buildVimPlugin {
      pname = "keytex";
      version = "2024-03-28"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "cronJohn";
        repo = "keytex.nvim";
        rev = "34c3cbb0e10102ed234695ea1d26332ea631d917";
        hash = "sha256-aFI1X7LpJBH7Evtdr3kQCcgKs/G8o/mC6W9PyXXWjgw=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/cronJohn/keytex.nvim";
        description = "";
      };
    };
    keylab = pkgs.vimUtils.buildVimPlugin {
      pname = "keylab";
      version = "2023-06-14"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "BooleanCube";
        repo = "keylab.nvim";
        rev = "9686b09253b5dde40e18554d189deb1b0c47f437";
        hash = "sha256-CLHp+FapT2vqgZtdEmHRJDBYxKTHN4SeueFCzimQtG8=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/BooleanCube/keylab.nvim";
        description = "";
      };
    };
    xkbswitch = pkgs.vimUtils.buildVimPlugin {
      pname = "xkbswitch";
      version = "2025-01-05"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "ivanesmantovich";
        repo = "xkbswitch.nvim";
        rev = "aae56d49db9baf0d9b9675a77da35173d8d87a30";
        hash = "sha256-2ziFjPanBHr9KAlIcYlx/EUbuCWdpo1pwUNAvnqfiZE=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/ivanesmantovich/xkbswitch.nvim";
        description = "";
      };
    };
    cyrillic = pkgs.vimUtils.buildVimPlugin {
      pname = "cyrillic";
      version = "2023-07-07"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "nativerv";
        repo = "cyrillic.nvim";
        rev = "86186af29eed2af1a069f9e36140d116a2765c80";
        hash = "sha256-B2NjvaKJbkih8HLgFAYVqmTuSKAj7XrCBPVoVpYCXXE=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/nativerv/cyrillic.nvim";
        description = "";
      };
    };
    homerows = pkgs.vimUtils.buildVimPlugin {
      pname = "homerows";
      version = "2023-05-08"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "kbario";
        repo = "homerows.nvim";
        rev = "b79e8fffb97ec8f93b040e7bae8846e171728fba";
        hash = "sha256-ukJFchYxnAD7hwCDpDB/tWVwQ1K4Hi3wyn01/ECm1Fs=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/kbario/homerows.nvim";
        description = "";
      };
    };
    wf = pkgs.vimUtils.buildVimPlugin {
      pname = "wf";
      version = "2024-11-23"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "Cassin01";
        repo = "wf.nvim";
        rev = "5b96c7300d4391f990d4bef22eace9d834167da4";
        hash = "sha256-ZnGshcI1jYORck/E7GHc8gOETYwBo0YdUB3jUcvn3pc=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/Cassin01/wf.nvim";
        description = "";
      };
    };
    NeoComposer = pkgs.vimUtils.buildVimPlugin {
      pname = "NeoComposer";
      version = "2025-05-17"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "lvim-tech";
        repo = "NeoComposer.nvim";
        rev = "83f78b23c4f6826b0f484a91869415b85f74b24f";
        hash = "sha256-tdM6kp0UfGN6Y4kWAPPOhboLZQWNBKGylqj5zBO1uSg=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/lvim-tech/NeoComposer.nvim";
        description = "";
      };
    };
    nvim-macros = pkgs.vimUtils.buildVimPlugin {
      pname = "nvim-macros";
      version = "2024-02-16"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "kr40";
        repo = "nvim-macros";
        rev = "f29d08ee7844ed6c9552699206e8c977d6936ee4";
        hash = "sha256-UDmMx4myoj0hx78C682BKMJ6RE0RQ/ilQatmMPGHtg8=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/kr40/nvim-macros";
        description = "";
      };
    };
    recorder = pkgs.vimUtils.buildVimPlugin {
      pname = "recorder";
      version = "2026-04-13"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "chrisgrieser";
        repo = "nvim-recorder";
        rev = "7acba6f7bbafb242f71c87e3f0ac4b1c40f03a96";
        hash = "sha256-E/QFpMyYi4CJ2YXb4Bm76GLsa59RPQtsJwvHRwVBJP0=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/chrisgrieser/nvim-recorder";
        description = "";
      };
    };
    indentmini = pkgs.vimUtils.buildVimPlugin {
      pname = "indentmini";
      version = "2026-01-04"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "nvimdev";
        repo = "indentmini.nvim";
        rev = "38572ce5a7a064a5deb89d6d861b7c40fc929ab1";
        hash = "sha256-XcoBNrvFMmEMcgrknDg/HnxRNssom6vLeOKiu1qJKBo=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/nvimdev/indentmini.nvim";
        description = "";
      };
    };
    anydent = pkgs.vimUtils.buildVimPlugin {
      pname = "anydent";
      version = "2026-01-22"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "hrsh7th";
        repo = "nvim-anydent";
        rev = "b6151bd50d5935522a71709202a0495a50681156";
        hash = "sha256-wFE7SLrHcVGl7eZnyd8Sc7lUn1gao8vcyYAAGTshOvw=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/hrsh7th/nvim-anydent";
        description = "";
      };
    };
    todo-comments = pkgs.vimUtils.buildVimPlugin {
      pname = "todo-comments-nvim";
      version = "2025-11-10"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "folke";
        repo = "todo-comments.nvim";
        rev = "31e3c38ce9b29781e4422fc0322eb0a21f4e8668";
        hash = "sha256-VGeIRfwQsHgSO89Pmn6yIP9na1F6mmYZx0HDLe9IKCQ=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/folke/todo-comments.nvim";
        description = "";
      };
    };
    splitjoin = pkgs.vimUtils.buildVimPlugin {
      pname = "splitjoin";
      version = "2026-04-26"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "bennypowers";
        repo = "splitjoin.nvim";
        rev = "371b5df7c9cef92225599e75ebc8c20434e1f9be";
        hash = "sha256-pH4AT+VTLYUlo3SDNomQCB/V3Vh8jYhREEJNX0AFFQ0=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/bennypowers/splitjoin.nvim";
        description = "";
      };
    };
    spread = pkgs.vimUtils.buildVimPlugin {
      pname = "spread";
      version = "2026-02-04"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "aarondiel";
        repo = "spread.nvim";
        rev = "825c9c4b11f5624bfe322b0626f1dc24cb3e06b5";
        hash = "sha256-daT0Ft3Y5I0Rlrf/guFcK7dPtUMqrsB/gItsJGVCq2I=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/aarondiel/spread.nvim";
        description = "";
      };
    };
    harpoon-core = pkgs.vimUtils.buildVimPlugin {
      pname = "harpoon-core";
      version = "2026-04-05"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "MeanderingProgrammer";
        repo = "harpoon-core.nvim";
        rev = "1bb6da6ea0b1501458c89c4c3947d10c454e2ae4";
        hash = "sha256-jPtqmibF1Dt3BOVaeA1rwme+BymlRHzGdycLuAEK7y0=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/MeanderingProgrammer/harpoon-core.nvim";
        description = "";
      };
    };
    markit = pkgs.vimUtils.buildVimPlugin {
      pname = "markit";
      version = "2025-10-09"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "2KAbhishek";
        repo = "markit.nvim";
        rev = "c716195d5b0b21ef03a20a1facc46d33ca9f7c49";
        hash = "sha256-RY4pFO3HDIaiTADE5T9jb+3X7KVHAFw3cT8wmAYz7KU=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/2KAbhishek/markit.nvim";
        description = "";
      };
    };
    spear = pkgs.vimUtils.buildVimPlugin {
      pname = "spear";
      version = "2022-11-15"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "kbario";
        repo = "spear.nvim";
        rev = "9fdcc9f2dcf264221d59a0e7938fcb31ea2331a8";
        hash = "sha256-YAwAvHlyBpYgvR4nl9gqz6l0BNtRLkjtaQfjiqkKUxk=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/kbario/spear.nvim";
        description = "";
      };
    };
    whaler = pkgs.vimUtils.buildVimPlugin {
      pname = "whaler";
      version = "2026-03-09"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "SalOrak";
        repo = "whaler.nvim";
        rev = "3581707eb24aa9feba9788ac997117eec67b1ad7";
        hash = "sha256-OoxENjXKwkGMDW0p0pWCRzBkMyhxJXcCPviF3IJiT3E=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/SalOrak/whaler.nvim";
        description = "";
      };
    };
    pasta = pkgs.vimUtils.buildVimPlugin {
      pname = "pasta";
      version = "2024-10-24"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "hrsh7th";
        repo = "nvim-pasta";
        rev = "7cc66bcf7101e40a6184b46a37eff0d5a43bde8d";
        hash = "sha256-5/qdoPqKbwQ47CPkoqk424gxbWSne5LlDqw1zbMyb/8=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/hrsh7th/nvim-pasta";
        description = "";
      };
    };
    wastebin = pkgs.vimUtils.buildVimPlugin {
      pname = "wastebin";
      version = "2025-05-07"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "matze";
        repo = "wastebin.nvim";
        rev = "a3738da8a8e7b8e9f575677399e9e88f109bbc51";
        hash = "sha256-K40M6QU7Q7UxCgi8YoibgfMrQiMMOvx8uqBJlmDR+TE=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/matze/wastebin.nvim";
        description = "";
      };
    };
    lazyclip = pkgs.vimUtils.buildVimPlugin {
      pname = "lazyclip";
      version = "2025-07-22"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "atiladefreitas";
        repo = "lazyclip";
        rev = "ca1f9b747a98d7ed6a02ad7a24d186b1d82300c5";
        hash = "sha256-SGcQVlQmxSGjQcJD7ugqTmtGawUIjLxb3coI1NcbOV8=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/atiladefreitas/lazyclip";
        description = "";
      };
    };
    beam = pkgs.vimUtils.buildVimPlugin {
      pname = "beam";
      version = "2026-03-27"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "Piotr1215";
        repo = "beam.nvim";
        rev = "2a2e64da684974c1a479b9b3c76e5227e5f6fe2c";
        hash = "sha256-WlV2Iodnyy4+6BfNUCq/8gZGQ7B/Tkvpb4HxvZm7EL8=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/Piotr1215/beam.nvim";
        description = "";
      };
    };
    ax = pkgs.vimUtils.buildVimPlugin {
      pname = "ax";
      version = "2025-02-06"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "mikeslattery";
        repo = "ax.nvim";
        rev = "f9ed1a62197ade90a3bf3f02b518d6f70c067690";
        hash = "sha256-EU+Eq7Wyw2WfWEuKmf+qC9/eCiuG6NtdYuC8eygDS5Y=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/mikeslattery/ax.nvim";
        description = "";
      };
    };
    advanced_new_file = pkgs.vimUtils.buildVimPlugin {
      pname = "AdvancedNewFile";
      version = "2022-07-31"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "Mohammed-Taher";
        repo = "AdvancedNewFile.nvim";
        rev = "9b4576dcf916d848148241e7269c9cd78f299b22";
        hash = "sha256-vnJuHGaZs6rLirWPm6vkw7nYSrZmZpIMXqhoejrzpsw=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/Mohammed-Taher/AdvancedNewFile.nvim";
        description = "";
      };
    };
    # dotdot = pkgs.vimUtils.buildVimPlugin {
    #   pname = "dotdot";
    #   version = "2026-03-14"; # updated: 2026-06
    #   src = pkgs.fetchFromGitHub {
    #     owner = "yelircaasi";
    #     repo = "dotdot.nvim__mirror";
    #     rev = "92e268eb5ac89e48450076cab245e7a5947aeea2";
    #     hash = "";
    #   };
    #   doCheck = false;
    #   meta = {
    #     homepage = "https://codeberg.org/hernandez/dotdot.nvim";
    #     description = ".";
    #   };
    # };
    dotdot = pkgs.vimUtils.buildVimPlugin {
      pname = "dotdot";
      version = "2026-03-14"; # updated: 2026-06
      src = pkgs.fetchgit {
        url = "https://codeberg.org/hernandez/dotdot.nvim";
        rev = "515625fd04b855de57351a43b819fc1bbfd30be6";
        hash = "sha256-HlyViDLcUhNJu/ILh84ZGYJSfix4M+3QX2h/tIGedlM=";
      };
      doCheck = false;
      meta = {
        homepage = "https://codeberg.org/hernandez/dotdot.nvim";
        description = "dotdot.nvim lets you search for and execute commands with a press of .. (i.e. period period)";
      };
    };
    minimal-narrow-region = pkgs.vimUtils.buildVimPlugin {
      pname = "minimal-narrow-region";
      version = "2023-02-04"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "bagohart";
        repo = "minimal-narrow-region.nvim";
        rev = "43a46bec5afc37a96bddc08d1a0772dfa26986fb";
        hash = "sha256-ezjXTCN7H1WH6oXCI5vqvI6BO0WxXCdjc70nXi3B1DQ=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/bagohart/minimal-narrow-region.nvim";
        description = "";
      };
    };
    date-time-inserter = pkgs.vimUtils.buildVimPlugin {
      pname = "date-time-inserter";
      version = "2025-11-23"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "AntonVanAssche";
        repo = "date-time-inserter.nvim";
        rev = "2d37e1a7aa75f8b4c90cb38248b442f979fe5830";
        hash = "sha256-eTKKJ0ISPl8a0wLSXs87w8XHhp/kR8yR5iBFkyP9bBw=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/AntonVanAssche/date-time-inserter.nvim";
        description = "";
      };
    };
    Bullets = pkgs.vimUtils.buildVimPlugin {
      pname = "bullets";
      version = "2025-10-03"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "kaymmm";
        repo = "bullets.nvim";
        rev = "0163fac9c1e7a04cd14d22aa63fd04509cad6900";
        hash = "sha256-4PgtWovBL9b+wXHuczVBTT9Qt/3JKxOGMGzgnisKjAE=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/kaymmm/bullets.nvim";
        description = "";
      };
    };
    vim-caser = pkgs.vimUtils.buildVimPlugin {
      pname = "vim-caser";
      version = "2021-07-27"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "arthurxavierx";
        repo = "vim-caser";
        rev = "6bc9f41d170711c58e0157d882a5fe8c30f34bf6";
        hash = "sha256-PXAY01O/cHvAdWx3V/pyWFeiV5qJGvLcAKhl5DQc0Ps=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/arthurxavierx/vim-caser";
        description = "";
      };
    };
    inlayhint-filler = pkgs.vimUtils.buildVimPlugin {
      pname = "inlayhint-filler";
      version = "2025-11-22"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "davidyz";
        repo = "inlayhint-filler.nvim";
        rev = "4b2b8d0df39d1ad7aaa7c101e5c382333b5bde01";
        hash = "sha256-9oVbb7bw/0FTm0t+jv1beBcYAgQyjZDRC2wkVlVn14s=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/davidyz/inlayhint-filler.nvim";
        description = "";
      };
    };
    ivy = pkgs.vimUtils.buildVimPlugin {
      pname = "ivy";
      version = "2026-06-19"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "AdeAttwood";
        repo = "ivy.nvim";
        rev = "7d1caee66a9005bd6f521091bbe8a689a78f6503";
        hash = "sha256-DHjHIFOkts+1bI6Xa6Q0I4umQnYa+f8PHHysXcXdCS4=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/AdeAttwood/ivy.nvim";
        description = "";
      };
    };
    cmp-fonts = pkgs.vimUtils.buildVimPlugin {
      pname = "nvim-cmp-fonts";
      version = "2022-10-10"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "amarakon";
        repo = "nvim-cmp-fonts";
        rev = "43be83eb24ff8aec124c3aae64d053a095e03bd0";
        hash = "sha256-POZcP9ssbgQvMTfMbROx0krVa7ehucqTc45dSw+QQ4M=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/amarakon/nvim-cmp-fonts";
        description = "";
      };
    };
    cmp-lua-latex-symbols = pkgs.vimUtils.buildVimPlugin {
      pname = "nvim-cmp-lua-latex-symbols";
      version = "2023-09-23"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "amarakon";
        repo = "nvim-cmp-lua-latex-symbols";
        rev = "89345d6e333c700d13748e8a7ee6fe57279b7f88";
        hash = "sha256-LQvYIA7864gcV+mDASLrP/tyHCk4ut6ONqbmMjaGzxU=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/amarakon/nvim-cmp-lua-latex-symbols";
        description = "";
      };
    };
    cmp-nvim-telekasten-tags = pkgs.vimUtils.buildVimPlugin {
      pname = "cmp-nvim-telekasten-tags";
      version = "2023-10-04"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "Cybolic";
        repo = "cmp-nvim-telekasten-tags";
        rev = "ef3b84f609c8fc70999326e04a4771d2981f73c3";
        hash = "sha256-8ubH4cesSea2B90hx06MPSnTf8/J0CX2DSaLkDgTtB8=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/Cybolic/cmp-nvim-telekasten-tags";
        description = "";
      };
    };
    cmp_bulma = pkgs.vimUtils.buildVimPlugin {
      pname = "cmp_bulma";
      version = "2023-03-15"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "garyhurtz";
        repo = "cmp_bulma.nvim";
        rev = "40b6b1b06a0b4378fbf11ff2e60a334663ae77bd";
        hash = "sha256-W2MOiyi/PtEXnSaQD3UBpQM5wUoHQ/EhkT34MCS9t0g=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/garyhurtz/cmp_bulma.nvim";
        description = "";
      };
    };
    efm = pkgs.vimUtils.buildVimPlugin {
      # TODO: move to CLI utils
      pname = "efm";
      version = "2026-03-08"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "mattn";
        repo = "efm-langserver";
        rev = "9408c7e9db230bce9ba1d428b9cf80dc7693f082";
        hash = "sha256-M2I5UQYCkIVfINWEVa4tOt0Dtl4sBZoHP/q0ia/Bo2Y=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/mattn/efm-langserver";
        description = "";
      };
    };
    output_panel = pkgs.vimUtils.buildVimPlugin {
      pname = "output-panel";
      version = "2026-06-10"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "mhanberg";
        repo = "output-panel.nvim";
        rev = "82a0b1248cc581d5939486c4befefcfbdc8c3cf2";
        hash = "sha256-069TY2FPZ2/pElmj2uTk+Pjri3hFbldXxLMwMdSoi8Y=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/mhanberg/output-panel.nvim";
        description = "";
      };
    };
    control_panel = pkgs.vimUtils.buildVimPlugin {
      pname = "control-panel";
      version = "2023-05-12"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "mhanberg";
        repo = "control-panel.nvim";
        rev = "b074f8f05f9c83904375a3f697a3ec8034ee84b9";
        hash = "sha256-3wiWK7A30mS2kqvPj5HdDE4OlBBnQJHimKm3Rm/fYf4=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/mhanberg/control-panel.nvim";
        description = "";
      };
    };
    corn = pkgs.vimUtils.buildVimPlugin {
      pname = "corn";
      version = "2024-10-08"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "RaafatTurki";
        repo = "corn.nvim";
        rev = "5106eff0d02decb76e823ae2abb2f74113579100";
        hash = "sha256-wJZ9gduCuIPl+M9CEGCof3XjMvWMmRvOJWUAHh5t0QI=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/RaafatTurki/corn.nvim";
        description = "";
      };
    };
    error-jump = pkgs.vimUtils.buildVimPlugin {
      pname = "error-jump";
      version = "2024-10-05"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "Dr-42";
        repo = "error-jump.nvim";
        rev = "4469f48935948d599e09302f72836549fe223800";
        hash = "sha256-NblqedDkVhN/1jwUduQ2fHaTUZ1tBs83ROTCA6/zhjU=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/Dr-42/error-jump.nvim";
        description = "";
      };
    };
    doc-window = pkgs.vimUtils.buildVimPlugin {
      pname = "doc-window";
      version = "2023-08-30"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "resonyze";
        repo = "doc-window.nvim";
        rev = "c69e83d53e864fe1648dd6a8e9cc5d5c59c05e81";
        hash = "sha256-GY+83weLOaKbK8+W/HY1pVq4vCqWuHS3HdMmP7Q5kSc=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/resonyze/doc-window.nvim";
        description = "";
      };
    };
    telescope-code-actions = pkgs.vimUtils.buildVimPlugin {
      # archived
      pname = "telescope-code-actions";
      version = "2022-09-24"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "nyarthan";
        repo = "telescope-code-actions.nvim";
        rev = "44a0c56886fa18d3c905ae9506e782d6cce65700";
        hash = "sha256-e5zdk5mImtxEJ8+kVMK98I6BWP0zYktCxlPhpnTgFSo=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/nyarthan/telescope-code-actions.nvim";
        description = "";
      };
    };
    dmap = pkgs.vimUtils.buildVimPlugin {
      # archived
      pname = "dmap";
      version = "2024-09-14"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "doums";
        repo = "dmap.nvim";
        rev = "ceccbdf31742a8427f87bf52d1fc419483045887";
        hash = "sha256-zfC0l4ioJrFP8Nb8hw3W9xPcWtqCSdeMrV/MxWiqDtU=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/doums/dmap.nvim";
        description = "";
      };
    };
    nix-develop = pkgs.vimUtils.buildVimPlugin {
      pname = "nix-develop-nvim";
      version = "2026-01-29"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "figsoda";
        repo = "nix-develop.nvim";
        rev = "bfba63d6c129d8b5073fe9eb965c9acee04becb0";
        hash = "sha256-JZ1QnbQlP/G4CahzvIZYWGhUe0jH4S9TF4xl6fJu2bA=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/figsoda/nix-develop.nvim";
        description = "";
      };
    };
    debugpy = pkgs.vimUtils.buildVimPlugin {
      pname = "debugpy";
      version = "2024-07-23"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "HiPhish";
        repo = "debugpy.nvim";
        rev = "490a0d7bfa23af8c6096bb3fbd867770b7d4a28b";
        hash = "sha256-8G2mHoxzco4HZUygMJ3AeA1lkgH7kevd5sLgKYeGEWI=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/HiPhish/debugpy.nvim";
        description = "";
      };
    };
    pylsp-rope = pkgs.vimUtils.buildVimPlugin {
      pname = "TODO: move to external tools";
      version = "2024-11-17"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "python-rope";
        repo = "pylsp-rope";
        rev = "aa7f929e5f434b31b5d775bfb87a9883ac4c2cd0";
        hash = "sha256-gEmSZQZ2rtSljN8USsUiqsP2cr54k6kwvsz8cjam9dU=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/python-rope/pylsp-rope";
        description = "";
      };
    };
    jsonpath = pkgs.vimUtils.buildVimPlugin {
      pname = "jsonpath";
      version = "2025-09-22"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "phelipetls";
        repo = "jsonpath.nvim";
        rev = "9e7a3c2aec3465a8f7c86cec6424cf98ee62ee24";
        hash = "sha256-JrWyCNWyub4rWpCjve06iaIAgb87sFFoBiGK9gZrMDs=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/phelipetls/jsonpath.nvim";
        description = "";
      };
    };
    sortjson = pkgs.vimUtils.buildVimPlugin {
      pname = "sortjson";
      version = "2026-03-08"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "2nthony";
        repo = "sortjson.nvim";
        rev = "341e371e8c2b1f44b2129ad08da5efd6d7007c9f";
        hash = "sha256-HlbltOJ4W1Ctm+7Q3wDbb1ODBldMvDhLq3+wfD0KZao=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/2nthony/sortjson.nvim";
        description = "";
      };
    };
    mvim-quicktype = pkgs.vimUtils.buildVimPlugin {
      pname = "quicktype";
      version = "2025-05-10"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "midoBB";
        repo = "nvim-quicktype";
        rev = "6d557a32fec1fb8a0b635e98cb856b24c7f0ef00";
        hash = "sha256-6BUKuRZ+7cUYvXuP9WF760IID9O4x/hn7uOK5/iApgc=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/midoBB/nvim-quicktype";
        description = "";
      };
    };
    yaml_nvim = pkgs.vimUtils.buildVimPlugin {
      pname = "yaml";
      version = "2026-06-12"; # updated: 2026-06
      src = pkgs.fetchgit {
        url = "https://tangled.org/cuducos.me/yaml.nvim";
        rev = "554b2730f3785e53b74e8371d6e2b451caa1a8df";
        hash = "sha256-hLB1TzkWyrdjbrVL2lSOg47OnLw8EVyqSc01sTLWD80=";
      };
      doCheck = false;
      meta = {
        homepage = "https://tangled.org/cuducos.me/yaml.nvim";
        description = "";
      };
    };
    strict = pkgs.vimUtils.buildVimPlugin {
      pname = "strict";
      version = "2026-04-15"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "emileferreira";
        repo = "nvim-strict";
        rev = "e48dff45ced1eee2a7807a86cc22bd7bf10b8c8a";
        hash = "sha256-liO6j/KNw3zblR2BC55wDOXh0MpA5MSdz3LwHLZwSeU=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/emileferreira/nvim-strict";
        description = "";
      };
    };
    officer = pkgs.vimUtils.buildVimPlugin {
      pname = "officer";
      version = "2026-05-17"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "pianocomposer321";
        repo = "officer.nvim";
        rev = "8e811c1b7e144fa4aa7f7788814bf97fbbb806f8";
        hash = "sha256-MvMx86h+64Z3qWKddeB1Fzf1xENWIALUng8mWuN3ifI=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/pianocomposer321/officer.nvim";
        description = "";
      };
    };
    jaq-nvim = pkgs.vimUtils.buildVimPlugin {
      pname = "jaq-nvim";
      version = "2022-10-11"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "is0n";
        repo = "jaq-nvim";
        rev = "236296aae555657487d1bb4d066cbde9d79d8cd4";
        hash = "sha256-4bCjqURFMWpPXgZGlCUYd4JVZr0JFC/uRah/iX/anps=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/is0n/jaq-nvim";
        description = "";
      };
    };
    moonicipal = pkgs.vimUtils.buildVimPlugin {
      pname = "moonicipal";
      version = "2025-11-03"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "idanarye";
        repo = "nvim-moonicipal";
        rev = "9ebe72787be2a3339bdc91e1c3eafe58a389c0c9";
        hash = "sha256-l97wMM+Oo+wOV6jdGIyHpd+YxcUJkJ0YEQs0U4gfcrg=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/idanarye/nvim-moonicipal";
        description = "";
      };
    };
    telemake = pkgs.vimUtils.buildVimPlugin {
      pname = "telemake";
      version = "2023-01-16"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "ChSotiriou";
        repo = "nvim-telemake";
        rev = "8322ffb24ffef50503ff888c17593f630fadc527";
        hash = "sha256-VT1pxsm2Ikj1Ibrjy6lQ2PI3QxCwT2w9Q9D6C/JV7hU=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/ChSotiriou/nvim-telemake";
        description = "";
      };
    };
    equals = pkgs.vimUtils.buildVimPlugin {
      pname = "equals";
      version = "2022-11-23"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "liborw";
        repo = "equals";
        rev = "4dfc2f7f4d83a68e73218f3ac87efc902f16a479";
        hash = "sha256-Zc63xuAqAloLK6zdaMUzxt6LhzdmqRjQwU5JFKrFxmA=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/liborw/equals";
        description = "";
      };
    };
    telescope-xc = pkgs.vimUtils.buildVimPlugin {
      pname = "telescope-xc";
      version = "2023-11-27"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "joerdav";
        repo = "telescope-xc.nvim";
        rev = "1646d45c933cd29528b9f0ea74e676cc257c6b12";
        hash = "sha256-zI81mF7miZTlbomelgwmpNfXz7ho8N9SwtiMKoCdtdM=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/joerdav/telescope-xc.nvim";
        description = "";
      };
    };
    resin = pkgs.vimUtils.buildVimPlugin {
      pname = "resin";
      version = "2023-02-01"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "fdschmidt93";
        repo = "resin.nvim";
        rev = "0929ab8813ebe8ce642604f8c6e2106e21330d38";
        hash = "sha256-3gE3TKTh8jr69OW2j45PIdNkbCw8YQhXCIjoQ7K6Q3E=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/fdschmidt93/resin.nvim";
        description = "";
      };
    };
    repl = pkgs.vimUtils.buildVimPlugin {
      pname = "repl";
      version = "2025-05-05"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "pappasam";
        repo = "nvim-repl";
        rev = "b2dc92607fd6d1833b9c2bd916eeedcb04cad7de";
        hash = "sha256-S19JUbE9mX93lbh5Co/Vd196kk+APR6zheIaHq6WdMU=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/pappasam/nvim-repl";
        description = "";
      };
    };
    yarepl = pkgs.vimUtils.buildVimPlugin {
      pname = "yarepl";
      version = "2026-05-13"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "milanglacier";
        repo = "yarepl.nvim";
        rev = "f6f07e7e593091364d8bef8a0d2eba68fadbe5b4";
        hash = "sha256-oIbtGYIOa8c0wxrUw7N9XirtkXA24ARBCvlkqd3A9XY=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/milanglacier/yarepl.nvim";
        description = "sha256-ho2b2Ulh+GTqY0QvW7zjFOSlF5g/kaxWyOjKWhTFq7c=";
      };
    };
    channelot = pkgs.vimUtils.buildVimPlugin {
      pname = "channelot";
      version = "2025-10-26"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "idanarye";
        repo = "nvim-channelot";
        rev = "80259020d16730266b7173eac1f38aea66b706c2";
        hash = "sha256-Io3XUFL44uXMEavZzeNQvO07k2+J5u/KQkNqp2PBOrc=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/idanarye/nvim-channelot";
        description = "";
      };
    };
    cmdbuf = pkgs.vimUtils.buildVimPlugin {
      pname = "cmdbuf";
      version = "2026-06-14"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "notomo";
        repo = "cmdbuf.nvim";
        rev = "78e744f13bc4003f2caa88b905cb2e5d63bc3ecc";
        hash = "sha256-AkjDC6YwMZ5UXIweEbMA7u6OH3zYqJqCq/+/E9j7gdg=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/notomo/cmdbuf.nvim";
        description = "";
      };
    };
    mypy = pkgs.vimUtils.buildVimPlugin {
      pname = "mypy";
      version = "2026-05-30"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "feakuru";
        repo = "mypy.nvim";
        rev = "7c21900112782559d82ed17f11e43d75e871d079";
        hash = "sha256-xMXY/4pb+MgdOh+XTtJSqLyCHLHjZWhVUoxY0vOQebA=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/feakuru/mypy.nvim";
        description = "";
      };
    };
    Launch = pkgs.vimUtils.buildVimPlugin {
      pname = "Launch";
      version = "2025-05-29"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "Beloin";
        repo = "Launch.nvim";
        rev = "93535ba3d243880ac3d9bf62c5b4e2297c775def";
        hash = "sha256-51PuTfUwlf2Ogg5UA0VHF+X8TVB/WJ0WMLkCp4NbtRk=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/Beloin/Launch.nvim";
        description = "";
      };
    };
    tracebundler = pkgs.vimUtils.buildVimPlugin {
      pname = "tracebundler";
      version = "2024-10-21"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "notomo";
        repo = "tracebundler.nvim";
        rev = "d5cf812d20ef4291c4f858cccc0d38cb4d0439fe";
        hash = "sha256-rdNHD/1DLNIiD1TQnwL5OiikAH+gdtSln72QtX+AS1s=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/notomo/tracebundler.nvim";
        description = "";
      };
    };
    termim = pkgs.vimUtils.buildVimPlugin {
      pname = "termim";
      version = "2025-12-01"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "2KAbhishek";
        repo = "termim.nvim";
        rev = "0bb39e30d2a1c05448f8eaeb9f5a09c742370490";
        hash = "sha256-H7zL/JIzYwwewZfnZqmbNWi1iAYhIJZB4RC6nZuXqQc=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/2KAbhishek/termim.nvim";
        description = "";
      };
    };
    neaterm = pkgs.vimUtils.buildVimPlugin {
      pname = "neaterm";
      version = "2025-07-25"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "Dan7h3x";
        repo = "neaterm.nvim";
        rev = "274fd715e2f7dbb29500e940fe217fbac20c89a9";
        hash = "sha256-lECpTfWb2xrym9bqoVXnwdsKSl3ICJ9qad1tuj+uDVI=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/Dan7h3x/neaterm.nvim";
        description = "";
      };
    };
    neomux = pkgs.vimUtils.buildVimPlugin {
      pname = "neomux";
      version = "2026-03-17"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "nikvdp";
        repo = "neomux";
        rev = "e5950a14275062dfe21f489bf84165fd69220e4c";
        hash = "sha256-+C/nVZ0cIKqmuCzyfWUSzwWPlHLMNeyEcsJlzan0M9Y=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/nikvdp/neomux";
        description = "";
      };
    };
    project_nvim = pkgs.vimUtils.buildVimPlugin {
      pname = "project_nvim";
      version = "2024-05-26"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "Zeioth";
        repo = "project.nvim";
        rev = "9cc719f455295e7a2fc7340d4fd87327f3fe15ca";
        hash = "sha256-1hHT4mmrTnvLyBL2TAzl7cCYqvRPF6PoQUbOez6JjoI=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/Zeioth/project.nvim";
        description = "";
      };
    };
    nvim-monorepos = pkgs.vimUtils.buildVimPlugin {
      pname = "monorepos";
      version = "2025-08-14"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "sajjathossain";
        repo = "nvim-monorepos";
        rev = "fdfb5c65faad6fb38581037521cf1b69f326aa28";
        hash = "sha256-Sv3T++GRtqG6pByEFhpaqRrQnEt3K9CiI1X3o7S70dc=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/sajjathossain/nvim-monorepos";
        description = "";
      };
    };
    projector = pkgs.vimUtils.buildVimPlugin {
      pname = "projector";
      version = "2022-07-28"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "smolovk";
        repo = "projector.nvim";
        rev = "63094c395fe00559772796c4281993955f7d2024";
        hash = "sha256-RP5pXOq/7PSK03GoS37bW3xLMBIqgu3O9mk3HZg3cnI=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/smolovk/projector.nvim";
        description = "";
      };
    };
    forgit = pkgs.vimUtils.buildVimPlugin {
      pname = "forgit";
      version = "2025-04-23"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "ray-x";
        repo = "forgit.nvim";
        rev = "d499a9cd433c0d64feb8e01b91f70d4695c671c6";
        hash = "sha256-Nhey+umLf3EK4DHEenGnECVD1+FkOL1Oj4DvFTAXTRM=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/ray-x/forgit.nvim";
        description = "";
      };
    };
    jujutsu-nvim = pkgs.vimUtils.buildVimPlugin {
      pname = "jujutsu";
      version = "2026-05-14"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "yannvanhalewyn";
        repo = "jujutsu.nvim";
        rev = "17ab008d71cbcd31f8c2891e11cb758579f597c0";
        hash = "sha256-KygJ73YZNPtTfECWyrwK86AfO7jXDEfIMFia3yvorM0=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/yannvanhalewyn/jujutsu.nvim";
        description = "";
      };
    };
    jiejie = pkgs.vimUtils.buildVimPlugin {
      pname = "jiejie";
      version = "2026-06-13"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "jceb";
        repo = "jiejie.nvim";
        rev = "e79982899358a15b535dcc901a61b331ebb3e922";
        hash = "sha256-SRpSCrCbszsSmuWSDfgjwIvj7H0GHqs7vQm56bOwP7o=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/jceb/jiejie.nvim";
        description = "";
      };
    };
    worktrees = pkgs.vimUtils.buildVimPlugin {
      pname = "worktrees.nvim";
      version = "2026-04-11"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "Juksuu";
        repo = "worktrees.nvim";
        rev = "9682494e33b375feccf93412adf807eb15f36c1e";
        hash = "sha256-iz8jHbe8+tw2ORlga9kFqfJgTwPoKhhkRPf0ms0f/6w=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/Juksuu/worktrees.nvim";
        description = "Git worktree wrapper for neovim";
      };
    };
    gitlab-nvim = pkgs.vimUtils.buildVimPlugin {
      pname = "gitlab-nvim";
      version = "2026-06-09"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "harrisoncramer";
        repo = "gitlab.nvim";
        rev = "2295d1e85c5e4d79c49cadda36b9848a3ffed4e2";
        hash = "sha256-J2yljPEWjFQf5XOm1VwlZSqvVhP4VO/k9nrzdmXEMG0=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/harrisoncramer/gitlab.nvim";
        description = "";
      };
    };
    octohub = pkgs.vimUtils.buildVimPlugin {
      pname = "octohub";
      version = "2025-08-09"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "2KAbhishek";
        repo = "octohub.nvim";
        rev = "03b50d28a61583387616c04ba08cee53379049b2";
        hash = "sha256-LSWRZF++SwMiBWprTa+i6lJ3MhLYvUU9rv+k7wewSkk=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/2KAbhishek/octohub.nvim";
        description = "";
      };
    };
    dashboard = pkgs.vimUtils.buildVimPlugin {
      pname = "dashboard";
      version = "2026-04-05"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "MeanderingProgrammer";
        repo = "dashboard.nvim";
        rev = "3ad1490962e69372190ded855988ad7a0cc6a0c6";
        hash = "sha256-4w8iuW1HEvacVW2IWiKt14gp5rmFzS3fpSkwEkrZ5Ak=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/MeanderingProgrammer/dashboard.nvim";
        description = "";
      };
    };
    modes = pkgs.vimUtils.buildVimPlugin {
      pname = "modes";
      version = "2026-03-16"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "mvllow";
        repo = "modes.nvim";
        rev = "2badf8771dbb2d1e1066fd6a5dddaad2fc836e72";
        hash = "sha256-Oj6l0lJegIe3rhM4Y7co3JAzQCRC1ryOruhDR1k3giY=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/mvllow/modes.nvim";
        description = "";
      };
    };
    lvim-ui-config = pkgs.vimUtils.buildVimPlugin {
      pname = "lvim-ui-config";
      version = "2024-12-26"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "lvim-tech";
        repo = "lvim-ui-config";
        rev = "56ec5a05408045b62f5fd59d94ca34223450cf57";
        hash = "sha256-m8MTj4Wg+R1B5nJMtgAu9J6n6hXVxNKHgI92mEL68gA=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/lvim-tech/lvim-ui-config";
        description = "";
      };
    };
    bye-nerdfont = pkgs.vimUtils.buildVimPlugin {
      pname = "bye-nerdfont";
      version = "2023-07-24"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "dullmode";
        repo = "bye-nerdfont.nvim";
        rev = "2c7951e404250f6bc98e625a3920a9a3d0432f11";
        hash = "sha256-RaHdyx9GIQfK5PtA65UNnKKdNfx4p/Dx85Zadv5lBgk=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/dullmode/bye-nerdfont.nvim";
        description = "";
      };
    };
    reactive = pkgs.vimUtils.buildVimPlugin {
      pname = "reactive";
      version = "2025-12-30"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "rasulomaroff";
        repo = "reactive.nvim";
        rev = "0588b5c2b0cf49bd2232fe4366b3516c32edee44";
        hash = "sha256-F2H1hH4MxNUFMKDtkrTbF8PwZW6SzXsbQidVWX/2N+M=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/rasulomaroff/reactive.nvim";
        description = "";
      };
    };
    fsplash = pkgs.vimUtils.buildVimPlugin {
      pname = "fsplash";
      version = "2023-05-26"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "jovanlanik";
        repo = "fsplash.nvim";
        rev = "efd4565bbeb526a93c9cb25c24bd8123e1af63ee";
        hash = "sha256-OzBra/eBRfpx19+WRBBsm5PspZHrfFL7g+C8bxP3+Nc=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/jovanlanik/fsplash.nvim";
        description = "";
      };
    };
    sunglasses = pkgs.vimUtils.buildVimPlugin {
      pname = "sunglasses";
      version = "2025-01-13"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "miversen33";
        repo = "sunglasses.nvim";
        rev = "1e4c4ea4d6b46124090df1d35426a705cb3b99cf";
        hash = "sha256-opkdp6kGGQa2BY/zPhDgrnk0nVMDCJXk79U5Pi7Dnh8=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/miversen33/sunglasses.nvim";
        description = "";
      };
    };
    runtimetable = pkgs.vimUtils.buildVimPlugin {
      pname = "runtimetable";
      version = "2026-06-18"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "notomo";
        repo = "runtimetable.nvim";
        rev = "1687a9d6e4f2ce6f034fb138e3620a13b0f85efc";
        hash = "sha256-gYd23f8vIvvggbXtdyqoqfqDsCvNugeYVGwg+gFw8eU=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/notomo/runtimetable.nvim";
        description = "";
      };
    };
    web-tools = pkgs.vimUtils.buildVimPlugin {
      pname = "web-tools";
      version = "2025-03-14"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "ray-x";
        repo = "web-tools.nvim";
        rev = "2f895049d3b6e3a0b2cedfa18c8733b36fb6cbda";
        hash = "sha256-KJk0OmdkywjUu6mofBq4NYpLofHe7bv/LJXg8MFme/g=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/ray-x/web-tools.nvim";
        description = "";
      };
    };
    Calendar = pkgs.vimUtils.buildVimPlugin {
      pname = "Calendar";
      version = "2025-05-13"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "ds1sqe";
        repo = "Calendar.nvim";
        rev = "d89b3ba88c27d66ff8af410ea65975b94ce55f59";
        hash = "sha256-5N0S2esCETOEfSbdvBE09JDByy1p9BfJ1qG0ghmRGl0=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/ds1sqe/Calendar.nvim";
        description = "";
      };
    };
    http-codes = pkgs.vimUtils.buildVimPlugin {
      pname = "http-codes";
      version = "2026-03-20"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "barrettruth";
        repo = "http-codes.nvim";
        rev = "f5481146cd7c8bc381b5a1b23ab73f5e93649566";
        hash = "sha256-ZYNv/oa5q/3In56JSPiRkO4uyijqC2f+x40ABy37gPk=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/barrettruth/http-codes.nvim";
        description = "";
      };
    };
    auto-pandoc = pkgs.vimUtils.buildVimPlugin {
      pname = "auto-pandoc";
      version = "2025-08-31"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "jghauser";
        repo = "auto-pandoc.nvim";
        rev = "1e28cbb1de644be466a36a009c6fd3b7950cacf7";
        hash = "sha256-dWspHPlYZ6viZhy7G8LrGy2f3znrcXM6RZzhF/qqoMM=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/jghauser/auto-pandoc.nvim";
        description = "";
      };
    };
    vale = pkgs.vimUtils.buildVimPlugin {
      pname = "vale";
      version = "2024-05-07"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "marcelofern";
        repo = "vale.nvim";
        rev = "4ca34a6355f8b422fc717d5a5cc41f0438a2b05e";
        hash = "sha256-L8Uj/iAsof8RZlqdud5zJYtGUmOT+jUUcSd89Ab5Qn0=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/marcelofern/vale.nvim";
        description = "";
      };
    };
    present = pkgs.vimUtils.buildVimPlugin {
      pname = "present";
      version = "2025-03-03"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "Chaitanyabsprip";
        repo = "present.nvim";
        rev = "c76e6996b346ff3ec6260c2461e56946c4a72d0d";
        hash = "sha256-EPQlVv4zn3LNgYu58xpp3OlLrFOW+VuRgiP0YzO6REw=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/Chaitanyabsprip/present.nvim";
        description = "";
      };
    };
    flashcards = pkgs.vimUtils.buildVimPlugin {
      pname = "flashcards";
      version = "2022-09-25"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "alex-laycalvert";
        repo = "flashcards.nvim";
        rev = "5b99cd63415625f04056602a14176755028520ff";
        hash = "sha256-eGXXnQS0VjDxXHQ7lCeu6ll4R+XZgp5TFgY1Sg5uTa0=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/alex-laycalvert/flashcards.nvim";
        description = "";
      };
    };
    nvim-license = pkgs.vimUtils.buildVimPlugin {
      pname = "license";
      version = "2023-05-13"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "KronsyC";
        repo = "nvim-license";
        rev = "adc45e665f6ffd52c6eb9450e29b86dce6f8936c";
        hash = "sha256-18K5iw32tJvCBYA1oN96D21QFvmSBRbS8dsGgId2Oz8=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/KronsyC/nvim-license";
        description = "";
      };
    };
    live-server = pkgs.vimUtils.buildVimPlugin {
      pname = "live-server";
      version = "2026-05-09"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "barrett-ruth";
        repo = "live-server.nvim";
        rev = "f1a2defb7bc3bfc37bcb455fafdf6d61113d71c8";
        hash = "sha256-FcZQiHmW2tqXz+RNkZemsyXpFWgXNziQzVloV6A77Ks=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/barrett-ruth/live-server.nvim";
        description = "";
      };
    };
    nvmm = pkgs.vimUtils.buildVimPlugin {
      pname = "nvim-mail-merge";
      version = "2025-05-07"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "martineausimon";
        repo = "nvim-mail-merge";
        rev = "45445e1c95cb644eaf3c200fc335ad52521deaf1";
        hash = "sha256-yp2LuvUW9t++gWWy8GnGkn3vPotfjpugogbw4qZr8IY=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/martineausimon/nvim-mail-merge";
        description = "";
      };
    };
    better-digraphs = pkgs.vimUtils.buildVimPlugin {
      pname = "better-digraphs";
      version = "2024-11-16"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "protex";
        repo = "better-digraphs.nvim";
        rev = "c895f619cbd2e23860285baea6d2933649a28b26";
        hash = "sha256-ckyoWDrvwMdCzbrGMiFXWR0wkKz03GlV6XStI7qYe04=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/protex/better-digraphs.nvim";
        description = "";
      };
    };
    qalc = pkgs.vimUtils.buildVimPlugin {
      pname = "qalc";
      version = "2026-01-29"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "Apeiros-46B";
        repo = "qalc.nvim";
        rev = "33198ba0533d6a514f9a48cb472e40407c2ea9f6";
        hash = "sha256-E1fUczmZ7B852OHxdPz7U0Zdhvl/qihp0cXZv/5HHts=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/Apeiros-46B/qalc.nvim";
        description = "";
      };
    };
    tldr = pkgs.vimUtils.buildVimPlugin {
      pname = "tldr";
      version = "2026-05-01"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "acuteenvy";
        repo = "tldr.nvim";
        rev = "1dc4239ff6f9e6f2817d112bfb8b456e9c863886";
        hash = "sha256-3HXLH959AGjVLorKDUoXxFsxUD1qlVgXz9AmyAK25dA=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/acuteenvy/tldr.nvim";
        description = "";
      };
    };
    precommit = pkgs.vimUtils.buildVimPlugin {
      pname = "pre-commit";
      version = "2025-09-08"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "Ttibsi";
        repo = "pre-commit.nvim";
        rev = "5e60fc6f534845782891738f78b76c81be6c4187";
        hash = "sha256-01jofB8cfLqU6sTs+ljbRqpHDSuMeA02F6CStwU9h5g=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/Ttibsi/pre-commit.nvim";
        description = "";
      };
    };
    api-browser = pkgs.vimUtils.buildVimPlugin {
      pname = "endpoint-previewer";
      version = "2023-12-21"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "tlj";
        repo = "endpoint-previewer.nvim";
        rev = "58468e609eea671fd48501910826edf35341502f";
        hash = "sha256-qTGTsoc9XOR6miApfzEGFlmGtELASKe3X1YMA2yfQeQ=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/tlj/endpoint-previewer.nvim";
        description = "";
      };
    };
    feed = pkgs.vimUtils.buildVimPlugin {
      pname = "feed";
      version = "2026-04-01"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "neo451";
        repo = "feed.nvim";
        rev = "4e0903343c47b13aa5355ed267dbd58300bff8be";
        hash = "sha256-pJYr1h7+0Exl0a5DYLeIAjBzOo5KbxxLtMqwDNc+GUg=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/neo451/feed.nvim";
        description = "";
      };
    };
    nerdy = pkgs.vimUtils.buildVimPlugin {
      pname = "nerdy";
      version = "2026-05-26"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "2KAbhishek";
        repo = "nerdy.nvim";
        rev = "8fd18f0075c480b4e0865464dcd4fb7a42c6889e";
        hash = "sha256-huI2IhQeCnwoRLUviZA82p/1zmSqcCnSg/vMZQhh6Qg=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/2KAbhishek/nerdy.nvim";
        description = "";
      };
    };
    interlaced = pkgs.vimUtils.buildVimPlugin {
      pname = "interlaced";
      version = "2026-04-30"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "tanloong";
        repo = "interlaced.nvim";
        rev = "3d05e32f6f0edf9084cee88509850576b464ce3d";
        hash = "sha256-exZRXti2dnkqdi035yfM9aq6wxrIjZ4R0uhsZ4lKiIA=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/tanloong/interlaced.nvim";
        description = "";
      };
    };
    texmagic = pkgs.vimUtils.buildVimPlugin {
      pname = "texmagic";
      version = "2026-03-02"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "jakewvincent";
        repo = "texmagic.nvim";
        rev = "8172d2d974b444dcc996d87a9e05723348676d5e";
        hash = "sha256-6KY+AIQB9OpSDO5MA6+deir++OT9rCj2SpUaZej+zeg=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/jakewvincent/texmagic.nvim";
        description = "";
      };
    };
    drop = pkgs.vimUtils.buildVimPlugin {
      pname = "drop";
      version = "2025-10-28"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "folke";
        repo = "drop.nvim";
        rev = "f27c147af59c41712dd3d513cb03f4fae7aec46d";
        hash = "sha256-rIOivAUJ328nWnckCnwv+pNdxZUmBZJterxh1kjXm70=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/folke/drop.nvim";
        description = "";
      };
    };
    regex-vars = pkgs.vimUtils.buildVimPlugin {
      pname = "regex-vars";
      version = "2025-03-31"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "jake-stewart";
        repo = "regex-vars.nvim";
        rev = "4e64d37078afae68e8e6c0a263fb3aa10e5da311";
        hash = "sha256-4/B0mAjyxAMVnu4qzVO7caMvFava8xjM3Eu5jwgKJGo=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/jake-stewart/regex-vars.nvim";
        description = "";
      };
    };
    regexplainer = pkgs.vimUtils.buildVimPlugin {
      pname = "regexplainer";
      version = "2026-04-14"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "bennypowers";
        repo = "nvim-regexplainer";
        rev = "5524915648a545e331b2fa7a3c80d32f0c14e8bd";
        hash = "sha256-nfTbQtovqdnPZbttics6+yPUtKV6aMkyP3vqGWk1vSU=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/bennypowers/nvim-regexplainer";
        description = "";
      };
    };
    hypersonic = pkgs.vimUtils.buildVimPlugin {
      pname = "Hypersonic";
      version = "2024-08-11"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "tomiis4";
        repo = "Hypersonic.nvim";
        rev = "734dfbfbe51952f102a9b439d53d4267bb0024cd";
        hash = "sha256-V9dBAadK4tx+M+adWxKZ+7t6wKdA0ojIgBd+sNysZJ8=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/tomiis4/Hypersonic.nvim";
        description = "";
      };
    };
    structlog = pkgs.vimUtils.buildVimPlugin {
      pname = "structlog";
      version = "2023-01-08"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "Tastyep";
        repo = "structlog.nvim";
        rev = "45b26a2b1036bb93c0e83f4225e85ab3cee8f476";
        hash = "sha256-Bq4YNpLQ1+iSBuN5MG4OBmI5r3DGWyDou4kRCMnked0=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/Tastyep/structlog.nvim";
        description = "";
      };
    };
    color-picker = pkgs.vimUtils.buildVimPlugin {
      # archived -> vendor?
      pname = "color-picker";
      version = "2023-05-21"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "ziontee113";
        repo = "color-picker.nvim";
        rev = "06cb5f853535dea529a523e9a0e8884cdf9eba4d";
        hash = "sha256-a1hpKKvBG8ey/+gbfFEK8CPawEK9EdcQbnIfi7X0C9I=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/ziontee113/color-picker.nvim";
        description = "";
      };
    };
    export-colorscheme = pkgs.vimUtils.buildVimPlugin {
      pname = "export-colorscheme";
      version = "2023-01-17"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "jpe90";
        repo = "export-colorscheme.nvim";
        rev = "805bc285c9ba0e6da5c7c08fc89734f19d72e473";
        hash = "sha256-oJMJbCyT3yMqMRP3XaHNyJVuTTwHSafedXBO92kQ5h0=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/jpe90/export-colorscheme.nvim";
        description = "";
      };
    };
    kreative = pkgs.vimUtils.buildVimPlugin {
      # fennel
      pname = "kreative";
      version = "2022-12-10"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "katawful";
        repo = "kreative";
        rev = "75d29935e90cb5c138c296d47b4043eb931cc32c";
        hash = "sha256-LoI+D+3nIh9QefH5BmmkgR8X4FVVlTMLkIhGvA5w7ow=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/katawful/kreative";
        description = "";
      };
    };
    text-to-colorscheme = pkgs.vimUtils.buildVimPlugin {
      pname = "text-to-colorscheme";
      version = "2024-08-14"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "svermeulen";
        repo = "text-to-colorscheme";
        rev = "f5fcd3df60dac59fb3f7686e8524297b005c7405";
        hash = "sha256-o349064drCRxiTcrpYMyDxOyxIpRalePWnNo4+f3OiE=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/svermeulen/text-to-colorscheme";
        description = "";
      };
    };
    easycolor = pkgs.vimUtils.buildVimPlugin {
      pname = "easycolor";
      version = "2025-03-15"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "vi013t";
        repo = "easycolor.nvim";
        rev = "907b54a77a0f996c66bc2d5888eee891a4019a99";
        hash = "sha256-uCgAb4KUbk3HyC/9a2OszBN0Mse8fcS6oC+6uJ56kjs=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/vi013t/easycolor.nvim";
        description = "";
      };
    };
    paint = pkgs.vimUtils.buildVimPlugin {
      pname = "paint";
      version = "2025-10-28"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "folke";
        repo = "paint.nvim";
        rev = "07ffa7e0e41f8d5b4ee7aa1531a33812db7595ac";
        hash = "sha256-sgplMZvnTN+UZPwkoAdHbsuiyQQdN1XbgXrnkdSqR0g=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/folke/paint.nvim";
        description = "";
      };
    };
    kubels = pkgs.vimUtils.buildVimPlugin {
      pname = "kubels";
      version = "2023-10-04"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "elasticrash";
        repo = "kubels.nvim";
        rev = "e1126031d9580d6567e3feb9b1e17bef8778cdd5";
        hash = "sha256-4rjFuQZfRS0SBIlR1kKSMw5v9+qlo3DRcgwTa4KOmLY=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/elasticrash/kubels.nvim";
        description = "";
      };
    };
    kubernetes = pkgs.vimUtils.buildVimPlugin {
      pname = "kubernetes";
      version = "2025-05-29"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "diogo464";
        repo = "kubernetes.nvim";
        rev = "44daf998345628a1a7034e3aaa31f4e05e4dde7c";
        hash = "sha256-zq8raDCY6uKf97esbQGNvPAMqi2LzIVt5lRlb53/5PU=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/diogo464/kubernetes.nvim";
        description = "";
      };
    };
    kpops = pkgs.vimUtils.buildVimPlugin {
      pname = "kpops";
      version = "2025-11-20"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "disrupted";
        repo = "kpops.nvim";
        rev = "5b154cb540317db2ee7c63b2f2ace8fa3170f0e6";
        hash = "sha256-Ui/ffZjpyDG6hTmr93fhrtwi3brW9aKMk1d154bNSQ8=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/disrupted/kpops.nvim";
        description = "";
      };
    };
    k8vim = pkgs.vimUtils.buildVimPlugin {
      pname = "k8vim";
      version = "2023-11-28"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "alonso-montero";
        repo = "k8vim.nvim";
        rev = "0bd48d39640bd66b3cee2b53425b6924759afe0d";
        hash = "sha256-c+8y4K4Bz1MD0Kas2hlcxpryAMQ4IEIj6uUQqpee6+A=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/alonso-montero/k8vim.nvim";
        description = "";
      };
    };
    kubectl = pkgs.vimUtils.buildVimPlugin {
      pname = "kubectl";
      version = "2026-06-18"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "Ramilito";
        repo = "kubectl.nvim";
        rev = "442aab0f28aa1860ab58925fd72d2b27e771fc2e";
        hash = "sha256-fswG4skvc0ynEMYXTfsodELGdp95lwC9NFW4tHSfvbQ=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/Ramilito/kubectl.nvim";
        description = "";
      };
    };
    vim-ai = pkgs.vimUtils.buildVimPlugin {
      pname = "vim-ai";
      version = "2026-03-11"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "madox2";
        repo = "vim-ai";
        rev = "f46c2343a7d81c74ab249214ed9d0a9c6edac07f";
        hash = "sha256-tMXlrZRv7B94TwE7YkNqxYDRWQUFdMNvHa6vle95EsE=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/madox2/vim-ai";
        description = "";
      };
    };
    metrics = pkgs.vimUtils.buildVimPlugin {
      pname = "metrics";
      version = "2023-07-25"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "mgerb";
        repo = "metrics.nvim";
        rev = "763a277b86a6e0e2bc86d0425761c1eeb55f48f8";
        hash = "sha256-kpHB5lAPQFFP9VWDDyG1CO/jVdeI1l8ADnfzWP8Bl1A=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/mgerb/metrics.nvim";
        description = "";
      };
    };
    orgmode = pkgs.vimUtils.buildVimPlugin {
      pname = "orgmode";
      version = "2026-06-18"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "nvim-orgmode";
        repo = "orgmode";
        rev = "f5485be9a4301ab535f99f2dc30601c47305dde7";
        hash = "sha256-PbvmqFjY4ycmwb+byntZ/3N4NRMK1pok/4JSFhYEBM0=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/nvim-orgmode/orgmode";
        description = "";
      };
    };
    twig = pkgs.vimUtils.buildVimPlugin {
      pname = "twig";
      version = "2023-12-04"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "hugginsio";
        repo = "twig.nvim";
        rev = "09b57e888c61f5b2c479bf8e0689f1343d2ba5e9";
        hash = "sha256-+gJ0IoBZDS0+MtU6X+35oyaMPZGioOUefPvGVRanyrY=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/hugginsio/twig.nvim";
        description = "";
      };
    };
    neorg-taskwarrior = pkgs.vimUtils.buildVimPlugin {
      pname = "neorg-taskwarrior";
      version = "2022-09-11"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "skbolton";
        repo = "neorg-taskwarrior";
        rev = "d2d57a8d3b8b7a19093850ecdf59c1fac179eb2e";
        hash = "sha256-ErXSHvwGnAp0sSJl9O0Sz7I7rLW1MCTkswe7EiaR414=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/skbolton/neorg-taskwarrior";
        description = "";
      };
    };
    doing = pkgs.vimUtils.buildVimPlugin {
      pname = "doing-nvim";
      version = "2026-01-19"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "Hashino";
        repo = "doing.nvim";
        rev = "83a0b110d9b6655172695238e066e2e513e78aaf";
        hash = "sha256-r3fZnGP3MqIMondJAsq6IskGWT5581/5HuH67rOeTCU=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/Hashino/doing.nvim";
        description = "";
      };
    };
    daily-focus = pkgs.vimUtils.buildVimPlugin {
      pname = "daily-focus";
      version = "2023-12-25"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "steveclarke";
        repo = "daily-focus.nvim";
        rev = "480f709f859d0c19610d6eaf7d836e1c1e84105c";
        hash = "sha256-rrYdHpXyoa70N2fgN1QXp6EB3klOkHIqHe+vCnQ6Yko=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/steveclarke/daily-focus.nvim";
        description = "";
      };
    };
    nomodoro = pkgs.vimUtils.buildVimPlugin {
      pname = "nomodoro";
      version = "2024-06-02"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "dbinagi";
        repo = "nomodoro";
        rev = "35076f96ea21fecc6202162304891338c8eebe3c";
        hash = "sha256-7sV8lKppllj56WKCgDbrt/yO4IBwNgn4uz5kSk8VTcg=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/dbinagi/nomodoro";
        description = "";
      };
    };
    pommodoro-clock = pkgs.vimUtils.buildVimPlugin {
      pname = "pommodoro-clock";
      version = "2023-01-23"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "jackMort";
        repo = "pommodoro-clock.nvim";
        rev = "eb7a59109c82917ba1c386f730ecdb9ef778b8a5";
        hash = "sha256-4AGs/gFItFINUArJ/iuj02jaVYSOuGH+yy/+pESs2W4=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/jackMort/pommodoro-clock.nvim";
        description = "";
      };
    };
    timew = pkgs.vimUtils.buildVimPlugin {
      pname = "timew";
      version = "2024-02-21"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "eliasCVII";
        repo = "timew.nvim";
        rev = "139c72ac853d43cbbfdb04b60cd41c8940f33439";
        hash = "sha256-HU6T4i5/bAsHmq5m8Zt9GETTIh9tiSJvDUlQt9yUrpA=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/eliasCVII/timew.nvim";
        description = "";
      };
    };
    pomodoro = pkgs.vimUtils.buildVimPlugin {
      pname = "pomodoro";
      version = "2024-04-29"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "wthollingsworth";
        repo = "pomodoro.nvim";
        rev = "04ea4152b1e1d0a42ac95f9f527a7cd9adec59f2";
        hash = "sha256-/+h6wH+kR9Kb+wSb9yAh0gPQK9nNm1OAAc4vsJhY4hQ=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/wthollingsworth/pomodoro.nvim";
        description = "";
      };
    };
    tdo = pkgs.vimUtils.buildVimPlugin {
      pname = "tdo";
      version = "2025-11-20"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "2KAbhishek";
        repo = "tdo.nvim";
        rev = "3e067afe8687517e205588dacf818648a163a5a4";
        hash = "sha256-Fpa0/WXAoel/w+sDBinniAMArcRcVYH3aF+Dy8sCbVU=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/2KAbhishek/tdo.nvim";
        description = "";
      };
    };
    tktodo = pkgs.vimUtils.buildVimPlugin {
      pname = "tktodo";
      version = "2023-01-26"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "tarting";
        repo = "tktodo.nvim";
        rev = "b49ae216846f5cd60478abc9e7ee17c3249b7705";
        hash = "sha256-KFfEkUcooaUb5ZxLrrKVqsYcVO/XI87bGwlHKbME1io=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/tarting/tktodo.nvim";
        description = "";
      };
    };
    zettelkasten = pkgs.vimUtils.buildVimPlugin {
      pname = "zettelkasten";
      version = "2025-09-21"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "Furkanzmc";
        repo = "zettelkasten.nvim";
        rev = "002c207be2eb3a0433e7e3c5999c81936106142a";
        hash = "sha256-HhWSg1ARF41TCUa7eJ+NEX3K0VFgnxzkhcG8QfFzH5c=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/Furkanzmc/zettelkasten.nvim";
        description = "";
      };
    };
    sche = pkgs.vimUtils.buildVimPlugin {
      pname = "sche";
      version = "2024-08-18"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "Cassin01";
        repo = "sche.nvim";
        rev = "31eda33db63ccff579867fea54c08da91af9f35f";
        hash = "sha256-kL54YyP5UjvO6hyRlBj6hYBsFaHt1ilsXDdhKuY1rrY=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/Cassin01/sche.nvim";
        description = "";
      };
    };
    flote = pkgs.vimUtils.buildVimPlugin {
      pname = "flote";
      version = "2024-04-13"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "JellyApple102";
        repo = "flote.nvim";
        rev = "0baa72f59c249b28cd33f07db862bed3192c03f9";
        hash = "sha256-lzJWw+M9tTSIXfaZiiTWNqq8Be9/PlW6BhAlNOYjZbQ=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/JellyApple102/flote.nvim";
        description = "";
      };
    };
    quicknote = pkgs.vimUtils.buildVimPlugin {
      pname = "quicknote";
      version = "2025-01-26"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "RutaTang";
        repo = "quicknote.nvim";
        rev = "a60828e54b5e4c474e7d583a14df09c98882dd42";
        hash = "sha256-tPfFeuzxT//qTBcqe90SpsiTnyAEp3cFoMD7DbqMxfs=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/RutaTang/quicknote.nvim";
        description = "";
      };
    };
    scratch-buffer = pkgs.vimUtils.buildVimPlugin {
      pname = "scratch-buffer";
      version = "2023-10-27"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "miguelcrespo";
        repo = "scratch-buffer.nvim";
        rev = "e14fba7425d3deab3e8abb9b599114cb6c955524";
        hash = "sha256-tAJoRrP3y5vJcT2gBMbMNr/j5vNoQ5TvFV4aXf5K8kU=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/miguelcrespo/scratch-buffer.nvim";
        description = "";
      };
    };
    edit-list = pkgs.vimUtils.buildVimPlugin {
      pname = "edit-list";
      version = "2023-10-31"; # updated: 2026-06
      src = pkgs.fetchFromGitHub {
        owner = "Sharonex";
        repo = "edit-list.nvim";
        rev = "86983717aafaeb9d82445d6f11b13eed6d20dc37";
        hash = "sha256-xeBjO4cFwpo+fBYNEwhP0hm2mgMoCRUY0qbcAIyCVMM=";
      };
      doCheck = false;
      meta = {
        homepage = "https://github.com/Sharonex/edit-list.nvim";
        description = "";
      };
    };
  };

  customList =
    pkgs.lib.attrsets.mapAttrsToList (_name: package: {
      name = _name;
      path = package;
    })
    customPlugins;

  nixpkgsList = with pkgs.vimPlugins; [
    {
      name = "arshlib";
      path = arshlib-nvim;
    }
    {
      name = "blink.lib";
      path = blink-lib;
    }
    {
      name = "promise-async";
      path = promise-async;
    }
    {
      name = "tealmaker";
      path = nvim-teal-maker;
    }
    {
      name = "plenary";
      path = plenary-nvim;
    }
    {
      name = "guihua";
      path = guihua-lua;
    }
    {
      name = "nio";
      path = nvim-nio;
    }
    {
      name = "async";
      path = async-nvim;
    }
    {
      name = "nvim-web-devicons";
      path = nvim-web-devicons;
    }
    # { MOVED TO LUA MODULES
    #   name = "nui";
    #   path = nui-nvim;
    # }
    {
      name = "sqlite";
      path = sqlite-lua;
    }
    {
      name = "bamboo";
      path = bamboo-nvim;
    }
    {
      name = "illuminate";
      path = vim-illuminate;
    }
    {
      name = "lualine";
      path = lualine-nvim;
    }
    {
      name = "nvim-navic";
      path = nvim-navic;
    }
    {
      name = "otter";
      path = otter-nvim;
    }
    {
      name = "FeMaco";
      path = nvim-FeMaco-lua;
    }
    # {
    #   name = "dropbar";
    #   path = dropbar-nvim;
    # }
    {
      name = "aerial";
      path = aerial-nvim;
    }
    {
      name = "treesitter-context";
      path = nvim-treesitter-context;
    }
    {
      name = "statuscol";
      path = statuscol-nvim;
    }
    {
      name = "smartcolumn";
      path = smartcolumn-nvim;
    }
    {
      name = "virt-column";
      path = virt-column-nvim;
    }
    {
      name = "bufferline";
      path = bufferline-nvim;
    }
    {
      name = "galaxyline";
      path = galaxyline-nvim;
    }
    {
      name = "heirline";
      path = heirline-nvim;
    }
    {
      name = "staline";
      path = staline-nvim;
    }
    {
      name = "nvim-navbuddy";
      path = nvim-navbuddy;
    }
    # { UNFREE LICENSE (?) TODO: vendor
    #   name = "barbar";
    #   path = barbar-nvim;
    # }
    {
      name = "tabby";
      path = tabby-nvim;
    }
    {
      name = "cokeline";
      path = nvim-cokeline;
    }
    {
      name = "oil";
      path = oil-nvim;
    }
    {
      name = "yazi";
      path = yazi-nvim;
    }
    {
      name = "neo-tree";
      path = neo-tree-nvim;
    }
    {
      name = "nvim-tree";
      path = nvim-tree-lua;
    }
    {
      name = "chadtree";
      path = chadtree;
    }
    {
      name = "telescope-file-browser";
      path = telescope-file-browser-nvim;
    }
    {
      name = "telescope";
      path = telescope-nvim;
    }
    {
      name = "telescope-fzf-native";
      path = telescope-fzf-native-nvim;
    }
    {
      name = "fzf-lua";
      path = fzf-lua;
    }
    {
      name = "telescope-smart-history";
      path = telescope-smart-history-nvim;
    }
    {
      name = "mini";
      path = mini-nvim;
    }
    {
      name = "snacks";
      path = snacks-nvim;
    }
    {
      name = "hlslens";
      path = nvim-hlslens;
    }
    {
      name = "clever-f.vim";
      path = clever-f-vim;
    }
    {
      name = "grug-far";
      path = grug-far-nvim;
    }
    {
      name = "spectre";
      path = nvim-spectre;
    }
    {
      name = "rip-substitute";
      path = nvim-rip-substitute;
    }
    {
      name = "inc_rename";
      path = inc-rename-nvim;
    }
    {
      name = "ssr";
      path = ssr-nvim;
    }
    {
      name = "substitute";
      path = substitute-nvim;
    }
    # {  VENDORED
    #   name = "replacer";
    #   path = replacer-nvim;
    # }
    {
      name = "renamer";
      path = renamer-nvim;
    }
    {
      name = "muren";
      path = muren-nvim;
    }
    {
      name = "windows";
      path = windows-nvim;
    }
    {
      name = "smart-splits";
      path = smart-splits-nvim;
    }
    {
      name = "ufo";
      path = nvim-ufo;
    }
    {
      name = "wrapping";
      path = wrapping-nvim;
    }
    {
      name = "vim-auto-save";
      path = vim-auto-save;
    }
    {
      name = "vim-visual-multi";
      path = vim-visual-multi;
    }
    {
      name = "multicursors";
      path = multicursors-nvim;
    }
    {
      name = "wildfire";
      path = wildfire-nvim;
    }
    {
      name = "sort";
      path = sort-nvim;
    }
    {
      name = "leap";
      path = leap-nvim;
    }
    {
      name = "flash";
      path = flash-nvim;
    }
    {
      name = "hop";
      path = hop-nvim;
    }
    {
      name = "spider";
      path = nvim-spider;
    }
    {
      name = "vim-wordmotion";
      path = vim-wordmotion;
    }
    {
      name = "rainbow-delimiters";
      path = rainbow-delimiters-nvim;
    }
    {
      name = "nvim-autopairs";
      path = nvim-autopairs;
    }
    {
      name = "blink.pairs";
      path = blink-pairs;
    }
    {
      name = "vim-sandwich";
      path = vim-sandwich;
    }
    {
      name = "nvim-surround";
      path = nvim-surround;
    }
    {
      name = "vim-surround";
      path = vim-surround;
    }
    {
      name = "vim-mundo";
      path = vim-mundo;
    }
    {
      name = "mini.keymap";
      path = mini-keymap;
    }
    {
      name = "hydra";
      path = hydra-nvim;
    }
    {
      name = "which-key";
      path = which-key-nvim;
    }
    {
      name = "better-escape";
      path = better-escape-nvim;
    }
    {
      # TODO: vendor because "unfree" (?)
      name = "unimpaired-which-key";
      path = unimpaired-which-key-nvim;
    }
    {
      name = "whichkey_setup";
      path = nvim-whichkey-setup-lua;
    }
    {
      name = "showkeys";
      path = showkeys;
    }
    {
      name = "indent-blankline";
      path = indent-blankline-nvim;
    }
    {
      name = "mini.align";
      path = mini-align;
    }
    {
      name = "tabular";
      path = tabular;
    }
    {
      name = "indent-tools";
      path = indent-tools-nvim;
    }
    {
      name = "nvim-treesitter-textobjects";
      path = nvim-treesitter-textobjects;
    }
    {
      name = "nvim-various-textobjs";
      path = nvim-various-textobjs;
    }
    {
      name = "Comment";
      path = comment-nvim;
    }
    {
      name = "ts-context-commentstring";
      path = nvim-ts-context-commentstring;
    }
    {
      name = "vim-commentary";
      path = vim-commentary;
    }
    {
      name = "treesj";
      path = treesj;
    }
    {
      name = "dial";
      path = dial-nvim;
    }
    {
      name = "switch.vim";
      path = switch-vim;
    }
    {
      name = "marks";
      path = marks-nvim;
    }
    {
      name = "arrow";
      path = arrow-nvim;
    }
    {
      name = "yanky";
      path = yanky-nvim;
    }
    {
      name = "neoclip";
      path = nvim-neoclip-lua;
    }
    {
      name = "moveline";
      path = moveline-nvim;
    }
    {
      name = "vim-abolish";
      path = vim-abolish;
    }
    {
      name = "blink.cmp";
      path = blink-cmp;
    }
    {
      name = "cmp";
      path = nvim-cmp;
    }
    {
      name = "lsp_signature";
      path = lsp_signature-nvim;
    }
    {
      name = "friendly-snippets";
      path = friendly-snippets;
    }
    {
      name = "ultisnips";
      path = ultisnips;
    }
    {
      name = "luasnip";
      path = luasnip;
    }
    {
      name = "cmp-nvim-lsp";
      path = cmp-nvim-lsp;
    }
    {
      name = "cmp-buffer";
      path = cmp-buffer;
    }
    {
      name = "cmp-path";
      path = cmp-path;
    }
    {
      name = "cmp-cmdline";
      path = cmp-cmdline;
    }
    {
      name = "cmp_luasnip";
      path = cmp_luasnip;
    }
    {
      name = "lsp-format";
      path = lsp-format-nvim;
    }
    {
      name = "lspkind";
      path = lspkind-nvim;
    }
    {
      name = "none-ls";
      path = none-ls-nvim;
    }
    {
      name = "lspsaga";
      path = lspsaga-nvim;
    }
    {
      name = "cmp-nvim-lsp-signature-help";
      path = cmp-nvim-lsp-signature-help;
    }
    {
      # TODO: vendor because "unfree" (?)
      name = "diagflow";
      path = diagflow-nvim;
    }
    {
      name = "nvim-lightbulb";
      path = nvim-lightbulb;
    }
    {
      name = "lazydev";
      path = lazydev-nvim;
    }
    {
      name = "rustaceanvim";
      path = rustaceanvim;
    }
    {
      name = "crates";
      path = crates-nvim;
    }
    {
      name = "haskell-tools";
      path = haskell-tools-nvim;
    }
    # { apparently deprecated
    #   name = "tree-sitter-just";
    #   path = pkgs.tree-sitter-grammars.tree-sitter-just;
    # }
    # {
    #   name = "guard";
    #   path = guard-nvim;
    # }
    {
      name = "conform";
      path = conform-nvim;
    }
    {
      name = "overseer";
      path = overseer-nvim;
    }
    {
      name = "asyncrun";
      path = asyncrun-vim;
    }
    {
      name = "compiler";
      path = compiler-nvim;
    }
    {
      name = "sniprun";
      path = sniprun;
    }
    {
      name = "conjure";
      path = conjure;
    }
    {
      name = "vim-slime";
      path = vim-slime;
    }
    {
      name = "xmake";
      path = xmake-nvim;
    }
    {
      name = "live-command";
      path = live-command-nvim;
    }
    {
      name = "actions-preview";
      path = actions-preview-nvim;
    }
    {
      name = "neotest";
      path = neotest;
    }
    {
      name = "coverage";
      path = nvim-coverage;
    }
    {
      name = "neotest-haskell";
      path = neotest-haskell;
    }
    {
      name = "neotest-python";
      path = neotest-python;
    }
    {
      name = "lint";
      path = nvim-lint;
    }
    {
      name = "dap-python";
      path = nvim-dap-python;
    }
    {
      name = "dapui";
      path = nvim-dap-ui;
    }
    {
      name = "nvim-dap-virtual-text";
      path = nvim-dap-virtual-text;
    }
    {
      name = "dap";
      path = nvim-dap;
    }
    {
      name = "trouble";
      path = trouble-nvim;
    }
    {
      name = "quicker";
      path = quicker-nvim;
    }
    {
      name = "bqf";
      path = nvim-bqf;
    }
    {
      name = "glance";
      path = glance-nvim;
    }
    {
      name = "vim-floaterm";
      path = vim-floaterm;
    }
    {
      name = "refactoring";
      path = refactoring-nvim;
    }
    {
      name = "neoconf";
      path = neoconf-nvim;
    }
    {
      name = "telescope-project";
      path = telescope-project-nvim;
    }
    {
      name = "advanced_git_search";
      path = advanced-git-search-nvim;
    }
    {
      name = "blame";
      path = blame-nvim;
    }
    {
      name = "jj";
      path = jj-nvim;
    }
    {
      name = "lazygit";
      path = lazygit-nvim;
    }
    {
      name = "neogit";
      path = neogit;
    }
    {
      name = "diffview";
      path = diffview-nvim;
    }
    {
      name = "gitsigns";
      path = gitsigns-nvim;
    }
    {
      # TODO: unfree -> vendor
      name = "git-conflict";
      path = git-conflict-nvim;
    }
    {
      name = "vim-fugitive";
      path = vim-fugitive;
    }
    {
      name = "octo";
      path = octo-nvim;
    }
    {
      name = "gitlab";
      path = gitlab-vim;
    }
    {
      name = "telescope-github";
      path = telescope-github-nvim;
    }
    {
      name = "dashboard-nvim";
      path = dashboard-nvim;
    }
    {
      name = "noice";
      path = noice-nvim;
    }
    {
      name = "volt";
      path = nvzone-volt;
    }
    {
      name = "menu";
      path = nvzone-menu;
    }
    {
      name = "modicator";
      path = modicator-nvim;
    }
    {
      name = "fidget";
      path = fidget-nvim;
    }
    {
      name = "notify";
      path = nvim-notify;
    }
    {
      name = "headlines";
      path = headlines-nvim;
    }
    {
      name = "auto-session";
      path = auto-session;
    }
    {
      name = "persistence";
      path = persistence-nvim;
    }
    {
      name = "shade";
      path = Shade-nvim;
    }
    {
      name = "zen-mode";
      path = zen-mode-nvim;
    }
    {
      name = "vimade";
      path = vimade;
    }
    {
      name = "schemastore";
      path = SchemaStore-nvim;
    }
    {
      name = "firenvim";
      path = firenvim;
    }
    {
      name = "render-markdown";
      path = render-markdown-nvim;
    }
    {
      name = "mkdp";
      path = markdown-preview-nvim;
    }
    {
      # TODO: vendor? (unfree)
      name = "vim-pug";
      path = vim-pug;
    }
    {
      name = "copilot";
      path = copilot-lua;
    }
    {
      name = "opencode";
      path = opencode-nvim;
    }
    # {  using as binary
    #   name = "panvimdoc";
    #   path = pkgs.panvimdoc;
    # }
    {
      name = "knap";
      path = knap;
    }
    {
      name = "urlview";
      path = urlview-nvim;
    }
    {
      name = "vimtex";
      path = vimtex;
    }
    {
      name = "ltex_extra";
      path = ltex_extra-nvim;
    }
    {
      name = "neorepl";
      path = neorepl-nvim;
    }
    {
      name = "neotest-plenary";
      path = neotest-plenary;
    }
    {
      name = "minty";
      path = nvzone-minty;
    }
    {
      name = "nvim-highlight-colors";
      path = nvim-highlight-colors;
    }
    {
      name = "vim-helm";
      path = vim-helm;
    }
    {
      name = "avante";
      path = avante-nvim;
    }
    {
      name = "codecompanion";
      path = codecompanion-nvim;
    }
    {
      name = "llm";
      path = llm-nvim;
    }
    {
      name = "sg";
      path = sg-nvim;
    }
    {
      name = "baleia";
      path = baleia-nvim;
    }
    {
      name = "obsidian";
      path = obsidian-nvim;
    }
    {
      name = "timerly";
      path = timerly;
    }
    {
      name = "vimwiki";
      path = vimwiki;
    }
    {
      name = "neorg";
      path = neorg;
    }
    {
      name = "ts_context_commentstring";
      path = nvim-ts-context-commentstring;
    }
    {
      name = "blink-cmp-env";
      path = blink-cmp-env;
    }
    {
      name = "blink-cmp-spell";
      path = blink-cmp-spell;
    }
    {
      name = "blink-cmp-dictionary";
      path = blink-cmp-dictionary;
    }
    {
      name = "blink-cmp-yanky";
      path = blink-cmp-yanky;
    }
    {
      name = "blink-cmp-conventional-commits";
      path = blink-cmp-conventional-commits;
    }
    {
      name = "blink-cmp-avante";
      path = blink-cmp-avante;
    }
    {
      name = "blink-cmp-copilot";
      path = blink-cmp-copilot;
    }
  ];
}

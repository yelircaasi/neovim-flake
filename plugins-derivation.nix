{pkgs}:
# usage: pkgs.callPackage ./neovim-plugin-pack.nix {} pluginSet;
plugins: let
  lib = pkgs.lib;
  stdenvNoCC = pkgs.stdenvNoCC;

  getPluginName = p: let
    raw =
      p.pname or (
        let
          m = builtins.match "(.+)-[0-9][^-]*" p.name;
        in
          if m != null
          then builtins.head m
          else p.name
      );
  in
    lib.removePrefix "plugin-" raw;
in
  stdenvNoCC.mkDerivation {
    name = "neovim-opt-pack";

    dontUnpack = true;
    dontConfigure = true;
    dontBuild = true;

    installPhase = ''
      runHook preInstall

      mkdir -p $out/pack/nix/opt

      ${lib.concatMapAttrsStrings (pluginName: plugin: ''
          ln -s ${plugin} $out/pack/nix/opt/${pluginName}
        '')
        pluginSet}

      runHook postInstall
    '';

    passthru = {inherit plugins pluginName;};

    meta.description = "Neovim opt-pack: plugins symlinked for manual RTP management";
  }

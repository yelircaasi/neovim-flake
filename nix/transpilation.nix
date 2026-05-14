{pkgs}:
pkgs.stdenv.mkDerivation {
  name = "tl-transpiled";
  src = ../teal;

  dontInstall = true;

  nativeBuildInputs = with pkgs; [
    lua51Packages.cyan
    stylua
  ];

  buildPhase = ''
    set -euo pipefail

    mkdir -p $out
    mkdir -p $out/config

    cyan build \
        --gen-target 5.1 \
        --global-env-def vim \
        --global-env-def cfg \
        -s src \
        -b $out/config/ \
        --prune

    stylua $out/config
  '';
}

{pkgs}:
pkgs.stdenv.mkDerivation rec {
  name = "pde";
  src = ./.;

  propagatedBuildInputs = tools;

  buildInputs = with pkgs; [
    lua5_1
    lua51Packages.tl
    lua51Packages.cyan
    stylua
  ];

  # Set up configuration during build
  buildPhase = ''
    cd ${./teal}
    cyan \
        --gen-target 5.1 \
        --global-env-def vim \
        --global-env-def cfg \
        -s ${./teal} \
        -b $out build \
        --prune
  '';

  # Add aliases and links for neovim
  # installPhase = ''

  # '';

  # Embed custom configuration and aliases
}
/*

def transpile_tl(cfg: Config) -> None:
    paths = cfg.paths
    tl_root = paths.tl_dir
    transpile_target = paths.tl_build_dir
    copy_target = paths.config_destination
    cyan_command: CommandList = [
        "cyan",
        "--gen-target",
        "5.1",
        "--global-env-def",
        "vim",
        "--global-env-def",
        "cfg",
        "-s",
        paths.tl_src_dir.relative_to(tl_root).name,
        "-b",
        transpile_target.relative_to(tl_root).name,
        "build",
        "--prune",
    ]
    run_with_result(cyan_command, cwd=tl_root, fail_on_error=True, print_output=True)
    result, _ = run_with_result(
        ["stylua", transpile_target / "init.lua", transpile_target / "lua"],
        print_output=True,
    )
    if result:
        run_with_result(
            ["lua", str(paths.cleanup_lua), transpile_target],
            fail_on_error=True,
            print_output=True,
        )
    shutil.copytree(copy_target, paths.backup_dir / copy_target.name)
    shutil.copytree(transpile_target, copy_target, dirs_exist_ok=True)
    print("Built lua config.")
*/


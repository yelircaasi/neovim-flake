check:
    cyan --gen-target 5.1 --global-env-def vim check

compile:
    if [ "$1" = "teal" ] || [ "$1" = "tl" ]; then
        echo "teal"
    elif [ "$1" = "ts" ] || [ "$1" = "typescript" ]; then
        echo "typescript"
    fi

transpile:
    cyan \
        --gen-target 5.1 \
        --global-env-def vim \
        --global-env-def cfg \
        build --prune

    stylua build/

    lua cleanup.lua build/

    echo "Built lua config."

pde:
    sh $HOME/repos/neovim-flake/scripts/sync-hooks.sh && $HOME/repos/neovim-flake/result/bin/pde

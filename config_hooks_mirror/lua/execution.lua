-- https://github.com/Olical/conjure Interactive evaluation for Neovim (Clojure, Fennel, Scheme, Python, JavaScript, PHP, R, Lua, Rust and more!)
vim.g["conjure#mapping#doc_word"] = true -- Disable the documentation mapping
vim.g["conjure#mapping#doc_word"] = { "gk" } -- Reset it to the default unprefixed K (note the special table wrapped syntax)
vim.cmd.packadd("conjure")

setup_plugin("sniprun", {})
setup_plugin("live-command", {})

setup_plugin("equals", {})

setup_plugin("channelot", function(_) end)

utils.packadd("vim-slime")
setup_plugin("jaq-nvim", {}) -- https://github.com/is0n/jaq-nvim Just Another Quickrun Plugin for Neovim in Lua

setup_plugin("iron-nvim", {})
setup_plugin("resin", {}) -- https://github.com/fdschmidt93/resin.nvim repl plugin for neovim built on textobjects

---------------- build -------------

setup_plugin("officer", {})
setup_plugin("compiler", function(_) end)
setup_plugin("compiler-nvim", {})

-- SORT
setup_plugin("jupytext", {})
setup_plugin("quarto", {})
utils.packadd("asyncrun") -- TODO: install as lua module (?)

-- https://github.com/Olical/conjure Interactive evaluation for Neovim (Clojure, Fennel, Scheme, Python, JavaScript, PHP, R, Lua, Rust and more!)
vim.g["conjure#mapping#doc_word"] = true -- Disable the documentation mapping
vim.g["conjure#mapping#doc_word"] = { "gk" } -- Reset it to the default unprefixed K (note the special table wrapped syntax)
vim.cmd.packadd("conjure")

local sniprun_defaults = {} -- TODO

-- LINK
-- DESC
local sniprun_defaults = {} -- TODO
setup_plugin("sniprun", sniprun_defaults)

-- LINK
-- DESC
local live_command_defaults = {} -- TODO
setup_plugin("live-command", live_command_defaults)

-- LINK
-- DESC
local equals_defaults = {} -- TODO
setup_plugin("equals", equals_defaults)

setup_plugin("channelot", function(_) end)

utils.packadd("vim-slime")

-- https://github.com/is0n/jaq-nvim
-- Just Another Quickrun Plugin for Neovim in Lua
local jaq_nvim_defaults = {} -- TODO
setup_plugin("jaq-nvim", jaq_nvim_defaults)

-- LINK
-- DESC
local iron_nvim_defaults = {} -- TODO
setup_plugin("iron-nvim", iron_nvim_defaults)

-- https://github.com/fdschmidt93/resin.nvim
-- repl plugin for neovim built on textobjects
local resin_defaults = {} -- TODO
setup_plugin("resin", resin_defaults)

---------------- build -------------

-- LINK
-- DESC
local officer_defaults = {} -- TODO
setup_plugin("officer", officer_defaults)
setup_plugin("compiler", function(_) end)

-- LINK
-- DESC
local compiler_nvim_defaults = {} -- TODO
setup_plugin("compiler-nvim", compiler_nvim_defaults)

-- SORT

-- LINK
-- DESC
local jupytext_defaults = {} -- TODO
setup_plugin("jupytext", jupytext_defaults)

-- LINK
-- DESC
local quarto_defaults = {} -- TODO
setup_plugin("quarto", quarto_defaults)
-- TODO: install as lua module (?)
utils.packadd("asyncrun")

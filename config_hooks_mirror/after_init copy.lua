-- TODO: see https://www.reddit.com/r/neovim/comments/1afw5tc/rustaceanvim_now_with_neotest_integration/

-- wezterm: TODO: vendor
-- https://github.com/willothy/wezterm.nvim
-- https://github.com/ianhomer/wezterm.nvim
-- https://github.com/aca/wezterm.nvim (in Go)
-- https://github.com/letieu/wezterm-move.nvim
-- https://github.com/jonboh/wezterm-mux.nvim -> https://github.com/mrjones2014/smart-splits.nvim

-- look at https://github.com/yochem/lazy-vimpack

-- additional LSPs:
-- https://github.com/latex-lsp/texlab
-- jsonls and yamlls
-- https://www.npmjs.com/package/vscode-json-languageserver
-- https://github.com/redhat-developer/yaml-language-server

-- on macos:
-- brew install ruff
-- brew install lua-language-server
-- brew install rust-analyzer
-- brew install haskell-language-server

--[[ DESIRED MAPPINGS/ACTIONS
	------------------
	--- NAVIGATION ---
	------------------
	- windows: up down left right, fzf menu, menu navigation (up down), move/rearrange
	- tabs: up down left right, fzf menu, menu navigation (up down), move/rearrange
	- buffers: up down left right, fzf menu, menu navigation (up down), move/rearrange

	------------
	--- SORT ---
	------------
	- open quickfix window
	- open floating terminal
	- copy selection to new file
	- jump to reference (next, previous)
	- jump to definition
	- open search and replace (with preview)
	- fold block
	- fold/unfold all of given level
	- toggle value under cursor
	- rename everywhere (optionally with preview)
	- search pattern/regex in given files -> save results list & use it to navigate
	- show keybinds available
	- add/view/edit comment/annotation pointing to given location
	- view/navigate TODOs and comments
	- insert snippet
	- format code (optionally only under selection)
	- edit selection in new buffer
	- dull colors outside of selection
	- edit filesystem as a buffer (oil.nvim?)
	- get autocomplete suggestion
	- check spelling in file (ONLY on command!)
	- view diff (with saved, last commit, etc.)
	- file tree view
	- navigate between search results
	- toggle to light colors (or even lighten/darken colors, increase contrast -> write plugin?)
	- jump to next syntactic object
	- command to run changed tests (use testmon or analogous)
	- get LLM feedback
	- unified preview_+accept/reject framework
	- multi-line / multi-location edits

	AUTOMATIC/TOGGLABLE FUNCTIONALITIES
	--> dull colors everywhere except in active block (via treesitter?)
	--> custom syntax highlighting for my special formats (from consilium-notes: jn, ...)
	--]]

print("Entering after_init.lua.")
vim.opt.runtimepath.prepend(CONFIG_DIR)

utils.printv("CONFIG_DIR: " .. CONFIG_DIR)
utils.printv("PLUGINS INCLUDED: " .. vim.inspect(utils.PLUGINS_INCLUDED))
utils.printbv(#utils.PLUGINS_INCLUDED .. " plugins included")

local setup_plugin = utils.setup_plugin
local packadd = utils.packadd

-- utils.printbv(#utils.PLUGINS_INCLUDED .. " plugins included")

local CONFIG_DIR = vim.fn.fnamemodify(debug.getinfo(1).source:sub(2), ":p:h")
local PWD = vim.fn.getcwd()
local NVIM_DIR = vim.fn.expand("~/.config/nvim")
HAS_NIX, PLUGIN_LOCATIONS = pcall(dofile, NVIM_DIR .. "/nix_plugins.lua")
BE_VERBOSE = false

local current_mode_index = 1
local diagnostics_active = false

-- PATH MANAGEMENT ========================================================================================

local config_dir = vim.fn.fnamemodify(debug.getinfo(1).source:sub(2), ":p:h")
-- print(config_dir)
vim.opt.runtimepath:prepend(config_dir)

if HAS_NIX then
	vim.opt.runtimepath:remove("/home/isaac/.local/share/nvim/site")
end

package.path = config_dir .. "/lua/?.lua;" .. config_dir .. "/lua/?/init.lua;" .. package.path

vim.opt.runtimepath:prepend("/nix/store/ydlwparyk4mxl6wzhlp3x54zl3nk82c5-pde")
vim.opt.runtimepath:remove("/home/isaac/.local/share/nvim/site")

-- MODULES

require("wezterm_send").setup()

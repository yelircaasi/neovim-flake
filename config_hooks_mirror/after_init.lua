-- make shell-highlighted scratch buffer that sends the command to wezterm and collects the output

-- TODO: see https://www.reddit.com/r/neovim/comments/1afw5tc/rustaceanvim_now_with_neotest_integration/
--
-- wezterm desiderata:
--   select and copy terminal output
--   unicode working right
--   rearrange terminal layout
--   default pane layout
--   history
--   different shells
--   open path in output in X (new pane, current pane, new tab)
--   proper handling of url
--   vim keybindings for line editing (provided by wezterm or shell? or simply open minimal vim editor to edit command)
--   comfortable switching between different shells (bash, nushell, xonsh, elvish, etc)

-- add <leader>wq, <leader>qq, etc
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
-- write my own LSP(s) for consilium
--
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

-- Set up a local map function for convenience

utils.printv("Entering after_init.lua.")
NVIM_HOME = vim.fn.expand("~/.config/nvim") --TODO: change after new build makes this global
vim.opt.runtimepath:prepend(NVIM_HOME)

function setup_plugin_explicit(dir_name, mod_name, config_or_function)
	utils.packadd(dir_name)
	mod = require(mod_name)
	if type(config_or_function) == "function" then
		config_or_function(mod)
	else
		mod.setup(config_or_function)
	end
end

-- GLOBALS ====================================================================

function map_explicit(spec)
	vim.keymap.set(spec.mode, spec.sequence or spec.lhs, spec.action or spec.rhs, spec.opts)
end
map = utils.map
setup_plugin = utils.setup_plugin
packadd = utils.packadd

vim.g.mapleader = " "

-- MODULES

vim.api.nvim_create_autocmd("ColorScheme", {
	-- immediate = true,
	callback = function()
		local win_sep = vim.api.nvim_get_hl(0, { name = "WinSeparator", link = false })
		local statusnc = vim.api.nvim_get_hl(0, { name = "StatusLineNC", link = false })

		-- Make the inactive bar background match so it blends with WinSeparator
		vim.api.nvim_set_hl(0, "StatusLineNC", {
			fg = win_sep.fg,
			bg = statusnc.bg,
		})
	end,
})

vim.opt.runtimepath:prepend("/home/isaac/repos/nvim-colors/odenwald.nvim")
local odenwald = require("odenwald")
odenwald.setup()
odenwald.load()
vim.api.nvim_set_hl(0, "pythonConstant", {
	link = "Constant",
})
vim.api.nvim_set_hl(0, "pythonBoolean", {
	link = "Constant",
})
vim.api.nvim_set_hl(0, "pythonAttribute", {
	link = "Constant",
})
map_explicit({
	mode = "n",
	lhs = "<leader>ii",
	rhs = "<cmd>Inspect<cr>",
})
vim.api.nvim_set_hl(0, "@variable", { link = "Identifier" })

require("options")
require("core")
require("ui")

require("completion")
require("explorers")
require("testing")
require("treesitter")
require("langs.python")
require("lsp_etc")

require("editing")
require("folding")
require("search")
require("navigation")

require("telescope_etc")
require("diff")
require("terminal")
require("debugging")
require("projects")
require("macros")

require("langs.rust")
require("langs.haskell")
require("langs.lua_language")

require("task_runner")

require("git")
require("ai")

require("mappings") -- TODO: move out to respective files

require("tmp")

if false then
	-- TODO
	require("wezterm_send").setup()

	-- TODO
	vim.opt.runtimepath:prepend("/home/isaac/repos/consilium.nvim")
	local consilium = require("consilium")
	consilium.setup()

	require("langs.xit") -- TODO
	require("langs.tex")
	require("langs.typst")
	require("langs.go")

	require("miscellaneous") -- TODO
end

utils.printv("Reached end of after_init.lua.")

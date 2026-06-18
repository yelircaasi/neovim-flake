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

-- vim\.keymap\.set\((".+?"), "(.+?)", ([^ \n\)]+?)\)$

-- TODO: move to utils
function map_explicit(spec)
	local opts = spec.opts or {}
	if spec.desc then
		opts.desc = spec.desc
	end
	vim.keymap.set(spec.mode, spec.sequence or spec.lhs, spec.action or spec.rhs, opts)
end
map = utils.map
setup_plugin = utils.setup_plugin
packadd = utils.packadd

function mkprint(msg)
	local function inner()
		print(msg)
	end
	return inner
end

vim.g.mapleader = " "

-- MODULES

-------------------------------------------------------------------------------
-- MODULES: ---------------------------------------------------------------------
-------------------------------------------------------------------------------
-- require("commons.fio")
-- require("nio")
-- require("nui.input")
-- require("jsregexp")
-- require("pathlib")

--─────────────────────────────────────────────────────────────────────────────
--──── colorscheme ────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

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

--─────────────────────────────────────────────────────────────────────────────
--──── modules ────────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

local ALL_config_modules = {
	["options"] = true,
	["core"] = true, -- empty
	["ui"] = true,

	["clipboard"] = true,
	["cloud"] = true,
	["colors"] = true,
	["execution"] = true,

	["completion"] = true,
	["explorers"] = true,
	["testing"] = true,
	["lsp_etc"] = true,

	["editing"] = true,
	["folding"] = true,
	["search"] = true,
	["navigation"] = true,

	["telescope_etc"] = true,
	["diff"] = true,
	["terminal"] = true,
	["debugging"] = true,
	["projects"] = true,
	["macros"] = true,

	["task_runner"] = true,
	["replacer"] = true,

	["git"] = true,
	["ai"] = true,

	["mappings"] = true, -- TODO: move out to respective files

	["tmp"] = true,

	["langs.multilang"] = false,
	["langs.go"] = false,
	["langs.haskell"] = true,
	["langs.json_yaml"] = true,
	["langs.lua_language"] = false,
	["langs.markdown"] = false,
	["langs.nix"] = true,
	["langs.rust"] = true,
	["langs.tex"] = false,
	["langs.typst"] = false,
	["langs.xit"] = false,

	["miscellaneous"] = false, -- TODO
}
-- TMP
config_modules = {
	["options"] = true,
	["lsp_etc"] = true,
	["editing"] = true,
	["navigation"] = true,
	["ui"] = true,
	["treesitter"] = true,
	["core"] = true,
	["langs.python"] = true,
	["colors"] = true,
}
local function maybe_require(mod_name)
	local include = config_modules[mod_name]
	if include then
		print("Requiring " .. mod_name)
		require(mod_name)
	end
end

maybe_require("options")
maybe_require("lsp_etc")
maybe_require("editing")
maybe_require("navigation")
maybe_require("treesitter")
maybe_require("core")
maybe_require("langs.python")
maybe_require("colors")
maybe_require("ui")

local include_experimental = false
if include_experimental then
	setup_plugin("fsread", function(fsread)
		vim.g.flow_strength = 0.7 -- low: 0.3, middle: 0.5, high: 0.7 (default)
		vim.api.nvim_set_hl(0, "FSPrefix", { fg = "#cdd6f4" })
		vim.api.nvim_set_hl(0, "FSSuffix", { fg = "#6C7086" })

		-- :FSRead " Flow state visual range
		-- :FSClear " Clear all flow states
		-- :FSToggle " Toggle flow state
	end)

	-- TODO
	-- require("wezterm_send").setup()
	vim.opt.runtimepath:prepend("/home/isaac/repos/wezterm-run.nvim")
	local wezrun = require("wezterm-run")
	wezrun.setup()

	-- TODO
	vim.opt.runtimepath:prepend("/home/isaac/repos/consilium.nvim")
	local consilium = require("consilium")
	consilium.setup()
end

utils.printv("Reached end of after_init.lua.")

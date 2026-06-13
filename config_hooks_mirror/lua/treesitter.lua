-- TREESITTER =================================================================================================

-- v_an, v_in, v_]n, v_[n now provide incremental selection of treesitter nodes

-- TODO: treesitter queries in RTP/queries/<lang>/

-- FILETYPES: put in ftplugin/<filetype>.lua ?

-- config/
-- ├── ftdetect/
-- │   └── xit.lua
-- ├── ftplugin/
-- │   └── xit.lua       ← here
-- ├── syntax/
-- │   └── xit.lua
-- └── init.lua

-- To manually toggle highlighting at runtime:
-- ```vim
-- :TSEnable highlight
-- :TSDisable highlight
-- ```

-- local TS_LANGUAGES = {
-- 		"haskell",
-- 		"javascript",
-- 		"json",
-- 		"lua",
-- 		"markdown",
-- 		"nix",
-- 		"python",
-- 		"rust",
-- 		"toml",
-- 		"typescript",
-- 		"yaml",
-- 		"zig",
-- 	}

-- NEW TREESITTER CONFIG COMPILED FROM OLD

TS_LANGUAGES = {
	"haskell",
	"javascript",
	"json",
	"lua",
	"markdown",
	"nix",
	"python",
	"rust",
	"toml",
	"typescript",
	"yaml",
	"zig",
}

-- PREAMBLE / VARS ----------------------------------------------

-- PATHS
-- print(vim.o.runtimepath:find(vim.env.VIMRUNTIME) ~= nil)
-- print(vim.inspect(vim.opt.runtimepath))

parser_root = vim.fn.fnamemodify(OPT_DIR, ":h:h:h")
vim.opt.runtimepath:prepend(PARSER_DIR)
-- -----
local my_install_dir = (not HAS_NIX) and ((vim.fn.stdpath("data")) .. "/site") or DERIVATION_DIR

local my_parser_install_dir = my_install_dir .. "/parser"
-- (not HAS_NIX) and (vim.fn.stdpath("data")) .. "/site/parsers" or DERIVATION_DIR ..
local my_ensure_installed = HAS_NIX and {} or TS_LANGUAGES

utils.printbv("Setting up treesitter.")
utils.printbv("my_install_dir:        " .. my_install_dir)
utils.printbv("my_parser_install_dir: " .. my_parser_install_dir)
utils.printbv("my_ensure_installed:   " .. vim.inspect(my_ensure_installed))

local old_config = {
	-- directory to install parsers and queries to (prepended to `runtimepath` to have priority)
	install_dir = (not HAS_NIX) and vim.fn.stdpath("data") .. "/site" or nil,
	parser_install_dir = (not HAS_NIX) and vim.fn.stdpath("data") .. "/parsers" or nil,
	ensure_installed = HAS_NIX and {} or TS_LANGUAGES,
	highlight = { enable = true },
	indent = { enable = true },
}

-- SETUP / CHECKS
local parsers_to_ensure = { "c", "lua", "python", "javascript", "typescript", "bash", "json" }
for _, lang in ipairs(parsers_to_ensure) do
	local is_installed, _ = pcall(vim.treesitter.language.add, lang)
	if not is_installed then
		print("Treesitter parser not installed: " .. lang)
	end
end

-- FILETYPES
vim.filetype.add({
	extension = { xit = "xit" },
})

-- REGISTER LANGUAGES
-- vim.treesitter.language.register("py", "python")

-- vim.opt.foldmethod = "expr" + foldexpr
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.indentexpr = "v:lua.vim.treesitter.indent()"
vim.g.treesitter_filetype_exclude = { "markdown", "txt" }

-- FILETYPE ALIASES
vim.treesitter.language.register("cpp", "cuda")
vim.treesitter.language.register("javascript", "jsx")
vim.treesitter.language.register("typescript", "tsx")

-- QUERIES
-- vim.treesitter.query.add_predicate("python", "highlights", [[(function_definition name: (identifier) @function.def)]])

-- AUTOCOMMANDS
-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = { "rust", "go", "python" }, -- add languages
-- 	callback = function()
-- 		if not vim.treesitter.language.get_lang(vim.bo.filetype) then
-- 			-- Or use a plugin/helper for installation
-- 			print("No Treesitter parser for " .. vim.bo.filetype)
-- 		end
-- 	end,
-- })

vim.api.nvim_create_autocmd("FileType", {
	callback = function(ev)
		local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
		if lang then
			local ok, err = pcall(vim.treesitter.start, ev.buf, lang)
			if not ok then
				vim.notify("treesitter start failed for " .. lang .. ": " .. err, vim.log.levels.WARN)
			end
		end
	end,
})

if false then
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "lua",
		callback = function()
			vim.treesitter.start()
		end,
	})

	vim.api.nvim_create_autocmd("FileType", {
		pattern = "python",
		callback = function(ev)
			vim.treesitter.start(ev.buf, "python")
		end,
	})

	vim.api.nvim_create_autocmd("FileType", {
		callback = function()
			pcall(vim.treesitter.start) -- pcall: silently skips if no parser
		end,
	})
end

-- COMMANDS

for _, cmd in ipairs({ "TSInstall", "TSInstallSync", "TSInstallFromGrammar" }) do
	pcall(vim.api.nvim_del_user_command, cmd)
end

-- OR:
vim.api.nvim_create_user_command("TSInstall", function()
	vim.notify("TSInstall is disabled. Manage parsers externally.", vim.log.levels.WARN)
end, {
	nargs = "*",
	complete = function()
		return {}
	end,
})

-- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
-- Syntax aware text-objects, select, move, swap, and peek support.
local treesitter_textobjects_defaults = {
	select = {
		-- Automatically jump forward to textobj, similar to targets.vim
		lookahead = true,
		-- You can choose the select mode (default is charwise 'v')
		--
		-- Can also be a function which gets passed a table with the keys
		-- * query_string: eg '@function.inner'
		-- * method: eg 'v' or 'o'
		-- and should return the mode ('v', 'V', or '<c-v>') or a table
		-- mapping query_strings to modes.
		selection_modes = {
			["@parameter.outer"] = "v", -- charwise
			["@function.outer"] = "V", -- linewise
			-- ['@class.outer'] = '<c-v>', -- blockwise
		},
		-- If you set this to `true` (default is `false`) then any textobject is
		-- extended to include preceding or succeeding whitespace. Succeeding
		-- whitespace has priority in order to act similarly to eg the built-in
		-- `ap`.
		--
		-- Can also be a function which gets passed a table with the keys
		-- * query_string: eg '@function.inner'
		-- * selection_mode: eg 'v'
		-- and should return true of false
		include_surrounding_whitespace = false,
	},
}
setup_plugin("nvim-treesitter-textobjects", function(tsto)
	tsto.setup(treesitter_textobjects_defaults)
	local tsto_select = require("nvim-treesitter-textobjects.select")
	-- keymaps
	-- You can use the capture groups defined in `textobjects.scm`
	vim.keymap.set({ "x", "o" }, "am", function()
		tsto_select.select_textobject("@function.outer", "textobjects")
	end)
	vim.keymap.set({ "x", "o" }, "im", function()
		tsto_select.select_textobject("@function.inner", "textobjects")
	end)
	vim.keymap.set({ "x", "o" }, "ac", function()
		tsto_select.select_textobject("@class.outer", "textobjects")
	end)
	vim.keymap.set({ "x", "o" }, "ic", function()
		tsto_select.select_textobject("@class.inner", "textobjects")
	end)
	-- You can also use captures from other query groups like `locals.scm`
	vim.keymap.set({ "x", "o" }, "as", function()
		tsto_select.select_textobject("@local.scope", "locals")
	end)
end)

pcall(vim.treesitter.language.register, "markdown", "snacks_notif")
pcall(vim.treesitter.language.register, "markdown", "blink-cmp-menu")
pcall(vim.treesitter.language.register, "markdown", "yazi")
pcall(vim.treesitter.language.register, "markdown", "oil")

-- vim.api.nvim_create_autocmd('FileType', {
--   callback = function(ev)
--     if vim.treesitter.language.get_lang(vim.bo[ev.buf].filetype) == nil then
--       return
--     end
--     vim.treesitter.start(ev.buf)
--   end,
-- })

-- local no_ts = { oil = true, yazi = true, lazy = true, }

-- vim.api.nvim_create_autocmd('FileType', {
--   callback = function(ev)
--     if no_ts[vim.bo[ev.buf].filetype] then return end
--     pcall(vim.treesitter.start, ev.buf)
--   end,
-- })

-- NEEDED TO PREVENT WARNINGS ON NON-CODE BUFFERS

local ts_disabled = {
	snacks_notif = true,
	["blink-cmp-menu"] = true,
	yazi = true,
	oil = true,
	telescope = true,
	TelescopePrompt = true,
	TelescopeResults = true,
	TelescopePreview = true,
	dmap = true,
}

local orig_ts_start = vim.treesitter.start

vim.treesitter.start = function(bufnr, lang)
	bufnr = bufnr or 0
	local ft = vim.bo[bufnr].filetype

	if ts_disabled[ft] then
		return
	end

	return orig_ts_start(bufnr, lang)
end

-- https://github.com/nvim-treesitter/nvim-treesitter-context
-- Show code context
local treesitter_context_defaults = {
	enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
	multiwindow = false, -- Enable multiwindow support.
	max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
	min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
	line_numbers = true,
	multiline_threshold = 20, -- Maximum number of lines to show for a single context
	trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
	mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
	-- Separator between context and content. Should be a single character string, like '-'.
	-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
	separator = nil,
	zindex = 20, -- The Z-index of the context window
	on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
}
setup_plugin("treesitter-context", treesitter_context_defaults)

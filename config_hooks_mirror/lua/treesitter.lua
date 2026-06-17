local selections = {}
local elements = {
	["set-global-ts-languages"] = true,
	["general-setup"] = true,
	["check-parsers"] = true,
	["configure-filetypes-and-aliases"] = true,
	["configure-folds-and-indentation"] = true,
	["nvim-treesitter-textobjects"] = true,
	["treesitter-context"] = true,
	["wrap-treesitter-start"] = true,
	["change-commands"] = true,
	["create-autocommands"] = true,
}

local function set_global_ts_languages()
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
end

local function general_setup()
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
end

local function check_parsers()
	local parsers_to_ensure = { "c", "lua", "python", "javascript", "typescript", "bash", "json" }
	for _, lang in ipairs(parsers_to_ensure) do
		local is_installed, _ = pcall(vim.treesitter.language.add, lang)
		if not is_installed then
			print("Treesitter parser not installed: " .. lang)
		end
	end
end

local function configure_filetypes_and_aliases()
	vim.g.treesitter_filetype_exclude = { "markdown", "txt" }
	-- FILETYPES
	vim.filetype.add({
		extension = { xit = "xit" },
	})

	-- FILETYPE ALIASES
	vim.treesitter.language.register("cpp", "cuda")
	vim.treesitter.language.register("javascript", "jsx")
	vim.treesitter.language.register("typescript", "tsx")
end

local function configure_folds_and_indentation()
	-- vim.opt.foldmethod = "expr" + foldexpr
	vim.opt.foldmethod = "expr"
	vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
	vim.opt.foldenable = true
	vim.opt.foldlevel = 99
	vim.opt.foldlevelstart = 99

	vim.opt.indentexpr = "v:lua.vim.treesitter.indent()"
end

local function setup_treesitter_textobjects()
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
		local xo = { "x", "o" }
		map_explicit({
			mode = xo,
			sequence = "am",
			action = function()
				tsto_select.select_textobject("@function.outer", "textobjects")
			end,
		})
		map_explicit({
			mode = xo,
			sequence = "im",
			action = function()
				tsto_select.select_textobject("@function.inner", "textobjects")
			end,
		})
		map_explicit({
			mode = xo,
			sequence = "ac",
			action = function()
				tsto_select.select_textobject("@class.outer", "textobjects")
			end,
		})
		map_explicit({
			mode = xo,
			sequence = "ic",
			action = function()
				tsto_select.select_textobject("@class.inner", "textobjects")
			end,
		})
		-- You can also use captures from other query groups like `locals.scm`
		map_explicit({
			mode = xo,
			sequence = "as",
			action = function()
				tsto_select.select_textobject("@local.scope", "locals")
			end,
		})
	end)
end

local function setup_treesitter_context()
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
end

local function wrap_treesitter_start()
	local orig_ts_start = vim.treesitter.start
	vim.treesitter.start = function(bufnr, lang)
		bufnr = bufnr or 0

		-- only code buffers have butype ""; 'special' buffers have a specific type
		local bt = vim.bo[bufnr].buftype
		if bt ~= "" then
			return
		end

		return orig_ts_start(bufnr, lang)
	end
end

local function change_commands()
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
end

local function create_autocommands()
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
end

local functions = {
	["set-global-ts-languages"] = set_global_ts_languages,
	["general-setup"] = general_setup,
	["check-parsers"] = check_parsers,
	["configure-filetypes-and-aliases"] = configure_filetypes_and_aliases,
	["configure-folds-and-indentation"] = configure_folds_and_indentation,
	["nvim-treesitter-textobjects"] = setup_treesitter_textobjects,
	["treesitter-context"] = setup_treesitter_context,
	["wrap-treesitter-start"] = wrap_treesitter_start,
	["change-commands"] = change_commands,
	["create-autocommands"] = create_autocommands,
}
local function maybe_call(element_name)
	local include = elements[element_name]
	if include then
		print("Calling '" .. element_name .. "'")
		local func = functions[element_name]
		func()
	end
end

maybe_call("set-global-ts-languages")
maybe_call("general-setup")
maybe_call("check-parsers")
maybe_call("configure-filetypes-and-aliases")
maybe_call("configure-folds-and-indentation")
maybe_call("nvim-treesitter-textobjects")
maybe_call("treesitter-context")
maybe_call("wrap-treesitter-start")
maybe_call("change-commands")
maybe_call("create-autocommands")

-- ================================================================================================
-- === NOTES ======================================================================================
-- ================================================================================================

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

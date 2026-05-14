global function join_paths(base: string, child: string): string
	return base .. "/" .. child
end

-- RTP =================================================================================================================
global DERIVATION_DIR: string = (vim.fn.resolve(vim.fn.expand("<sfile>:p:h:h") as string) as string)
global CONFIG_DIR: string = join_paths(DERIVATION_DIR, "config")
global PARSER_DIR: string = join_paths(DERIVATION_DIR, "parser")
vim.opt.runtimepath:prepend(DERIVATION_DIR)
vim.opt.runtimepath:prepend(PARSER_DIR)

-- PRE HOOKS ===========================================================================================================
local NVIM_HOME: string = vim.fn.expand("~/.config/nvim") as string
global VERBOSE: boolean = false
global SAFE: boolean = true
dofile(NVIM_HOME .. "/before_init.lua")

-- GLOBAL OPTIONS ======================================================================================================
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.loaded_matchparen = 1
vim.g.loaded_matchit = 1
vim.g.loaded_netrw = 1

-- UTILS ===============================================================================================================
local path_helpers: {string: (function(string):string)} = {}

path_helpers.resolve = function(path: string): string return vim.fn.expand(path) as string end

path_helpers.resolve_existing = function(path: string): string
	local resolved: string = path_helpers.resolve(path)
	if not vim.fn.exists(resolved) then error("function 'resolve': path " .. path .. " must already exist.") end
	return resolved
end

path_helpers.resolve_and_mkdir = function(path: string): string
	local resolved: string = path_helpers.resolve(path)
	if not vim.fn.exists(resolved) then vim.fn.mkdir(resolved) end
	return resolved
end

local prepend_safe = function(path: string, create?: boolean): nil
	local resolver: function(string): string = create and path_helpers.resolve_and_mkdir or path_helpers.resolve_existing
	local expanded_path: string = resolver(path)
	if not vim.tbl_contains(vim.opt.runtimepath:get() as {string}, expanded_path) then
		vim.opt.runtimepath:prepend(expanded_path)
	end
end

prepend_safe(vim.env.VIMRUNTIME as string)

global HAS_NIX: boolean = vim.fn.isdirectory("/nix/store") ~= 0

package.path = package.path .. ";" .. CONFIG_DIR .. "/?.lua"
local result, explicit_paths = pcall(dofile, NVIM_HOME .. "/plugin_paths.lua") as (boolean, {string:string})
local plugin_paths: {string:string} = result and explicit_paths or {}

global utils = require("lua.utils").setup({
	verbose = VERBOSE,
	safe = SAFE,
	prepend_safe = prepend_safe,
	layers = {0, 1,},
	plugin_paths = plugin_paths,
	dependencies = dofile(CONFIG_DIR .. "/meta/dependencies.lua") as {string:{string}},
	plugins_by_layer = dofile(CONFIG_DIR .. "/meta/plugin_layers.lua") as {number:{number:{string}}},
})

-- =====================================================================================================================
-- PLUGIN SETUP ========================================================================================================
-- =====================================================================================================================

--[[

local setup_plugin: SetupFunction = utils.setup_plugin
local map: MapFunction = utils.map

-- LAYER 0: foundation, colors, search, core navigation ============================================================== 0
------ core dependencies
setup_plugin("plenary")
setup_plugin("nio")
setup_plugin("nvim-web-devicons")
------ core setup and UI
setup_plugin("bamboo", function(bamboo: Plugin)
	(bamboo.setup as function(table))({
		style = "multiplex",
		colors = {
			bg0 = "#020802",
		},
		-- highlights = { Normal = { bg = "#020802" } },
	})
	(bamboo.load as function)()
	utils.printbv("Set up bamboo")
	-- require("vague").setup({ transparent = true })
	-- vim.cmd("colorscheme bamboo")
	-- vim.cmd(":hi statusline guibg=#081608")
end)
setup_plugin("zen-mode")
setup_plugin("lualine")
setup_plugin("nvim-navic")
setup_plugin("bufferline")
setup_plugin("statuscol")
setup_plugin("nvim-treesitter", function(treesitter: Plugin)
	local TS_LANGUAGES = {
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

	utils.printbv("Setting up treesitter.")
	local my_install_dir = (not HAS_NIX) and (vim.fn.stdpath("data") as string) .. "/site" or nil
	utils.printv(my_install_dir)
	local my_parser_install_dir = (not HAS_NIX) and (vim.fn.stdpath("data") as string) .. "/parsers" or nil
	utils.printv(my_parser_install_dir)
	local my_ensure_installed = HAS_NIX and {} or TS_LANGUAGES
	utils.printv(vim.inspect(my_ensure_installed))
	-- vim.fn.mkdir(my_parser_install_dir, "p")
	-- IMPORTANT: Neovim expects parsers to be in a 'parser' subfolder of an RTP entry
	-- vim.opt.runtimepath:append(my_parser_install_dir)
	utils.printbv("Treesitter exists")
	(treesitter.setup as function(table))({
		-- directory to install parsers and queries to (prepended to `runtimepath` to have priority)
		install_dir = my_install_dir,
		parser_install_dir = my_parser_install_dir,
		ensure_installed = my_ensure_installed,
		highlight = { enable = true },
		indent = { enable = true },
	})
end as CustomSetupFunction)
setup_plugin("treesitter-modules")
setup_plugin("dropbar")
utils.packadd("nvim-navbuddy")
setup_plugin("aerial")
------ file explorer (as central focus)
setup_plugin("oil")
setup_plugin("yazi")
setup_plugin("neo-tree")
setup_plugin("nvim-tree")
------ picker / search
setup_plugin("pickme")
setup_plugin("telescope")
-- setup_plugin("telescope-fzf-native") TODO!
setup_plugin("fzf-lua")
setup_plugin("deck")
------ suites
setup_plugin("mini.indent")
setup_plugin("mini.keymap")
setup_plugin("mini.sessions")
-- TODO: further mini.* plugins
setup_plugin("snacks")
setup_plugin("blink")
------ search
setup_plugin("hlslens")
setup_plugin("hlsearch")
------ find-and-replace
setup_plugin("grug-far")
setup_plugin("spectre")
------ layout & buffer/tab navigation
setup_plugin("flybuf")
setup_plugin("stickybuf")
setup_plugin("swm", function(swm: Plugin)
	map("n", "<C-w>h", swm.h as function())
	map("n", "<C-w>j", swm.j as function())
	map("n", "<C-w>k", swm.k as function())
	map("n", "<C-w>l", swm.l as function())
end as CustomSetupFunction)
------ wezterm integration
setup_plugin("smart-splits")

-- LAYER 1: editing enhancements ===================================================================================== 1
------ folds
setup_plugin("ufo")
------ macros
setup_plugin("NeoComposer")
setup_plugin("nvim-macros", {
	json_file_path = "./macros.json",
	default_macro_register = "a",
	json_formatter = "jq",
})
setup_plugin("recorder")

------ multi-cursor
utils.packadd("vim-visual-multi")
------ motion
setup_plugin("leap")
setup_plugin("flash")
setup_plugin("hop")
------ pairs

setup_plugin("rainbow-delimiters")
setup_plugin("nvim-autopairs")
-- TODO setup_plugin("blink.pairs")
utils.packadd("vim-sandwich")
-- setup_plugin("vim-sandwich")
setup_plugin("nvim-surround")
------ undo
utils.packadd("vim-mundo")
------ keymapping-related
setup_plugin("mini.keymap")
setup_plugin("hydra")
setup_plugin("insx")
setup_plugin("which-key")
------ alignment / indentation
setup_plugin("indentmini")
utils.packadd("indent-blankline")
setup_plugin("nvim-anydent")
setup_plugin("mini.align")
utils.packadd("tabular")
------ textobjects
setup_plugin("nvim-treesitter-textobjects")
utils.packadd("nvim-various-textobjs")
------ comments
setup_plugin("Comment")
setup_plugin("todo-comments")
utils.packadd("vim-commentary")
------ split / join
setup_plugin("treesj")
------ value manipulation
-- this one has a flawed structure; need to fork it and fix that
-- setup_plugin("dial")
------ marks
setup_plugin("harpoon-core")
setup_plugin("marks")
setup_plugin("markit")
------ yank/paste & clipboard
setup_plugin("nvim-pasta")
------ miscellaneous
setup_plugin("beam")
------ sort

-- LAYER 2: LSP, autocompletion, snippets ============================================================================ 2
------ snippets, autocomplete
setup_plugin("blink.cmp")
setup_plugin("nvim-cmp")
------ snippets (as main focus)
setup_plugin("friendly-snippets")
setup_plugin("ultisnips")
setup_plugin("LuaSnip")
------ completion sources
setup_plugin("cmp-nvim-lsp")
setup_plugin("cmp-buffer")
setup_plugin("cmp-path")
setup_plugin("cmp-cmdline")
------ LSP general
------ (configure ruff, pyright, lua-language-server, haskell-language-server, rust-analyzer with built-in client)
setup_plugin("lsp-format")
setup_plugin("lspkind")
------ LSP UI
----- see also fidget.nvim
setup_plugin("lspsaga")
------ language-specific
setup_plugin("lazydev")
setup_plugin("rustaceanvim")
setup_plugin("crates")
setup_plugin("haskell-tools")
------ LSP-adjacent
setup_plugin("none-ls")

-- LAYER 3: formatting & linting ===================================================================================== 3
setup_plugin("guard")
setup_plugin("conform")

-- LAYER 4: testing, debugging/quickfix, execution =================================================================== 4
setup_plugin("asyncrun")
setup_plugin("neotest-haskell")
setup_plugin("neotest-python")
setup_plugin("neotest")
setup_plugin("dap-python", function(dap_python: Plugin)
	(dap_python.setup as function(string))("debugpy-adapter")
	dap_python.test_runner = "pytest"
	map("n", "<leader>tt", function()
		print("Leader is working!")
	end)
	map("n", "<leader>pp", function() print("This works") end)
	map("n", "<leader>dn", dap_python.test_method as function())
	map("n", "<leader>df", dap_python.test_class as function())
	map("v", "<leader>ds", dap_python.debug_selection as function())
end)
setup_plugin("dapui")
setup_plugin("nvim-dap-virtual-text")
setup_plugin("dap")
setup_plugin("mypy")
setup_plugin("nvim-lint")
------ DAP/quickix UI
setup_plugin("trouble.nvim")
setup_plugin("quicker")
setup_plugin("nvim-bqf")
------ terminal
setup_plugin("vim-floaterm")
setup_plugin("toggleterm")
------ code/task runners
setup_plugin("overseer")

-- LAYER 5: refactoring & code intelligence ========================================================================== 5
setup_plugin("refactoring")
------ project management
setup_plugin("project")
setup_plugin("telescope-project")

-- LAYER 6: version control & collaboration ========================================================================== 6
setup_plugin("jj")
setup_plugin("jujutsu")
setup_plugin("lazygit")
setup_plugin("git-conflict")
setup_plugin("neogit")
setup_plugin("jiejie")
setup_plugin("diffview")
setup_plugin("gitsigns")
setup_plugin("vim-fugitive")
-- git forges
setup_plugin("octo")
setup_plugin("gitlab-nvim")
setup_plugin("gitlab")

-- LAYER 7: UI polish & productivity ================================================================================= 7
setup_plugin("dashboard-nvim")
setup_plugin("dashboard")
setup_plugin("noice")
setup_plugin("modes")
------ UI (important for LSP)
setup_plugin("fidget")
setup_plugin("nvim-notify")
setup_plugin("headlines")
------ session management
setup_plugin("auto-session")
setup_plugin("persistence")

-- LAYER 8: miscellaneous/advanced =================================================================================== 8
utils.packadd("vimtex", function() vim.g.vimtex_view_method = "zathura" end)
setup_plugin("texmagic")
setup_plugin("schemastore")
setup_plugin("firenvim")
setup_plugin("render-markdown")
setup_plugin("jupytext")
setup_plugin("quarto")
setup_plugin("markdown-preview")
------ Lua / self-referential
setup_plugin("structlog")
setup_plugin("neorepl")
--]]
-- POST HOOKS =========================================================================================================

dofile(NVIM_HOME .. "/after_init.lua")

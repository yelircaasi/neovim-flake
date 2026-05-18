print("Entering after_init.lua.")

utils.printv("CONFIG_DIR: " .. CONFIG_DIR)
utils.printv("PLUGINS INCLUDED: " .. vim.inspect(utils.PLUGINS_INCLUDED))
utils.printbv(#utils.PLUGINS_INCLUDED .. " plugins included")

if HAS_NIX then
	vim.opt.runtimepath:remove("/home/isaac/.local/share/nvim/site")
end

local setup_plugin = utils.setup_plugin
local packadd = utils.packadd
local map = utils.map

vim.filetype.add({
	extension = { xit = "xit" },
})

-- utils.printbv(#utils.PLUGINS_INCLUDED .. " plugins included")

local telescope = utils.setup_plugin_default("telescope", function(telescope)
	telescope.setup({
		extensions = {
			fzf = {
				fuzzy = true, -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = "smart_case", -- or "ignore_case" or "respect_case"
				-- the default case_mode is "smart_case"
			},
		},
	})
	telescope.load_extension("fzf")
	print("loaded telescope with fzf-native")
end)

setup_plugin("bamboo", function(bamboo)
	(bamboo.setup)({
		style = "multiplex",
		colors = {
			bg0 = "#020802",
		},
	});
	(bamboo.load)()
	utils.printbv("Set up bamboo")
end)

if false then --=============
	setup_plugin("plenary")
	setup_plugin("nio")
	setup_plugin("nvim-web-devicons")

	setup_plugin("zen-mode")
	setup_plugin("lualine")
	setup_plugin("nvim-navic")
	setup_plugin("bufferline")
	setup_plugin("statuscol")

	setup_plugin("treesitter-modules")
	setup_plugin("dropbar")
	utils.packadd("nvim-navbuddy")
	setup_plugin("aerial")

	setup_plugin("oil")
	setup_plugin("yazi")
	setup_plugin("neo-tree")
	setup_plugin("nvim-tree")

	setup_plugin("pickme")
	-- setup_plugin("telescope") MOVED

	setup_plugin("fzf-lua")
	setup_plugin("deck")

	setup_plugin("mini.indent")
	setup_plugin("mini.keymap")
	setup_plugin("mini.sessions")

	setup_plugin("snacks")
	setup_plugin("blink")

	setup_plugin("hlslens")
	setup_plugin("hlsearch")

	setup_plugin("grug-far")
	setup_plugin("spectre")

	setup_plugin("flybuf")
	setup_plugin("stickybuf")
	setup_plugin("swm", function(swm)
		map("n", "<C-w>h", swm.h)
		map("n", "<C-w>j", swm.j)
		map("n", "<C-w>k", swm.k)
		map("n", "<C-w>l", swm.l)
	end)

	setup_plugin("smart-splits")

	setup_plugin("ufo")

	setup_plugin("NeoComposer")
	setup_plugin("nvim-macros", {
		json_file_path = "./macros.json",
		default_macro_register = "a",
		json_formatter = "jq",
	})
	setup_plugin("recorder")

	utils.packadd("vim-visual-multi")

	setup_plugin("leap")
	setup_plugin("flash")
	setup_plugin("hop")

	setup_plugin("rainbow-delimiters")
	setup_plugin("nvim-autopairs")

	utils.packadd("vim-sandwich")

	setup_plugin("nvim-surround")

	utils.packadd("vim-mundo")

	setup_plugin("mini.keymap")
	setup_plugin("hydra")
	setup_plugin("insx")
	setup_plugin("which-key")

	setup_plugin("indentmini")
	utils.packadd("indent-blankline")
	setup_plugin("nvim-anydent")
	setup_plugin("mini.align")
	utils.packadd("tabular")

	setup_plugin("nvim-treesitter-textobjects")
	utils.packadd("nvim-various-textobjs")

	setup_plugin("Comment")
	setup_plugin("todo-comments")
	utils.packadd("vim-commentary")

	setup_plugin("treesj")
	setup_plugin("dial")
	setup_plugin("harpoon-core")
	setup_plugin("marks")
	setup_plugin("markit")

	setup_plugin("nvim-pasta")

	setup_plugin("beam")

	setup_plugin("blink.cmp")
	setup_plugin("nvim-cmp")

	setup_plugin("friendly-snippets")
	setup_plugin("ultisnips")
	setup_plugin("LuaSnip")

	setup_plugin("cmp-nvim-lsp")
	setup_plugin("cmp-buffer")
	setup_plugin("cmp-path")
	setup_plugin("cmp-cmdline")

	setup_plugin("lsp-format")
	setup_plugin("lspkind")

	setup_plugin("lspsaga")

	setup_plugin("lazydev")
	setup_plugin("rustaceanvim")
	setup_plugin("crates")
	setup_plugin("haskell-tools")

	setup_plugin("none-ls")

	setup_plugin("guard")
	setup_plugin("conform")

	setup_plugin("asyncrun")
	setup_plugin("neotest-haskell")
	setup_plugin("neotest-python")
	setup_plugin("neotest")
	setup_plugin("dap-python", function(dap_python)
		(dap_python.setup)("debugpy-adapter")
		dap_python.test_runner = "pytest"
		map("n", "<leader>tt", function()
			print("Leader is working!")
		end)
		map("n", "<leader>pp", function()
			print("This works")
		end)
		map("n", "<leader>dn", dap_python.test_method)
		map("n", "<leader>df", dap_python.test_class)
		map("v", "<leader>ds", dap_python.debug_selection)
	end)
	setup_plugin("dapui")
	setup_plugin("nvim-dap-virtual-text")
	setup_plugin("dap")
	setup_plugin("mypy")
	setup_plugin("nvim-lint")

	setup_plugin("trouble.nvim")
	setup_plugin("quicker")
	setup_plugin("nvim-bqf")

	setup_plugin("vim-floaterm")
	setup_plugin("toggleterm")

	setup_plugin("overseer")

	setup_plugin("refactoring")

	setup_plugin("project")
	setup_plugin("telescope-project")

	setup_plugin("jj")
	setup_plugin("jujutsu")
	setup_plugin("lazygit")
	setup_plugin("git-conflict")
	setup_plugin("neogit")
	setup_plugin("jiejie")
	setup_plugin("diffview")
	setup_plugin("gitsigns")
	setup_plugin("vim-fugitive")

	setup_plugin("octo")
	setup_plugin("gitlab-nvim")
	setup_plugin("gitlab")

	setup_plugin("dashboard-nvim")
	setup_plugin("dashboard")
	setup_plugin("noice")
	setup_plugin("modes")

	setup_plugin("fidget")
	setup_plugin("nvim-notify")
	setup_plugin("headlines")

	setup_plugin("auto-session")
	setup_plugin("persistence")

	utils.packadd("vimtex", function()
		vim.g.vimtex_view_method = "zathura"
	end)
	setup_plugin("texmagic")
	setup_plugin("schemastore")
	setup_plugin("firenvim")
	setup_plugin("render-markdown")
	setup_plugin("jupytext")
	setup_plugin("quarto")
	setup_plugin("markdown-preview")

	setup_plugin("structlog")
	setup_plugin("neorepl")
end

utils.setup_plugin("xit")

vim.treesitter.language.register("py", "python")

vim.filetype.add({
	extension = { xit = "xit" },
})
vim.treesitter.language.register("xit", "xit")
vim.api.nvim_create_autocmd("FileType", {
	pattern = "xit",
	callback = function(ev)
		print("executing xit callback")
		vim.treesitter.language.add("xit", { path = PARSER_DIR .. "/xit.so" })
		vim.treesitter.start(ev.buf, "xit")
	end,
})

-- v_an, v_in, v_]n, v_[n now provide incremental selection of treesitter nodes

-- put in ftplugin/<filetype>.lua ?

-- config/
-- ├── ftdetect/
-- │   └── xit.lua
-- ├── ftplugin/
-- │   └── xit.lua       ← here
-- ├── syntax/
-- │   └── xit.lua
-- └── init.lua

vim.api.nvim_create_autocmd("FileType", {
	pattern = "lua",
	callback = function()
		vim.treesitter.start()
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		pcall(vim.treesitter.start) -- pcall: silently skips if no parser
	end,
})

vim.opt.indentexpr = "v:lua.vim.treesitter.indent()"
-- vim.opt.foldmethod = "expr" + foldexpr
-- vim.treesitter.query.add(lang, name, str) -- TODO
-- vim.treesitter.language.register() -- TODO

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.indentexpr = "v:lua.vim.treesitter.indent()"

-- Register filetype aliases
vim.treesitter.language.register("cpp", "cuda")
vim.treesitter.language.register("javascript", "jsx")
vim.treesitter.language.register("typescript", "tsx")

-- Optional: Auto-install parsers on first run (custom helper)
-- local parsers_to_ensure = { "c", "lua", "python", "javascript", "typescript", "bash", "json" }
-- for _, lang in ipairs(parsers_to_ensure) do
-- 	if not vim.treesitter.language.is_installed(lang) then  TODO
-- 		vim.cmd.TSInstall(lang)
-- 	end
-- end

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.indentexpr = "v:lua.vim.treesitter.indent()"

-- vim.g.treesitter_filetype_exclude = { "markdown", "txt" }

-- TODO: treesitter queries in RTP/queries/<lang>/

vim.treesitter.query.add_predicate(
	"python",
	"highlights",
	[[
  (function_definition
    name: (identifier) @function.def)
]]
)

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "rust", "go", "python" }, -- add languages
	callback = function()
		if not vim.treesitter.language.get_lang(vim.bo.filetype) then
			-- Or use a plugin/helper for installation
			print("No Treesitter parser for " .. vim.bo.filetype)
		end
	end,
})

pcall(vim.api.nvim_del_user_command, "TSInstall")
pcall(vim.api.nvim_del_user_command, "TSInstallSync") -- if it exists
pcall(vim.api.nvim_del_user_command, "TSInstallFromGrammar")

-- OR:
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

-- To manually toggle highlighting at runtime:
-- ```vim
-- :TSEnable highlight
-- :TSDisable highlight
-- ```

-- print(vim.o.runtimepath:find(vim.env.VIMRUNTIME) ~= nil)

-- print(vim.inspect(vim.opt.runtimepath))

-- setup_plugin("nvim-treesitter", function(treesitter)
-- 	local TS_LANGUAGES = {
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

-- 	utils.printbv("Setting up treesitter.")
-- 	local my_install_dir = (not HAS_NIX) and ((vim.fn.stdpath("data")) .. "/site") or DERIVATION_DIR
-- 	utils.printv(my_install_dir)
-- 	local my_parser_install_dir = (not HAS_NIX) and (vim.fn.stdpath("data")) .. "/site/parsers" or nil
-- 	utils.printv(my_parser_install_dir)
-- 	local my_ensure_installed = HAS_NIX and {} or TS_LANGUAGES
-- 	utils.printv(vim.inspect(my_ensure_installed))

-- 	utils.printbv("Treesitter exists")
-- 	(treesitter.setup)({
-- 		install_dir = my_install_dir,
-- 		parser_install_dir = my_parser_install_dir,
-- 		ensure_installed = my_ensure_installed,
-- 		highlight = { enable = true },
-- 		indent = { enable = true },
-- 	})
-- end)

local my_install_dir = (not HAS_NIX) and ((vim.fn.stdpath("data")) .. "/site") or DERIVATION_DIR

local my_parser_install_dir = my_install_dir .. "/parser"
-- (not HAS_NIX) and (vim.fn.stdpath("data")) .. "/site/parsers" or DERIVATION_DIR ..

local my_ensure_installed = HAS_NIX and {} or TS_LANGUAGES

utils.printbv("Setting up treesitter.")
utils.printb("my_install_dir:        " .. my_install_dir)
utils.printb("my_parser_install_dir: " .. my_parser_install_dir)
utils.printb("my_ensure_installed:   " .. vim.inspect(my_ensure_installed))

-- vim.treesitter.setup(
--     {
-- 		install_dir = my_install_dir,
-- 		parser_install_dir = my_parser_install_dir,
-- 		ensure_installed = my_ensure_installed,
-- 		highlight = { enable = true },
-- 		indent = { enable = true },
-- 	}
-- )

parser_root = vim.fn.fnamemodify(OPT_DIR, ":h:h:h")
vim.opt.runtimepath:prepend(PARSER_DIR)

vim.opt.runtimepath:prepend("/nix/store/ydlwparyk4mxl6wzhlp3x54zl3nk82c5-pde")

vim.opt.runtimepath:remove("/home/isaac/.local/share/nvim/site")

setup_plugin("dial")

-- debug.getinfo(2, "S").source:sub(2):match("(.*/)") or "./"

-- OVERSEER
local overseer = utils.setup_plugin("overseer", function(overseer)
	overseer.setup({ templates = { "builtin", "my_custom_just_provider" } })
end)

local overseer = utils.get_plugin("overseer")
-- print(overseer)

-- sky.nvim?
-- just.nvim
-- Task.nvim
-- resession.nvim
-- toggleterm.nvim

local function run_just_task()
	local opts = {}
	-- Use vim.system to get just tasks as a table
	local obj = vim.system({ "just", "--summary" }, { text = true }):wait()
	local tasks = vim.split(obj.stdout, " ")

	vim.ui.select(tasks, { prompt = "Run Just Task:" }, function(choice)
		if choice then
			-- Run in a floating terminal (using toggleterm or built-in)
			vim.cmd("TermExec cmd='just " .. choice .. "'")
		end
	end)
end

-- local overseer = require("overseer")

overseer.register_template({
	name = "Taskfile Runner",
	generator = function(opts, cb)
		-- 1. Check for Taskfile
		local taskfile = vim.fs.find({ "Taskfile.yml", "Taskfile.yaml" }, { upward = true, path = opts.dir })[1]
		if not taskfile then
			cb({})
			return
		end

		-- 2. Fetch tasks via CLI
		vim.system({ "task", "--list-all", "--json" }, { text = true }, function(obj)
			if obj.code ~= 0 then
				cb({})
				return
			end

			local data = vim.json.decode(obj.stdout)
			local tasks = {}

			-- 3. Map JSON tasks to Overseer format
			for _, task in ipairs(data.tasks or {}) do
				table.insert(
					tasks,
					overseer.wrap_template({
						name = task.name,
						desc = task.desc or "Taskfile task",
						params = {},
						builder = function()
							return {
								cmd = { "task" },
								args = { task.name },
								components = { "default", "on_result_diagnostics" },
							}
						end,
					}, { name = task.name })
				)
			end

			cb(tasks)
		end)
	end,
	condition = {
		callback = function(opts)
			return vim.fs.find({ "Taskfile.yml", "Taskfile.yaml" }, { upward = true, path = opts.dir })[1] ~= nil
		end,
	},
})

overseer.register_template({
	name = "Taskfile (with Params)",
	generator = function(opts, cb)
		local taskfile = vim.fs.find({ "Taskfile.yml", "Taskfile.yaml" }, { upward = true, path = opts.dir })[1]
		if not taskfile then
			return cb({})
		end

		vim.system({ "task", "--list-all", "--json" }, { text = true }, function(obj)
			if obj.code ~= 0 then
				return cb({})
			end
			local data = vim.json.decode(obj.stdout)
			local tasks = {}

			for _, task in ipairs(data.tasks or {}) do
				table.insert(
					tasks,
					overseer.wrap_template({
						name = task.name,
						desc = task.desc,
						-- Define parameters here
						params = {
							args = {
								type = "string",
								name = "Extra Arguments",
								desc = "Vars to pass (e.g. VERSION=1.0)",
								optional = true,
							},
						},
						builder = function(params)
							local cmd_args = { task.name }
							if params.args and params.args ~= "" then
								table.insert(cmd_args, params.args)
							end

							return {
								cmd = { "task" },
								args = cmd_args,
								components = {
									"default",
									{ "display_duration", detail_level = 2 },
									"on_output_summarize",
									"on_exit_set_status",
								},
							}
						end,
					}, { name = task.name })
				)
			end
			cb(tasks)
		end)
	end,
})

local function run_task_with_ui()
	vim.system({ "task", "--list-all", "--summary" }, { text = true }, function(obj)
		local tasks = {}
		for line in obj.stdout:gmatch("[^\r\n]+") do
			local name = line:match("^%* ([%w%-_]+):")
			if name then
				table.insert(tasks, name)
			end
		end

		vim.schedule(function()
			vim.ui.select(tasks, { prompt = "Execute Task:" }, function(choice)
				if not choice then
					return
				end
				-- Run in a background job or terminal
				vim.cmd("vsplit | term task " .. choice)
			end)
		end)
	end)
end

-- with watcher
overseer.register_template({
	name = "Taskfile (with Watcher)",
	generator = function(opts, cb)
		local taskfile = vim.fs.find({ "Taskfile.yml", "Taskfile.yaml" }, { upward = true, path = opts.dir })[1]
		if not taskfile then
			return cb({})
		end

		vim.system({ "task", "--list-all", "--json" }, { text = true }, function(obj)
			if obj.code ~= 0 then
				return cb({})
			end
			local data = vim.json.decode(obj.stdout)
			local tasks = {}

			for _, task in ipairs(data.tasks or {}) do
				table.insert(
					tasks,
					overseer.wrap_template({
						name = task.name,
						desc = task.desc,
						params = {
							args = { type = "string", name = "Vars", optional = true },
							watch = { type = "boolean", name = "Watch files?", default = false },
						},
						builder = function(params)
							local cmd_args = { task.name }
							if params.args and params.args ~= "" then
								table.insert(cmd_args, params.args)
							end

							local components = { "default" }
							if params.watch then
								-- This component tells Overseer to restart the task on save
								table.insert(components, { "on_save_reload", delay = 500 })
							end

							return {
								cmd = { "task" },
								args = cmd_args,
								components = components,
							}
						end,
					}, { name = task.name })
				)
			end
			cb(tasks)
		end)
	end,
})

utils.setup_plugin("lualine", {
	sections = {
		lualine_x = {
			{
				"overseer",
				label = "Tasks: ", -- Prefix for the section
				unique = true, -- Only show one representative icon per state
			},
		},
	},
})

overseer.register_template({
	name = "Taskfile with Diagnostics",
	generator = function(opts, cb)
		local taskfile = vim.fs.find({ "Taskfile.yml", "Taskfile.yaml" }, { upward = true, path = opts.dir })[1]
		if not taskfile then
			return cb({})
		end

		vim.system({ "task", "--list-all", "--json" }, { text = true }, function(obj)
			if obj.code ~= 0 then
				return cb({})
			end
			local data = vim.json.decode(obj.stdout)
			local tasks = {}

			for _, task in ipairs(data.tasks or {}) do
				table.insert(
					tasks,
					overseer.wrap_template({
						name = task.name,
						params = {
							watch = { type = "boolean", name = "Watch files?", default = false },
						},
						builder = function(params)
							local components = { "default" }
							if params.watch then
								table.insert(components, { "on_save_reload", delay = 500 })
							end

							-- ADDED: This component parses the output into diagnostics
							table.insert(components, {
								"on_result_diagnostics",
								remove_on_restart = true,
								-- Standard Python error format (adjust as needed)
								errorformat = [[%f:%l:%c: %t%*[^ ] %m,%f:%l: %t%*[^ ] %m]],
							})

							return {
								cmd = { "task" },
								args = { task.name },
								components = components,
							}
						end,
					}, { name = task.name })
				)
			end
			cb(tasks)
		end)
	end,
})

-- OverseerRun
-- OverseerToggle

local function taskfile_picker()
	vim.cmd.packadd("telescope")
	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	local conf = require("telescope.config").values
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")

	-- Get tasks from Taskfile
	local handle = io.popen("task --list-all --summary")
	local result = handle:read("*a")
	handle:close()

	local tasks = {}
	for line in result:gmatch("[^\r\n]+") do
		local name = line:match("^%* ([%w%-_]+):")
		if name then
			table.insert(tasks, name)
		end
	end

	pickers
		.new({}, {
			prompt_title = "Taskfile Tasks",
			finder = finders.new_table({ results = tasks }),
			sorter = conf.generic_sorter({}),
			attach_mappings = function(prompt_bufnr, map)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local selection = action_state.get_selected_entry()
					-- Execute in a terminal
					vim.cmd("split | term task " .. selection[1])
				end)
				return true
			end,
		})
		:find()
end

vim.keymap.set("n", "<leader>tk", taskfile_picker, { desc = "Pick Taskfile task" })

-- common formats for
-- Python (Ruff/Flake8):** `%f:%l:%c: %m`
-- Go (golangci-lint):** `%f:%l:%c: %m`
-- Generic (File:Line:Msg):** `%f:%l: %m`

-- xpcall example
if false then
	local function my_function()
		error("Oops!")
	end

	local function my_handler(err)
		return "Custom Error Handler: " .. debug.traceback(err)
	end

	local status, err_msg = xpcall(my_function, my_handler)

	if not status then
		print(err_msg) -- Will print the error + the line-by-line stack trace
	end

	-- pcall example
	local status, telescope = pcall(require, "telescope")
	if not status then
		return -- Silently exit if plugin isn't installed
	end
end

-- symlinking
if false then
	local plugins = {
		["user/repo-name"] = { path = "source_path/repo1" },
		["another-user/cool-plugin"] = { path = "/home/user/dev/cool-plugin" },
		["someone/awesome-nvim"] = { path = "~/projects/awesome-nvim" },
	}

	local PLUGIN_DIR = vim.fn.stdpath("data") .. "/site/pack/plugins/start"

	-- Extract repo name from "user/repo-name" format
	local function get_repo_name(plugin_id)
		return plugin_id:match("([^/]+)$")
	end

	-- Create symbolic links
	for plugin_id, config in pairs(plugins) do
		local repo_name = get_repo_name(plugin_id)
		local source_path = vim.fn.expand(config.path)
		local target_path = PLUGIN_DIR .. "/" .. repo_name

		-- Check if source exists
		if vim.fn.isdirectory(source_path) == 0 then
			vim.notify(string.format("Warning: Source path does not exist: %s", source_path), vim.log.levels.WARN)
		else
			-- Remove existing link/directory if it exists
			vim.fn.delete(target_path, "rf")

			-- Create symbolic link
			local success = vim.loop.fs_symlink(source_path, target_path)

			if success then
				vim.notify(string.format("✓ Linked: %s -> %s", repo_name, source_path), vim.log.levels.INFO)
			else
				vim.notify(string.format("✗ Failed to link: %s", plugin_id), vim.log.levels.ERROR)
			end
		end
	end

	print("Symbolic links created!")
end

-- LSP

-- lua/lsp/python.lua
-- Neovim 0.12+ native LSP for Python: Ruff + mypy + conform.nvim format-on-save
-- Best practices as of May 2026

local conform = utils.get_plugin("conform")

local function on_attach(client, bufnr)
	-- Disable Ruff hover if you add another server like pyright/basedpyright later
	if client.name == "ruff" then
		client.server_capabilities.hoverProvider = false
	end

	-- Common keymaps (adjust as needed)
	local opts = { buffer = bufnr, silent = true }
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "<leader>cf", function()
		conform.format({ bufnr = bufnr })
	end, opts)
end

-- Ruff LSP (fast linting, formatting, import organization, etc.)
-- Place this in after/lsp/ruff.lua or define inline
vim.lsp.config("ruff", {
	cmd = { "ruff", "server" },
	filetypes = { "python" },
	root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
	on_attach = on_attach,
	init_options = {
		settings = {
			-- Ruff server settings (see Ruff docs)
			logLevel = "info", -- or "debug" for troubleshooting
			-- Example: enable specific rules or configure line length
			-- lint = { select = { "ALL" }, ignore = {} },
			-- format = { preview = true },
		},
	},
})

-- Enable Ruff
vim.lsp.enable("ruff")

-- Optional: Add pyright/basedpyright for richer completion & type checking
-- (Uncomment if desired; it complements Ruff well)
--[[
vim.lsp.config("pyright", {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "setup.py", ... },
  on_attach = on_attach,
  settings = {
    pyright = {
      disableOrganizeImports = true, -- Let Ruff handle imports
    },
    python = {
      analysis = {
        typeCheckingMode = "basic", -- or "strict"
        diagnosticMode = "workspace",
      },
    },
  },
})
vim.lsp.enable("pyright")
--]]

-- Mypy integration
-- Option 1: Via nvim-lint (recommended for live diagnostics)
-- Option 2: Use conform for on-save mypy checks (slower but thorough)

-- Diagnostics config (best practices)
vim.diagnostic.config({
	virtual_text = { prefix = "●", spacing = 2 },
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = { border = "rounded", source = "always" },
})

-- Conform.nvim setup for formatting on save (Ruff + optional mypy)
conform.setup({
	formatters_by_ft = {
		python = {
			"ruff_fix", -- Auto-fix lint errors
			"ruff_format", -- Ruff formatter (replaces Black)
			"ruff_organize_imports",
			-- "mypy"             -- Uncomment for type checking on save (slow; better in CI)
		},
	},
	format_on_save = {
		timeout_ms = 1000,
		lsp_format = "fallback", -- Use LSP formatting if available
	},
	-- Custom mypy formatter (runs mypy and reports errors)
	formatters = {
		mypy = {
			command = "mypy",
			args = { "--no-error-summary", "--show-column-numbers", "--no-color-output", "$FILENAME" },
			stdin = false,
			-- Ignore exit code so it doesn't block save; use for diagnostics instead
			ignore_exitcode = true,
		},
	},
})

-- Auto-format on save via autocmd (fallback / extra control)
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.py",
	callback = function(args)
		conform.format({ bufnr = args.buf })
	end,
	desc = "Format Python on save with conform",
})

-- Optional: nvim-lint for mypy + ruff linting (faster live feedback)
-- Add `mfussenegger/nvim-lint` plugin if you want this
--[[
require("lint").linters_by_ft = {
  python = { "ruff", "mypy" },
}
vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
--]]

-- alternative

vim.lsp.config("ruff", {
	cmd = { "ruff", "server" },
	filetypes = { "python" },
	root_markers = { "pyproject.toml", "ruff.toml", ".git" },
	settings = {
		-- Any specific ruff settings go here
	},
})

-- PyLSP: Specifically configured for Mypy type checking
vim.lsp.config("pylsp", {
	cmd = { "pylsp" },
	filetypes = { "python" },
	settings = {
		pylsp = {
			plugins = {
				-- Disable standard lints/formatters provided by Ruff
				pyflakes = { enabled = false },
				pycodestyle = { enabled = false },
				mccabe = { enabled = false },
				-- Enable Mypy
				pylsp_mypy = {
					enabled = true,
					live_mode = true, -- Provides type-checking as you type
					strict = true,
				},
			},
		},
	},
})

-- Enable both servers
vim.lsp.enable("ruff")
vim.lsp.enable("pylsp")

-- 2. FORMATTING (Conform.nvim)
-- Using conform for "Format on Save" with Ruff
conform.setup({
	formatters_by_ft = {
		python = { "ruff_format", "ruff_organize_imports" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})

-- 3. MODERN LSP KEYMAPS (Neovim 0.12 Defaults)
-- Neovim 0.12 provides better defaults, but here are the standard 2026 mappings:
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local opts = { buffer = args.buf }
		-- Note: 'grn' (rename), 'gra' (code action), and 'grr' (references)
		-- are now built-in defaults in 0.12.
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "<leader>cl", vim.lsp.codelens.run, opts)
	end,
})

-- use Nix to install:
-- pip install "python-lsp-server[all]" pylsp-mypy

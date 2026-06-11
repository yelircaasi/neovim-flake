-- OVERSEER =================================================================================================

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
setup_plugin("moonicipal", {}) -- https://github.com/idanarye/nvim-moonicipal Task runner with focus on rapidly changing personal tasks

-- TODO: https://tamerlan.dev/setting-up-a-testing-environment-in-neovim/

-- vim.api.nvim_create_autocmd("TermOpen", {
-- 	group = vim.api.nvim_create_augroup("neotest_terminal_fix", { clear = true }),
-- 	pattern = "*",
-- 	callback = function()
-- 		-- Force Neovim out of insert/terminal mode immediately when a terminal opens
-- 		vim.cmd("stopinsert")
--
-- 		-- Map 'q' dynamically so if you DO open the output float,
-- 		-- you can instantly dismiss it with a single keypress.
-- 		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = true, silent = true })
-- 	end,
-- })

vim.api.nvim_create_autocmd("TermOpen", {
	desc = "Auto enter insert mode when opening a terminal",
	pattern = "*",
	callback = function()
		-- Wait briefly just in case we immediately switch out of the buffer
		vim.defer_fn(function()
			if vim.api.nvim_buf_get_option(0, "buftype") == "terminal" then
				vim.cmd([[startinsert]])
			end
		end, 100)
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "term://*",
	callback = function()
		-- If we find ourselves in a terminal buffer that we didn't explicitly ask for
		-- jump back to the previous buffer immediately
		if vim.bo.buftype == "terminal" then
			vim.cmd("stopinsert")
			vim.cmd("wincmd p")
		end
	end,
})

if false then
	local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

	-- Enter insert mode when switching to terminal
	autocmd("TermOpen", {
		command = "setlocal listchars= nonumber norelativenumber nocursorline",
	})

	autocmd("TermOpen", {
		pattern = "term://*",
		command = "startinsert",
	})

	-- Close terminal buffer on process exit
	autocmd("BufLeave", {
		pattern = "term://*",
		command = "stopinsert",
	})
end

vim.opt.shell = "/bin/sh"

local run_test = function()
	neotest.run.run({
		strategy = "integrated",
		-- Ensure the output window doesn't steal focus
		extra_args = { "--capture=no" },
	})
	-- Force the cursor back to the current window immediately
	-- in case a strategy plugin is being "helpful" and jumping focus.
	vim.schedule(function()
		vim.cmd("stopinsert")
		vim.api.nvim_set_current_win(vim.api.nvim_get_current_win())
	end)
end

setup_plugin("neotest", function(neotest)
	-- local function get_pytest()
	-- 	local pt = utils.get_executable("pytest")
	-- 	return pt
	-- end
	-- local function get_python()
	-- 	local py = utils.get_executable("python")
	-- 	return py
	-- end
	-- print(get_pytest())
	-- print(get_python())
	--
	-- 	neotest.setup({
	-- 	-- consumers = {},
	-- 	-- default_strategy = "integrated",
	-- 	-- strategies = {
	-- 	-- 	integrated = {
	-- 	-- 		width = 120,
	-- 	-- 	},
	-- 	-- },
	-- 	-- default_strategy = "async", -- or try "async"
	-- 	-- output = {
	-- 	-- 	open_on_run = false, -- don't auto-open terminal output
	-- 	-- },
	-- 	-- summary = {
	-- 	-- 	open_on_run = true, -- open summary panel instead
	-- 	-- },
	-- 	adapters = {
	-- 		require("neotest-python")({
	-- 			-- Extra arguments for nvim-dap configuration
	-- 			-- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
	-- 			dap = { justMyCode = false },

	-- 			-- Command line arguments for runner
	-- 			-- Can also be a function to return dynamic values
	-- 			args = { "--log-level", "DEBUG" },
	-- 			-- Runner to use. Will use pytest if available by default.
	-- 			-- Can be a function to return dynamic value.
	-- 			runner = get_pytest,
	-- 			-- Custom python path for the runner.
	-- 			-- Can be a string or a list of strings.
	-- 			-- Can also be a function to return dynamic value.
	-- 			-- If not provided, the path will be inferred by checking for
	-- 			-- virtual envs in the local directory and for Pipenv/Poetry configs
	-- 			python = get_python,
	-- 			-- Returns if a given file path is a test file.
	-- 			-- NB: This function is called a lot so don't perform any heavy tasks within it.
	-- 			is_test_file = function(file_path)
	-- 				local file_name = vim.fn.fnamemodify(file_path, ":t")
	-- 				print(file_name)
	-- 				return vim.regex("^test_\\|_test\\.py$"):match_str(file_name) ~= nil
	-- 			end,
	-- 			-- !!EXPERIMENTAL!! Enable shelling out to `pytest` to discover test
	-- 			-- instances for files containing a parametrize mark (default: false)
	-- 			-- pytest_discover_instances = true,
	-- 		}),
	-- 	},
	-- })

	neotest.setup({
		output = {
			open_on_run = false,
			enter = false,
		},
		output_panel = {
			open_on_run = false,
			enter = false,
		},
		strategy = {
			integrated = {
				pty = false,
				height = 20,
			},
		},
		run = {
			enabled = true,
		},
		adapters = {
			require("neotest-python")({
				dap = { justMyCode = false },
				args = { "--log-level", "DEBUG" },
				runner = utils.get_executable("pytest"),
				python = utils.get_executable("python"),
				is_test_file = function(file_path)
					local file_name = vim.fn.fnamemodify(file_path, ":t")
					return vim.regex("^test_\\|_test\\.py$"):match_str(file_name) ~= nil
				end,
				pytest_discover_instances = true,
			}),
		},
	})

	local nmap = function(lhs, rhs, desc)
		vim.keymap.set("n", lhs, rhs, { silent = true, desc = desc })
	end

	-- Run
	nmap("<leader>tt", function()
		neotest.run.run({
			strategy = function(spec)
				-- spec.strategy is the default table. We override it to be 'headless'
				spec.strategy = {
					type = "integrated",
					-- This ensures it doesn't try to open a TTY that hijacks focus
					detach = true,
				}
				return spec
			end,
		})
	end, "Run nearest test")
	nmap("<leader>tf", function()
		neotest.run.run(vim.fn.expand("%"))
	end, "Run tests in file")
	nmap("<leader>ta", function()
		neotest.run.run(vim.fn.getcwd())
	end, "Run all tests")
	nmap("<leader>tl", function()
		neotest.run.run_last()
	end, "Re-run last test")

	-- Debug
	nmap("<leader>td", function()
		neotest.run.run({ strategy = "dap" })
	end, "Debug nearest test")

	-- Stop
	nmap("<leader>ts", function()
		neotest.run.stop()
	end, "Stop running tests")

	-- UI
	nmap("<leader>to", function()
		neotest.output.open({ enter = false, short = false })
	end, "Open test output")
	nmap("<leader>tO", function()
		neotest.output_panel.toggle()
	end, "Toggle output panel")
	nmap("<leader>tS", function()
		neotest.summary.toggle()
	end, "Toggle test summary")

	-- Jump
	nmap("[t", function()
		neotest.jump.prev({ status = "failed" })
	end, "Jump to previous failed test")
	nmap("]t", function()
		neotest.jump.next({ status = "failed" })
	end, "Jump to next failed test")
	nmap("[T", function()
		neotest.jump.prev()
	end, "Jump to previous test")
	nmap("]T", function()
		neotest.jump.next()
	end, "Jump to next test")
end)

if false then
	setup_plugin("neotest-haskell")
	setup_plugin("neotest-python")
end

-- vim.api.nvim_create_autocmd("TermOpen", {
-- 	group = vim.api.nvim_create_augroup("neotest_term_settings", { clear = true }),
-- 	callback = function()
-- 		-- Stop terminal buffers from automatically entering Terminal mode
-- 		vim.cmd("stopinsert")

-- 		-- Optional: Map 'q' to close the output float easily
-- 		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = true })
-- 	end,
-- })

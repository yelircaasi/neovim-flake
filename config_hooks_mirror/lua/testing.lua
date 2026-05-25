-- TODO: https://tamerlan.dev/setting-up-a-testing-environment-in-neovim/
setup_plugin("neotest", function(neotest)
	neotest.setup({
		adapters = {
			require("neotest-python")({
				-- Extra arguments for nvim-dap configuration
				-- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
				dap = { justMyCode = false },
				-- Command line arguments for runner
				-- Can also be a function to return dynamic values
				args = { "--log-level", "DEBUG" },
				-- Runner to use. Will use pytest if available by default.
				-- Can be a function to return dynamic value.
				runner = function()
					return utils.get_executable("pytest")
				end,
				-- Custom python path for the runner.
				-- Can be a string or a list of strings.
				-- Can also be a function to return dynamic value.
				-- If not provided, the path will be inferred by checking for
				-- virtual envs in the local directory and for Pipenev/Poetry configs
				python = function()
					return utils.get_executable("python")
				end,
				-- Returns if a given file path is a test file.
				-- NB: This function is called a lot so don't perform any heavy tasks within it.
				is_test_file = function(file_path)
					local file_name = vim.fn.fnamemodify(file_path, ":t")
					print(file_name)
					return vim.regex("^test_\\|_test\\.py$"):match_str(file_name) ~= nil
				end,
				-- !!EXPERIMENTAL!! Enable shelling out to `pytest` to discover test
				-- instances for files containing a parametrize mark (default: false)
				-- pytest_discover_instances = true,
			}),
		},
	})

	local nmap = function(lhs, rhs, desc)
		vim.keymap.set("n", lhs, rhs, { silent = true, desc = desc }) end

	-- Run
	nmap("<leader>tt", function() neotest.run.run() end, "Run nearest test")
	nmap("<leader>tf", function() neotest.run.run(vim.fn.expand("%")) end, "Run tests in file")
	nmap("<leader>ta", function() neotest.run.run(vim.fn.getcwd()) end, "Run all tests")
	nmap("<leader>tl", function() neotest.run.run_last() end, "Re-run last test")

	-- Debug
	nmap("<leader>td", function() neotest.run.run({ strategy = "dap" }) end, "Debug nearest test")

	-- Stop
	nmap("<leader>ts", function() neotest.run.stop() end, "Stop running tests")

	-- UI
	nmap("<leader>to", function() neotest.output.open({ enter = true }) end, "Open test output")
	nmap("<leader>tO", function() neotest.output_panel.toggle() end, "Toggle output panel")
	nmap("<leader>tS", function() neotest.summary.toggle() end, "Toggle test summary")

	-- Jump
	nmap("[t", function() neotest.jump.prev({ status = "failed" }) end, "Jump to previous failed test")
	nmap("]t", function() neotest.jump.next({ status = "failed" }) end, "Jump to next failed test")
	nmap("[T", function() neotest.jump.prev() end, "Jump to previous test")
	nmap("]T", function() neotest.jump.next() end, "Jump to next test")
end)

setup_plugin("neotest-haskell")
setup_plugin("neotest-python")

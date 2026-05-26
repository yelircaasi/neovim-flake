vim.opt.shell = utils.get_executable("sh")
local pytest_exec = utils.get_executable("pytest")
local python_exec = utils.get_executable("python")
print(pytest_exec)
print(python_exec)

-- neotest = utils.get_plugin("neotest")
-- neotest.setup({
setup_plugin("neotest", function(neotest)
	neotest.setup({
		adapters = {
			require("neotest-python")({
				dap = { justMyCode = false },
			}),
			python = python_exec,
			runner = pytest_exec,
		},
		strategies = {
			integrated = {
				width = 120,
			},
		},
	})
	vim.keymap.set("n", "<leader>tt", function()
		neotest.run.run({
			strategy = "integrated",
			enter = false,
		})
	end, { desc = "Run nearest test" })
end)

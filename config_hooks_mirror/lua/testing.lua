vim.opt.shell = utils.get_executable("sh") -- TODO: move to global opts file?

-- neotest = utils.get_plugin("neotest")
-- neotest.setup({
setup_plugin("neotest", function(neotest)
	neotest.setup({
		adapters = {
			require("neotest-python")({
				dap = { justMyCode = false },
				python = function(_)
					return utils.get_executable("python")
				end,
				runner = "pytest",
			}),
		},
		strategies = {
			integrated = {
				width = 120,
			},
		},
	})

	local nmap = function(lhs, rhs, desc)
		vim.keymap.set("n", lhs, rhs, { silent = true, desc = desc })
	end

	nmap("<leader>tt", function()
		neotest.run.run({
			strategy = "integrated",
			enter = false,
		})
	end, "Run nearest test")

	nmap("<leader>to", function()
		neotest.output.open({ enter = false, short = false })
	end, "Open test output")
	nmap("<leader>tO", function()
		neotest.output_panel.toggle()
	end, "Toggle output panel")
	nmap("<leader>tS", function()
		neotest.summary.toggle()
	end, "Toggle test summary")
end)

-- https://github.com/andythigpen/nvim-coverage
-- DESC
local coverage_defaults = {} -- TODO
setup_plugin("coverage", coverage_defaults)

-- LINK
-- for lua testing
local neotest_plenary_defaults = {} -- TODO
setup_plugin("neotest-plenary", neotest_plenary_defaults)

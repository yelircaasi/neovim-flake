vim.opt.shell = utils.get_executable("sh") -- TODO: move to global opts file?

-- https://github.com/nvim-neotest/neotest
-- An extensible framework for interacting with tests within NeoVim.
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
-- Displays test coverage data in the sign column
local coverage_sample_config = {
	commands = true, -- create commands
	highlights = {
		-- customize highlight groups created by the plugin
		covered = { fg = "#C3E88D" }, -- supports style, fg, bg, sp (see :h highlight-gui)
		uncovered = { fg = "#F07178" },
	},
	signs = {
		-- use your own highlight groups or text markers
		covered = { hl = "CoverageCovered", text = "▎" },
		uncovered = { hl = "CoverageUncovered", text = "▎" },
	},
	summary = {
		-- customize the summary pop-up
		min_coverage = 80.0, -- minimum coverage threshold (used for highlighting)
	},
	lang = {
		-- customize language specific settings
	},
}
setup_plugin("coverage", coverage_sample_config)

-- https://github.com/nvim-neotest/neotest-plenary
-- for lua testing
local neotest_plenary_defaults = {} -- TODO
setup_plugin("neotest-plenary", neotest_plenary_defaults)

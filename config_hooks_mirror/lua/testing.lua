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

	local function nmap(spec)
		spec.mode = "n"
		spec.opts = { silent = true }
		map_explicit(specs)
	end

	nmap({
		sequence = "<leader>tt",
		action = function()
			neotest.run.run({
				strategy = "integrated",
				enter = false,
			})
		end,
		desc = "Run nearest test",
	})

	nmap({
		sequence = "<leader>to",
		action = function()
			neotest.output.open({ enter = false, short = false })
		end,
		desc = "Open test output",
	})
	nmap({
		sequence = "<leader>tO",
		action = neotest.output_panel.toggle,
		desc = "Toggle output panel",
	})
	nmap({
		sequence = "<leader>tS",
		action = neotest.summary.toggle,
		desc = "Toggle test summary",
	})
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

-- TODO: add to neotest setup
-- https://github.com/nvim-neotest/neotest-plenary
-- for lua testing
setup_plugin("neotest-plenary") -- just to test installation & requiring

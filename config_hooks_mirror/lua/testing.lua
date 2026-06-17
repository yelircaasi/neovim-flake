vim.opt.shell = utils.get_executable("sh") -- TODO: move to global opts file?

-- https://github.com/nvim-neotest/neotest
-- An extensible framework for interacting with tests within NeoVim.
local neotest_defaults = {
	adapters = {},
	strategies = {
		integrated = {
			width = 120,
		},
	},
}

local function setup_neotest_for_lang(language, adapter, overrides)
	cfg = vim.tbl_deep_extend("force", neotest_defaults, overrides or {})
	cfg.adapters[language] = adapter
	neotest = setup_plugin("neotest", cfg)

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
end

-- https://github.com/andythigpen/nvim-coverage
-- Displays test coverage data in the sign column
local coverage_defaults = { -- just sample config; not exchaustive
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
local function setup_coverage_for_lang(language, lang_specs, overrides)
	cfg = vim.tbl_deep_extend("force", cfg, overrides or {})
	cfg.lang[language] = lang_specs
	setup_plugin("coverage", cfg)
end

---@class LanguageTestingConfig
---@field language string
---@field coverage_langspec LanguageCoverageConfig
---@field neotest_adapter LanguageNeotestAdapterConfig
---@field neotest_overrides NeotestConfig
---@field coverage_overrides CoverageConfig

local function setup_testing_for_lang(lang_cfg)
	setup_neotest_for_lang(lang_cfg.language, lang_cfg.neotest_adapter, lang_cfg.neotest_overrides)
	setup_coverage_for_lang(lang_cfg.language, lang_cfg.coverage_langspec, lang_cfg.coverage_overrides)
end

return { setup_testing_for_lang = setup_testing_for_lang }

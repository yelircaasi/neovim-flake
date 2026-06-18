local function setup_fsread()
	setup_plugin("fsread", function(fsread)
		vim.g.flow_strength = 0.7 -- low: 0.3, middle: 0.5, high: 0.7 (default)
		vim.api.nvim_set_hl(0, "FSPrefix", { fg = "#cdd6f4" })
		vim.api.nvim_set_hl(0, "FSSuffix", { fg = "#6C7086" })

		-- :FSRead " Flow state visual range
		-- :FSClear " Clear all flow states
		-- :FSToggle " Toggle flow state
	end)
end

local function setup_wezterm_run()
	-- TODO
	-- require("wezterm_send").setup()
	vim.opt.runtimepath:prepend("/home/isaac/repos/wezterm-run.nvim")
	local wezrun = require("wezterm-run")
	wezrun.setup()
end

local function setup_consilium()
	-- TODO
	vim.opt.runtimepath:prepend("/home/isaac/repos/consilium.nvim")
	local consilium = require("consilium")
	consilium.setup()
end

setup_fsread()
setup_wezterm_run()
setup_consilium()

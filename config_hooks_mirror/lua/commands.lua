vim.api.nvim_create_user_command("PickMe", function()
	setup_plugin("pickme", function(pickme)
		-- Include at least one of these pickers:
		-- utils.packadd("snacks") -- For snacks.picker
		-- utils.packadd("telescope") -- For telescope
		-- utils.packadd("fzf-lua") -- For fzf-lua
		pickme.setup({
			picker_provider = "snacks", -- Default provider
		})
	end)
end, {
	nargs = "*",
	-- complete = function()
	-- 	return {}
	-- end,
})

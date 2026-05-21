setup_plugin("copilot-lua", function(copilot)
	local function setup_copilot()
		copilot.setup({
			suggestion = { enabled = true },
			panel = { enabled = true },
		})
	end
	vim.api.nvim_create_user_command("Copilot", setup_copilot)
	vim.api.nvim_create_autocmd("InsertEnter", setup_copilot)
end)

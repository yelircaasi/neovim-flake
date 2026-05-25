setup_plugin("octo")

local include_gitlab = false
if include_gitlab then
	local function setup_gitlab_nvim()
		utils.packadd("gitlab-nvim")
		setup_plugin("gitlab", {})
	end
	setup_gitlab_nvim()

	setup_plugin("gitlab")
end

setup_plugin("gitsigns", function(gitsigns)
	vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
		callback = function()
			gitsigns.setup({})
		end,
	})
end)

setup_plugin("jj")

setup_plugin("jujutsu-nvim", {})
setup_plugin("jiejie")

setup_plugin("gitsigns")
setup_plugin("lazygit")
setup_plugin("git-conflict")
setup_plugin("neogit")
utils.packadd("vim-fugitive")

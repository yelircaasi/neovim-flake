setup_plugin("flybuf")
setup_plugin("stickybuf")
setup_plugin("swm", function(swm)
	map("n", "<C-w>h", swm.h)
	map("n", "<C-w>j", swm.j)
	map("n", "<C-w>k", swm.k)
	map("n", "<C-w>l", swm.l)
end)

setup_plugin("smart-splits")
setup_plugin("harpoon-core")
setup_plugin("marks", {})
setup_plugin("nvim-pasta")
setup_plugin("beam")

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
	callback = function()
		setup_plugin("markit", function(markit)
			-- utils.packadd("pickme")
		end)
	end,
})

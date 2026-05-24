-- AUTOCOMMANDS =================================================================================================

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {

	pattern = { "*.c", "*.h" },

	callback = function(ev)
		print(string.format("event fired: %s", vim.inspect(ev)))
	end,
})

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, function()
	setup_plugin("markit", function(markit)
		-- utils.packadd("pickme")
	end)
end)

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, function()
	setup_plugin("todo-comments", {})
end)

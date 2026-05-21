setup_plugin("diffview", function()
	-- TODO: port from lazy
	cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" }
	dependencies = { "plenary" }
	require("diffview").setup({})
end)

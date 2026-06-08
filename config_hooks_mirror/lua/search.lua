setup_plugin("fzf-lua", function(fzf)
	fzf.setup({
		winopts = {
			height = 0.85,
			width = 0.85,
			preview = { layout = "vertical", vertical = "up:50%" },
		},
		keymap = {
			fzf = {
				["ctrl-q"] = "select-all+accept", -- send all to quickfix
			},
		},
	})

	local map = vim.keymap.set
	-- Files
	map("n", "<leader>ff", fzf.files, { desc = "Find files" })
	map("n", "<leader>fr", fzf.oldfiles, { desc = "Recent files" })
	map("n", "<leader>fb", fzf.buffers, { desc = "Buffers" })
	-- Search
	map("n", "<leader>fg", fzf.live_grep, { desc = "Live grep" })
	map("n", "<leader>fw", fzf.grep_cword, { desc = "Grep word under cursor" })
	map("v", "<leader>fw", fzf.grep_visual, { desc = "Grep selection" })
	map("n", "<leader>f/", fzf.grep_curbuf, { desc = "Grep current buffer" })
	-- LSP
	map("n", "<leader>fs", fzf.lsp_document_symbols, { desc = "Document symbols" })
	map("n", "<leader>fS", fzf.lsp_workspace_symbols, { desc = "Workspace symbols" })
	map("n", "<leader>fd", fzf.diagnostics_document, { desc = "Buffer diagnostics" })
	map("n", "<leader>fD", fzf.diagnostics_workspace, { desc = "Workspace diagnostics" })
	-- Misc
	map("n", "<leader>fh", fzf.help_tags, { desc = "Help tags" })
	map("n", "<leader>fc", fzf.commands, { desc = "Commands" })
	map("n", "<leader>fq", fzf.quickfix, { desc = "Quickfix list" })
	map("n", "<leader>f.", fzf.resume, { desc = "Resume last picker" })
end)

-- NOTE: deck.nvim (hrsh7th) is a low-level async UI framework, not typically
-- setup directly — it's a dependency other plugins build on. If you have a
-- specific deck-based plugin, configure that instead. Bare minimum to load it:
setup_plugin("deck")

setup_plugin("snacks", function(snacks)
	snacks.setup({
		bigfile = { enabled = true },
		notifier = { enabled = true, timeout = 3000 },
		quickfile = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = true }, -- highlight word under cursor
		indent = { enabled = true },
		dashboard = { enabled = false }, -- enable if you want a start screen
		scroll = { enabled = false }, -- smooth scroll, can conflict with other plugins
	})

	local map = vim.keymap.set
	map("n", "<leader>n", function()
		snacks.notifier.show_history()
	end, { desc = "Notification history" })
	map("n", "<leader>bd", function()
		snacks.bufdelete()
	end, { desc = "Delete buffer" })
	map("n", "<leader>gB", function()
		snacks.gitbrowse()
	end, { desc = "Git browse (open in browser)" })
	map("n", "<leader>gl", function()
		snacks.lazygit.log()
	end, { desc = "Lazygit log" })
	map("n", "]]", function()
		snacks.words.jump(1)
	end, { desc = "Next reference" })
	map("n", "[[", function()
		snacks.words.jump(-1)
	end, { desc = "Prev reference" })
end)

setup_plugin("hlslens", function(lens)
	lens.setup({ calm_down = true })

	-- Augment n/N/*/# with match count virtual text
	local map = vim.keymap.set
	local opts = { noremap = true, silent = true }
	map("n", "n", [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], opts)
	map("n", "N", [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], opts)
	map("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], opts)
	map("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], opts)
	map("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], opts)
	map("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], opts)
end)

-- nvim-hlsearch: auto-clears search highlight when cursor moves off a match
setup_plugin("nvim-hlsearch", { auto_restore = true })

-- NOTE: grug-far and spectre are both find-and-replace — you probably only
-- need one. grug-far is more actively maintained and ergonomic.
setup_plugin("grug-far", function(grug)
	grug.setup({ headerMaxWidth = 80 })

	local map = vim.keymap.set
	map("n", "<leader>sr", function()
		grug.open()
	end, { desc = "Search and replace" })
	map("n", "<leader>sw", function()
		grug.open({ prefills = { search = vim.fn.expand("<cword>") } })
	end, { desc = "Search and replace word under cursor" })
	map("v", "<leader>sr", function()
		grug.open({ prefills = { search = grug.get_visual_selection() } })
	end, { desc = "Search and replace selection" })
end)

setup_plugin("spectre", function(spectre)
	spectre.setup({ live_update = true })

	local map = vim.keymap.set
	map("n", "<leader>sR", function()
		spectre.toggle()
	end, { desc = "Spectre toggle" })
	map("n", "<leader>sW", function()
		spectre.open_visual({ select_word = true })
	end, { desc = "Spectre word under cursor" })
	map("v", "<leader>sR", function()
		spectre.open_visual()
	end, { desc = "Spectre selection" })
	map("n", "<leader>sf", function()
		spectre.open_file_search()
	end, { desc = "Spectre current file" })
end)

print("Set up search.")

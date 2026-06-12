setup_plugin("inc_rename", {})

setup_plugin("muren", {})
setup_plugin("rip-substitute", {})
setup_plugin("sad", {}) -- TODO: install sad

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
setup_plugin("deck", function(deck)
	require("deck.easy").setup()

	-- Set up buffer-specific key mappings for nvim-deck.
	vim.api.nvim_create_autocmd("User", {
		pattern = "DeckStart",
		callback = function(e)
			local ctx = e.data.ctx --[[@as deck.Context]]

			ctx.keymap("n", "<Leader>;", function()
				local history = deck.get_history()
				for i, context in ipairs(history) do
					if context.id == ctx.id then
						local next_idx = (i % #history) + 1
						history[next_idx].show()
					end
				end
			end)
			ctx.keymap("n", "<Tab>", deck.action_mapping("choose_action"))
			ctx.keymap("n", "<C-l>", deck.action_mapping("refresh"))
			ctx.keymap("n", "i", deck.action_mapping("prompt"))
			ctx.keymap("n", "a", deck.action_mapping("prompt"))
			ctx.keymap("n", "@", deck.action_mapping("toggle_select"))
			ctx.keymap("n", "*", deck.action_mapping("toggle_select_all"))
			ctx.keymap("n", "p", deck.action_mapping("toggle_preview_mode"))
			ctx.keymap("n", "d", deck.action_mapping("delete"))
			ctx.keymap("n", "<CR>", deck.action_mapping("default"))
			ctx.keymap("n", "o", deck.action_mapping("open"))
			ctx.keymap("n", "O", deck.action_mapping("open_keep"))
			ctx.keymap("n", "s", deck.action_mapping("open_split"))
			ctx.keymap("n", "v", deck.action_mapping("open_vsplit"))
			ctx.keymap("n", "N", deck.action_mapping("create"))
			ctx.keymap("n", "R", deck.action_mapping("rename"))
			ctx.keymap("n", "w", deck.action_mapping("write"))
			ctx.keymap("n", "<C-u>", deck.action_mapping("scroll_preview_up"))
			ctx.keymap("n", "<C-d>", deck.action_mapping("scroll_preview_down"))

			-- If you want to start the filter by default, call ctx.prompt() here
			ctx.prompt()
		end,
	})

	--key-mapping for explorer source (requires `require('deck.easy').setup()`).
	vim.api.nvim_create_autocmd("User", {
		pattern = "DeckStart:explorer",
		callback = function(e)
			local ctx = e.data.ctx --[[@as deck.Context]]
			ctx.keymap("n", "h", deck.action_mapping("explorer.collapse"))
			ctx.keymap("n", "l", deck.action_mapping("explorer.expand"))
			ctx.keymap("n", ".", deck.action_mapping("explorer.toggle_dotfiles"))
			ctx.keymap("n", "c", deck.action_mapping("explorer.clipboard.save_copy"))
			ctx.keymap("n", "m", deck.action_mapping("explorer.clipboard.save_move"))
			ctx.keymap("n", "p", deck.action_mapping("explorer.clipboard.paste"))
			ctx.keymap("n", "x", deck.action_mapping("explorer.clipboard.paste"))
			ctx.keymap("n", "<Leader>ff", deck.action_mapping("explorer.dirs"))
			ctx.keymap("n", "P", deck.action_mapping("toggle_preview_mode"))
			ctx.keymap("n", "~", function()
				ctx.do_action("explorer.get_api").set_cwd(vim.fs.normalize("~"))
			end)
			ctx.keymap("n", "\\", function()
				ctx.do_action("explorer.get_api").set_cwd(vim.fs.normalize("/"))
			end)
		end,
	})

	-- Example key bindings for launching nvim-deck sources. (These mapping required `deck.easy` calls.)
	vim.keymap.set("n", "<Leader>ff", "<Cmd>Deck files<CR>", { desc = "Show recent files, buffers, and more" })
	vim.keymap.set("n", "<Leader>gr", "<Cmd>Deck grep<CR>", { desc = "Start grep search" })
	vim.keymap.set("n", "<Leader>gi", "<Cmd>Deck git<CR>", { desc = "Open git launcher" })
	vim.keymap.set("n", "<Leader>he", "<Cmd>Deck helpgrep<CR>", { desc = "Live grep all help tags" })

	-- Show the latest deck context.
	vim.keymap.set("n", "<Leader>;", function()
		local context = deck.get_history()[vim.v.count == 0 and 1 or vim.v.count]
		if context then
			context.show()
		end
	end)

	-- Do default action on next item.
	vim.keymap.set("n", "<Leader>n", function()
		local ctx = require("deck").get_history()[1]
		if ctx then
			ctx.set_cursor(ctx.get_cursor() + 1)
			ctx.do_action("default")
		end
	end)
end)

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

-- TODO: make lazy
setup_plugin("pickme", function(pickme)
	-- Include at least one of these pickers:
	-- utils.packadd("snacks") -- For snacks.picker
	-- utils.packadd("telescope") -- For telescope
	-- utils.packadd("fzf-lua") -- For fzf-lua
	pickme.setup({
		picker_provider = "snacks", -- Default provider
	})
end)

-- TODO: make lazy (remove above?)
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

setup_plugin("renamer", {})

setup_plugin("search-replace", {})

local rgflow_defaults = {
	-- Set the default rip grep flags and options for when running a search via
	-- RgFlow. Once changed via the UI, the previous search flags are used for
	-- each subsequent search (until Neovim restarts).
	cmd_flags = "--smart-case --fixed-strings --ignore --max-columns 200",

	-- Mappings to trigger RgFlow functions
	default_trigger_mappings = true,
	-- These mappings are only active when the RgFlow UI (panel) is open
	default_ui_mappings = true,
	-- QuickFix window only mapping
	default_quickfix_mappings = true,
}
setup_plugin("rgflow-nvim", rgflow_defaults)

setup_plugin("ssr", {})
setup_plugin("substitute", {})

setup_plugin("actions-preview", {})

setup_plugin("spider", {})
setup_plugin("improved-search-nvim", {}) -- PROBABLY NOT, BUT WORTH A TRY
setup_plugin("nvim-rg", {}) -- PROBABLY NOT, BUT WORTH A TRY https://github.com/duane9/nvim-rg
setup_plugin("hlsearch-nvim", {}) -- PROBABLY NOT, BUT WORTH A TRY
setup_plugin("nvim-monorepos", {}) -- https://github.com/sajjathossain/nvim-monorepos simple telescope file finder for monorepos

utils.setup_plugin("flybuf", function(flybuf)
	flybuf.setup({
		-- Show relative line numbers in the buffer list
		rnu = true,
	})
	vim.keymap.set("n", "<leader>bf", "FlyBuf", { desc = "FlyBuf: buffer list" })
end)

setup_plugin("stickybuf", function(stickybuf)
	-- Automatically pin special buffers so they can't be replaced
	stickybuf.setup({
		get_auto_pin = function(bufnr)
			local buftype = vim.bo[bufnr].buftype
			local filetype = vim.bo[bufnr].filetype
			local buftypes = { "help", "nofile", "prompt", "quickfix", "terminal" }
			local fttypes = {
				"neo-tree",
				"neotest-summary",
				"neotest-output-panel",
				"Outline",
				"toggleterm",
				"trouble",
			}
			if vim.tbl_contains(buftypes, buftype) then
				return stickybuf.strategy.buf
			end
			if vim.tbl_contains(fttypes, filetype) then
				return stickybuf.strategy.buf
			end
		end,
	})
end)

setup_plugin("swm", function(swm)
	local map = vim.keymap.set
	-- Window navigation: swm makes these smart about floating windows
	map("n", "<C-w>h", swm.h, { desc = "Window left" })
	map("n", "<C-w>j", swm.j, { desc = "Window down" })
	map("n", "<C-w>k", swm.k, { desc = "Window up" })
	map("n", "<C-w>l", swm.l, { desc = "Window right" })
	-- Also bind to plain <C-hjkl> for convenience
	map("n", "<C-h>", swm.h, { desc = "Window left" })
	map("n", "<C-j>", swm.j, { desc = "Window down" })
	map("n", "<C-k>", swm.k, { desc = "Window up" })
	map("n", "<C-l>", swm.l, { desc = "Window right" })
end)

setup_plugin("smart-splits", function(ss)
	ss.setup({
		ignored_filetypes = { "nofile", "quickfix", "prompt" },
		default_amount = 3,
		-- Multiplexer integration (resize across tmux/wezterm panes)
		at_edge = "wrap",
		multiplexer_integration = "wezterm",
	})

	local map = vim.keymap.set
	-- Resize
	map("n", "<A-h>", ss.resize_left, { desc = "Resize window left" })
	map("n", "<A-j>", ss.resize_down, { desc = "Resize window down" })
	map("n", "<A-k>", ss.resize_up, { desc = "Resize window up" })
	map("n", "<A-l>", ss.resize_right, { desc = "Resize window right" })
	-- Swap buffers between windows
	map("n", "<leader><leader>h", ss.swap_buf_left, { desc = "Swap buffer left" })
	map("n", "<leader><leader>j", ss.swap_buf_down, { desc = "Swap buffer down" })
	map("n", "<leader><leader>k", ss.swap_buf_up, { desc = "Swap buffer up" })
	map("n", "<leader><leader>l", ss.swap_buf_right, { desc = "Swap buffer right" })
end)

setup_plugin("harpoon", function(harpoon)
	-- harpoon-core uses the same API as harpoon2
	harpoon.setup({})
	local list = harpoon:list()

	local map = vim.keymap.set
	map("n", "<leader>ha", function()
		list:add()
	end, { desc = "Harpoon: add file" })
	map("n", "<leader>hh", function()
		harpoon.ui:toggle_quick_menu(list)
	end, { desc = "Harpoon: menu" })
	-- Quick jump to slots 1-4
	for i = 1, 4 do
		map("n", "<leader>" .. i, function()
			list:select(i)
		end, { desc = "Harpoon: jump to " .. i })
	end
	map("n", "<leader>hp", function()
		list:prev()
	end, { desc = "Harpoon: prev" })
	map("n", "<leader>hn", function()
		list:next()
	end, { desc = "Harpoon: next" })
end)

setup_plugin("nvim-pasta", function(pasta)
	pasta.setup({
		-- Reindent pasted text to match surrounding context
		next_key = vim.api.nvim_replace_termcodes("<C-n>", true, true, true),
		prev_key = vim.api.nvim_replace_termcodes("<C-p>", true, true, true),
	})
	-- p/P are remapped by pasta automatically; C-n/C-p cycle through paste history
end)

-- NOTE: beam.nvim is a cursor beam plugin for mode-based cursor shapes.
-- Most terminal emulators handle this, so only enable if yours doesn't.
setup_plugin("beam", function(beam)
	beam.setup({
		cursors = {
			normal = "block",
			insert = "beam",
			replace = "underline",
			visual = "block",
			operator = "block",
		},
	})
end)

setup_plugin("marks", function(marks)
	marks.setup({
		default_mappings = true, -- m{a-z}, m{A-Z} etc
		builtin_marks = { ".", "<", ">", "^" },
		cyclic = true, -- wrap around when jumping with ]' ['
		force_write_shada = false,
		sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
		bookmark_0 = {
			sign = "⚑",
			virt_text = "bookmark",
		},
	})

	local map = vim.keymap.set
	map("n", "<leader>mlb", "MarksListBuf", { desc = "Marks: list buffer marks" })
	map("n", "<leader>mqb", "MarksQFListBuf", { desc = "Marks: list buffer marks in quickfix" })
	-- map("n", "<leader>md", marks.delete_buf,  { desc = "Marks: delete all buffer marks" })
end)

-- markit is a marks extension; moving setup inside BufReadPre ensures it's
-- ready before any buffer is fully loaded. Flatten into top-level if you
-- don't need the deferred init.
setup_plugin("markit", function(markit)
	markit.setup({
		default_mappings = false, -- define your own below to avoid conflicts with marks.nvim
		marks_in_signs = true,
	})

	local map = vim.keymap.set
	map("n", "m;", "Markit mark toggle<cr>", { desc = "Markit: toggle mark" })
	map("n", "m:", "Markit mark list all<cr>", { desc = "Markit: list marks" })
end)

-- OLD:
-- vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
-- 	callback = function()
-- 		setup_plugin("markit", function(markit)
-- 			-- utils.packadd("pickme")
-- 		end)
-- 	end,
-- })

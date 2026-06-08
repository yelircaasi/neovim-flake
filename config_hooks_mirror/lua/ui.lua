setup_plugin("fidget", {
	notification = {
		window = {
			winblend = 0,
		},
	},
	progress = {
		suppress_on_insert = false,
	},
})

setup_plugin("nvim-notify", function(notify)
	notify.setup({
		stages = "fade",
		timeout = 3000,
		render = "wrapped-default",
		max_width = function()
			return math.floor(vim.o.columns * 0.4)
		end,
	})

	vim.notify = notify
end)

setup_plugin("headlines", {
	markdown = {
		headline_highlights = {
			"Headline1",
			"Headline2",
			"Headline3",
			"Headline4",
			"Headline5",
			"Headline6",
		},
		codeblock_highlight = "CodeBlock",
	},
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "norg" },
	callback = function()
		vim.opt_local.conceallevel = 2
	end,
})

setup_plugin("dropbar", function(dropbar)
	dropbar.setup({
		-- bar = {
		-- 	padding = {
		-- 		left = 1,
		-- 		right = 1,
		-- 	},
		-- },
	})

	vim.ui.select = require("dropbar.utils.menu").select

	vim.keymap.set("n", "<leader>;", function()
		require("dropbar.api").pick()
	end)

	vim.keymap.set("n", "[;", function()
		require("dropbar.api").goto_context_start()
	end)

	vim.keymap.set("n", "];", function()
		require("dropbar.api").select_next_context()
	end)
end)

-- utils.packadd("nui") -- TODO: comment out after next build
setup_plugin("nvim-navbuddy", function(navbuddy)
	navbuddy.setup({
		lsp = {
			auto_attach = true,
		},
	})

	vim.keymap.set("n", "<leader>nb", function()
		navbuddy.open()
	end)
end)

-- TODO: maybe use aerial instead of navbuddy
setup_plugin("aerial", function(aerial)
	aerial.setup({
		layout = {
			min_width = 30,
			default_direction = "prefer_right",
		},
		attach_mode = "window",
		close_automatic_events = {
			"unsupported",
			"switch_buffer",
		},
	})

	vim.keymap.set("n", "<leader>o", "<cmd>AerialToggle<cr>")
	vim.keymap.set("n", "{", "<cmd>AerialPrev<cr>")
	vim.keymap.set("n", "}", "<cmd>AerialNext<cr>")
end)

setup_plugin("noice")

setup_plugin("modes", {
	colors = {
		bg = "", -- Optional bg param, defaults to Normal hl group
		copy = "#f5c359",
		delete = "#c75c6a",
		change = "#c75c6a", -- Optional param, defaults to delete
		format = "#c79585",
		insert = "#78ccc5",
		replace = "#245361",
		select = "#9745be", -- Optional param, defaults to visual
		visual = "#9745be",
	},

	-- Set opacity for cursorline and number background
	line_opacity = 0.15,

	-- Enable cursor highlights
	set_cursor = true,

	-- Enable cursorline initially, and disable cursorline for inactive windows
	-- or ignored filetypes
	set_cursorline = true,

	-- Enable line number highlights to match cursorline
	set_number = true,

	-- Enable sign column highlights to match cursorline
	set_signcolumn = true,

	-- Disable modes highlights for specified filetypes
	-- or enable with prefix "!" if otherwise disabled (please PR common patterns)
	-- Can also be a function fun():boolean that disables modes highlights when true
	ignore = { "NvimTree", "TelescopePrompt", "!minifiles" },
})

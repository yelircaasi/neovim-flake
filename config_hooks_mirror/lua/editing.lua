setup_plugin("dial", function(dial)
	local augend = require("dial.augend")
	local manipulate = require("dial.map")
	require("dial.config").augends:register_group({
		default = {
			augend.integer.alias.decimal,
			augend.integer.alias.hex,
			augend.date.alias["%Y/%m/%d"],
			augend.constant.alias.Bool,
			augend.constant.alias.bool,
		},
	})
	map("n", "<C-a>", function()
		manipulate("increment", "normal")
	end)
	map("n", "<C-x>", function()
		manipulate("decrement", "normal")
	end)
	map("n", "g<C-a>", function()
		manipulate("increment", "gnormal")
	end)
	map("n", "g<C-x>", function()
		manipulate("decrement", "gnormal")
	end)
	map("x", "<C-a>", function()
		manipulate("increment", "visual")
	end)
	map("x", "<C-x>", function()
		manipulate("decrement", "visual")
	end)
	map("x", "g<C-a>", function()
		manipulate("increment", "gvisual")
	end)
	map("x", "g<C-x>", function()
		manipulate("decrement", "gvisual")
	end)
end)

utils.packadd("vim-visual-multi", function()
	vim.g.VM_default_mappings = true
end)

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
	callback = function()
		setup_plugin("todo-comments", {})
	end,
})

utils.packadd("vim-sandwich", function()
	vim.g["sandwich#magicchar#f#patterns"] = { { header = "f", bra = "", ket = "" } }
end)

utils.packadd("vim-mundo", function()
	vim.keymap.set("n", "<leader>u", "<cmd>MundoToggle<cr>")
end)

utils.packadd("indent-blankline", function()
	require("ibl").setup({
		indent = {
			char = "▏",
		},
		scope = {
			enabled = false,
		},
	})
end)

utils.packadd("tabular", function()
	vim.keymap.set("n", "<leader>a=", ":Tabularize /=<cr>")
	vim.keymap.set("v", "<leader>a=", ":Tabularize /=<cr>")
end)

utils.packadd("nvim-various-textobjs", function()
	require("various-textobjs").setup({
		useDefaultKeymaps = true,
	})
end)

utils.packadd("vim-commentary", function()
	-- no configuration needed
end)

setup_plugin("treesj", function(treesj)
	treesj.setup({
		use_default_keymaps = false,
		max_join_length = 120,
	})

	vim.keymap.set("n", "gS", treesj.toggle)
end)

setup_plugin("leap", function(leap)
	leap.opts.safe_labels = {}

	vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward)")
	vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward)")
end)

setup_plugin("flash", function(flash)
	flash.setup()

	vim.keymap.set({ "n", "x", "o" }, "s", function()
		require("flash").jump()
	end)

	vim.keymap.set({ "n", "x", "o" }, "S", function()
		require("flash").treesitter()
	end)

	vim.keymap.set("o", "r", function()
		require("flash").remote()
	end)

	vim.keymap.set({ "o", "x" }, "R", function()
		require("flash").treesitter_search()
	end)
end)

setup_plugin("hop", function(hop)
	hop.setup()

	vim.keymap.set("", "s", function()
		hop.hint_char1()
	end)
end)

setup_plugin("rainbow-delimiters", function()
	local rd = require("rainbow-delimiters")

	vim.g.rainbow_delimiters = {
		strategy = {
			[""] = rd.strategy["global"],
		},
		query = {
			[""] = "rainbow-delimiters",
		},
	}
end)

setup_plugin("nvim-autopairs", function(ap)
	ap.setup({
		check_ts = true,
	})
end)

setup_plugin("nvim-surround", function(ns)
	ns.setup()
end)

setup_plugin("mini.keymap", function(km)
	km.setup()

	km.map_combo({ "n", "i" }, { "j", "k" }, "<Esc>")
	km.map_combo({ "n", "i" }, { "k", "j" }, "<Esc>")
end)

setup_plugin("indentmini", function(im)
	im.setup({
		char = "▏",
		exclude = {
			"help",
			"lazy",
			"mason",
			"terminal",
		},
	})
end)

setup_plugin("nvim-anydent", function(ad)
	ad.setup()
end)

setup_plugin("mini.align", function(ma)
	ma.setup()

	-- ga in normal and visual mode
end)

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.hl.on_yank()
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "help", "qf", "man", "lspinfo" },
	callback = function(ev)
		vim.keymap.set("n", "q", "<cmd>quit<cr>", {
			buffer = ev.buf,
		})
	end,
})

-- TODO: notes: ===================================================================================

-- Flash has largely superseded Leap and Hop.
-- nvim-surround supersedes vim-sandwich unless you specifically prefer sandwich's text-object grammar.
-- indentmini and indent-blankline (ibl) solve the same problem; I would pick one.
-- nvim-autopairs and insx overlap; insx is more extensible but heavier.
-- Comment.nvim makes vim-commentary redundant.
-- mini.align is excellent and largely removes the need for Tabular.

-- Modern stack: --[[
-- Flash
-- nvim-surround
-- nvim-autopairs
-- mini.align
-- Comment.nvim
-- rainbow-delimiters
-- treesj
-- indentmini
--]]

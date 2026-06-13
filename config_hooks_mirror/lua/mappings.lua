-- MAPPINGS ========================================================================================
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
setup_plugin("which-key", function(which_key)
	vim.o.timeout = true
	vim.o.timeoutlen = 300
	which_key.setup({})
end)

setup_plugin("mini.keymap")

-- WAS:
-- local map = vim.keymap.set
if false then
	-- floaterm -----------------------------------------------------------------------------------------------------------
	vim.keymap.set("n", "<leader>ft", "<Cmd>FloatermToggle<CR>", { desc = "Toggle floaterm" })
	vim.keymap.set("t", "<leader>ft", "<C-\\><C-n><Cmd>FloatermToggle<CR>", { desc = "Toggle floaterm" })

	-- LSP ----------------------------------------------------------------------------------------------------------------
	-- We will create an autocommand group to attach keymaps only to buffers with an active LSP client.
	local lsp_keymaps_group = vim.api.nvim_create_augroup("LspKeymaps", { clear = true })

	vim.api.nvim_create_autocmd("LspAttach", {
		group = lsp_keymaps_group,
		callback = function(ev)
			local lsp_map = function(keys, func, desc)
				vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = "LSP: " .. desc })
			end

			-- Navigation and Information
			lsp_map("gd", vim.lsp.buf.definition, "Go to Definition")
			lsp_map("gD", vim.lsp.buf.declaration, "Go to Declaration")
			lsp_map("gr", vim.lsp.buf.references, "Go to References")
			lsp_map("gI", vim.lsp.buf.implementation, "Go to Implementation")
			lsp_map("K", vim.lsp.buf.hover, "Hover Documentation")
			lsp_map("<C-k>", vim.lsp.buf.signature_help, "Signature Help")

			-- Actions
			lsp_map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
			lsp_map("<leader>rn", vim.lsp.buf.rename, "Rename")

			-- Diagnostics
			lsp_map("[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
			lsp_map("]d", vim.diagnostic.goto_next, "Next Diagnostic")
			lsp_map("<leader>dl", vim.diagnostic.open_float, "Show Line Diagnostics")

			-- format on save (to use LSP formatter instead of conform)
			-- vim.api.nvim_buf_create_autocmd("BufWritePre", {
			--   buffer = ev.buf,
			--   callback = function() vim.lsp.buf.format { async = false } end
			-- })
			--
			local bufopts = { noremap = true, silent = true, buffer = bufnr }
		end,
	})

	-- other LSP maps

	local lsp_map_opts = { buffer = bufnr, silent = true }
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, lsp_map_opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, lsp_map_opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, lsp_map_opts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, lsp_map_opts)
	vim.keymap.set("n", "<leader>cf", function()
		conform.format({ bufnr = bufnr })
	end, lsp_map_opts)

	-- quickfix -----------------------------------------------------------------------------------------------------------
	vim.keymap.set("i", "kj", "<escape>")
	vim.keymap.set("n", "<leader>wq", function()
		vim.cmd("wq")
	end)
	vim.keymap.set("n", "<leader>ww", function()
		vim.cmd("w")
	end)
	vim.keymap.set("n", "<leader>q", function()
		-- Populates the Quickfix list with all diagnostics from the current buffer
		vim.diagnostic.setqflist({ bufnr = 0 })
		vim.cmd("copen")
	end, { desc = "Open Quickfix with diagnostics" })

	--- zen-mode ----------------------------------------------------------------------------------------------------------

	map("n", "<leader>zm", function()
		require("zen-mode").toggle({
			window = {
				width = 0.85, -- width will be 85% of the editor width
			},
		})
	end)
end

if other_mappings then
	---------------------------------------------------------------------------------------------------------------- KEYMAPS
	local nvx = { "n", "v", "x" }
	map_explicit({
		mode = "n",
		sequence = "<leader>o",
		action = ":update<CR> :source<CR>",
		opts = {},
	})
	map_explicit({
		mode = "n",
		sequence = "<leader>ww",
		action = ":write<CR>",
		opts = {},
	})
	map_explicit({
		mode = "n",
		sequence = "<leader>qq",
		action = ":quit<CR>",
		opts = {},
	})
	map_explicit({
		mode = "n",
		sequence = "<leader>wq",
		action = ":wq<CR>",
		opts = {},
	})
	map_explicit({
		mode = "n",
		sequence = "<leader>f",
		action = ":Pick files<CR>",
		opts = {},
	})
	map_explicit({
		mode = "t",
		sequence = "<Esc>",
		action = [[<C-\><C-n>]],
		opts = { desc = "Exit terminal mode" },
	})
	map_explicit({
		mode = "t",
		sequence = "kj",
		action = [[<C-\><C-n>]],
		opts = { desc = "Exit terminal mode" },
	})
	map_explicit({
		mode = "t",
		sequence = "<C-o>",
		action = [[<C-\><C-o>]],
		opts = { desc = "Temporary normal mode" },
	})
	map_explicit({
		mode = "n",
		sequence = "<leader>lf",
		action = vim.lsp.buf.format,
		opts = { desc = "" },
	})
	map_explicit({
		mode = "n",
		sequence = "<leader>h",
		action = ":Pick help",
	})
	map_explicit({
		mode = "n",
		sequence = "<leader>e",
		action = ":Oil<CR>",
	})
	map_explicit({
		mode = nvx,
		sequence = "<leader>y",
		action = "+y<CR>",
		opts = { desc = "Yank to system clipboard" },
	})
	map_explicit({
		mode = nvx,
		sequence = "<leader>d",
		action = "+d<CR>",
		opts = { desc = "Paste from system clipboard" },
	})
	-- map_explicit({
	--     mode = "",
	--     sequence = "",\
	--     action = [[]],
	--     opts = { desc = "" }
	-- })
	-- map_explicit({
	--     mode = "",
	--     sequence = "",
	--     action = [[]],
	--     opts = { desc = "" }
	-- })
	-- map('t', '^[', "^\^N")
	-- map('t', '^O', '^\^O')
	map_explicit({
		mode = "x",
		sequence = "<leader>mf",
		action = ":'<,'>lua move_selection_to_new_file()<CR>",
		opts = { desc = "Move selection to new file (split)" },
	})
	map_explicit({
		mode = "n",
		sequence = "<leader>lu",
		action = function()
			-- Create a new empty floating window or split
			vim.cmd("vsplit | enew")
			vim.bo.filetype = "lua"
			vim.bo.bufhidden = "hide"

			-- Map <CR> to execute the current line or selection
			vim.keymap.set("n", "<CR>", ":.lua<CR>", { buffer = true })
			vim.keymap.set("v", "<CR>", ":lua<CR>", { buffer = true })
		end,
		opts = { desc = "Open Lua Scratchpad" },
	})
	map_explicit({
		mode = "v",
		sequence = "<leader>ms",
		action = move_selection_to_new_file,
	})
	map_explicit({ ------------------------------------------------------------------------------------------------------ diagnostics
		mode = "n",
		sequence = "<leader>dt",
		action = function()
			diagnostics_active = not diagnostics_active
			set_diagnostics_mode()
		end,
		opts = { desc = "Toggle LSP Diagnostics" },
	})
	map_explicit({
		mode = "n",
		sequence = "<leader>dm",
		action = function()
			-- only cycle if active; otherwise turn on and reset to 1
			if not diagnostics_active then
				diagnostics_active = true
				current_mode_index = 1
			else
				current_mode_index = current_mode_index + 1
				if current_mode_index > #diagnostic_modes then
					current_mode_index = 1
				end
			end
			set_diagnostics_mode()
		end,
		opts = { desc = "Cycle LSP Diagnostic Modes" },
	})
	map_explicit({ -------------------------------------------------------------------------------------------------------- telescope
		mode = "n",
		sequence = "<leader>ff",
		action = make_setup_function(function()
			require("telescope.builtin").find_files()
		end),
		opts = { desc = "Find Files" },
	})
	map_explicit({
		mode = "n",
		sequence = "<leader>gf",
		action = function()
			require("telescope.builtin").git_files()
		end,
		opts = { desc = "Find Git Files" },
	})
	map_explicit({
		mode = "n",
		sequence = "<leader>fg",
		action = function()
			require("telescope.builtin").live_grep()
		end,
		opts = { desc = "Live Grep" },
	})
	map_explicit({
		mode = "n",
		sequence = "<leader>fb",
		action = function()
			require("telescope.builtin").buffers()
		end,
		opts = { desc = "Find Buffers" },
	})
	map_explicit({
		mode = "n",
		sequence = "<leader>fh",
		action = function()
			require("telescope.builtin").help_tags()
		end,
		opts = { desc = "Find Help Tags" },
	})
	map_explicit({ --------------------------------------------------------------------------------------------------------- floaterm
		mode = "n",
		sequence = "<leader>ft",
		action = "<Cmd>FloatermToggle<CR>",
		opts = { desc = "Toggle floaterm" },
	})
	map_explicit({
		mode = "t",
		sequence = "<leader>ft",
		action = "<C-\\><C-n><Cmd>FloatermToggle<CR>",
		opts = { desc = "Toggle floaterm" },
	})
	-------------------------------------------------------------------------------------------------------------------- LSP

	map_explicit({ --------------------------------------------------------------------------------------------------------- quickfix
		mode = { "i" },
		sequence = "kj",
		action = "<escape>",
	})
	map_explicit({
		mode = "n",
		sequence = "<leader>wq",
		action = function()
			vim.cmd("wq")
		end,
	})
	map_explicit({
		mode = "n",
		sequence = "<leader>ww",
		action = function()
			vim.cmd("w")
		end,
	})
	map_explicit({
		mode = "n",
		sequence = "<leader>q",
		action = function()
			-- Populates the Quickfix list with all diagnostics from the current buffer
			vim.diagnostic.setqflist({ bufnr = 0 })
			vim.cmd("copen")
		end,
		opts = { desc = "Open Quickfix with diagnostics" },
	})
	map_explicit({ ------------------------------------------------------------------------------------------------------------- dial
		mode = "n",
		sequence = "<C-a>",
		action = function()
			require("dial.map").manipulate("increment", "normal")
		end,
		opts = { desc = "" },
	})
	map_explicit({
		mode = "n",
		sequence = "<C-x>",
		action = function()
			require("dial.map").manipulate("decrement", "normal")
		end,
		opts = { desc = "" },
	})
	map_explicit({
		mode = "n",
		sequence = "g<C-a>",
		action = function()
			require("dial.map").manipulate("increment", "gnormal")
		end,
		opts = { desc = "" },
	})
	map_explicit({
		mode = "n",
		sequence = "g<C-x>",
		action = function()
			require("dial.map").manipulate("decrement", "gnormal")
		end,
		opts = { desc = "" },
	})
	map_explicit({
		mode = "x",
		sequence = "<C-a>",
		action = function()
			require("dial.map").manipulate("increment", "visual")
		end,
		opts = { desc = "" },
	})
	map_explicit({
		mode = "x",
		sequence = "<C-x>",
		action = function()
			require("dial.map").manipulate("decrement", "visual")
		end,
		opts = { desc = "" },
	})
	map_explicit({
		mode = "x",
		sequence = "g<C-a>",
		action = function()
			require("dial.map").manipulate("increment", "gvisual")
		end,
		opts = { desc = "" },
	})
	map_explicit({
		mode = "x",
		sequence = "g<C-x>",
		action = function()
			require("dial.map").manipulate("decrement", "gvisual")
		end,
		opts = { desc = "" },
	})
	map_explicit({ --------------------------------------------------------------------------------------------------------- zen-mode
		mode = "n",
		sequence = "<leader>zm",
		action = function()
			-- width will be 85% of the editor width
			require("zen-mode").toggle({ window = { width = 0.85 } })
		end,
		opts = { desc = "" },
	})
end

-- https://github.com/nvimtools/hydra.nvim
-- Create custom submodes and menus
-- TODO: Hydra is too generic for a global setup; just expose the module:
setup_plugin("hydra")

-- https://github.com/hrsh7th/nvim-insx
-- Flexible key mapping manager.
setup_plugin("insx", function(insx)
	require("insx.preset.standard").setup()
	-- insx.add(require("insx.preset.standard").setup())
end)

-- https://github.com/anuvyklack/keymap-amend.nvim
-- Amend the existing keymap in Neovim
local keymap_amend_nvim_defaults = {} -- TODO
setup_plugin("keymap-amend-nvim", keymap_amend_nvim_defaults)

-- https://github.com/afreakk/unimpaired-which-key.nvim
-- Bridge between vim-unimpaired and which-key.nvim
setup_plugin("unimpaired-which-key", function(_) end)

-- https://github.com/Cassin01/wf.nvim
--  A modern which-key for neovim
local wf_defaults = {} -- TODO
setup_plugin("wf", wf_defaults)

-- use which-key to ncreate commands
--[[
t = {
	name = "Terminal",
	["`"] = { "<cmd>Sterm<cr>", "Horizontal Terminal" },
	e = { "<cmd>Sterm iex<cr>", "Elixir" },
	f = { "<cmd>Fterm<cr>", "Floating Terminal" },
	g = { "<cmd>Fterm lazygit<cr>", "Lazygit" },
	n = { "<cmd>Sterm node<cr>", "Node" },
	p = { "<cmd>Sterm bpython<cr>", "Python" },
	r = { "<cmd>Sterm irb<cr>", "Ruby" },
	s = { "<cmd>Sterm<cr>", "Horizontal Terminal" },
	t = { "<cmd>Tterm<cr>", "Terminal" },
	v = { "<cmd>Vterm<cr>", "Vertical Terminal" },
},
--]]

-- TODO
-- https://github.com/cronJohn/keytex.nvim
--  A neovim plugin for keyboard shortcut management
local keytex_defaults = {} -- TODO
setup_plugin("keytex", keytex_defaults)

-- https://github.com/bgrohman/nvim-keymapper
-- Neovim Telescope extension for creating, documenting, and searching keymaps.
local nvim_keymapper_defaults = nil
setup_plugin("nvim-keymapper", function(keymapper)
	vim.api.nvim_create_user_command("Keymaps", keymapper.keymaps_picker, { desc = "Telescope: Show keymaps" })
	vim.api.nvim_create_user_command("AllKeymaps", builtin.keymaps, { desc = "Telescope: Show all keymaps" })
	keymapper.set("n", "<leader>k", ":Keymaps<CR>", {}, "Telescope: Show keymaps")
	keymapper.set("n", "<leader>T", "<ESC>:vsplit | term<CR>", {}, "Open a terminal in a vertical split")
end)

-- https://github.com/jokajak/keyseer.nvim
-- Neovim plugin to display which keys have keymaps assigned
-- command: `:KeySeer`
local keyseer_defaults = {
	-- Prints useful logs about what event are triggered, and reasons actions are executed.
	debug = false,
	-- Initial neovim mode to display keybindings
	initial_mode = "n",

	-- Boolean to include built in keymaps in display
	include_builtin_keymaps = true,
	-- Boolean to include global keymaps in display
	include_global_keymaps = true,
	-- Boolean to include buffer keymaps in display
	include_buffer_keymaps = true,
	-- TODO: Represent modifier toggling in highlights
	-- Boolean to include modified keys (e.g. <C-x> or <A-y> or C) in display
	include_modified_keypresses = false,
	-- TODO: Support ignoring whichkey conflicts when showing builtin keymaps
	-- Boolean to ignore whichkey keymaps
	ignore_whichkey_conflicts = true,

	-- Configuration for ui:
	-- - `border` defines border (as in `nvim_open_win()`).
	ui = {
		border = "double", -- none, single, double, shadow
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		winblend = 0, -- value between 0-100 0 for fully opaque and 100 for fully transparent
		size = {
			width = 65,
			height = 10,
		},
		icons = {
			keyseer = "",
		},
		show_header = true, -- boolean if the header should be shown
	},

	-- Keyboard options
	keyboard = {
		-- Layout of the keycaps
		---@type string|Keyboard
		layout = "qwerty",
		keycap_padding = { 0, 1, 0, 1 }, -- padding around keycap labels [top, right, bottom, left]
		-- How much padding to highlight around each keycap
		highlight_padding = { 0, 0, 0, 0 },
		-- override the label used to display some keys.
		key_labels = {
			["Up"] = "↑",
			["Down"] = "↓",
			["Left"] = "←",
			["Right"] = "→",
			["<F1>"] = "F1",
			["<F2>"] = "F2",
			["<F3>"] = "F3",
			["<F4>"] = "F4",
			["<F5>"] = "F5",
			["<F6>"] = "F6",
			["<F7>"] = "F7",
			["<F8>"] = "F8",
			["<F9>"] = "F9",
			["<F10>"] = "F10",

			-- For example:
			-- ["<space>"] = "SPC",
			-- ["<cr>"] = "RET",
			-- ["<tab>"] = "TAB",
		},
	},
}
setup_plugin("keyseer", keyseer_defaults)

-- PROBABLY NOT, BUT WORTH A TRY https://github.com/unode/homerow.vim/blob/master/autoload/homerow.vim
-- https://github.com/kbario/homerows.nvim
-- "I don't care what keyboard layout I'm using, i just want the keybinding on my homerows"
local homerows_defaults = {
	-- used to give preference to ripples. see ripples below.
	pref = { "programmers_dvorak", "colemak_dh" },
	-- whether or not to add the keybinding for changing the current homerows layout
	add_change_keymap = true,
	-- whether or not to add the keybinding for printing the current homerows layout
	add_print_keymap = true,
	-- where you add layouts that don't come standard with homerows.
	custom_layouts = {
		your_layout = {
			r1 = "a",
			r2 = "b",
			-- ...
		},
	},
}
setup_plugin("homerows", homerows_defaults)

-- PROBABLY NOT, BUT WORTH A TRY
-- https://github.com/AckslD/nvim-whichkey-setup.lua
-- Nvim-plugin what wraps vim-which-key to simplify setup in lua
local whichkey_setup_defaults = {} -- TODO
setup_plugin("whichkey_setup", whichkey_setup_defaults)

-- https://github.com/max397574/better-escape.nvim
-- Map keys without delay when typing
local better_escape_defaults = {} -- TODO
setup_plugin("better-escape", better_escape_defaults)

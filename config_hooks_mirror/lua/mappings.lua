--─────────────────────────────────────────────────────────────────────────────
--──── general mappings ───────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

local nvx = { "n", "v", "x" }
-- map_explicit({
--     mode = "",
--     sequence = "",
--     action = [[]],
--     desc = "",
-- })
map_explicit({
	mode = "n",
	sequence = "<leader>o",
	action = ":update<CR> :source<CR>",
})
map_explicit({
	mode = "n",
	sequence = "<leader>ww",
	action = ":write<CR>",
})
map_explicit({
	mode = "n",
	sequence = "<leader>qq",
	action = ":quit<CR>",
})
map_explicit({
	mode = "n",
	sequence = "<leader>wq",
	action = ":wq<CR>",
})
map_explicit({
	mode = "n",
	sequence = "<leader>f",
	action = ":Pick files<CR>",
})
map_explicit({
	mode = "n",
	sequence = "<leader>lf",
	action = vim.lsp.buf.format,
	desc = "",
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
	desc = "Yank to system clipboard",
})
map_explicit({
	mode = nvx,
	sequence = "<leader>d",
	action = "+d<CR>",
	desc = "Paste from system clipboard",
})
map_explicit({
	mode = "x",
	sequence = "<leader>mf",
	action = ":'<,'>lua move_selection_to_new_file()<CR>",
	desc = "Move selection to new file (split)",
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
		map_explicit({
			mode = "n",
			sequence = "<CR>",
			action = ":.lua<CR>",
			opts = { buffer = true },
		})
		map_explicit({
			mode = "v",
			sequence = "<CR>",
			action = ":lua<CR>",
			opts = { buffer = true },
		})
	end,
	desc = "Open Lua Scratchpad",
})
map_explicit({
	mode = "v",
	sequence = "<leader>ms",
	action = move_selection_to_new_file,
})

--─────────────────────────────────────────────────────────────────────────────
--──── plugins ──────────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

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
-- TODO: review examples
-- https://github.com/AckslD/nvim-whichkey-setup.lua
-- Nvim-plugin what wraps vim-which-key to simplify setup in lua
local whichkey_setup_defaults = nil
setup_plugin("whichkey_setup", function(wks)
	wks.config({
		hide_statusline = false,
		default_keymap_settings = {
			silent = true,
			noremap = true,
		},
		default_mode = "n",
	})
end)

-- https://github.com/max397574/better-escape.nvim
-- Map keys without delay when typing
local better_escape_defaults = {
	timeout = vim.o.timeoutlen, -- after `timeout` passes, you can press the escape key and the plugin will ignore it
	default_mappings = true, -- setting this to false removes all the default mappings
	mappings = {
		-- i for insert
		i = {
			j = {
				-- These can all also be functions
				k = "<Esc>",
				j = "<Esc>",
			},
		},
		c = {
			j = {
				k = "<C-c>",
				j = "<C-c>",
			},
		},
		t = {
			j = {
				k = "<C-\\><C-n>",
			},
		},
		v = {
			j = {
				k = "<Esc>",
			},
		},
		s = {
			j = {
				k = "<Esc>",
			},
		},
	},
}

setup_plugin("better-escape", better_escape_defaults)

-- https://github.com/folke/which-key.nvim
-- Create key bindings that stick. WhichKey helps you remember your Neovim keymaps, by showing available keybindings in a popup as you type.
local which_key_defaults = {
	---@type false | "classic" | "modern" | "helix"
	preset = "classic",
	-- Delay before showing the popup. Can be a number or a function that returns a number.
	---@type number | fun(ctx: { keys: string, mode: string, plugin?: string }):number
	delay = function(ctx)
		return ctx.plugin and 0 or 200
	end,
	---@param mapping wk.Mapping
	filter = function(mapping)
		-- example to exclude mappings without a description
		-- return mapping.desc and mapping.desc ~= ""
		return true
	end,
	--- You can add any mappings here, or use `require('which-key').add()` later
	---@type wk.Spec
	spec = {},
	-- show a warning when issues were detected with your mappings
	notify = true,
	-- Which-key automatically sets up triggers for your mappings.
	-- But you can disable this and setup the triggers manually.
	-- Check the docs for more info.
	---@type wk.Spec
	triggers = {
		{ "<auto>", mode = "nxso" },
	},
	-- Start hidden and wait for a key to be pressed before showing the popup
	-- Only used by enabled xo mapping modes.
	---@param ctx { mode: string, operator: string }
	defer = function(ctx)
		return ctx.mode == "V" or ctx.mode == "<C-V>"
	end,
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		spelling = {
			enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},
		presets = {
			operators = true, -- adds help for operators like d, y, ...
			motions = true, -- adds help for motions
			text_objects = true, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
	},
	---@type wk.Win.opts
	win = {
		-- don't allow the popup to overlap with the cursor
		no_overlap = true,
		-- width = 1,
		-- height = { min = 4, max = 25 },
		-- col = 0,
		-- row = math.huge,
		-- border = "none",
		padding = { 1, 2 }, -- extra window padding [top/bottom, right/left]
		title = true,
		title_pos = "center",
		zindex = 1000,
		-- Additional vim.wo and vim.bo options
		bo = {},
		wo = {
			-- winblend = 10, -- value between 0-100 0 for fully opaque and 100 for fully transparent
		},
	},
	layout = {
		width = { min = 20 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
	},
	keys = {
		scroll_down = "<c-d>", -- binding to scroll down inside the popup
		scroll_up = "<c-u>", -- binding to scroll up inside the popup
	},
	---@type (string|wk.Sorter)[]
	--- Mappings are sorted using configured sorters and natural sort of the keys
	--- Available sorters:
	--- * local: buffer-local mappings first
	--- * order: order of the items (Used by plugins like marks / registers)
	--- * group: groups last
	--- * alphanum: alpha-numerical first
	--- * mod: special modifier keys last
	--- * manual: the order the mappings were added
	--- * case: lower-case first
	sort = { "local", "order", "group", "alphanum", "mod" },
	---@type number|fun(node: wk.Node):boolean?
	expand = 0, -- expand groups when <= n mappings
	-- expand = function(node)
	--   return not node.desc -- expand all nodes without a description
	-- end,
	-- Functions/Lua Patterns for formatting the labels
	---@type table<string, ({[1]:string, [2]:string}|fun(str:string):string)[]>
	replace = {
		key = {
			function(key)
				return require("which-key.view").format(key)
			end,
			-- { "<Space>", "SPC" },
		},
		desc = {
			{ "<Plug>%(?(.*)%)?", "%1" },
			{ "^%+", "" },
			{ "<[cC]md>", "" },
			{ "<[cC][rR]>", "" },
			{ "<[sS]ilent>", "" },
			{ "^lua%s+", "" },
			{ "^call%s+", "" },
			{ "^:%s*", "" },
		},
	},
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
		ellipsis = "…",
		-- set to false to disable all mapping icons,
		-- both those explicitly added in a mapping
		-- and those from rules
		mappings = true,
		--- See `lua/which-key/icons.lua` for more details
		--- Set to `false` to disable keymap icons from rules
		---@type wk.IconRule[]|false
		rules = {},
		-- use the highlights from mini.icons
		-- When `false`, it will use `WhichKeyIcon` instead
		colors = true,
		-- used by key format
		keys = {
			Up = " ",
			Down = " ",
			Left = " ",
			Right = " ",
			C = "󰘴 ",
			M = "󰘵 ",
			D = "󰘳 ",
			S = "󰘶 ",
			CR = "󰌑 ",
			Esc = "󱊷 ",
			ScrollWheelDown = "󱕐 ",
			ScrollWheelUp = "󱕑 ",
			NL = "󰌑 ",
			BS = "󰁮",
			Space = "󱁐 ",
			Tab = "󰌒 ",
			F1 = "󱊫",
			F2 = "󱊬",
			F3 = "󱊭",
			F4 = "󱊮",
			F5 = "󱊯",
			F6 = "󱊰",
			F7 = "󱊱",
			F8 = "󱊲",
			F9 = "󱊳",
			F10 = "󱊴",
			F11 = "󱊵",
			F12 = "󱊶",
		},
	},
	show_help = true, -- show a help message in the command line for using WhichKey
	show_keys = true, -- show the currently pressed key and its label as a message in the command line
	-- disable WhichKey for certain buf types and file types.
	disable = {
		ft = {},
		bt = {},
	},
	debug = false, -- enable wk.log in the current directory
}
setup_plugin("which-key", function(which_key)
	vim.o.timeout = true
	vim.o.timeoutlen = 300
	which_key.setup(which_key_defaults)
end)

-- https://github.com/nvim-mini/mini.keymap
-- Special key mappings. Part of 'mini.nvim' library.
mini_keymap_defaults = {}
setup_plugin("mini.keymap", mini_keymap_defaults)

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
local keymap_amend_nvim_defaults = nil
setup_plugin("keymap-amend-nvim", function(keymap_amend)
	local keymap = vim.keymap
	keymap.amend = keymap_amend

	-- examples

	keymap.amend("n", "k", function(original)
		print("k key is amended!")
		original()
	end)

	keymap.amend("n", "<Esc>", function(original)
		if vim.v.hlsearch and vim.v.hlsearch == 1 then
			vim.cmd("nohlsearch")
		end
		original()
	end, { desc = "disable search highlight" })
end)

-- https://github.com/afreakk/unimpaired-which-key.nvim
-- Bridge between vim-unimpaired and which-key.nvim
setup_plugin("unimpaired-which-key", function(_) end)

-- https://github.com/Cassin01/wf.nvim
--  A modern which-key for neovim
local wf_defaults = {
	theme = "default",
	-- you can copy the full list from lua/wf/setup/init.lua
}
setup_plugin("wf", function(wf)
	local which_key = require("wf.builtin.which_key")
	local register = require("wf.builtin.register")
	local bookmark = require("wf.builtin.bookmark")
	local buffer = require("wf.builtin.buffer")
	local mark = require("wf.builtin.mark")

	-- Register
	map_explicit({
		mode = "n",
		sequence = "<Space>wr",
		-- register(opts?: table) -> function
		-- opts?: option
		action = register(),
		opts = { noremap = true, silent = true, desc = "[wf.nvim] register" },
	})

	-- Bookmark
	map_explicit({
		mode = "n",
		sequence = "<Space>wbo",
		-- bookmark(bookmark_dirs: table, opts?: table) -> function
		-- bookmark_dirs: directory or file paths
		-- opts?: option
		action = bookmark({
			nvim = "~/.config/nvim",
			zsh = "~/.zshrc",
		}),
		opts = { noremap = true, silent = true, desc = "[wf.nvim] bookmark" },
	})

	-- Buffer
	map_explicit({
		mode = "n",
		sequence = "<Space>wbu",
		-- buffer(opts?: table) -> function
		-- opts?: option
		action = buffer(),
		opts = { noremap = true, silent = true, desc = "[wf.nvim] buffer" },
	})

	-- Mark
	map_explicit({
		mode = "n",
		sequence = "'",
		-- mark(opts?: table) -> function
		-- opts?: option
		mark(),
		opts = { nowait = true, noremap = true, silent = true, desc = "[wf.nvim] mark" },
	})

	-- Which Key
	map_explicit({
		mode = "n",
		sequence = "<Leader>",
		-- mark(opts?: table) -> function
		-- opts?: option
		action = which_key({ text_insert_in_advance = "<Leader>" }),
		opts = { noremap = true, silent = true, desc = "[wf.nvim] which-key /" },
	})

	-- set keymaps with `nowait`
	-- see `:h :map-nowait`

	-- a timer to call a callback after a specified number of milliseconds.
	local function timeout(ms, callback)
		local uv = vim.loop
		local timer = uv.new_timer()
		local _callback = vim.schedule_wrap(function()
			uv.timer_stop(timer)
			uv.close(timer)
			callback()
		end)
		uv.timer_start(timer, ms, 0, _callback)
	end
	timeout(100, function()
		map_explicit({
			mode = "n",
			sequence = "<Leader>",
			action = which_key({ text_insert_in_advance = "<Leader>" }),
			opts = { noremap = true, silent = true, desc = "[wf.nvim] which-key /" },
		})
	end)
	vim.api.nvim_create_autocmd({ "BufEnter", "BufAdd" }, {
		group = vim.api.nvim_create_augroup("my_wf", { clear = true }),
		callback = function()
			timeout(100, function()
				map_explicit({
					mode("n"),
					sequence = "<Leader>",
					action = which_key({ text_insert_in_advance = "<Leader>" }),
					opts = { noremap = true, silent = true, desc = "[wf.nvim] which-key /", buffer = true },
				})
			end)
		end,
	})
end)

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
local keytex_defaults = nil
setup_plugin("keytex", function(keytex) end)

-- https://github.com/bgrohman/nvim-keymapper
-- Neovim Telescope extension for creating, documenting, and searching keymaps.
local nvim_keymapper_defaults = nil
setup_plugin("nvim-keymapper", function(keymapper)
	vim.api.nvim_create_user_command("Keymaps", keymapper.keymaps_picker, { desc = "Telescope: Show keymaps" })
	vim.api.nvim_create_user_command("AllKeymaps", builtin.keymaps, { desc = "Telescope: Show all keymaps" })
	keymapper.set("n", "<leader>k", ":Keymaps<CR>", {}, "Telescope: Show keymaps")
	keymapper.set("n", "<leader>T", "<ESC>:vsplit | term<CR>", {}, "Open a terminal in a vertical split")
end)

local function setup_mini_keymap()
	setup_plugin("mini.keymap", function(km)
		km.setup()

		km.map_combo({ "n", "i" }, { "j", "k" }, "<Esc>")
		km.map_combo({ "n", "i" }, { "k", "j" }, "<Esc>")
	end)
end

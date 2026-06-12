setup_plugin("nvim-web-devicons", {
	-- your personal icons can go here (to override)
	-- you can specify color or cterm_color instead of specifying both of them
	-- DevIcon will be appended to `name`
	override = {
		zsh = {
			icon = "",
			color = "#428850",
			cterm_color = "65",
			name = "Zsh",
		},
	},
	-- globally enable different highlight colors per icon (default to true)
	-- if set to false all icons will have the default icon's color
	color_icons = true,
	-- globally enable default icons (default to false)
	-- will get overriden by `get_icons` option
	default = true,
	-- globally enable "strict" selection of icons - icon will be looked up in
	-- different tables, first by filename, and if not found by extension; this
	-- prevents cases when file doesn't have any extension but still gets some icon
	-- because its name happened to match some extension (default to false)
	strict = true,
	-- set the light or dark variant manually, instead of relying on `background`
	-- (default to nil)
	variant = "light|dark",
	-- override blend value for all highlight groups :h highlight-blend.
	-- setting this value to `0` will make all icons opaque. in practice this means
	-- that icons width will not be affected by pumblend option (see issue #608)
	-- (default to nil)
	blend = 0,
	-- same as `override` but specifically for overrides by filename
	-- takes effect when `strict` is true
	override_by_filename = {
		[".gitignore"] = {
			icon = "",
			color = "#f1502f",
			name = "Gitignore",
		},
	},
	-- same as `override` but specifically for overrides by extension
	-- takes effect when `strict` is true
	override_by_extension = {
		["log"] = {
			icon = "",
			color = "#81e043",
			name = "Log",
		},
	},
	-- same as `override` but specifically for operating system
	-- takes effect when `strict` is true
	override_by_operating_system = {
		["apple"] = {
			icon = "",
			color = "#A2AAAD",
			cterm_color = "248",
			name = "Apple",
		},
	},
})
setup_plugin("bye-nerdfont", {}) -- https://github.com/dullmode/bye-nerdfont.nvim

setup_plugin("mini.cmdline", {
	-- Autocompletion: show `:h 'wildmenu'` as you type
	autocomplete = {
		enable = true,

		-- Delay (in ms) after which to trigger completion
		-- Neovim>=0.12 is recommended for positive values
		delay = 0,

		-- Custom rule of when to trigger completion
		predicate = nil,

		-- Whether to map arrow keys for more consistent wildmenu behavior
		map_arrows = true,
	},

	-- Autocorrection: adjust non-existing words (commands, options, etc.)
	autocorrect = {
		enable = true,

		-- Custom autocorrection rule
		func = nil,
	},

	-- Autopeek: show command's target range in a floating window
	autopeek = {
		enable = true,

		-- Number of lines to show above and below range lines
		n_context = 1,

		-- Custom rule of when to show peek window
		predicate = nil,

		-- Window options
		window = {
			-- Floating window config
			config = {},

			-- Function to render statuscolumn
			statuscolumn = nil,
		},
	},
})

setup_plugin("zen-mode", {
	wezterm = {
		enabled = true,
		-- can be either an absolute font size or the number of incremental steps
		font = "+4", -- (10% increase per step)
	},
})
vim.o.laststatus = 3
setup_plugin("lualine", {
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
})

setup_plugin("nvim-navic", {})
setup_plugin("bufferline", {})
setup_plugin("statuscol", {})

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

setup_plugin("cmdbuf", {}) -- https://github.com/notomo/cmdbuf.nvim -- PROBABLY NOT, BUT WORTH A TRY

if false then
	---------------- alternative lines -------------
	setup_plugin("cokeline", {})
	setup_plugin("galaxyline", function(_) end)
	setup_plugin("heirline", {})
	setup_plugin("heirline-components", {})
	setup_plugin("nougat", function(_) end)
	setup_plugin("staline", {})
	setup_plugin("tabby", {})
	setup_plugin("minibar", {})
	setup_plugin("winbar", {})
	setup_plugin("windline", function(_) end)
end

setup_plugin("control_panel", {}) -- https://github.com/mhanberg/control-panel.nvim
setup_plugin("output_panel", {}) --  https://github.com/mhanberg/output-panel.nvim

setup_plugin("cosmic-ui", {})
setup_plugin("fsplash", {}) -- https://github.com/jovanlanik/fsplash.nvim Show a custom splash screen in a floating window

setup_plugin("smartcolumn", {})

setup_plugin("vimade", {
	recipe = { "default", { animate = true } },
	fadelevel = 0.4,
})

setup_plugin("menu", {})
setup_plugin("symbols", {})
setup_plugin("reactive", {}) -- https://github.com/rasulomaroff/reactive.nvim Reactivity. Right in your neovim.
setup_plugin("modicator", {}) -- https://github.com/mawkler/modicator.nvim Cursor line number mode indicator plugin for Neovim
setup_plugin("volt", function(_) end) -- https://github.com/nvzone/volt  Create blazing fast & beautiful reactive UI in Neovim
setup_plugin("notify", {}) -- PROBABLY NOT, BUT WORTH A TRY (== nvim-notify ?)

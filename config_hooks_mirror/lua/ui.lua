--─────────────────────────────────────────────────────────────────────────────
--──── columns ────────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- LINK
-- DESC
local smartcolumn_defaults = {} -- TODO
setup_plugin("smartcolumn", smartcolumn_defaults)

-- LINK
-- DESC
local statuscol_defaults = {} -- TODO
setup_plugin("statuscol", statuscol_defaults)

--─────────────────────────────────────────────────────────────────────────────
--──── menus, selection ───────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- LINK
-- DESC
local menu_defaults = {} -- TODO
setup_plugin("menu", menu_defaults)

--─────────────────────────────────────────────────────────────────────────────
--──── outline ────────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- LINK
-- DESC
local symbols_defaults = {} -- TODO
setup_plugin("symbols", symbols_defaults)

-- TODO: maybe use aerial instead of navbuddy
setup_plugin(
	"aerial",
	function(aerial) -- https://github.com/stevearc/aerial.nvim | Neovim plugin for a code outline window
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
	end
)

-- utils.packadd("nui") -- TODO: comment out after next build
setup_plugin(
	"nvim-navbuddy",
	function(navbuddy) -- https://github.com/SmiteshP/nvim-navbuddy | A simple popup display that provides breadcrumbs feature using LSP server
		navbuddy.setup({
			lsp = {
				auto_attach = true,
			},
		})

		vim.keymap.set("n", "<leader>nb", function()
			navbuddy.open()
		end)
	end
)

--─────────────────────────────────────────────────────────────────────────────
--──── lines, bars ──────────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

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

-- LINK
-- DESC
local nvim_navic_defaults = {} -- TODO
setup_plugin("nvim-navic", nvim_navic_defaults)

-- LINK
-- DESC
local bufferline_defaults = {} -- TODO
setup_plugin("bufferline", bufferline_defaults)

---------------- alternative lines -------------
if false then
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

--─────────────────────────────────────────────────────────────────────────────
--──── command interface ──────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- https://github.com/notomo/cmdbuf.nvim
-- -- PROBABLY NOT, BUT WORTH A TRY
local cmdbuf_defaults = {} -- TODO
setup_plugin("cmdbuf", cmdbuf_defaults)

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

--─────────────────────────────────────────────────────────────────────────────
--──── output, notification ───────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

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

-- PROBABLY NOT, BUT WORTH A TRY (== nvim-notify ?)
-- LINK
-- DESC
local notify_defaults = {} -- TODO
setup_plugin("notify", notify_defaults)

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

-- https://github.com/mhanberg/control-panel.nvim
-- DESC
local control_panel_defaults = {} -- TODO
setup_plugin("control_panel", control_panel_defaults)

-- https://github.com/mhanberg/output-panel.nvim
-- DESC
local output_panel_defaults = {} -- TODO
setup_plugin("output_panel", output_panel_defaults)

--─────────────────────────────────────────────────────────────────────────────
--──── UI libraries ───────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- LINK
-- DESC
local cosmic_ui_defaults = {} -- TODO
setup_plugin("cosmic-ui", cosmic_ui_defaults)
setup_plugin("volt", function(_) end) -- https://github.com/nvzone/volt  Create blazing fast & beautiful reactive UI in Neovim
setup_plugin("noice")

--─────────────────────────────────────────────────────────────────────────────
--──── fonts, characters ──────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────
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

-- https://github.com/dullmode/bye-nerdfont.nvim
-- DESC
local bye_nerdfont_defaults = {} -- TODO
setup_plugin("bye-nerdfont", bye_nerdfont_defaults)

--─────────────────────────────────────────────────────────────────────────────
--──── focus ──────────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

setup_plugin("vimade", {
	recipe = { "default", { animate = true } },
	fadelevel = 0.4,
})

setup_plugin("zen-mode", {
	wezterm = {
		enabled = true,
		-- can be either an absolute font size or the number of incremental steps
		font = "+4", -- (10% increase per step)
	},
})
vim.o.laststatus = 3

--─────────────────────────────────────────────────────────────────────────────
--──── mode-related ───────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- https://github.com/mawkler/modicator.nvim
-- Cursor line number mode indicator plugin for Neovim
local modicator_defaults = {} -- TODO
setup_plugin("modicator", modicator_defaults)

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

--─────────────────────────────────────────────────────────────────────────────
--──── other/general ──────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- https://github.com/rasulomaroff/reactive.nvim
-- Reactivity. Right in your neovim.
local reactive_defaults = {} -- TODO
setup_plugin("reactive", reactive_defaults)

-- https://github.com/lukas-reineke/headlines.nvim | adds horizontal highlights for text filetypes, like markdown, orgmode, and neorg
setup_plugin("headlines", { -- TODO: move to colors (?)
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

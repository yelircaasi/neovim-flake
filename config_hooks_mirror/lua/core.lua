-- setup_plugin("plenary")
-- setup_plugin("nio")

--─────────────────────────────────────────────────────────────────────────────
--──── fonts, characters ──────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────
if vim.g.nerdfont then
	print("Using nerd icons")
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
else
	-- TODO: integrate with nvim-tree, bufferline, lualine
	-- https://github.com/dullmode/bye-nerdfont.nvim
	-- devicons without nerdfont
	local bye_nerdfont_defaults = {
		mode = "emoji", -- alternative: "simple"
	}
	setup_plugin("bye-nerdfont", bye_nerdfont_defaults)
end

--─────────────────────────────────────────────────────────────────────────────
--──── outline ────────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- https://github.com/oskarrrrrrr/symbols.nvim
-- Code navigation sidebar for Neovim.
local symbols_defaults = {
	sidebar = {
		-- Hide the cursor when in sidebar.
		hide_cursor = true,
		-- Side on which the sidebar will open, available options:
		-- try-left  Opens to the left of the current window if there are no
		--           windows there. Otherwise opens to the right.
		-- try-right Opens to the right of the current window if there are no
		--           windows there. Otherwise opens to the left.
		-- right     Always opens to the right of the current window.
		-- left      Always opens to the left of the current window.
		open_direction = "try-left",
		-- Whether to run `wincmd =` after opening a sidebar.
		on_open_make_windows_equal = true,
		-- Whether the cursor in the sidebar should automatically follow the
		-- cursor in the source window. Does not unfold the symbols. You can jump
		-- to symbol with unfolding with "gs" by default.
		cursor_follow = true,
		auto_resize = {
			-- When enabled the sidebar will be resized whenever the view changes.
			-- For example, after folding/unfolding symbols, after toggling inline details
			-- or whenever the source file is saved.
			enabled = true,
			-- The sidebar will never be auto resized to a smaller width then `min_width`.
			min_width = 20,
			-- The sidebar will never be auto resized to a larger width then `max_width`.
			max_width = 40,
		},
		-- Default sidebar width.
		fixed_width = 30,
		-- Allows to filter symbols. By default all the symbols are shown.
		symbol_filter = function(filetype, symbol)
			return true
		end,
		-- Show inline details by default.
		show_inline_details = false,
		-- Show details floating window at all times.
		show_details_pop_up = false,
		-- When enabled every symbol will be automatically peeked after cursor
		-- movement.
		auto_peek = false,
		-- Whether the sidebar should unfold the target buffer on goto
		-- This simply sends a zv after the zz
		unfold_on_goto = false,
		-- Whether to close the sidebar on goto symbol.
		close_on_goto = false,
		-- Whether the sidebar should wrap text.
		wrap = false,
		-- Whether to show the guide lines.
		show_guide_lines = true,
		chars = {
			folded = "",
			unfolded = "",
			guide_vert = "│",
			guide_middle_item = "├",
			guide_last_item = "└",
			-- use this highlight group for the guide lines
			hl_guides = "Comment",
			-- use this highlight group for the collapse/expand markers
			hl_foldmarker = "String",
		},
		-- highlight group for the inline details shown next to the symbol name
		-- (provider - dependent)
		hl_details = "Comment",
		-- Config for the preview window.
		preview = {
			-- Whether the preview window is always opened when the sidebar is
			-- focused.
			show_always = false,
			-- Whether the preview window should show line numbers.
			show_line_number = false,
			-- Whether to determine the preview window's height automatically.
			auto_size = true,
			-- The total number of extra lines shown in the preview window.
			auto_size_extra_lines = 6,
			-- Minimum window height when `auto_size` is true.
			min_window_height = 7,
			-- Maximum window height when `auto_size` is true.
			max_window_height = 30,
			-- Preview window size when `auto_size` is false.
			fixed_size_height = 12,
			-- Desired preview window width. Actuall width will be capped at
			-- the current width of the source window width.
			window_width = 100,
			-- Keymaps for actions in the preview window. Available actions:
			-- close: Closes the preview window.
			-- goto-code: Changes window to the source code and moves cursor to
			--            the same position as in the preview window.
			-- Note: goto-code is not set by default because the most natual
			-- key would be Enter but some people already have that key mapped.
			keymaps = {
				["q"] = "close",
			},
		},
		-- Keymaps for actions in the sidebar. All available actions are used
		-- in the default keymaps.
		keymaps = {
			-- Jumps to symbol in the source window.
			["<CR>"] = "goto-symbol",
			-- Jumps to symbol in the source window but the cursor stays in the
			-- sidebar.
			["<RightMouse>"] = "peek-symbol",
			["o"] = "peek-symbol",

			-- Opens a floating window with symbol preview.
			["K"] = "open-preview",
			-- Opens a floating window with symbol details.
			["d"] = "open-details-window",

			-- In the sidebar jumps to symbol under the cursor in the source
			-- window. Unfolds all the symbols on the way.
			["gs"] = "show-symbol-under-cursor",
			-- Jumps to parent symbol. Can be used with a count, e.g. "3gp"
			-- will go 3 levels up.
			["gp"] = "goto-parent",
			-- Jumps to the previous symbol at the same nesting level.
			["[["] = "prev-symbol-at-level",
			-- Jumps to the next symbol at the same nesting level.
			["]]"] = "next-symbol-at-level",

			-- Unfolds the symbol under the cursor.
			["l"] = "unfold",
			["zo"] = "unfold",
			-- Unfolds the symbol under the cursor and all its descendants.
			["L"] = "unfold-recursively",
			["zO"] = "unfold-recursively",
			-- Reduces folding by one level. Can be used with a count,
			-- e.g. "3zr" will unfold 3 levels.
			["zr"] = "unfold-one-level",
			-- Unfolds all symbols in the sidebar.
			["zR"] = "unfold-all",

			-- Folds the symbol under the cursor.
			["h"] = "fold",
			["zc"] = "fold",
			-- Folds the symbol under the cursor and all its descendants.
			["H"] = "fold-recursively",
			["zC"] = "fold-recursively",
			-- Increases folding by one level. Can be used with a count,
			-- e.g. "3zm" will fold 3 levels.
			["zm"] = "fold-one-level",
			-- Folds all symbols in the sidebar.
			["zM"] = "fold-all",

			-- Start fuzzy search.
			["s"] = "search",

			-- Toggles inline details (see sidebar.show_inline_details).
			["td"] = "toggle-inline-details",
			-- Toggles auto details floating window (see sidebar.show_details_pop_up).
			["tD"] = "toggle-auto-details-window",
			-- Toggles auto preview floating window.
			["tp"] = "toggle-auto-preview",
			-- Toggles cursor hiding (see sidebar.auto_resize.
			["tch"] = "toggle-cursor-hiding",
			-- Toggles cursor following (see sidebar.cursor_follow).
			["tcf"] = "toggle-cursor-follow",
			-- Toggles symbol filters allowing the user to see all the symbols
			-- given by the provider.
			["tf"] = "toggle-filters",
			-- Toggles automatic peeking on cursor movement (see sidebar.auto_peek).
			["to"] = "toggle-auto-peek",
			-- Toggles closing on goto symbol (see sidebar.close_on_goto).
			["tg"] = "toggle-close-on-goto",
			-- Toggles automatic sidebar resizing (see sidebar.auto_resize).
			["t="] = "toggle-auto-resize",
			-- Decrease auto resize max width by 5. Works with a count.
			["t["] = "decrease-max-width",
			-- Increase auto resize max width by 5. Works with a count.
			["t]"] = "increase-max-width",

			-- Toggle fold of the symbol under the cursor.
			["<2-LeftMouse>"] = "toggle-fold",

			-- Close the sidebar window.
			["q"] = "close",

			-- Show help.
			["?"] = "help",
			["g?"] = "help",
		},
	},
	providers = {
		-- Order in which providers will be called to get symbols.
		priority = {
			-- Default in case other rules are not defined.
			["*"] = { "treesitter", "lsp" },
			-- Treesitter provider for JSON can be slow for large files.
			json = { "lsp", "treesitter" },
			python = { "treesitter", "lsp" },
		},
		-- Override the priority using extra context.
		-- Input has the following fields:
		--  * filetype string
		--  * path string - absolute path
		--
		-- Return `nil` to fall back to `priority` table.
		priority_fun = function(input)
			return nil
		end,
		lsp = {
			timeout_ms = 1000,
			details = {},
			kinds = { default = {} },
			highlights = {
				-- ...
				default = {},
			},
		},
		treesitter = {
			details = {},
			kinds = { default = {} },
			highlights = {
				-- ...
				default = {},
			},
		},
	},
	dev = {
		enabled = false,
		log_level = vim.log.levels.ERROR,
		keymaps = {},
	},
}
setup_plugin("symbols", symbols_defaults)

--─────────────────────────────────────────────────────────────────────────────
--──── lines, bars ────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- https://github.com/nvim-lualine/lualine.nvim
-- A blazing fast and easy to configure neovim statusline plugin written in pure lua.
--[[
setup_plugin("lualine", ) --, lualine_config)
]]

local function lualine_bubbles(lualine)
	-- don't split bar; use single bar
	vim.o.laststatus = 3

	local colors = {
		blue = "#80a0ff",
		cyan = "#79dac8",
		black = "#080808",
		white = "#c6c6c6",
		red = "#ff5189",
		violet = "#d183e8",
		grey = "#303030",
	}

	local bubbles_theme = {
		normal = {
			a = { fg = colors.black, bg = colors.violet },
			b = { fg = colors.white, bg = colors.grey },
			c = { fg = colors.white },
		},

		insert = { a = { fg = colors.black, bg = colors.blue } },
		visual = { a = { fg = colors.black, bg = colors.cyan } },
		replace = { a = { fg = colors.black, bg = colors.red } },

		inactive = {
			a = { fg = colors.white, bg = colors.black },
			b = { fg = colors.white, bg = colors.black },
			c = { fg = colors.white },
		},
	}

	local cfg = {
		options = {
			theme = bubbles_theme,
			component_separators = "",
			section_separators = { left = "", right = "" },
		},
		sections = {
			lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
			lualine_b = { "filename", "branch" },
			lualine_c = {
				"%=", --[[ add your center components here in place of this comment ]]
			},
			lualine_x = {},
			lualine_y = { "filetype", "progress" },
			lualine_z = {
				{ "location", separator = { right = "" }, left_padding = 2 },
			},
		},
		inactive_sections = {
			lualine_a = {}, -- "filename" },
			lualine_b = {},
			lualine_c = {},
			lualine_x = {},
			lualine_y = {},
			lualine_z = {}, -- "location" },
		},
		tabline = {},
		extensions = {},
	}

	lualine.setup(cfg)
end

local function lualine_defaultlike(lualine)
	-- don't split bar; use single bar
	vim.o.laststatus = 3

	local cfg = {
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {},
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		},
	}
	lualine.setup(cfg)
end

setup_plugin("lualine", lualine_defaultlike) -- lualine_bubbles)

--─────────────────────────────────────────────────────────────────────────────
--──── focus ──────────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- https://github.com/tadaa/vimade
-- Vimade let's you dim, fade, tint, animate, and customize colors in your windows and buffers for (Neo)vim
setup_plugin("vimade", {
	recipe = { "default", { animate = true } },
	fadelevel = 0.4,
})

-- https://github.com/folke/zen-mode.nvim
-- Distraction-free coding for Neovim
local zenmode_defaults = {
	wezterm = {
		enabled = true,
		-- can be either an absolute font size or the number of incremental steps
		font = "+4", -- (10% increase per step)
	},
}
setup_plugin("zen-mode", function(zenmode)
	zenmode.setup(zenmode_defaults)

	map_explicit({
		mode = "n",
		sequence = "<leader>zm",
		action = function()
			-- width will be 85% of the editor width
			zenmode.toggle({ window = { width = 0.85 } })
		end,
		desc = "",
	})
	-- print("set map")
end)

--─────────────────────────────────────────────────────────────────────────────
--──── mode-related ───────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- https://github.com/mawkler/modicator.nvim
-- Cursor line number mode indicator plugin for Neovim
local modicator_defaults = {
	-- Warn if any required option is missing. May emit false positives if some
	-- other plugin modifies them, which in that case you can just ignore
	show_warnings = false,
	highlights = {
		-- Default options for bold/italic
		defaults = {
			bold = false,
			italic = false,
		},
		-- Use `CursorLine`'s background color for `CursorLineNr`'s background
		use_cursorline_background = false,
	},
	integration = {
		lualine = {
			enabled = true,
			-- Letter of lualine section to use (if `nil`, gets detected automatically)
			mode_section = nil,
			-- Whether to use lualine's mode highlight's foreground or background
			highlight = "bg",
		},
	},
}
setup_plugin("modicator", function(modicator)
	-- already selected in options.lua
	-- vim.o.termguicolors = true
	-- vim.o.cursorline = true
	-- vim.o.number = true
	modicator.setup(modicator_defaults)
end)

-- https://github.com/mvllow/modes.nvim
-- Prismatic line decorations for the adventurous vim user
local modes_defaults = {
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
}
setup_plugin("modes", function(modes)
	modes.setup(modes_defaults)
	vim.o.cmdheight = 0
end)

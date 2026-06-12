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

-- SETUP ==========================================================================================

--─────────────────────────────────────────────────────────────────────────────
--──── comments ───────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

utils.packadd("vim-commentary", function()
	-- no configuration needed
end)

local comment_defaults = {
	---Add a space b/w comment and the line
	padding = true,
	---Whether the cursor should stay at its position
	sticky = true,
	---Lines to be ignored while (un)comment
	ignore = nil,
	---LHS of toggle mappings in NORMAL mode
	toggler = {
		---Line-comment toggle keymap
		line = "gcc",
		---Block-comment toggle keymap
		block = "gbc",
	},
	---LHS of operator-pending mappings in NORMAL and VISUAL mode
	opleader = {
		---Line-comment keymap
		line = "gc",
		---Block-comment keymap
		block = "gb",
	},
	---LHS of extra mappings
	extra = {
		---Add comment on the line above
		above = "gcO",
		---Add comment on the line below
		below = "gco",
		---Add comment at the end of line
		eol = "gcA",
	},
	---Enable keybindings
	---NOTE: If given `false` then the plugin won't create any mappings
	mappings = {
		---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
		basic = true,
		---Extra mapping; `gco`, `gcO`, `gcA`
		extra = true,
	},
	---Function to call before (un)comment
	pre_hook = nil,
	---Function to call after (un)comment
	post_hook = nil,
}
setup_plugin("Comment", comment_defaults)

local todo_comments_defaults = {
	signs = true, -- show icons in the signs column
	sign_priority = 8, -- sign priority
	-- keywords recognized as todo comments
	keywords = {
		FIX = {
			icon = " ", -- icon used for the sign, and in search results
			color = "error", -- can be a hex color, or a named color (see below)
			alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
			-- signs = false, -- configure signs for some keywords individually
		},
		TODO = { icon = " ", color = "info" },
		HACK = { icon = " ", color = "warning" },
		WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
		PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
		NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
		TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
	},
	gui_style = {
		fg = "NONE", -- The gui style to use for the fg highlight group.
		bg = "BOLD", -- The gui style to use for the bg highlight group.
	},
	merge_keywords = true, -- when true, custom keywords will be merged with the defaults
	-- highlighting of the line containing the todo comment
	-- * before: highlights before the keyword (typically comment characters)
	-- * keyword: highlights of the keyword
	-- * after: highlights after the keyword (todo text)
	highlight = {
		multiline = true, -- enable multine todo comments
		multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
		multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
		before = "", -- "fg" or "bg" or empty
		keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
		after = "fg", -- "fg" or "bg" or empty
		pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
		comments_only = true, -- uses treesitter to match keywords in comments only
		max_line_len = 400, -- ignore lines longer than this
		exclude = {}, -- list of file types to exclude highlighting
	},
	-- list of named colors where we try to extract the guifg from the
	-- list of highlight groups or use the hex color if hl not found as a fallback
	colors = {
		error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
		warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
		info = { "DiagnosticInfo", "#2563EB" },
		hint = { "DiagnosticHint", "#10B981" },
		default = { "Identifier", "#7C3AED" },
		test = { "Identifier", "#FF00FF" },
	},
	search = {
		command = "rg",
		args = {
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
		},
		-- regex that will be used to match keywords.
		-- don't replace the (KEYWORDS) placeholder
		pattern = [[\b(KEYWORDS):]], -- ripgrep regex
		-- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
	},
}
vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
	callback = function()
		setup_plugin("todo-comments", todo_comments_defaults)
	end,
})

setup_plugin("ts_context_commentstring", {}) -- MAYBE NOT, BUT WORTH A TRY - https://github.com/JoosepAlviste/nvim-ts-context-commentstring  Neovim treesitter plugin for setting the commentstring based on the cursor location in a file.

--─────────────────────────────────────────────────────────────────────────────
--──── saving ─────────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

setup_plugin("savior", {}) -- PROBABLY NOT, BUT WORTH A TRY
utils.packadd("vim-auto-save") -- PROBABLY NOT, BUT WORTH A TRY
setup_plugin("zpragmatic", {}) -- https://github.com/muhammadzkralla/zpragmatic.nvim  prompts you with alert dialog questions whenever you attempt to save changes in a file

--─────────────────────────────────────────────────────────────────────────────
--──── multicursor ────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────
setup_plugin("multicursors", {})
utils.packadd("vim-multiple-cursors") -- PROBABLY NOT, BUT WORTH A TRY

--─────────────────────────────────────────────────────────────────────────────
--──── semantic features ──────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────
utils.packadd("illuminate") -- https://github.com/rrethy/vim-illuminate (Neo)Vim plugin for automatically highlighting other uses of the word under the cursor using either LSP, Tree-sitter, or regex matching.

--─────────────────────────────────────────────────────────────────────────────
--──── sequences ─────────────────────────────────────────────────────────────-
--─────────────────────────────────────────────────────────────────────────────
setup_plugin("splitjoin", {}) -- https://github.com/bennypowers/splitjoin.nvim Split or join list-like syntax constructs

setup_plugin("treesj", function(treesj)
	treesj.setup({
		use_default_keymaps = false,
		max_join_length = 120,
	})

	vim.keymap.set("n", "gS", treesj.toggle)
end)

local bullets_defaults = {
	"kaymmm/bullets.nvim",
	opts = {
		colon_indent = true,
		delete_last_bullet = true,
		empty_buffers = true,
		file_types = { "markdown", "text", "gitcommit" },
		line_spacing = 1,
		mappings = true,
		outline_levels = { "ROM", "ABC", "num", "abc", "rom", "std*", "std-", "std+" },
		renumber = true,
		alpha = {
			len = 2,
		},
		checkbox = {
			nest = true,
			markers = " .oOx",
			toggle_partials = true,
		},
	},
}
setup_plugin("Bullets", {})

--─────────────────────────────────────────────────────────────────────────────
--──── sorting ─────────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

setup_plugin("sort", {})

--─────────────────────────────────────────────────────────────────────────────
--──── deletion ───────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────
setup_plugin("ax") -- https://github.com/mikeslattery/ax.nvim  Delete all the things!

--─────────────────────────────────────────────────────────────────────────────
--──── casing ─────────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────
utils.packadd("vim-caser") -- cycle a word through snake_case, camelCase, PascalCase, SCREAMING_SNAKE

--─────────────────────────────────────────────────────────────────────────────
--──── wrapping ───────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────
setup_plugin("wrapping", {}) -- https://github.com/andrewferrier/wrapping.nvim Plugin to make it easier to switch between 'soft' and 'hard' line wrapping in NeoVim
setup_plugin("wrapping-paper", {}) -- https://github.com/benlubas/wrapping-paper.nvim Simple plugin which simulates wrapping a single line at a time using floating windows and virtual text trickery

--─────────────────────────────────────────────────────────────────────────────
--──── command helpers ────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────
setup_plugin("dotdot", {}) -- https://codeberg.org/hernandez/dotdot.nvim lets you search for and execute commands with a press of ..

--─────────────────────────────────────────────────────────────────────────────
--──── values ─────────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────
utils.packadd("vim-abolish") -- https://github.com/tpope/vim-abolish abolish.vim: Work with several variants of a word at once

setup_plugin("date-time-inserter", {})

-- likely strictly dominated by dial
utils.packadd("switch.vim") --  A simple Vim plugin to switch segments of text with predefined replacements

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

setup_plugin("indent-tools", {})

utils.packadd("tabular", function()
	vim.keymap.set("n", "<leader>a=", ":Tabularize /=<cr>")
	vim.keymap.set("v", "<leader>a=", ":Tabularize /=<cr>")
end)

utils.packadd("nvim-various-textobjs", function()
	require("various-textobjs").setup({
		useDefaultKeymaps = true,
	})
end)

--─────────────────────────────────────────────────────────────────────────────
--──── text movement ──────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────
setup_plugin("moveline", function(moveline) end)

setup_plugin("sibling-swap-nvim", {}) -- https://github.com/Wansmer/sibling-swap.nvim

local move_defaults = {
	line = {
		enable = true, -- Enables line movement
		indent = true, -- Toggles indentation
	},
	block = {
		enable = true, -- Enables block movement
		indent = true, -- Toggles indentation
	},
	word = {
		enable = true, -- Enables word movement
	},
	char = {
		enable = false, -- Enables char movement
	},
}
setup_plugin("move", function(move)
	move.setup(move_defaults)

	local opts = { noremap = true, silent = true }
	-- Normal-mode commands
	vim.keymap.set("n", "<A-j>", ":MoveLine(1)<CR>", opts)
	vim.keymap.set("n", "<A-k>", ":MoveLine(-1)<CR>", opts)
	vim.keymap.set("n", "<A-h>", ":MoveHChar(-1)<CR>", opts)
	vim.keymap.set("n", "<A-l>", ":MoveHChar(1)<CR>", opts)
	vim.keymap.set("n", "<leader>wf", ":MoveWord(1)<CR>", opts)
	vim.keymap.set("n", "<leader>wb", ":MoveWord(-1)<CR>", opts)

	-- Visual-mode commands
	vim.keymap.set("v", "<A-j>", ":MoveBlock(1)<CR>", opts)
	vim.keymap.set("v", "<A-k>", ":MoveBlock(-1)<CR>", opts)
	vim.keymap.set("v", "<A-h>", ":MoveHBlock(-1)<CR>", opts)
	vim.keymap.set("v", "<A-l>", ":MoveHBlock(1)<CR>", opts)
end)

--─────────────────────────────────────────────────────────────────────────────
--──── selection ─────────────────────────────────────────────────────────────-
--─────────────────────────────────────────────────────────────────────────────
setup_plugin("wildfire", {})

--─────────────────────────────────────────────────────────────────────────────
--──── pairs ──────────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

local mini_surround_defaults = {
	-- Add custom surroundings to be used on top of builtin ones. For more
	-- information with examples, see `:h MiniSurround.config`.
	custom_surroundings = nil,

	-- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
	highlight_duration = 500,

	-- Module mappings. Use `''` (empty string) to disable one.
	mappings = {
		add = "sa", -- Add surrounding in Normal and Visual modes
		delete = "sd", -- Delete surrounding
		find = "sf", -- Find surrounding (to the right)
		find_left = "sF", -- Find surrounding (to the left)
		highlight = "sh", -- Highlight surrounding
		replace = "sr", -- Replace surrounding

		suffix_last = "l", -- Suffix to search with "prev" method
		suffix_next = "n", -- Suffix to search with "next" method
	},

	-- Number of lines within which surrounding is searched
	n_lines = 20,

	-- Whether to respect selection type:
	-- - Place surroundings on separate lines in linewise mode.
	-- - Place surroundings on each line in blockwise mode.
	respect_selection_type = false,

	-- How to search for surrounding (first inside current line, then inside
	-- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
	-- 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
	-- see `:h MiniSurround.config`.
	search_method = "cover",

	-- Whether to disable showing non-error feedback
	-- This also affects (purely informational) helper messages shown after
	-- idle time if user input is required.
	silent = false,
}
setup_plugin("mini.surround", mini_surround_defaults)

setup_plugin("sentiment-nvim", {}) -- archived
setup_plugin("ultimate-autopair-nvim", {}) -- use?
setup_plugin("blink.pairs", {})

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

local mini_pairs_defaults = {
	-- In which modes mappings from this `config` should be created
	modes = { insert = true, command = false, terminal = false },

	-- Global mappings. Each right hand side should be a pair information, a
	-- table with at least these fields (see more in |MiniPairs.map()|):
	-- - <action> - one of "open", "close", "closeopen".
	-- - <pair> - two character string for pair to be used.
	-- By default pair is not inserted after `\`, quotes are not recognized by
	-- <CR>, `'` does not insert the pair after a letter.
	-- Only parts of tables can be tweaked (others will use these defaults).
	-- Supply `false` instead of table to not map particular key.
	mappings = {
		["("] = { action = "open", pair = "()", neigh_pattern = "^[^\\]" },
		["["] = { action = "open", pair = "[]", neigh_pattern = "^[^\\]" },
		["{"] = { action = "open", pair = "{}", neigh_pattern = "^[^\\]" },

		[")"] = { action = "close", pair = "()", neigh_pattern = "^[^\\]" },
		["]"] = { action = "close", pair = "[]", neigh_pattern = "^[^\\]" },
		["}"] = { action = "close", pair = "{}", neigh_pattern = "^[^\\]" },

		['"'] = { action = "closeopen", pair = '""', neigh_pattern = "^[^\\]", register = { cr = false } },
		["'"] = { action = "closeopen", pair = "''", neigh_pattern = "^[^%a\\]", register = { cr = false } },
		["`"] = { action = "closeopen", pair = "``", neigh_pattern = "^[^\\]", register = { cr = false } },
	},
}
setup_plugin("mini.pairs", mini_pairs_defaults)

--─────────────────────────────────────────────────────────────────────────────
--──── indentation and alignment ──────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

local mini_indentscope_defaults = {
	-- Draw options
	draw = {
		-- Delay (in ms) between event and start of drawing scope indicator
		delay = 100,

		-- Animation rule for scope's first drawing. A function which, given
		-- next and total step numbers, returns wait time (in ms). See
		-- |MiniIndentscope.gen_animation| for builtin options. To disable
		-- animation, use `require('mini.indentscope').gen_animation.none()`.
		-- animation = --<function: implements constant 20ms between steps>,

		-- Whether to auto draw scope: return `true` to draw, `false` otherwise.
		-- Default draws only fully computed scope (see `options.n_lines`).
		predicate = function(scope)
			return not scope.body.is_incomplete
		end,

		-- Symbol priority. Increase to display on top of more symbols.
		priority = 2,
	},

	-- Module mappings. Use `''` (empty string) to disable one.
	mappings = {
		-- Textobjects
		object_scope = "ii",
		object_scope_with_border = "ai",

		-- Motions (jump to respective border line; if not present - body line)
		goto_top = "[i",
		goto_bottom = "]i",
	},

	-- Options which control scope computation
	options = {
		-- Type of scope's border: which line(s) with smaller indent to
		-- categorize as border. Can be one of: 'both', 'top', 'bottom', 'none'.
		border = "both",

		-- Whether to use cursor column when computing reference indent.
		-- Useful to see incremental scopes with horizontal cursor movements.
		indent_at_cursor = true,

		-- Maximum number of lines above or below within which scope is computed
		n_lines = 10000,

		-- Whether to first check input line to be a border of adjacent scope.
		-- Use it if you want to place cursor on function header to get scope of
		-- its body.
		try_as_border = false,
	},

	-- Which character to use for drawing scope indicator
	symbol = "╎",
}
setup_plugin("mini.indentscope", mini_indentscope_defaults)

setup_plugin("anydent", function(anydent) end)

setup_plugin("nvim-anydent", function(ad)
	ad.setup()
end)

-- ga in normal and visual mode
local mini_align_defaults = {
	-- Module mappings. Use `''` (empty string) to disable one.
	mappings = {
		start = "ga",
		start_with_preview = "gA",
	},

	-- Modifiers changing alignment steps and/or options
	modifiers = {
		-- Main option modifiers
		-- ['s'] = --<function: enter split pattern>,
		-- ['j'] = --<function: choose justify side>,
		-- ['m'] = --<function: enter merge delimiter>,

		-- -- Modifiers adding pre-steps
		-- ['f'] = --<function: filter parts by entering Lua expression>,
		-- ['i'] = --<function: ignore some split matches>,
		-- ['p'] = --<function: pair parts>,
		-- ['t'] = --<function: trim parts>,

		-- -- Delete some last pre-step
		-- ['<BS>'] = --<function: delete some last pre-step>,

		-- -- Special configurations for common splits
		-- ['='] = --<function: enhanced setup for '='>,
		-- [','] = --<function: enhanced setup for ','>,
		-- ['|'] = --<function: enhanced setup for '|'>,
		-- [' '] = --<function: enhanced setup for ' '>,
	},

	-- Default options controlling alignment process
	options = {
		split_pattern = "",
		justify_side = "left",
		merge_delimiter = "",
	},

	-- Default steps performing alignment (if `nil`, default is used)
	steps = {
		pre_split = {},
		split = nil,
		pre_justify = {},
		justify = nil,
		pre_merge = {},
		merge = nil,
	},

	-- Whether to disable showing non-error feedback
	-- This also affects (purely informational) helper messages shown after
	-- idle time if user input is required.
	silent = false,
}
setup_plugin("mini.align", mini_align_defaults)

-- AUTOCOMMANDS ===================================================================================

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "help", "qf", "man", "lspinfo" },
	callback = function(ev)
		vim.keymap.set("n", "q", "<cmd>quit<cr>", {
			buffer = ev.buf,
		})
	end,
})

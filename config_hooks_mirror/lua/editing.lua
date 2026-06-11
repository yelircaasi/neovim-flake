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

--=================================================================================================

-- SETUP ==========================================================================================

-- values ---------------------------------------------------------------------
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

utils.packadd("tabular", function()
	vim.keymap.set("n", "<leader>a=", ":Tabularize /=<cr>")
	vim.keymap.set("v", "<leader>a=", ":Tabularize /=<cr>")
end)

utils.packadd("nvim-various-textobjs", function()
	require("various-textobjs").setup({
		useDefaultKeymaps = true,
	})
end)

-- comments -------------------------------------------------------------------
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

-- pairs ----------------------------------------------------------------------

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

-- indentation and alignment --------------------------------------------------

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

local mini_hipatterns_defaults = {
	-- Table with highlighters (see |MiniHipatterns.config| for more details).
	-- Nothing is defined by default. Add manually for visible effect.
	highlighters = {},

	-- Delays (in ms) defining asynchronous highlighting process
	delay = {
		-- How much to wait for update after every text change
		text_change = 200,

		-- How much to wait for update after window scroll
		scroll = 50,
	},
}
setup_plugin("mini.hipatterns", mini_hipatterns_defaults)

local mini_jump_defaults = {
	-- Module mappings. Use `''` (empty string) to disable one.
	mappings = {
		forward = "f",
		backward = "F",
		forward_till = "t",
		backward_till = "T",
		repeat_jump = ";",
	},

	-- Delay values (in ms) for different functionalities. Set any of them to
	-- a very big number (like 10^7) to virtually disable.
	delay = {
		-- Delay between jump and highlighting all possible jumps
		highlight = 250,

		-- Delay between jump and automatic stop if idle (no jump is done)
		idle_stop = 10000000,
	},

	-- Whether to disable showing non-error feedback
	-- This also affects (purely informational) helper messages shown after
	-- idle time if user input is required.
	silent = false,
}
setup_plugin("mini.jump", mini_jump_defaults)

local mini_jump2d_defaults = {
	-- Function producing jump spots (byte indexed) for a particular line.
	-- For more information see |MiniJump2d.start()|.
	-- If `nil` (default) - use |MiniJump2d.default_spotter()|
	spotter = nil,

	-- Characters used for labels of jump spots (in supplied order)
	labels = "abcdefghijklmnopqrstuvwxyz",

	-- Options for visual effects
	view = {
		-- Whether to dim lines with at least one jump spot
		dim = false,

		-- How many steps ahead to show. Set to big number to show all steps.
		n_steps_ahead = 0,
	},

	-- Which lines are used for computing spots
	allowed_lines = {
		blank = true, -- Blank line (not sent to spotter even if `true`)
		cursor_before = true, -- Lines before cursor line
		cursor_at = true, -- Cursor line
		cursor_after = true, -- Lines after cursor line
		fold = true, -- Start of fold (not sent to spotter even if `true`)
	},

	-- Which windows from current tabpage are used for visible lines
	allowed_windows = {
		current = true,
		not_current = true,
	},

	-- Functions to be executed at certain events
	hooks = {
		before_start = nil, -- Before jump start
		after_jump = nil, -- After jump was actually done
	},

	-- Module mappings. Use `''` (empty string) to disable one.
	mappings = {
		start_jumping = "<CR>",
	},

	-- Whether to disable showing non-error feedback
	-- This also affects (purely informational) helper messages shown after
	-- idle time if user input is required.
	silent = false,
}
setup_plugin("mini.jump2d", mini_jump2d_defaults)

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

-- AUTOCOMMANDS ===================================================================================

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "help", "qf", "man", "lspinfo" },
	callback = function(ev)
		vim.keymap.set("n", "q", "<cmd>quit<cr>", {
			buffer = ev.buf,
		})
	end,
})

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

TODO = false
if TODO then
	setup_plugin("inc_rename", {})
	setup_plugin("treesitter-context", {})
	setup_plugin("debugpy", function(_) end)
	setup_plugin("wrapping-paper", {})
	setup_plugin("coverage", {})
	setup_plugin("rip-substitute", {})
	setup_plugin("sad", {}) -- TODO: install sad
	setup_plugin("Bullets", {})
	setup_plugin("precommit", {})
	setup_plugin("yaml_nvim", {})
	setup_plugin("nvim-quicktype", {})
	setup_plugin("hypersonic", {}) -- https://github.com/tomiis4/hypersonic.nvim A Neovim plugin that provides an explanation for regular expressions.", {})
	setup_plugin("nvim-lightbulb", {})
	setup_plugin("nvim-monorepos", {})
	setup_plugin("diagflow", {})

	setup_plugin("neaterm", {})
	setup_plugin("muren", {})
	setup_plugin("arrow", {}) -- https://github.com/otavioschwanck/arrow.nvim
	utils.packadd("auto-pandoc")
	setup_plugin("sniprun", {})
	setup_plugin("glance", {})
	setup_plugin("anydent", function(anydent) end)
	setup_plugin("blame", {})
	setup_plugin("blink.pairs", {})
	setup_plugin("cosmic-ui", {})
	setup_plugin("keytex", {}) -- https://github.com/cronJohn/keytex.nvim  A neovim plugin for keyboard shortcut management
	setup_plugin("bye-nerdfont", {}) -- https://github.com/dullmode/bye-nerdfont.nvim
	setup_plugin("nvim-luaref", {}) -- https://github.com/emiasims/nvim-luaref Add a vim :help reference for lua

	setup_plugin("otter", {})
	setup_plugin("move-nvim", {})
	setup_plugin("moveline", function(moveline) end)
	setup_plugin("multicursors", {})

	---------------- described as medium-value -------------

	setup_plugin("regexplainer", {})
	setup_plugin("actions-preview", {})
	setup_plugin("hlargs-nvim", {})
	utils.packadd("illuminate")
	setup_plugin("modicator", {})
	setup_plugin("smartcolumn", {})
	setup_plugin("urlview", {})
	setup_plugin("wrapping", {})
	setup_plugin("nvim-highlight-colors", {})
	setup_plugin("neoconf", {})
	setup_plugin("windex-nvim", {})

	setup_plugin("kubels", {})
	utils.packadd("vim-helm")

	setup_plugin("ax") -- https://github.com/mikeslattery/ax.nvim  Delete all the things!
	setup_plugin("sortjson", {})
	setup_plugin("qfview-nvim", {})
	setup_plugin("rgflow-nvim", {})

	setup_plugin("gx-extended-nvim", {})
	setup_plugin("ssr", {})
	setup_plugin("substitute", {})

	-- TODO: vendor/PR to fix old LspStart command -> new Lua LSP API
	-- setup_plugin("scratch-buffer", function(scratch_buffer)
	-- 	scratch_buffer.setup(
	-- 		{ with_lsp = false }
	-- 	)
	-- end)

	utils.packadd("vim-caser") -- cycle a word through snake_case, camelCase, PascalCase, SCREAMING_SNAKE

	setup_plugin("splitjoin", {})
	utils.packadd("switch.vim")
	utils.packadd("vim-abolish")
	setup_plugin("spider", {})
	setup_plugin("bqf", {})
	setup_plugin("FeMaco", {})
	setup_plugin("jsonpath", {})
	setup_plugin("tldr", {})
	setup_plugin("vale", {})
	setup_plugin("iron-nvim", {})

	setup_plugin("vimade", {
		recipe = { "default", { animate = true } },
		fadelevel = 0.4,
	})

	setup_plugin("corn", {}) -- https://github.com/RaafatTurki/corn.nvim LSP diagnostics at your corner
	setup_plugin("nix-develop", {})
	setup_plugin("sibling-swap-nvim", {}) -- https://github.com/Wansmer/sibling-swap.nvim

	setup_plugin("lint", function(lint) end)

	setup_plugin("yarepl", {
		-- see `:h buflisted`, whether the REPL buffer should be buflisted.
		buflisted = true,
		-- whether the REPL buffer should be a scratch buffer.
		scratch = true,
		-- the filetype of the REPL buffer created by `yarepl`
		ft = "REPL",
		-- How yarepl open the REPL window, can be a string or a lua function.
		-- See below example for how to configure this option
		wincmd = "belowright 15 split",
		-- The available REPL palattes that `yarepl` can create REPL based on.
		-- To disable a built-in meta, set its key to `false`, e.g., `metas = { R = false }`
		metas = {
			aichat = { cmd = "aichat", formatter = "bracketed_pasting", source_syntax = "aichat" },
			radian = { cmd = "radian", formatter = "bracketed_pasting_no_final_new_line", source_syntax = "R" },
			-- builtin command names search a .venv/bin/ipython first, then fall back to PATH
			ipython = { cmd = "builtin:ipython", formatter = "bracketed_pasting", source_syntax = "ipython" },
			python = { cmd = "builtin:python", formatter = "trim_empty_lines", source_syntax = "python" },
			R = { cmd = "R", formatter = "trim_empty_lines", source_syntax = "R" },
			bash = {
				cmd = "bash",
				formatter = vim.fn.has("linux") == 1 and "bracketed_pasting" or "trim_empty_lines",
				source_syntax = "bash",
			},
			zsh = { cmd = "zsh", formatter = "bracketed_pasting", source_syntax = "bash" },
		},
		-- when a REPL process exits, should the window associated with those REPLs closed?
		close_on_exit = true,
		-- whether automatically scroll to the bottom of the REPL window after sending
		-- text? This feature would be helpful if you want to ensure that your view
		-- stays updated with the latest REPL output.
		scroll_to_bottom_after_sending = true,
		-- Format REPL buffer names as #repl_name#n (e.g., #ipython#1) instead of using terminal defaults
		format_repl_buffers_names = true,
		-- Highlight the operated range when using send/source operators
		highlight_on_send_operator = { enabled = false, hl_group = "IncSearch", timeout = 150 },
		os = {
			-- Some hacks for Windows. macOS and Linux users can simply ignore
			-- them. The default options are recommended for Windows user.
			windows = {
				-- Send a final `\r` to the REPL with delay,
				send_delayed_final_cr = true,
			},
		},
		-- Display the first line as virtual text to indicate the actual
		-- command sent to the REPL.
		source_command_hint = {
			enabled = false,
			hl_group = "Comment",
		},
	})
end

local NEXT = false
if NEXT then
	-------------------------------------------------------------------------------
	-- GET IMPORTING NEXT
	-------------------------------------------------------------------------------

	setup_plugin("api-browser", {})
	setup_plugin("control_panel", {})
	setup_plugin("indent-tools", {})
	setup_plugin("nvim-keymapper", {})
	setup_plugin("nvim-license", {})
	setup_plugin("menu", {})
	setup_plugin("output_panel", {})

	setup_plugin("date-time-inserter", {})
	setup_plugin("dmap", {})
	setup_plugin("doing", {})
	setup_plugin("dotdot", {})
	setup_plugin("flashcards", {})
	setup_plugin("flote", {})
	setup_plugin("fsplash", {})
	setup_plugin("highlight-current-n-nvim", {})
	setup_plugin("http-codes", function(http_codes) end) -- use vim.g.http_codes
	setup_plugin("inlayhint-filler", {})
	setup_plugin("interlaced", {})
	setup_plugin("keyseer", {})
	setup_plugin("Launch", {})
	setup_plugin("live-server", function(live_server) end) -- use vim.g.live_server
	setup_plugin("metrics", {})
	setup_plugin("minimal-narrow-region", function(_) end)
	setup_plugin("moonicipal", {})
	setup_plugin("navigator", {})
	setup_plugin("neocomposer-nvim", {})
	setup_plugin("neotest-plenary", {})
	setup_plugin("neowell-lua", {})
	setup_plugin("neowords", function(_) end)
	setup_plugin("nerdy", {})
	setup_plugin("nvim-genghis", {}) -- https://github.com/chrisgrieser/nvim-genghis Lightweight and quick file operations without being a full-blown file manager.
	setup_plugin("paint", {})
	setup_plugin("pragma", {})
	setup_plugin("quicknote", {})
	setup_plugin("reactive", {})
	setup_plugin("regex-vars", {})
	setup_plugin("renamer", {})
	setup_plugin("resin", {})
	setup_plugin("retrospect", {})
	setup_plugin("runtimetable", function(_) end)
	setup_plugin("sche", {})
	setup_plugin("search-replace", {})
	setup_plugin("sentiment-nvim", {})
	setup_plugin("sort", {})
	setup_plugin("spaceport-nvim", {})
	setup_plugin("spear", {})
	setup_plugin("strict", {})
	setup_plugin("symbols", {})
	setup_plugin("tdo", {})
	setup_plugin("treemonkey", function(_) end)
	setup_plugin("twig", {})
	setup_plugin("ultimate-autopair-nvim", {})
	utils.packadd("vim-twig")
	setup_plugin("vuffers", {})
	setup_plugin("wastebin", {
		url = "https://foo.bar.com",
	}) -- TODO: install https://github.com/matze/wastebin
	setup_plugin("web-tools", {})
	setup_plugin("wf", {})
	setup_plugin("whaler", {})
	setup_plugin("wildfire", {})

	-------------------------------------------------------------------------------
	-- MODULES: ---------------------------------------------------------------------
	-------------------------------------------------------------------------------
	require("commons.fio")
	require("nio")
	require("nui.input")
	require("jsregexp")
	require("pathlib")
end

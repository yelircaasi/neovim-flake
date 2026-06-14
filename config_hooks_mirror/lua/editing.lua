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

-- https://github.com/JoosepAlviste/nvim-ts-context-commentstring
-- Neovim treesitter plugin for setting the commentstring based on the cursor location in a file.
local ts_context_commentstring_defaults = {}
setup_plugin("ts_context_commentstring", ts_context_commentstring_defaults) -- MAYBE NOT, BUT WORTH A TRY

--─────────────────────────────────────────────────────────────────────────────
--──── saving ─────────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- https://github.com/willothy/savior.nvim | Customizable, event-based auto saving for Neovim
local savior_defaults = {
	events = {
		immediate = {
			"FocusLost",
			"BufLeave",
		},
		deferred = {
			"InsertLeave",
			"TextChanged",
		},
		cancel = {
			"InsertEnter",
			"BufWritePost",
			"TextChanged",
		},
	},
	callbacks = {},
	conditions = {
		savior.conditions.is_file_buf,
		savior.conditions.not_of_filetype({
			"gitcommit",
			"gitrebase",
		}),
		savior.conditions.is_named,
		savior.conditions.file_exists,
		savior.conditions.has_no_errors,
	},
	throttle_ms = 3000,
	interval_ms = 30000,
	defer_ms = 1000,
	-- Set to false to disable fidget.nvim notifications
	notify = true,
}
setup_plugin("savior", savior_defaults) -- PROBABLY NOT, BUT WORTH A TRY

utils.packadd("vim-auto-save", function()
	-- no config required
end) -- PROBABLY NOT, BUT WORTH A TRY

local zpragmatic_defaults = {
	filetype_questions = {
		["*"] = { -- Questions for any file type
			"Don't break any windows.",
			"Don't violate the DRY principle.",
			"Don't violate the ETC principle.",
			"Comment your code.",
			"Ensure your code is easy to change.",
			"Avoid code duplication.",
			"Run tests before saving.",
		},
		["java"] = { -- Questions for Java file types
			"All maven tests must pass before you save.",
			"Ensure code is properly indented and formatted.",
			"Check for potential null pointer exceptions.",
			"All public methods should have proper documentation.",
		},
		["javascript"] = { -- Questions for JavaScript file types
			"Run the linter.",
			"Add jsdocs for all functions.",
			"Ensure there are no console logs left in the code.",
			"Verify no unused variables exist.",
			"Test the code in multiple browsers if necessary.",
		},
		["python"] = { -- Questions for Python file types
			"All tests must pass before saving.",
			"Follow PEP 8 coding standards.",
			"Ensure all functions are properly documented.",
			"Check for any unused imports.",
			"Run `black` to format your code.",
		},
		["html"] = { -- Questions for HTML file types
			"Check for unclosed tags.",
			"Ensure all images have alt attributes.",
			"Validate your HTML with the W3C validator.",
		},
		["css"] = { -- Questions for CSS file types
			"Check for unused CSS rules.",
			"Ensure all CSS classes are named meaningfully.",
			"Ensure consistency in indentation.",
		},
		["go"] = { -- Questions for Go file types
			"Ensure all tests pass using `go test`.",
			"Run `gofmt` to format your code.",
			"Check for unnecessary dependencies.",
		},
		["ruby"] = { -- Questions for Ruby file types
			"All tests should pass using `rspec`.",
			"Follow the Ruby style guide.",
			"Ensure code is well-optimized and readable.",
		},
		["rust"] = { -- Questions for Rust file types
			"All tests should pass using `cargo test`.",
			"Check for unused code and dependencies.",
			"Run `cargo fmt` to format your code.",
		},
	},
	bypass_filetypes = { "markdown", "txt", "text", "plain", "json" }, -- List of file types that should bypass the prompt
}
setup_plugin("zpragmatic", zpragmatic_defaults) -- https://github.com/muhammadzkralla/zpragmatic.nvim  prompts you with alert dialog questions whenever you attempt to save changes in a file

--─────────────────────────────────────────────────────────────────────────────
--──── multicursor ────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────
local multicursors_defaults = {
	DEBUG_MODE = false,
	create_commands = true, -- create Multicursor user commands
	updatetime = 50, -- selections get updated if this many milliseconds nothing is typed in the insert mode see :help updatetime
	nowait = true, -- see :help :map-nowait
	mode_keys = {
		append = "a",
		change = "c",
		extend = "e",
		insert = "i",
	}, -- set bindings to start these modes
	normal_keys = normal_keys,
	insert_keys = insert_keys,
	extend_keys = extend_keys,
	-- see :help hydra-config.hint
	hint_config = {
		float_opts = {
			border = "none",
		},
		position = "bottom",
	},
	-- accepted values:
	-- -1 true: generate hints
	-- -2 false: don't generate hints
	-- -3 [[multi line string]] provide your own hints
	-- -4 fun(heads: Head[]): string - provide your own hints
	generate_hints = {
		normal = true,
		insert = true,
		extend = true,
		config = {
			-- determines how many columns are used to display the hints. If you leave this option nil, the number of columns will depend on the size of your window.
			column_count = nil,
			-- maximum width of a column.
			max_hint_length = 25,
		},
	},
}
setup_plugin("multicursors", multicursors_defaults) -- https://github.com/smoka7/multicursors.nvim

-- https://github.com/mg979/vim-visual-multi
utils.packadd("vim-visual-multi", function()
	vim.g.VM_default_mappings = true
end)

--─────────────────────────────────────────────────────────────────────────────
--──── semantic features ──────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- https://github.com/rrethy/vim-illuminate
-- illuminate.vim - (Neo)Vim plugin for automatically highlighting other uses of the word under the cursor using either LSP, Tree-sitter, or regex matching
utils.packadd("illuminate")

--─────────────────────────────────────────────────────────────────────────────
--──── sequences ─────────────────────────────────────────────────────────────-
--─────────────────────────────────────────────────────────────────────────────

-- https://github.com/bennypowers/splitjoin.nvim | Split or join list-like syntax constructs
setup_plugin("splitjoin", function(splitjoin)
	local CSS = require("splitjoin.languages.css.functions")
	local ECMAScript = require("splitjoin.languages.ecmascript.functions")
	local Go = require("splitjoin.languages.go.functions")
	local HTML = require("splitjoin.languages.html.functions")
	local JSDoc = require("splitjoin.languages.jsdoc.functions")
	local Lua = require("splitjoin.languages.lua.functions")
	local Nix = require("splitjoin.languages.nix.functions")
	local Node = require("splitjoin.util.node")
	local Node = require("splitjoin.util.node")
	local String = require("splitjoin.util.string")
	local Yaml = require("splitjoin.languages.yaml.functions")

	local function save_cursor_node_context()
		local node = vim.treesitter.get_node()
		if not node then
			return nil
		end
		local parent_union = node
		while parent_union and parent_union:type() ~= "union_type" do
			parent_union = parent_union:parent()
		end
		local union_start_row, _ = parent_union and parent_union:start() or node:start()
		local node_start_row, node_start_col = node:start()
		return {
			type = node:type(),
			text = vim.treesitter.get_node_text(node, 0),
			rel_row = node_start_row - union_start_row,
			rel_col = node_start_col,
		}
	end

	local get_node_text = vim.treesitter.get_node_text

	vim.g.splitjoin = {
		languages = {
			c = {
				nodes = {
					parameter_list = { surround = { "(", ")" }, trailing_separator = false },
					argument_list = { surround = { "(", ")" }, trailing_separator = false },
					initializer_list = { surround = { "{", "}" } },
					enumerator_list = { surround = { "{", "}" }, padding = " " },
					field_declaration_list = {
						surround = { "{", "}" },
						separator = ";",
						separator_is_node = false,
					},
				},
			},
			cpp = {
				extends = "c",

				nodes = {
					template_argument_list = { surround = { "<", ">" }, trailing_separator = false },
					template_parameter_list = { surround = { "<", ">" }, trailing_separator = false },
				},
			},
			css = {
				nodes = {

					block = {
						surround = { "{", "}" },
						separator = ";",
						separator_is_node = false,
					},

					arguments = {
						surround = { "(", ")" },
						trailing_separator = false,
					},

					declaration = {
						split = CSS.split_declaration,
						join = CSS.join_declaration,
					},
				},
			},
			ecmascript = {

				nodes = {

					object = {
						surround = { "{", "}" },
					},

					object_pattern = {
						surround = { "{", "}" },
						padding = " ",
					},

					array = {
						surround = { "[", "]" },
					},

					array_pattern = {
						surround = { "[", "]" },
					},

					named_imports = {
						surround = { "{", "}" },
					},

					arguments = {
						surround = { "(", ")" },
					},

					formal_parameters = {
						surround = { "(", ")" },
					},

					function_declaration = {
						split = ECMAScript.split_function,
						join = ECMAScript.join_function,
					},

					function_expression = {
						split = ECMAScript.split_function,
						join = ECMAScript.join_function,
					},

					arrow_function = {
						split = ECMAScript.split_arrow_function,
						join = ECMAScript.join_arrow_function,
					},

					comment = {
						default_indent = " ",
						split = ECMAScript.split_comment,
						join = ECMAScript.join_comment,
					},
				},
			},
			go = {
				default_indent = "  ",
				nodes = {
					-- Go struct fields
					field_declaration_list = {
						surround = { "{", "}" },
						split = Go.split_struct,
						join = Go.join_struct,
					},

					-- Go function parameters and return lists
					parameter_list = {
						surround = { "(", ")" },
						trailing_separator = true,
					},

					-- Go function call arguments
					argument_list = {
						surround = { "(", ")" },
					},

					-- Go slice, map, and composite literals
					literal_value = {
						surround = { "{", "}" },
					},
				},
			},
			html = {

				nodes = {

					tag_name = {
						split = HTML.split,
						join = HTML.join,
					},

					attribute = {
						split = HTML.split,
						join = HTML.join,
					},

					text = {
						split = HTML.split,
						join = HTML.join,
					},

					start_tag = {
						split = HTML.split,
						join = HTML.join,
					},

					end_tag = {
						split = HTML.split,
						join = HTML.join,
					},
				},
			},
			javascript = {
				extends = "ecmascript",
			},
			jsdoc = {

				nodes = {

					description = {
						split = JSDoc.split_jsdoc_description,
						join = JSDoc.join_jsdoc_description,
						trailing_separator = false,
					},
				},
			},
			json = {

				nodes = {

					object = {
						surround = { "{", "}" },
						trailing_separator = false,
					},

					array = {
						surround = { "[", "]" },
						trailing_separator = false,
					},
				},
			},
			lua = {

				nodes = {

					arguments = {
						surround = { "(", ")" },
						trailing_separator = false,
					},

					function_declaration = {
						split = Lua.split_function,
						join = Lua.join_function,
					},

					function_definition = {
						split = Lua.split_function,
						join = Lua.join_function,
					},

					if_statement = {
						trailing_separator = false,
						surround = { "if", "end" },
						split = Lua.split_if,
						join = Lua.join_if,
					},

					parameters = {
						surround = { "(", ")" },
						trailing_separator = false,
					},

					table_constructor = {
						surround = { "{", "}" },
					},

					variable_list = {
						trailing_separator = false,
						split = function(node)
							local source = get_node_text(node, 0)
							local is_variable_decl = Node.is_child_of("variable_declaration", node)
							local indent = ""
							if is_variable_decl then
								local _, scol = node:child(0):start()
								local base_len = #(Node.get_base_indent(node))
								indent = string.rep(" ", scol - base_len)
							end
							local new = source:gsub(",%s*", ",\n" .. indent)
							Node.replace(node, new)
							Node.goto_node(node)
							if is_variable_decl then
								Node.trim_line_end(node)
							end
						end,
						join = function(node)
							local source = get_node_text(node, 0)
							local next = source:gsub("%s+", " ")
							Node.replace(node, next)
							Node.goto_node(node)
						end,
					},
				},
			},
			nix = {
				nodes = {
					list_expression = {
						split = Nix.split_list,
						join = Nix.join_list,
					},
				},
			},
			python = {
				default_indent = String.buffer_indent,
				nodes = {
					parameters = { surround = { "(", ")" } },
					argument_list = { surround = { "(", ")" } },
					list = { surround = { "[", "]" } },
					dictionary = { surround = { "{", "}" } },
					tuple = { surround = { "(", ")" } },
					set = { surround = { "{", "}" } },
				},
			},
			rust = {
				nodes = {
					parameters = { surround = { "(", ")" } },
					arguments = { surround = { "(", ")" } },
					tuple_expression = { surround = { "(", ")" } },
					field_declaration_list = { surround = { "{", "}" }, padding = " " },
					enum_variant_list = { surround = { "{", "}" }, padding = " " },
					use_list = { surround = { "{", "}" } },
					token_tree = { surround = { "[", "]" } },
					match_block = { surround = { "{", "}" } },
				},
			},
			typescript = {
				extends = "ecmascript",

				nodes = {

					union_type = {
						separator = "|",
						split = function(node, options)
							local n = node
							while Node.is_child_of("union_type", n) do
								n = n:parent()
							end
							local source = get_node_text(n, 0)
							local base_indent = Node.get_base_indent(n) or ""
							local indent = base_indent
							local sep = options.sep_first and ("\n" .. indent .. "| ") or (" |\n" .. indent)
							local prefix = options.sep_first and "\n" .. indent .. indent .. "| " or indent
							local replacement = prefix .. source:gsub("|", sep)

							local start_row, start_col = n:start()

							Node.replace(n, replacement)
							Node.trim_line_end(node)

							vim.treesitter.get_parser(0):parse()

							local new_node_at_pos = vim.treesitter.get_node({ pos = { start_row, start_col } })
							local union_node = new_node_at_pos
								and Node.find_descendant(new_node_at_pos, function(nd)
									return nd:type() == "union_type"
								end)

							if union_node then
								Node.goto_node(union_node, "start", 1)
							else
								vim.api.nvim_win_set_cursor(0, { start_row + 1, start_col })
							end
						end,
						join = function(node, options)
							local cursor_ctx = save_cursor_node_context()

							local n = node
							while n and n:type() ~= "type_alias_declaration" do
								n = n:parent()
							end
							if not n then
								return
							end

							local source = Node.get_text(n)
							local collapsed = source
								:gsub("\n%s*|%s*", "|")
								:gsub("[\n\r]", " ")
								:gsub("%s*=%s*", " = ")
								:gsub("%s*;%s*$", ";")
								:gsub("= *|%s*", "= ")
								:gsub("^%s*|%s*", "")

							Node.replace(n, collapsed)

							local new_node = vim.treesitter.get_node()
							while new_node and new_node:type() ~= "union_type" do
								new_node = new_node:parent()
							end
							local match = cursor_ctx
								and new_node
								and Node.find_descendant(new_node, function(nd)
									return nd:type() == cursor_ctx.type and Node.get_text(nd) == cursor_ctx.text
								end)
							Node.goto_node(match or new_node, "start", 1)
						end,
					},

					type_arguments = {
						surround = { "<", ">" },
						trailing_separator = false,
					},

					type_parameters = {
						surround = { "<", ">" },
					},
				},
			},
			yaml = {
				nodes = {
					flow_sequence = { surround = { "[", "]" }, split = Yaml.split_flow_sequence },
					flow_mapping = { surround = { "{", "}" } },
					block_sequence = { split = function() end, join = Yaml.join_block_sequence },
				},
			},
		},
	}
end)

-- (uses nvim-treesitter)
-- https://github.com/aarondiel/spread.nvim
-- a neovim plugin to spread out inline objects, arrays, parameter lists, etc.
local spread_defaults = nil
setup_plugin("spread", function(spread)
	local default_options = {
		silent = true,
		noremap = true,
	}

	vim.keymap.add("n", "<leader>ss", spread.out, default_options)
	vim.keymap.add("n", "<leader>ssc", spread.combine, default_options)
end)

-- https://github.com/wansmer/treesj | for splitting/joining blocks of code
local treesj_defaults = {
	---@type boolean Use default keymaps (<space>m - toggle, <space>j - join, <space>s - split)
	use_default_keymaps = true,
	---@type boolean Node with syntax error will not be formatted
	check_syntax_error = true,
	---If line after join will be longer than max value,
	---@type number If line after join will be longer than max value, node will not be formatted
	max_join_length = 120,
	---Cursor behavior:
	---hold - cursor follows the node/place on which it was called
	---start - cursor jumps to the first symbol of the node being formatted
	---end - cursor jumps to the last symbol of the node being formatted
	---@type 'hold'|'start'|'end'
	cursor_behavior = "hold",
	---@type boolean Notify about possible problems or not
	notify = true,
	---@type boolean Use `dot` for repeat action
	dot_repeat = true,
	---@type nil|function Callback for treesj error handler. func (err_text, level, ...other_text)
	on_error = nil,
	---@type table Presets for languages
	-- langs = {}, -- See the default presets in lua/treesj/langs
}
setup_plugin("treesj", function(treesj)
	treesj.setup({
		use_default_keymaps = false,
		max_join_length = 120,
	})

	vim.keymap.set("n", "gS", treesj.toggle)
end)

-- https://github.com/kaymmm/bullets.nvim | lua port of dkarter/bullets.vim
--     (plugin for automated bullet lists)
local bullets_defaults = {
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
}
setup_plugin("Bullets", bullets_defaults)

--─────────────────────────────────────────────────────────────────────────────
--──── sorting ─────────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- https://github.com/sQVe/sort.nvim
-- Sorting plugin for Neovim that supports line-wise and delimiter sorting.
local sort_defaults = {
	-- Delimiter priority order.
	delimiters = {
		",",
		"|",
		";",
		":",
		"s", -- Space.
		"t", -- Tab.
	},

	-- Natural sorting (default: true).
	natural_sort = true,

	-- Case-insensitive sorting (default: false).
	ignore_case = false,

	-- Remove duplicate items when sorting (default: false).
	unique = false,

	-- Whitespace alignment threshold.
	whitespace = {
		alignment_threshold = 3,
	},

	-- Default keymappings (set to false to disable).
	mappings = {
		operator = "go",
		textobject = {
			inner = "io",
			around = "ao",
		},
		motion = {
			next_delimiter = "]o",
			prev_delimiter = "[o",
		},
	},
}
setup_plugin("sort", sort_defaults)

--─────────────────────────────────────────────────────────────────────────────
--──── deletion ───────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────
setup_plugin("ax") -- https://github.com/mikeslattery/ax.nvim  Delete all the things!

--─────────────────────────────────────────────────────────────────────────────
--──── casing ─────────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────
-- cycle a word through snake_case, camelCase, PascalCase, SCREAMING_SNAKE
utils.packadd("vim-caser")

--─────────────────────────────────────────────────────────────────────────────
--──── wrapping ───────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- https://github.com/andrewferrier/wrapping.nvim
-- Plugin to make it easier to switch between 'soft' and 'hard' line wrapping in NeoVim
local wrapping_defaults = {
	set_nvim_opt_defaults = true,
	softener = {
		default = 1.0,
		gitcommit = false, -- Based on https://stackoverflow.com/a/2120040/27641
	},
	create_commands = true,
	create_keymaps = true,
	auto_set_mode_heuristically = true,
	auto_set_mode_filetype_allowlist = {
		"asciidoc",
		"gitcommit",
		"help",
		"latex",
		"mail",
		"markdown",
		"rst",
		"tex",
		"text",
		"typst",
	},
	auto_set_mode_filetype_denylist = {},
	buftype_allowlist = {},
	excluded_treesitter_queries = {
		markdown = {
			"(fenced_code_block) @markdown1",
			"(atx_heading) @markdown2",
			"(pipe_table_header) @markdown3",
			"(pipe_table_delimiter_row) @markdown4",
			"(pipe_table_row) @markdown5",
		},
	},
	notify_on_switch = true,
	-- log_path = utils.get_log_path(),
}
setup_plugin("wrapping", wrapping_defaults)

-- https://github.com/benlubas/wrapping-paper.nvim
-- Simple plugin which simulates wrapping a single line at a time using floating windows and virtual text trickery
local wrapping_paper_defaults = {
	width = math.huge, -- max width of the wrap window
	remaps = {
		-- { "mode", "lhs", "rhs" }, -- these are added to the buffer on open, and removed on close
		{ "n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true } },
		{ "n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true } }, -- This isn't really how it's done, the real mapping for k is more complicated, but it will function like this
		{ "n", "0", "g0" },
		{ "n", "_", "g0" },
		{ "n", "^", "g^" },
		{ "v", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true } },
		{ "v", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true } }, -- same as normal mode k ^
		{ "v", "0", "g0" },
		{ "v", "_", "g0" },
		{ "v", "^", "g^" },

		-- NOTE: these functions are called when the cursor is still in the parent window
		-- remap <c-d> and <c-u>, otherwise they scroll half the popup height which is not what you
		-- expect to happen
		function()
			return { "n", "<c-d>", math.floor(vim.api.nvim_win_get_height(0) / 2) .. "j" }
		end,
		function()
			return { "n", "<c-u>", math.floor(vim.api.nvim_win_get_height(0) / 2) .. "k" }
		end,
		{
			"n",
			"<c-e>",
			function()
				local cursor = vim.api.nvim_win_get_cursor(0)
				local keys = vim.api.nvim_replace_termcodes(
					":q<CR><C-e>:lua require('wrapping-paper').wrap_line()<CR>",
					true,
					false,
					true
				)
				vim.api.nvim_feedkeys(keys, "n", false)
				vim.api.nvim_win_set_cursor(0, cursor)
			end,
		},
		{
			"n",
			"<c-y>",
			function()
				local cursor = vim.api.nvim_win_get_cursor(0)
				local keys = vim.api.nvim_replace_termcodes(
					":q<CR><C-y>:lua require('wrapping-paper').wrap_line()<CR>",
					true,
					false,
					true
				)
				vim.api.nvim_feedkeys(keys, "n", false)
				vim.api.nvim_win_set_cursor(0, cursor)
			end,
		},
	},
}
setup_plugin("wrapping-paper", wrapping_paper_defaults)

--─────────────────────────────────────────────────────────────────────────────
--──── command helpers ────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- https://codeberg.org/hernandez/dotdot.nvim
-- lets you search for and execute commands with a press of `..`
-- TODO: PR with function syntax fixed
local function format_buffer(ctx)
	vim.lsp.buf.format({ bufnr = ctx.bufnr })
end

local format_buffer_cmd = {
	id = "format",
	title = "Format Buffer",
	run = format_buffer,
}

local function insert_date(ctx)
	local date = os.date("%Y-%m-%d")
	vim.api.nvim_buf_set_text(
		ctx.bufnr,
		ctx.cursor.row - 1,
		ctx.cursor.col,
		ctx.cursor.row - 1,
		ctx.cursor.col,
		{ date }
	)
end

local insert_date_cmd = {
	id = "insert_date",
	title = "Insert Date",
	description = "Insert today's date in %Y-%m-%d format",
	run = insert_date_cmd,
}

local function copy_rel_path(ctx)
	local path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(ctx.bufnr), ":.")
	vim.fn.setreg("+", path)
	vim.notify("Copied: " .. path)
end

local copy_rel_path_cmd = {
	id = "copy_rel_path",
	title = "Copy Relative Path",
	category = "FILEPATH",
	run = copy_rel_path,
}

local function copy_abs_path(ctx)
	local path = vim.api.nvim_buf_get_name(ctx.bufnr)
	vim.fn.setreg("+", path)
	vim.notify("Copied: " .. path)
end

local copy_abs_path_cmd = {
	id = "copy_abs_path",
	title = "Copy Absolute Path",
	category = "FILEPATH",
	run = copy_abs_path,
}

local commands = {
	format_buffer_cmd,
	insert_date_cmd,
	copy_rel_path_cmd,
	copy_abs_path_cmd,
}
setup_plugin("dotdot", { commands = commands })

--─────────────────────────────────────────────────────────────────────────────
--──── values ─────────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- https://github.com/tpope/vim-abolish
-- abolish.vim: Work with several variants of a word at once
utils.packadd("vim-abolish")

setup_plugin("date-time-inserter", function(dti)
	dti.setup({
		date_format = "%d-%m-%Y",
		time_format = "%H:%M",
		date_time_separator = " at ",
		presets = {},
	})

	vim.keymap.set("n", "<leader>dt", ':r! date "+\\%d-\\%m-\\%Y" <CR>', { noremap = true })
	vim.keymap.set("n", "<leader>tt", ':r! date "+\\%H:\\%M:\\%S" <CR>', { noremap = true })

	vim.keymap.set("n", "<leader>dt", "<cmd>InsertDate<CR>", { noremap = true, silent = true })

	vim.keymap.set("n", "<leader>tt", "<cmd>InsertTime<CR>", { noremap = true, silent = true })

	vim.keymap.set("n", "<leader>dtt", "<cmd>InsertDateTime<CR>", { noremap = true, silent = true })
end)

-- likely strictly dominated by dial
-- https://github.com/AndrewRadev/switch.vim
-- A simple Vim plugin to switch segments of text with predefined replacements
utils.packadd("switch.vim")

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
		only_in_visual = {
			augend.integer.alias.decimal,
			augend.integer.alias.hex,
			augend.date.alias["%Y/%m/%d"],
			augend.constant.alias.alpha,
			augend.constant.alias.Alpha,
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

	map("x", "<C-a>", function()
		require("dial.map").manipulate("increment", "visual", "only_in_visual")
	end)
	map("x", "<C-x>", function()
		require("dial.map").manipulate("decrement", "visual", "only_in_visual")
	end)

	require("dial.config").augends:on_filetype({
		typescript = {
			augend.integer.alias.decimal,
			augend.integer.alias.hex,
			augend.constant.new({ elements = { "let", "const" } }),
		},
	})
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

-- https://github.com/arsham/indent-tools.nvim
local indent_tools_defaults = {
	normal = {
		up = "[i",
		down = "]i",
		repeatable = true, -- requires nvim-treesitter-textobjects
	},
	textobj = {
		ii = "ii",
		ai = "ai",
	},
}
setup_plugin("indent-tools", indent_tools_defaults)

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

-- https://github.com/willothy/moveline.nvim
-- Neovim plugin for moving lines up and down
setup_plugin("moveline", function(moveline)
	vim.keymap.set("n", "<M-k>", moveline.up)
	vim.keymap.set("n", "<M-j>", moveline.down)
	vim.keymap.set("v", "<M-k>", moveline.block_up)
	vim.keymap.set("v", "<M-j>", moveline.block_down)
end)

-- https://github.com/Wansmer/sibling-swap.nvim
-- Neovim plugin for swaps closest siblings with Tree-Sitter
local sibling_swap_defaults = {
	allowed_separators = {
		",",
		";",
		"and",
		"or",
		"&&",
		"&",
		"||",
		"|",
		"==",
		"===",
		"!=",
		"!==",
		"-",
		"+",
		["<"] = ">",
		["<="] = ">=",
		[">"] = "<",
		[">="] = "<=",
	},
	use_default_keymaps = true,
	-- Highlight recently swapped node. Can be boolean or table
	-- If table: { ms = 500, hl_opts = { link = 'IncSearch' } }
	-- `hl_opts` is a `val` from `nvim_set_hl()`
	highlight_node_at_cursor = false,
	-- keybinding for movements to right or left (and up or down, if `allow_interline_swaps` is true)
	-- (`<C-,>` and `<C-.>` may not map to control chars at system level, so are sent by certain terminals as just `,` and `.`. In this case, just add the mappings you want.)
	keymaps = {
		["<C-.>"] = "swap_with_right",
		["<C-,>"] = "swap_with_left",
		["<space>."] = "swap_with_right_with_opp",
		["<space>,"] = "swap_with_left_with_opp",
	},
	ignore_injected_langs = false,
	-- allow swaps across lines
	allow_interline_swaps = true,
	-- swaps interline siblings without separators (no recommended, helpful for swaps html-like attributes)
	interline_swaps_without_separator = false,
	-- Fallbacs for tiny settings for langs and nodes. See #fallback
	fallback = {},
}
setup_plugin("sibling-swap-nvim", sibling_swap_defaults)

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

-- https://github.com/SUSTech-data/wildfire.nvim
-- incremental and decremental selection
local wildfire_defaults = {
	surrounds = {
		{ "(", ")" },
		{ "{", "}" },
		{ "<", ">" },
		{ "[", "]" },
	},
	keymaps = {
		init_selection = "<CR>",
		node_incremental = "<CR>",
		node_decremental = "<BS>",
	},
	filetype_exclude = { "qf" }, --keymaps will be unset in excluding filetypes
}
setup_plugin("wildfire", wildfire_defaults)

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

-- https://github.com/utilyre/sentiment.nvim
-- Enhanced matchparen.vim plugin for Neovim to highlight the outer pair.
-- TODO: deprecated -> vendor? fork?
local sentiment_defaults = {
	---Dictionary to check whether a buftype should be included.
	---
	---@type table<string, boolean>
	included_buftypes = {
		[""] = true,
	},

	---Dictionary to check whether a filetype should be excluded.
	---
	---@type table<string, boolean>
	excluded_filetypes = {},

	---Dictionary to check whether a mode should be included.
	---
	---@type table<string, boolean>
	included_modes = {
		n = true,
		i = true,
	},

	---How much (in milliseconds) should the cursor stay still to calculate and
	---render a pair.
	---
	---NOTE: It's recommended to set this somewhere above and close to your key
	---repeat speed in order to keep the calculations at minimum.
	---
	---@type integer
	delay = 50,

	---How many lines to look backwards/forwards to find a pair.
	---
	---@type integer
	limit = 100,

	---List of `(left, right)` pairs.
	---
	---NOTE: Both sides of a pair can't have the same character.
	---
	---@type tuple<string, string>[]
	pairs = {
		{ "(", ")" },
		{ "{", "}" },
		{ "[", "]" },
	},
}
setup_plugin("sentiment-nvim", sentiment_defaults) -- archived

-- https://github.com/altermo/ultimate-autopair.nvim
-- treesitter supported autopairing plugin with extensions, and much more
local ultimate_autopair_defaults = {
	conf = {
		profile = "default",
		--what profile to use
		map = true,
		--whether to allow any insert map
		cmap = true, --cmap stands for cmd-line map
		--whether to allow any cmd-line map
		pair_map = true,
		--whether to allow pair insert map
		pair_cmap = true,
		--whether to allow pair cmd-line map
		multiline = true,
		--enable/disable multiline
		bs = { -- *ultimate-autopair-map-backspace-config*
			enable = true,
			map = "<bs>", --string or table
			cmap = "<bs>", --string or table
			overjumps = true,
			--(|foo) > bs > |foo
			space = true, --false, true or 'balance'
			--( |foo ) > bs > (|foo)
			--balance:
			--  Will prioritize balanced spaces
			--  ( |foo  ) > bs > ( |foo )
			indent_ignore = false,
			--(\n\t|\n) > bs > (|)
			single_delete = false,
			-- <!--|--> > bs > <!-|
			delete_from_end = true,
			-- []| > bs > |
			conf = {},
			--contains extension config
			multi = false,
			--use multiple configs (|ultimate-autopair-map-multi-config|)
		},
		cr = { -- *ultimate-autopair-map-newline-config*
			enable = true,
			map = "<cr>", --string or table
			autoclose = false,
			--(| > cr > (\n|\n)
			conf = {
				cond = function(fn)
					return not fn.in_lisp()
				end,
			},
			--contains extension config
			multi = false,
			--use multiple configs (|ultimate-autopair-map-multi-config|)
		},
		space = { -- *ultimate-autopair-map-space-config*
			enable = true,
			map = " ", --string or table
			cmap = " ", --string or table
			check_box_ft = { "markdown", "vimwiki", "org" },
			_check_box_ft2 = { "norg" }, --may be removed
			--+ [|] > space > + [ ]
			conf = {},
			--contains extension config
			multi = false,
			--use multiple configs (|ultimate-autopair-map-multi-config|)
		},
		space2 = { -- *ultimate-autopair-map-space2-config*
			enable = false,
			match = [[\k]],
			--what character activate
			conf = {},
			--contains extension config
			multi = false,
			--use multiple configs (|ultimate-autopair-map-multi-config|)
		},
		fastwarp = { -- *ultimate-autopair-map-fastwarp-config*
			enable = true,
			enable_normal = true,
			enable_reverse = true,
			hopout = false,
			--{(|)} > fastwarp > {(}|)
			map = "<A-e>", --string or table
			rmap = "<A-E>", --string or table
			cmap = "<A-e>", --string or table
			rcmap = "<A-E>", --string or table
			multiline = true,
			--(|) > fastwarp > (\n|)
			nocursormove = true,
			--makes the cursor not move (|)foo > fastwarp > (|foo)
			--disables multiline feature
			--only activates if prev char is start pair, otherwise fallback to normal
			do_nothing_if_fail = true,
			--add a module so that if fastwarp fails
			--then an `e` will not be inserted
			no_filter_nodes = { "string", "raw_string", "string_literals", "character_literal" },
			--which nodes to skip for tsnode filtering
			faster = false,
			--only enables jump over pair, goto end/next line
			--useful for the situation of:
			--{|}M.foo('bar') > {M.foo('bar')|}
			conf = {},
			--contains extension config
			multi = false,
			--use multiple configs (|ultimate-autopair-map-multi-config|)
		},
		close = { -- *ultimate-autopair-map-close-config*
			enable = true,
			map = "<A-)>", --string or table
			cmap = "<A-)>", --string or table
			conf = {},
			--contains extension config
			multi = false,
			--use multiple configs (|ultimate-autopair-map-multi-config|)
			do_nothing_if_fail = true,
			--add a module so that if close fails
			--then a `)` will not be inserted
		},
		tabout = { -- *ultimate-autopair-map-tabout-config*
			enable = false,
			map = "<A-tab>", --string or table
			cmap = "<A-tab>", --string or table
			conf = {},
			--contains extension config
			multi = false,
			--use multiple configs (|ultimate-autopair-map-multi-config|)
			hopout = false,
			-- (|) > tabout > ()|
			do_nothing_if_fail = true,
			--add a module so that if close fails
			--then a `\t` will not be inserted
		},
		extensions = { -- *ultimate-autopair-extensions-default-config*
			bigfile = { p = 110 },
			cmdtype = { skip = { "/", "?", "@", "-" }, p = 100 },
			filetype = { p = 90, nft = { "TelescopePrompt" }, tree = true },
			escape = { filter = true, p = 80 },
			utf8 = { p = 70 },
			tsnode = {
				p = 60,
				separate = {
					"comment",
					"string",
					"char",
					"character",
					"raw_string", --fish/bash/sh
					"char_literal",
					"string_literal", --c/cpp
					"string_value", --css
					"str_lit",
					"char_lit", --clojure/commonlisp
					"interpreted_string_literal",
					"raw_string_literal",
					"rune_literal", --go
					"quoted_attribute_value", --html
					"template_string", --javascript
					"LINESTRING",
					"STRINGLITERALSINGLE",
					"CHAR_LITERAL", --zig
					"string_literals",
					"character_literal",
					"line_comment",
					"block_comment",
					"nesting_block_comment", --d #62
					"multiline_comment",
					"line_string_literal",
					"raw_string_literal",
					"multi_line_string_literal", -- swift #84
				},
			},
			cond = { p = 40, filter = true },
			alpha = { p = 30, filter = false, all = false },
			suround = { p = 20 },
			fly = {
				other_char = { " " },
				nofilter = false,
				p = 10,
				undomapconf = {},
				undomap = nil,
				undocmap = nil,
				only_jump_end_pair = false,
			},
		},
		internal_pairs = { -- *ultimate-autopair-pairs-default-pairs*
			{ "[", "]", fly = true, dosuround = true, newline = true, space = true },
			{ "(", ")", fly = true, dosuround = true, newline = true, space = true },
			{ "{", "}", fly = true, dosuround = true, newline = true, space = true },
			{
				'"',
				'"',
				suround = true,
				cond = function(fn, o)
					return fn.get_ft() ~= "vim"
						or (not o.line:sub(1, o.col - 1):match("^%s*$") and o.line:sub(o.col - 1, o.col - 1) ~= "@")
				end,
				multiline = false,
			},
			{
				"'",
				"'",
				suround = true,
				cond = function(fn)
					return not fn.in_lisp() or fn.in_string()
				end,
				alpha = true,
				nft = { "tex", "rust" },
				multiline = false,
			},
			{
				"`",
				"`",
				cond = function(fn)
					return not fn.in_lisp() or fn.in_string()
				end,
				nft = { "tex" },
				multiline = false,
			},
			{ "``", "''", ft = { "tex" } },
			{ "```", "```", newline = true, ft = { "markdown" } },
			{ "<!--", "-->", ft = { "markdown", "html" }, space = true },
			{ '"""', '"""', newline = true, ft = { "python" } },
			{ "'''", "'''", newline = true, ft = { "python" } },
		},
		config_internal_pairs = { -- *ultimate-autopair-pairs-configure-default-pairs*
			--configure internal pairs
			--example:
			--{'{','}',suround=true},
		},
	},
}
setup_plugin("ultimate-autopair", ultimate_autopair_defaults) -- use?

-- https://github.com/saghen/blink.pairs
-- Intelligent auto-pairs with rainbow highlighting for Neovim
local blink_pairs_defaults = {
	mappings = {
		-- you can call require("blink.pairs.mappings").enable()
		-- and require("blink.pairs.mappings").disable()
		-- to enable/disable mappings at runtime
		enabled = true,
		cmdline = true,
		-- or disable with `vim.g.pairs = false` (global) and `vim.b.pairs = false` (per-buffer)
		-- and/or with `vim.g.blink_pairs = false` and `vim.b.blink_pairs = false`
		disabled_filetypes = {},
		wrap = {
			-- move closing pair via motion
			["<C-b>"] = "motion",
			-- move opening pair via motion
			["<C-S-b>"] = "motion_reverse",
			-- set to 'treesitter' or 'treesitter_reverse' to use treesitter instead of motions
			-- set to nil, '' or false to disable the mapping
			-- normal_mode = {} <- for normal mode mappings, only supports 'motion' and 'motion_reverse'
		},
		-- see the defaults:
		-- https://github.com/Saghen/blink.pairs/blob/main/lua/blink/pairs/config/mappings.lua#L52
		pairs = {},
	},
	highlights = {
		enabled = true,
		-- requires require('vim._core.ui2').enable({}), otherwise has no effect
		cmdline = true,
		-- set to { 'BlinkPairs' } to disable rainbow highlighting
		groups = { "BlinkPairsOrange", "BlinkPairsPurple", "BlinkPairsBlue" },
		unmatched_group = "BlinkPairsUnmatched",

		-- highlights matching pairs under the cursor
		matchparen = {
			enabled = true,
			-- known issue where typing won't update matchparen highlight, disabled by default
			cmdline = false,
			-- also include pairs not on top of the cursor, but surrounding the cursor
			include_surrounding = false,
			group = "BlinkPairsMatchParen",
			priority = 250,
		},
	},
	debug = false,
}
setup_plugin("blink.pairs", blink_pairs_defaults)

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
--──── digraphs ───────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- https://github.com/protex/better-digraphs.nvim
-- Better digraphs plugin based on idea from Damian Conway
setup_plugin("better-digraphs", function(_) end)

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

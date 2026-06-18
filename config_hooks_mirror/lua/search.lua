local selections = {
	picker = "snacks",
}
local elements = {
	["regex-vars"] = false,
	["inc_rename"] = false,
	["muren"] = false,
	["rip-substitute"] = false,
	["sad"] = false,
	["fzf-lua"] = false,
	["deck"] = false,
	["snacks"] = selections.picker == "snacks",
	["hlslens"] = false,
	["nvim-hlsearch"] = false,
	["grug-far"] = false,
	["spectre"] = false,
	["pickme"] = selections.picker == "pickme",
	["renamer"] = false,
	["search-replace"] = false,
	["rgflow"] = false,
	["ssr"] = false,
	["substitute"] = false,
	["actions-preview"] = false,
	["spider"] = false,
	["improved-search-nvim"] = false,
	["nvim-rg"] = false,
	["hlsearch-nvim"] = false,
	["nvim-monorepos"] = false,
	["blink"] = false,
}

local function setup_regex_vars()
	-- https://github.com/jake-stewart/regex-vars.nvim
	-- search in neovim with variable expansion
	local regex_vars_defaults = nil
	setup_plugin("regex-vars", function(rv)
		-- example
		rv.setup({
			[rv.escape(":foo:")] = "bar",
		})
	end)
end

local function setup_inc_rename()
	-- https://github.com/smjonas/inc-rename.nvim
	-- Incremental LSP renaming based on Neovim's command-preview feature
	local inc_rename_defaults = {
		-- the name of the command
		cmd_name = "IncRename",
		-- the highlight group used for highlighting the identifier's new name
		hl_group = "Substitute",
		-- whether an empty new name should be previewed; if false the command preview will be cancelled instead
		preview_empty_name = false,
		-- whether to display a `Renamed m instances in n files` message after a rename operation
		show_message = true,
		-- whether to save the "IncRename" command in the commandline history (set to false to prevent issues with
		-- navigating to older entries that may arise due to the behavior of command preview)
		save_in_cmdline_history = true,
		-- the type of the external input buffer to use (currently supports "dressing" or "snacks")
		input_buffer_type = nil,
		-- callback to run after renaming, receives the result table (from LSP handler) as an argument
		post_hook = nil,
	}
	setup_plugin("inc_rename", inc_rename_defaults)
end

local function setup_muren()
	-- https://github.com/AckslD/muren.nvim
	-- multiple search and replace with ease
	local muren_defaults = {
		-- general
		create_commands = true,
		filetype_in_preview = true,
		-- default togglable options
		two_step = false,
		all_on_line = true,
		preview = true,
		cwd = false,
		files = "**/*",
		-- keymaps
		keys = {
			close = "q",
			toggle_side = "<Tab>",
			toggle_options_focus = "<C-s>",
			toggle_option_under_cursor = "<CR>",
			scroll_preview_up = "<Up>",
			scroll_preview_down = "<Down>",
			do_replace = "<CR>",
			-- NOTE these are not guaranteed to work, what they do is just apply `:normal! u` vs :normal! <C-r>`
			-- on the last affected buffers so if you do some edit in these buffers in the meantime it won't do the correct thing
			do_undo = "<localleader>u",
			do_redo = "<localleader>r",
		},
		-- ui sizes
		patterns_width = 30,
		patterns_height = 10,
		options_width = 20,
		preview_height = 12,
		-- window positions
		anchor = "center", -- Set to one of:
		-- 'center' | 'top' | 'bottom' | 'left' | 'right' | 'top_left' | 'top_right' | 'bottom_left' | 'bottom_right'
		vertical_offset = 0, -- offsets are relative to anchors
		horizontal_offset = 0,
		-- options order in ui
		order = {
			"buffer",
			"dir",
			"files",
			"two_step",
			"all_on_line",
			"preview",
		},
		-- highlights used for options ui
		hl = {
			options = {
				on = "@string",
				off = "@variable.builtin",
			},
			preview = {
				cwd = {
					path = "Comment",
					lnum = "Number",
				},
			},
		},
	}
	setup_plugin("muren", muren_defaults)
end

local function setup_rip_substitute()
	-- TODO: install ripgrep
	-- https://github.com/chrisgrieser/nvim-rip-substitute
	-- Search & replace in the current buffer or workspace with incremental preview, a convenient UI, and modern regex syntax
	local rip_substitute_defaults = {
		popupWin = {
			title = " rip-substitute",
			border = getBorder(), -- `vim.o.winborder` on nvim 0.11, otherwise "rounded"
			matchCountHlGroup = "Keyword",
			noMatchHlGroup = "ErrorMsg",
			position = "bottom", ---@type "top"|"bottom"
			hideSearchReplaceLabels = false,
			hideKeymapHints = false,
			disableCompletions = true, -- such as from blink.cmp
		},
		prefill = {
			normal = "cursorWord", ---@type "cursorWord"|false
			visual = "selection", ---@type "selection"|false -- (not with ex-command, see README)
			startInReplaceLineIfPrefill = false,
			alsoPrefillReplaceLine = false,
		},
		keymaps = { -- normal mode (if not stated otherwise)
			abort = "q",
			confirmAndSubstituteInBuffer = "<CR>",
			insertModeConfirmAndSubstituteInBuffer = "<C-CR>",
			confirmAndSubstituteInCwd = "<S-CR>",
			prevSubstitutionInHistory = "<Up>",
			nextSubstitutionInHistory = "<Down>",
			toggleFixedStrings = "<C-f>", -- ripgrep's `--fixed-strings`
			toggleIgnoreCase = "<C-c>", -- ripgrep's `--ignore-case`
			openAtRegex101 = "R",
			showHelp = "?",
		},
		incrementalPreview = {
			matchHlGroup = "IncSearch",
			rangeBackdropBrightness = 50, ---@type number|false 0-100, false disables backdrop
		},
		regexOptions = {
			startWithFixedStrings = false,
			startWithIgnoreCase = false,
			pcre2 = true, -- enables lookarounds and backreferences, but slightly slower
			autoBraceSimpleCaptureGroups = true, -- disable if using named capture groups (see README)
		},
		editingBehavior = {
			-- typing `()` in the search line automatically adds `$n` to the replace line
			autoCaptureGroups = false,
		},
		history = {
			---@type string|false false to disable saving history, will only have sessional history
			path = vim.fn.stdpath("data") .. "/rip-substitute/history.json",
			maxSize = 30,
		},
		notification = {
			onSuccess = true,
			icon = "",
		},
		debug = false, -- extra notifications for debugging
	}
	setup_plugin("rip-substitute", rip_substitute_defaults)
end

local function setup_sad()
	-- TODO: install sad, delta, fzf, fd
	-- https://github.com/ray-x/sad.nvim
	-- Space Age seD in Neovim. A project-wide find and replace plugin for Neovim.
	local sad_defaults = {
		debug = false, -- print debug info
		diff = "delta", -- you can use `less`, `diff-so-fancy`
		ls_file = "fd", -- also git ls-files
		exact = false, -- exact match
		vsplit = false, -- split sad window the screen vertically, when set to number
		-- it is a threadhold when window is larger than the threshold sad will split vertically,
		height_ratio = 0.6, -- height ratio of sad window when split horizontally
		width_ratio = 0.6, -- height ratio of sad window when split vertically
	}
	setup_plugin("sad", sad_defaults)
end

local function setup_fzf_lua()
	setup_plugin("fzf-lua", function(fzf)
		fzf.setup({
			winopts = {
				height = 0.85,
				width = 0.85,
				preview = { layout = "vertical", vertical = "up:50%" },
			},
			keymap = {
				fzf = {
					["ctrl-q"] = "select-all+accept", -- send all to quickfix
				},
			},
		})

		-- Files
		map_explicit({
			mode = "n",
			sequence = "<leader>ff",
			action = fzf.files,
			desc = "Find files",
		})
		map_explicit({
			mode = "n",
			sequence = "<leader>fr",
			action = fzf.oldfiles,
			desc = "Recent files",
		})
		map_explicit({
			mode = "n",
			sequence = "<leader>fb",
			action = fzf.buffers,
			desc = "Buffers",
		})
		-- Search
		map_explicit({
			mode = "n",
			sequence = "<leader>fg",
			action = fzf.live_grep,
			desc = "Live grep",
		})
		map_explicit({
			mode = "n",
			sequence = "<leader>fw",
			action = fzf.grep_cword,
			desc = "Grep word under cursor",
		})
		map_explicit({
			mode = "v",
			sequence = "<leader>fw",
			action = fzf.grep_visual,
			desc = "Grep selection",
		})
		map_explicit({
			mode = "n",
			sequence = "<leader>f/",
			action = fzf.grep_curbuf,
			desc = "Grep current buffer",
		})
		-- LSP
		map_explicit({
			mode = "n",
			sequence = "<leader>fs",
			action = fzf.lsp_document_symbols,
			desc = "Document symbols",
		})
		map_explicit({
			mode = "n",
			"<leader>fS",
			action = fzf.lsp_workspace_symbols,
			desc = "Workspace symbols",
		})
		map_explicit({
			mode = "n",
			"<leader>fd",
			action = fzf.diagnostics_document,
			desc = "Buffer diagnostics",
		})
		map_explicit({
			mode = "n",
			"<leader>fD",
			action = fzf.diagnostics_workspace,
			desc = "Workspace diagnostics",
		})
		-- Misc
		map_explicit({
			mode = "n",
			"<leader>fh",
			action = fzf.help_tags,
			desc = "Help tags",
		})
		map_explicit({
			mode = "n",
			"<leader>fc",
			action = fzf.commands,
			desc = "Commands",
		})
		map_explicit({
			mode = "n",
			"<leader>fq",
			action = fzf.quickfix,
			desc = "Quickfix list",
		})
		map_explicit({
			mode = "n",
			"<leader>f.",
			action = fzf.resume,
			desc = "Resume last picker",
		})
	end)
end

local function setup_deck()
	-- NOTE: deck.nvim (hrsh7th) is a low-level async UI framework, not typically
	-- setup directly — it's a dependency other plugins build on. If you have a
	-- specific deck-based plugin, configure that instead. Bare minimum to load it:
	setup_plugin("deck", function(deck)
		require("deck.easy").setup()

		-- Set up buffer-specific key mappings for nvim-deck.
		vim.api.nvim_create_autocmd("User", {
			pattern = "DeckStart",
			callback = function(e)
				local ctx = e.data.ctx --[[@as deck.Context]]

				ctx.keymap("n", "<Leader>;", function()
					local history = deck.get_history()
					for i, context in ipairs(history) do
						if context.id == ctx.id then
							local next_idx = (i % #history) + 1
							history[next_idx].show()
						end
					end
				end)
				ctx.keymap("n", "<Tab>", deck.action_mapping("choose_action"))
				ctx.keymap("n", "<C-l>", deck.action_mapping("refresh"))
				ctx.keymap("n", "i", deck.action_mapping("prompt"))
				ctx.keymap("n", "a", deck.action_mapping("prompt"))
				ctx.keymap("n", "@", deck.action_mapping("toggle_select"))
				ctx.keymap("n", "*", deck.action_mapping("toggle_select_all"))
				ctx.keymap("n", "p", deck.action_mapping("toggle_preview_mode"))
				ctx.keymap("n", "d", deck.action_mapping("delete"))
				ctx.keymap("n", "<CR>", deck.action_mapping("default"))
				ctx.keymap("n", "o", deck.action_mapping("open"))
				ctx.keymap("n", "O", deck.action_mapping("open_keep"))
				ctx.keymap("n", "s", deck.action_mapping("open_split"))
				ctx.keymap("n", "v", deck.action_mapping("open_vsplit"))
				ctx.keymap("n", "N", deck.action_mapping("create"))
				ctx.keymap("n", "R", deck.action_mapping("rename"))
				ctx.keymap("n", "w", deck.action_mapping("write"))
				ctx.keymap("n", "<C-u>", deck.action_mapping("scroll_preview_up"))
				ctx.keymap("n", "<C-d>", deck.action_mapping("scroll_preview_down"))

				-- If you want to start the filter by default, call ctx.prompt() here
				ctx.prompt()
			end,
		})

		--key-mapping for explorer source (requires `require('deck.easy').setup()`).
		vim.api.nvim_create_autocmd("User", {
			pattern = "DeckStart:explorer",
			callback = function(e)
				local ctx = e.data.ctx --[[@as deck.Context]]
				ctx.keymap("n", "h", deck.action_mapping("explorer.collapse"))
				ctx.keymap("n", "l", deck.action_mapping("explorer.expand"))
				ctx.keymap("n", ".", deck.action_mapping("explorer.toggle_dotfiles"))
				ctx.keymap("n", "c", deck.action_mapping("explorer.clipboard.save_copy"))
				ctx.keymap("n", "m", deck.action_mapping("explorer.clipboard.save_move"))
				ctx.keymap("n", "p", deck.action_mapping("explorer.clipboard.paste"))
				ctx.keymap("n", "x", deck.action_mapping("explorer.clipboard.paste"))
				ctx.keymap("n", "<Leader>ff", deck.action_mapping("explorer.dirs"))
				ctx.keymap("n", "P", deck.action_mapping("toggle_preview_mode"))
				ctx.keymap("n", "~", function()
					ctx.do_action("explorer.get_api").set_cwd(vim.fs.normalize("~"))
				end)
				ctx.keymap("n", "\\", function()
					ctx.do_action("explorer.get_api").set_cwd(vim.fs.normalize("/"))
				end)
			end,
		})

		-- Example key bindings for launching nvim-deck sources. (These mapping required `deck.easy` calls.)
		map_explicit({
			mode = "n",
			sequence = "<Leader>ff",
			action = "<Cmd>Deck files<CR>",
			desc = "Show recent files, buffers, and more",
		})
		map_explicit({
			mode = "n",
			sequence = "<Leader>gr",
			action = "<Cmd>Deck grep<CR>",
			desc = "Start grep search",
		})
		map_explicit({
			mode = "n",
			sequence = "<Leader>gi",
			action = "<Cmd>Deck git<CR>",
			desc = "Open git launcher",
		})
		map_explicit({
			mode = "n",
			sequence = "<Leader>he",
			action = "<Cmd>Deck helpgrep<CR>",
			desc = "Live grep all help tags",
		})

		-- Show the latest deck context.
		map_explicit({
			mode = "n",
			sequence = "<Leader>;",
			action = function()
				local context = deck.get_history()[vim.v.count == 0 and 1 or vim.v.count]
				if context then
					context.show()
				end
			end,
		})

		-- Do default action on next item.
		map_explicit({
			mode = "n",
			sequence = "<Leader>n",
			action = function()
				local ctx = require("deck").get_history()[1]
				if ctx then
					ctx.set_cursor(ctx.get_cursor() + 1)
					ctx.do_action("default")
				end
			end,
		})
	end)
end

local function setup_snacks()
	setup_plugin("snacks", function(snacks)
		snacks.setup({
			bigfile = { enabled = true },
			notifier = { enabled = true, timeout = 3000 },
			quickfile = { enabled = true },
			statuscolumn = { enabled = true },
			words = { enabled = true }, -- highlight word under cursor
			indent = { enabled = true },
			dashboard = { enabled = false }, -- enable if you want a start screen
			scroll = { enabled = false }, -- smooth scroll, can conflict with other plugins
		})

		map_explicit({
			mode = "n",
			sequence = "<leader>n",
			action = snacks.notifier.show_history,
			desc = "Notification history",
		})
		map_explicit({
			mode = "n",
			sequence = "<leader>bd",
			action = snacks.bufdelete,
			desc = "Delete buffer",
		})
		map_explicit({
			mode = "n",
			sequence = "<leader>gB",
			action = snacks.gitbrowse,
			desc = "Git browse (open in browser)",
		})
		map_explicit({
			mode = "n",
			sequence = "<leader>gl",
			action = snacks.lazygit.log,
			desc = "Lazygit log",
		})
		map_explicit({
			mode = "n",
			sequence = "]]",
			action = function()
				snacks.words.jump(1)
			end,
			desc = "Next reference",
		})
		map_explicit({
			mode = "n",
			sequence = "[[",
			action = function()
				snacks.words.jump(-1)
			end,
			desc = "Prev reference",
		})
	end)
end

local function setup_hlslens()
	setup_plugin("hlslens", function(lens)
		lens.setup({ calm_down = true })

		-- Augment n/N/*/# with match count virtual text
		local shared_opts = { noremap = true, silent = true }
		map_explicit({
			mode = "n",
			sequence = "n",
			action = [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
			opts = shared_opts,
		})
		map_explicit({
			mode = "n",
			sequence = "N",
			action = [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
			opts = shared_opts,
		})
		map_explicit({
			mode = "n",
			sequence = "*",
			action = [[*<Cmd>lua require('hlslens').start()<CR>]],
			opts = shared_opts,
		})
		map_explicit({
			mode = "n",
			sequence = "#",
			action = [[#<Cmd>lua require('hlslens').start()<CR>]],
			opts = shared_opts,
		})
		map_explicit({
			mode = "n",
			sequence = "g*",
			action = [[g*<Cmd>lua require('hlslens').start()<CR>]],
			opts = shared_opts,
		})
		map_explicit({
			mode = "n",
			sequence = "g#",
			action = [[g#<Cmd>lua require('hlslens').start()<CR>]],
			opts = shared_opts,
		})
	end)
end

local function setup_nvim_hlsearch()
	-- nvim-hlsearch: auto-clears search highlight when cursor moves off a match
	setup_plugin("nvim-hlsearch", { auto_restore = true })
end

local function setup_grug_far()
	-- NOTE: grug-far and spectre are both find-and-replace — you probably only
	-- need one. grug-far is more actively maintained and ergonomic.
	setup_plugin("grug-far", function(grug)
		grug.setup({ headerMaxWidth = 80 })

		map_explicit({
			mode = "n",
			sequence = "<leader>sr",
			grug.open,
			opts = { desc = "Search and replace" },
		})
		map_explicit({
			mode = "n",
			sequence = "<leader>sw",
			action = function()
				grug.open({ prefills = { search = vim.fn.expand("<cword>") } })
			end,
			opts = { desc = "Search and replace word under cursor" },
		})
		map_explicit({
			mode = "v",
			sequence = "<leader>sr",
			action = function()
				grug.open({ prefills = { search = grug.get_visual_selection() } })
			end,
			opts = { desc = "Search and replace selection" },
		})
	end)
end

local function setup_spectre()
	-- https://github.com/nvim-pack/nvim-spectre
	-- search panel for neovim
	local spectre_defaults = {

		color_devicons = true,
		open_cmd = "vnew", -- can also be a lua function
		live_update = false, -- auto execute search again when you write to any file in vim
		lnum_for_results = true, -- show line number for search/replace results
		line_sep_start = "┌-----------------------------------------",
		result_padding = "¦  ",
		line_sep = "└-----------------------------------------",
		highlight = {
			ui = "String",
			search = "DiffChange",
			replace = "DiffDelete",
		},
		mapping = {
			["tab"] = {
				map = "<Tab>",
				cmd = "<cmd>lua require('spectre').tab()<cr>",
				desc = "next query",
			},
			["shift-tab"] = {
				map = "<S-Tab>",
				cmd = "<cmd>lua require('spectre').tab_shift()<cr>",
				desc = "previous query",
			},
			["toggle_line"] = {
				map = "dd",
				cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
				desc = "toggle item",
			},
			["enter_file"] = {
				map = "<cr>",
				cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
				desc = "open file",
			},
			["send_to_qf"] = {
				map = "<leader>q",
				cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
				desc = "send all items to quickfix",
			},
			["replace_cmd"] = {
				map = "<leader>c",
				cmd = "<cmd>lua require('spectre.actions').replace_cmd()<CR>",
				desc = "input replace command",
			},
			["show_option_menu"] = {
				map = "<leader>o",
				cmd = "<cmd>lua require('spectre').show_options()<CR>",
				desc = "show options",
			},
			["run_current_replace"] = {
				map = "<leader>rc",
				cmd = "<cmd>lua require('spectre.actions').run_current_replace()<CR>",
				desc = "replace current line",
			},
			["run_replace"] = {
				map = "<leader>R",
				cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
				desc = "replace all",
			},
			["change_view_mode"] = {
				map = "<leader>v",
				cmd = "<cmd>lua require('spectre').change_view()<CR>",
				desc = "change result view mode",
			},
			["change_replace_sed"] = {
				map = "trs",
				cmd = "<cmd>lua require('spectre').change_engine_replace('sed')<CR>",
				desc = "use sed to replace",
			},
			["change_replace_oxi"] = {
				map = "tro",
				cmd = "<cmd>lua require('spectre').change_engine_replace('oxi')<CR>",
				desc = "use oxi to replace",
			},
			["toggle_live_update"] = {
				map = "tu",
				cmd = "<cmd>lua require('spectre').toggle_live_update()<CR>",
				desc = "update when vim writes to file",
			},
			["toggle_ignore_case"] = {
				map = "ti",
				cmd = "<cmd>lua require('spectre').change_options('ignore-case')<CR>",
				desc = "toggle ignore case",
			},
			["toggle_ignore_hidden"] = {
				map = "th",
				cmd = "<cmd>lua require('spectre').change_options('hidden')<CR>",
				desc = "toggle search hidden",
			},
			["resume_last_search"] = {
				map = "<leader>l",
				cmd = "<cmd>lua require('spectre').resume_last_search()<CR>",
				desc = "repeat last search",
			},
			["select_template"] = {
				map = "<leader>rp",
				cmd = "<cmd>lua require('spectre.actions').select_template()<CR>",
				desc = "pick template",
			},
			["delete_line"] = {
				map = "<leader>rd",
				cmd = "<cmd>lua require('spectre.actions').run_delete_line()<CR>",
				desc = "delete line",
			},
			-- you can put your mapping here it only use normal mode
		},
		find_engine = {
			-- rg is map with finder_cmd
			["rg"] = {
				cmd = "rg",
				-- default args
				args = {
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
				},
				options = {
					["ignore-case"] = {
						value = "--ignore-case",
						icon = "[I]",
						desc = "ignore case",
					},
					["hidden"] = {
						value = "--hidden",
						desc = "hidden file",
						icon = "[H]",
					},
					-- you can put any rg search option you want here it can toggle with
					-- show_option function
				},
			},
			["ag"] = {
				cmd = "ag",
				args = {
					"--vimgrep",
					"-s",
				},
				options = {
					["ignore-case"] = {
						value = "-i",
						icon = "[I]",
						desc = "ignore case",
					},
					["hidden"] = {
						value = "--hidden",
						desc = "hidden file",
						icon = "[H]",
					},
				},
			},
		},
		replace_engine = {
			["sed"] = {
				cmd = "sed",
				args = nil,
				options = {
					["ignore-case"] = {
						value = "--ignore-case",
						icon = "[I]",
						desc = "ignore case",
					},
				},
			},
			-- call rust code by nvim-oxi to replace
			["oxi"] = {
				cmd = "oxi",
				args = {},
				options = {
					["ignore-case"] = {
						value = "i",
						icon = "[I]",
						desc = "ignore case",
					},
				},
			},
			["sd"] = {
				cmd = "sd",
				options = {},
			},
		},
		default = {
			find = {
				--pick one of item in find_engine
				cmd = "rg",
				options = { "ignore-case" },
			},
			replace = {
				--pick one of item in replace_engine
				cmd = "sed",
			},
		},
		replace_vim_cmd = "cdo",
		use_trouble_qf = false, -- use trouble.nvim as quickfix list
		is_open_target_win = true, --open file on opener window
		is_insert_mode = false, -- start open panel on is_insert_mode
		is_block_ui_break = false, -- mapping backspace and enter key to avoid ui break
		open_template = {
			-- an template to use on open function
			-- see the 'custom function' section below to learn how to configure the template
			-- { search_text = 'text1', replace_text = '', path = "" }
		},
	}
	setup_plugin("spectre", function(spectre)
		spectre.setup({ live_update = true })

		map_explicit({
			mode = "n",
			sequence = "<leader>sR",
			action = function()
				spectre.toggle()
			end,
			desc = "Spectre toggle",
		})
		map_explicit({
			mode = "n",
			sequence = "<leader>sW",
			action = function()
				spectre.open_visual({ select_word = true })
			end,
			desc = "Spectre word under cursor",
		})
		map_explicit({
			mode = "v",
			sequence = "<leader>sR",
			action = function()
				spectre.open_visual()
			end,
			desc = "Spectre selection",
		})
		map_explicit({
			mode = "n",
			sequence = "<leader>sf",
			action = function()
				spectre.open_file_search()
			end,
			desc = "Spectre current file",
		})
	end)
end

local function setup_pickme()
	-- TODO: make lazy
	setup_plugin("pickme", function(pickme)
		-- Include at least one of these pickers:
		-- utils.packadd("snacks") -- For snacks.picker
		-- utils.packadd("telescope") -- For telescope
		-- utils.packadd("fzf-lua") -- For fzf-lua
		pickme.setup({
			picker_provider = "snacks", -- Default provider
		})
	end)

	-- TODO: make lazy (remove above?)
	vim.api.nvim_create_user_command("PickMe", function()
		setup_plugin("pickme", function(pickme)
			-- Include at least one of these pickers:
			-- utils.packadd("snacks") -- For snacks.picker
			-- utils.packadd("telescope") -- For telescope
			-- utils.packadd("fzf-lua") -- For fzf-lua
			pickme.setup({
				picker_provider = "snacks", -- Default provider
			})
		end)
	end, {
		nargs = "*",
		-- complete = function()
		-- 	return {}
		-- end,
	})

	vim.api.nvim_create_user_command("PickMe", function()
		setup_plugin("pickme", function(pickme)
			-- Include at least one of these pickers:
			-- utils.packadd("snacks") -- For snacks.picker
			-- utils.packadd("telescope") -- For telescope
			-- utils.packadd("fzf-lua") -- For fzf-lua
			pickme.setup({
				picker_provider = "snacks", -- Default provider
			})
		end)
	end, {
		nargs = "*",
		-- complete = function()
		-- 	return {}
		-- end,
	})
end

local function setup_renamer()
	-- https://github.com/filipdutescu/renamer.nvim
	-- VS Code-like renaming UI for Neovim, writen in Lua
	setup_plugin("renamer", function(renamer)
		local mappings_utils = require("renamer.mappings.utils")
		local renamer_defaults = {
			-- The popup title, shown if `border` is true
			title = "Rename",
			-- The padding around the popup content
			padding = {
				top = 0,
				left = 0,
				bottom = 0,
				right = 0,
			},
			-- The minimum width of the popup
			min_width = 15,
			-- The maximum width of the popup
			max_width = 45,
			-- Whether or not to shown a border around the popup
			border = true,
			-- The characters which make up the border
			border_chars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
			-- Whether or not to highlight the current word references through LSP
			show_refs = true,
			-- Whether or not to add resulting changes to the quickfix list
			with_qf_list = true,
			-- Whether or not to enter the new name through the UI or Neovim's `input`
			-- prompt
			with_popup = true,
			-- The keymaps available while in the `renamer` buffer. The example below
			-- overrides the default values, but you can add others as well.
			mappings = {
				["<c-i>"] = mappings_utils.set_cursor_to_start,
				["<c-a>"] = mappings_utils.set_cursor_to_end,
				["<c-e>"] = mappings_utils.set_cursor_to_word_end,
				["<c-b>"] = mappings_utils.set_cursor_to_word_start,
				["<c-c>"] = mappings_utils.clear_line,
				["<c-u>"] = mappings_utils.undo,
				["<c-r>"] = mappings_utils.redo,
			},
			-- Custom handler to be run after successfully renaming the word. Receives
			-- the LSP 'textDocument/rename' raw response as its parameter.
			handler = nil,
		}
		renamer.setup(renamer_defaults)
	end)
end

local function setup_search_replace()
	-- https://github.com/roobert/search-replace.nvim
	-- A Neovim search and replace plugin that builds on the native search and replace experience
	local search_replace_defaults = {
		-- optionally override defaults
		default_replace_single_buffer_options = "gcI",
		default_replace_multi_buffer_options = "egcI",
	}
	setup_plugin("search-replace", function(search_replace)
		search_replace.setup(search_replace_defaults)
		local shared_opts = {}
		map_explicit({
			mode = "v",
			sequence = "<C-r>",
			action = "<CMD>SearchReplaceSingleBufferVisualSelection<CR>",
			opts = shared_opts,
		})
		map_explicit({
			mode = "v",
			sequence = "<C-s>",
			action = "<CMD>SearchReplaceWithinVisualSelection<CR>",
			opts = shared_opts,
		})
		map_explicit({
			mode = "v",
			sequence = "<C-b>",
			action = "<CMD>SearchReplaceWithinVisualSelectionCWord<CR>",
			opts = shared_opts,
		})

		map_explicit({
			mode = "n",
			sequence = "<leader>rs",
			action = "<CMD>SearchReplaceSingleBufferSelections<CR>",
			opts = shared_opts,
		})
		map_explicit({
			mode = "n",
			sequence = "<leader>ro",
			action = "<CMD>SearchReplaceSingleBufferOpen<CR>",
			opts = shared_opts,
		})
		map_explicit({
			mode = "n",
			sequence = "<leader>rw",
			action = "<CMD>SearchReplaceSingleBufferCWord<CR>",
			opts = shared_opts,
		})
		map_explicit({
			mode = "n",
			sequence = "<leader>rW",
			action = "<CMD>SearchReplaceSingleBufferCWORD<CR>",
			opts = shared_opts,
		})
		map_explicit({
			mode = "n",
			sequence = "<leader>re",
			action = "<CMD>SearchReplaceSingleBufferCExpr<CR>",
			opts = shared_opts,
		})
		map_explicit({
			mode = "n",
			sequence = "<leader>rf",
			action = "<CMD>SearchReplaceSingleBufferCFile<CR>",
			opts = shared_opts,
		})

		map_explicit({
			mode = "n",
			sequence = "<leader>rbs",
			action = "<CMD>SearchReplaceMultiBufferSelections<CR>",
			opts = shared_opts,
		})
		map_explicit({
			mode = "n",
			sequence = "<leader>rbo",
			action = "<CMD>SearchReplaceMultiBufferOpen<CR>",
			opts = shared_opts,
		})
		map_explicit({
			mode = "n",
			sequence = "<leader>rbw",
			action = "<CMD>SearchReplaceMultiBufferCWord<CR>",
			opts = shared_opts,
		})
		map_explicit({
			mode = "n",
			sequence = "<leader>rbW",
			action = "<CMD>SearchReplaceMultiBufferCWORD<CR>",
			opts = shared_opts,
		})
		map_explicit({
			mode = "n",
			sequence = "<leader>rbe",
			action = "<CMD>SearchReplaceMultiBufferCExpr<CR>",
			opts = shared_opts,
		})
		map_explicit({
			mode = "n",
			sequence = "<leader>rbf",
			action = "<CMD>SearchReplaceMultiBufferCFile<CR>",
			opts = shared_opts,
		})

		-- show the effects of a search / replace in a live preview window
		vim.o.inccommand = "split"
	end)
end

local function setup_rgflow()
	-- https://github.com/mangelozzi/rgflow.nvim
	-- The more you use this plugin, the better you become at using RipGrep from the CLI.
	--     Not simply a wrapper which could be replaced by a few lines of config.
	local rgflow_defaults = {
		-- Set the default rip grep flags and options for when running a search via
		-- RgFlow. Once changed via the UI, the previous search flags are used for
		-- each subsequent search (until Neovim restarts).
		cmd_flags = "--smart-case --fixed-strings --ignore --max-columns 200",

		-- Mappings to trigger RgFlow functions
		default_trigger_mappings = true,
		-- These mappings are only active when the RgFlow UI (panel) is open
		default_ui_mappings = true,
		-- QuickFix window only mapping
		default_quickfix_mappings = true,
	}
	setup_plugin("rgflow-nvim", rgflow_defaults)
end

local function setup_ssr()
	-- https://github.com/cshuaimin/ssr.nvim
	-- Treesitter based structural search and replace plugin for Neovim
	local ssr_defaults = {
		border = "rounded",
		min_width = 50,
		min_height = 5,
		max_width = 120,
		max_height = 25,
		adjust_window = true,
		keymaps = {
			close = "q",
			next_match = "n",
			prev_match = "N",
			replace_confirm = "<cr>",
			replace_all = "<leader><cr>",
		},
	}
	setup_plugin("ssr", ssr_defaults)
end

local function setup_substitute()
	-- https://github.com/gbprod/substitute.nvim
	-- Neovim plugin introducing a new operators motions to quickly replace and exchange text
	local substitute_defaults = {
		on_substitute = nil,
		yank_substituted_text = false,
		preserve_cursor_position = false,
		modifiers = nil,
		highlight_substituted_text = {
			enabled = true,
			timer = 500,
		},
		range = {
			prefix = "s",
			prompt_current_text = false,
			confirm = false,
			complete_word = false,
			subject = nil,
			range = nil,
			suffix = "",
			auto_apply = false,
			cursor_position = "end",
		},
		exchange = {
			motion = false,
			use_esc_to_cancel = true,
			preserve_cursor_position = false,
		},
	}
	setup_plugin("substitute", function(substitute)
		substitute.setup(substitute_defaults)
		map_explicit({
			mode = "n",
			sequence = "s",
			action = substitute.operator,
			opts = { noremap = true },
		})
		map_explicit({
			mode = "n",
			sequence = "ss",
			action = substitute.line,
			opts = { noremap = true },
		})
		map_explicit({
			mode = "n",
			sequence = "S",
			action = substitute.eol,
			opts = { noremap = true },
		})
		map_explicit({
			mode = "x",
			sequence = "s",
			action = substitute.visual,
			opts = { noremap = true },
		})
	end)
end

local function setup_actions_preview()
	-- https://github.com/aznhe21/actions-preview.nvim
	-- Fully customizable previewer for LSP code actions
	local actions_preview_defaults = {
		-- options for vim.diff(): https://neovim.io/doc/user/lua.html#vim.diff()
		diff = {
			ctxlen = 3,
		},

		-- priority list of external command to highlight diff
		-- disabled by defalt, must be set by yourself
		highlight_command = {
			-- require("actions-preview.highlight").delta(),
			-- require("actions-preview.highlight").diff_so_fancy(),
			-- require("actions-preview.highlight").diff_highlight(),
		},

		-- priority list of preferred backend
		backend = { "telescope", "minipick", "snacks", "nui" },

		-- options related to telescope.nvim
		telescope = vim.tbl_extend(
			"force",
			-- telescope theme: https://github.com/nvim-telescope/telescope.nvim#themes
			require("telescope.themes").get_dropdown(),
			-- a table for customizing content
			{
				-- a function to make a table containing the values to be displayed.
				-- fun(action: Action): { title: string, client_name: string|nil }
				make_value = nil,

				-- a function to make a function to be used in `display` of a entry.
				-- see also `:h telescope.make_entry` and `:h telescope.pickers.entry_display`.
				-- fun(values: { index: integer, action: Action, title: string, client_name: string }[]): function
				make_make_display = nil,
			}
		),

		-- options for nui.nvim components
		nui = {
			-- component direction. "col" or "row"
			dir = "col",
			-- keymap for selection component: https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/menu#keymap
			keymap = nil,
			-- options for nui Layout component: https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/layout
			layout = {
				position = "50%",
				size = {
					width = "60%",
					height = "90%",
				},
				min_width = 40,
				min_height = 10,
				relative = "editor",
			},
			-- options for preview area: https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/popup
			preview = {
				size = "60%",
				border = {
					style = "rounded",
					padding = { 0, 1 },
				},
			},
			-- options for selection area: https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/menu
			select = {
				size = "40%",
				border = {
					style = "rounded",
					padding = { 0, 1 },
				},
			},
		},

		--- options for snacks picker
		---@type snacks.picker.Config
		snacks = {
			layout = { preset = "default" },
		},
	}
	setup_plugin("actions-preview", actions_preview_defaults)
end

local function setup_spider()
	-- TODO: custom movement patterns: https://github.com/chrisgrieser/nvim-spider#advanced-custom-movement-patterns
	-- https://github.com/chrisgrieser/nvim-spider
	-- Use the w, e, b motions like a spider. Move by subwords and skip insignificant punctuation.
	local spider_defaults = {
		skipInsignificantPunctuation = true,
		subwordMovement = true,
		consistentOperatorPending = false, -- see the README for details
		customPatterns = {}, -- see the README for details
	}
	setup_plugin("spider", function(spider)
		spider.setup(spider_defaults)
		local nox = { "n", "o", "x" }

		map_explicit({ mode = nox, sequence = "w", action = "<cmd>lua require('spider').motion('w')<CR>" })
		map_explicit({ mode = nox, sequence = "e", action = "<cmd>lua require('spider').motion('e')<CR>" })
		map_explicit({ mode = nox, sequence = "b", action = "<cmd>lua require('spider').motion('b')<CR>" })
		map_explicit({ mode = nox, sequence = "ge", action = "<cmd>lua require('spider').motion('ge')<CR>" })
	end)
end

local function setup_improved_search_nvim()
	-- PROBABLY NOT, BUT WORTH A TRY
	-- https://github.com/backdround/improved-search.nvim
	--[[
	provides:

	- stable jump to next / previous search pattern (regardless of the last search direction)
	- search the word under the cursor without moving (like * or #)
	- search operator:
	- search text selected in visual mode (visual selection + operator)
	- search text provided by a motion (operator + motion)
	- it all works for a multiline search.
	--]]
	local improved_search_nvim_defaults = nil
	setup_plugin("improved-search-nvim", function(search)
		map_explicit({
			mode = { "n", "x", "o" },
			sequence = "n",
			action = search.stable_next,
		})
		map_explicit({
			mode = { "n", "x", "o" },
			sequence = "N",
			action = search.stable_previous,
		})

		-- Search current word without moving.
		map_explicit({
			mode = "n",
			sequence = "!",
			action = search.current_word,
		})

		-- Search selected text in visual mode
		map_explicit({
			mode = "x",
			sequence = "!",
			search.in_place,
		}) -- search selection without moving
		map_explicit({
			mode = "x",
			sequence = "*",
			search.forward,
		}) -- search selection forward
		map_explicit({
			mode = "x",
			sequence = "#",
			search.backward,
		}) -- search selection backward

		-- Search by motion in place
		map_explicit({
			mode = "n",
			sequence = "|",
			action = search.in_place,
		})
		-- You can also use search.forward / search.backward for motion selection.
	end)
end

local function setup_nvim_rg()
	-- PROBABLY NOT, BUT WORTH A TRY https://github.com/duane9/nvim-rg
	-- https://github.com/duane9/nvim-rg
	-- Run ripgrep from Neovim asynchronously.
	local nvim_rg_defaults = nil
	utils.packadd("nvim-rg", function()
		vim.g.rg_command = "rg --vimgrep"

		-- to turn off the default mappings:
		-- vim.g.rg_map_keys = 0
	end)
end

local function setup_hlsearch_nvim()
	-- PROBABLY NOT, BUT WORTH A TRY
	-- https://github.com/nvimdev/hlsearch.nvim
	-- auto remove search highlight and rehighlight when using n or N
	local hlsearch_nvim_defaults = nil
	setup_plugin("hlsearch-nvim", hlsearch_nvim_defaults)
end

local function setup_nvim_monorepos()
	-- https://github.com/sajjathossain/nvim-monorepos
	-- simple telescope file finder for monorepos
	local nvim_monorepos_config = {
		files = { "package.json", "Cargo.toml", "go.mod", "pyproject.toml" },
		ignore = { ".git", "node_modules", "target", "build" },
	}
	setup_plugin("nvim-monorepos", nvim_monorepos_config)
end

local function setup_blink()
	local blink_defaults = {
		-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
		-- 'super-tab' for mappings similar to vscode (tab to accept)
		-- 'enter' for enter to accept
		-- 'none' for no mappings
		--
		-- All presets have the following mappings:
		-- C-space: Open menu or open docs if already open
		-- C-n/C-p or Up/Down: Select next/previous item
		-- C-e: Hide menu
		-- C-k: Toggle signature help (if signature.enabled = true)
		--
		-- See :h blink-cmp-config-keymap for defining your own keymap
		keymap = { preset = "default" },

		appearance = {
			-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- Adjusts spacing to ensure icons are aligned
			nerd_font_variant = "mono",
		},

		-- (Default) Only show the documentation popup when manually triggered
		completion = { documentation = { auto_show = false } },

		-- Default list of enabled providers defined so that you can extend it
		-- elsewhere in your config, without redefining it, due to `opts_extend`
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},

		-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
		-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
		-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
		--
		-- See the fuzzy documentation for more information
		fuzzy = { implementation = "prefer_rust_with_warning" },
	}
	setup_plugin("blink", blink_defaults)
end

local functions = {
	["regex-vars"] = setup_regex_vars,
	["inc_rename"] = setup_inc_rename,
	["muren"] = setup_muren,
	["rip-substitute"] = setup_rip_substitute,
	["sad"] = setup_sad,
	["fzf-lua"] = setup_fzf_lua,
	["deck"] = setup_deck,
	["snacks"] = setup_snacks,
	["hlslens"] = setup_hlslens,
	["nvim-hlsearch"] = setup_nvim_hlsearch,
	["grug-far"] = setup_grug_far,
	["spectre"] = setup_spectre,
	["pickme"] = setup_pickme,
	["renamer"] = setup_renamer,
	["search-replace"] = setup_search_replace,
	["rgflow"] = setup_rgflow,
	["ssr"] = setup_ssr,
	["substitute"] = setup_substitute,
	["actions-preview"] = setup_actions_preview,
	["spider"] = setup_spider,
	["improved-search-nvim"] = setup_improved_search_nvim,
	["nvim-rg"] = setup_nvim_rg,
	["hlsearch-nvim"] = setup_hlsearch_nvim,
	["nvim-monorepos"] = setup_nvim_monorepos,
	["blink"] = setup_blink,
}
local function maybe_call(element_name)
	local include = elements[element_name]
	if include then
		-- print("Calling '" .. element_name .. "'")
		local func = functions[element_name]
		func()
	end
end

maybe_call("regex-vars")
maybe_call("inc_rename")
maybe_call("muren")
maybe_call("rip-substitute")
maybe_call("sad")
maybe_call("fzf-lua")
maybe_call("deck")
maybe_call("snacks")
maybe_call("hlslens")
maybe_call("nvim-hlsearch")
maybe_call("grug-far")
maybe_call("spectre")
maybe_call("pickme")
maybe_call("renamer")
maybe_call("search-replace")
maybe_call("rgflow")
maybe_call("ssr")
maybe_call("substitute")
maybe_call("actions-preview")
maybe_call("spider")
maybe_call("improved-search-nvim")
maybe_call("nvim-rg")
maybe_call("hlsearch-nvim")
maybe_call("nvim-monorepos")
maybe_call("blink")

local function setup_conjure()
	-- https://github.com/Olical/conjure Interactive evaluation for Neovim (Clojure, Fennel, Scheme, Python, JavaScript, PHP, R, Lua, Rust and more!)
	vim.g["conjure#mapping#doc_word"] = true -- Disable the documentation mapping
	vim.g["conjure#mapping#doc_word"] = { "gk" } -- Reset it to the default unprefixed K (note the special table wrapped syntax)
	vim.cmd.packadd("conjure")
end

local function setup_sniprun()
	-- https://github.com/michaelb/sniprun
	-- https://michaelb.github.io/sniprun/index.html
	-- A neovim plugin to run lines/blocs of code (independently of the rest of the file), supporting multiples languages
	local sniprun_defaults = {
		selected_interpreters = {}, --# use those instead of the default for the current filetype
		repl_enable = {}, --# enable REPL-like behavior for the given interpreters
		repl_disable = {}, --# disable REPL-like behavior for the given interpreters

		interpreter_options = { --# interpreter-specific options, see doc / :SnipInfo <name>

			--# use the interpreter name as key
			GFM_original = {
				use_on_filetypes = { "markdown.pandoc" }, --# the 'use_on_filetypes' configuration key is
				--# available for every interpreter
			},
			Python3_original = {
				error_truncate = "auto", --# Truncate runtime errors 'long', 'short' or 'auto'
				--# the hint is available for every interpreter
				--# but may not be always respected
			},
		},

		--# you can combo different display modes as desired and with the 'Ok' or 'Err' suffix
		--# to filter only sucessful runs (or errored-out runs respectively)
		display = {
			"Classic", --# display results in the command-line  area
			"VirtualTextOk", --# display ok results as virtual text (multiline is shortened)

			-- "VirtualText",             --# display results as virtual text
			-- "VirtualLine",             --# display results as virtual lines
			-- "TempFloatingWindow",      --# display results in a floating window
			-- "LongTempFloatingWindow",  --# same as above, but only long results. To use with VirtualText[Ok/Err]
			-- "Terminal",                --# display results in a vertical split
			-- "TerminalWithCode",        --# display results and code history in a vertical split
			-- "NvimNotify",              --# display with the nvim-notify plugin
			-- "Api"                      --# return output to a programming interface
		},

		live_display = { "VirtualTextOk" }, --# display mode used in live_mode

		display_options = {
			terminal_scrollback = vim.o.scrollback, --# change terminal display scrollback lines
			terminal_line_number = false, --# whether show line number in terminal window
			terminal_signcolumn = false, --# whether show signcolumn in terminal window
			terminal_position = "vertical", --# or "horizontal", to open as horizontal split instead of vertical split
			terminal_width = 45, --# change the terminal display option width (if vertical)
			terminal_height = 20, --# change the terminal display option height (if horizontal)
			notification_timeout = 5, --# timeout for nvim_notify output
			max_fw_width = 80, --# max width for floating windows, longer lines will wrap
		},

		--# You can use the same keys to customize whether a sniprun producing
		--# no output should display nothing or '(no output)'
		show_no_output = {
			"Classic",
			"TempFloatingWindow", --# implies LongTempFloatingWindow, which has no effect on its own
		},

		cwd = ".", --# set the working directory for build/run processes. By default or if set to '.',
		--# is neovim's current working directory. Can be overwritten by interpreter-options

		--# customize highlight groups (setting this overrides colorscheme)
		--# any parameters of nvim_set_hl() can be passed as-is
		snipruncolors = {
			SniprunVirtualTextOk = { bg = "#66eeff", fg = "#000000", ctermbg = "Cyan", ctermfg = "Black" },
			SniprunFloatingWinOk = { fg = "#66eeff", ctermfg = "Cyan" },
			SniprunVirtualTextErr = { bg = "#881515", fg = "#000000", ctermbg = "DarkRed", ctermfg = "Black" },
			SniprunFloatingWinErr = { fg = "#881515", ctermfg = "DarkRed", bold = true },
		},

		live_mode_toggle = "off", --# live mode toggle, see Usage - Running for more info

		--# miscellaneous compatibility/adjustement settings
		ansi_escape = true, --# Remove ANSI escapes (usually color) from outputs
		inline_messages = false, --# boolean toggle for a one-line way to display output
		--# to workaround sniprun not being able to display anything

		borders = "single", --# display borders around floating windows
		--# possible values are 'none', 'single', 'double', or 'shadow'
	}
	setup_plugin("sniprun", sniprun_defaults)
end

local function setup_live_command()
	-- https://github.com/smjonas/live-command.nvim
	-- Easily create previewable commands in Neovim.
	local live_command_defaults = {
		enable_highlighting = true,
		inline_highlighting = true,
		hl_groups = {
			insertion = "DiffAdd",
			deletion = "DiffDelete",
			change = "DiffChange",
		},
	}
	setup_plugin("live-command", live_command_defaults)
end

local function setup_channelot()
	-- https://github.com/idanarye/nvim-channelot
	-- Operate Neovim jobs from Lua coroutines
	setup_plugin("channelot", function(_) end)
end

local function setup_vim_slime()
	-- https://github.com/jpalardy/vim-slime
	-- type text in a file, send it to a live REPL, and avoid having to reload all your code every time you make a change
	utils.packadd("vim-slime")
end

local function setup_jaq()
	-- TODO: look at using https://github.com/totochi-2022/jaq-nvim/commits/master/
	-- https://github.com/is0n/jaq-nvim
	-- Just Another Quickrun Plugin for Neovim in Lua
	-- TODO: JSON file
	--[[
	{
	"internal": {
		"lua": "luafile %",
		"vim": "source %"
	},

	"external": {
		"markdown": "glow %",
		"python": "python3 %",
		"go": "go run %",
		"sh": "sh %"
	}
	}
	--]]
	local jaq_example_config = {
		cmds = {
			-- Uses vim commands
			internal = {
				lua = "luafile %",
				vim = "source %",
			},

			-- Uses shell commands
			external = {
				markdown = "glow %",
				python = "python3 %",
				go = "go run %",
				sh = "sh %",
			},
		},

		behavior = {
			-- Default type
			default = "float",

			-- Start in insert mode
			startinsert = false,

			-- Use `wincmd p` on startup
			wincmd = false,

			-- Auto-save files
			autosave = false,
		},

		ui = {
			float = {
				-- See ':h nvim_open_win'
				border = "none",

				-- See ':h winhl'
				winhl = "Normal",
				borderhl = "FloatBorder",

				-- See ':h winblend'
				winblend = 0,

				-- Num from `0-1` for measurements
				height = 0.8,
				width = 0.8,
				x = 0.5,
				y = 0.5,
			},

			terminal = {
				-- Window position
				position = "bot",

				-- Window size
				size = 10,

				-- Disable line numbers
				line_no = false,
			},

			quickfix = {
				-- Window position
				position = "bot",

				-- Window size
				size = 10,
			},
		},
	}
	setup_plugin("jaq-nvim", jaq_example_config)
end

local function setup_iron()
	-- https://github.com/Vigemus/iron.nvim
	-- Interactive Repl Over Neovim
	setup_plugin("iron-nvim", function(iron)
		local view = require("iron.view")
		local common = require("iron.fts.common")

		iron.setup({
			config = {
				-- Whether a repl should be discarded or not
				scratch_repl = true,
				-- Your repl definitions come here
				repl_definition = {
					sh = {
						-- Can be a table or a function that
						-- returns a table (see below)
						command = { "bash" },
					},
					python = {
						command = { "python3" }, -- or { "ipython", "--no-autoindent" }
						format = common.bracketed_paste_python,
						block_dividers = { "# %%", "#%%" },
						env = { PYTHON_BASIC_REPL = "1" }, --this is needed for python3.13 and up.
					},
					haskell = {
						command = function(meta)
							local filename = vim.api.nvim_buf_get_name(meta.current_bufnr)
							return { "cabal", "v2-repl", filename }
						end,
					},
				},
				-- set the file type of the newly created repl to ft
				-- bufnr is the buffer id of the REPL and ft is the filetype of the
				-- language being used for the REPL.
				repl_filetype = function(bufnr, ft)
					return ft
					-- or return a string name such as the following
					-- return "iron"
				end,
				-- Send selections to the DAP repl if an nvim-dap session is running.
				dap_integration = true,
				-- How the repl window will be displayed
				-- See below for more information
				repl_open_cmd = view.bottom(40),

				-- repl_open_cmd can also be an array-style table so that multiple
				-- repl_open_commands can be given.
				-- When repl_open_cmd is given as a table, the first command given will
				-- be the command that `IronRepl` initially toggles.
				-- Moreover, when repl_open_cmd is a table, each key will automatically
				-- be available as a keymap (see `keymaps` below) with the names
				-- toggle_repl_with_cmd_1, ..., toggle_repl_with_cmd_k
				-- For example,
				--
				-- repl_open_cmd = {
				--   view.split.vertical.rightbelow("%40"), -- cmd_1: open a repl to the right
				--   view.split.rightbelow("%25")  -- cmd_2: open a repl below
				-- }
			},
			-- Iron doesn't set keymaps by default anymore.
			-- You can set them here or manually add keymaps to the functions in iron.core
			keymaps = {
				toggle_repl = "<space>rr", -- toggles the repl open and closed.
				-- If repl_open_command is a table as above, then the following keymaps are
				-- available
				-- toggle_repl_with_cmd_1 = "<space>rv",
				-- toggle_repl_with_cmd_2 = "<space>rh",
				restart_repl = "<space>rR", -- calls `IronRestart` to restart the repl
				send_motion = "<space>sc",
				visual_send = "<space>sc",
				send_file = "<space>sf",
				send_line = "<space>sl",
				send_paragraph = "<space>sp",
				send_until_cursor = "<space>su",
				send_mark = "<space>sm",
				send_code_block = "<space>sb",
				send_code_block_and_move = "<space>sn",
				mark_motion = "<space>mc",
				mark_visual = "<space>mc",
				remove_mark = "<space>md",
				cr = "<space>s<cr>",
				interrupt = "<space>s<space>",
				exit = "<space>sq",
				clear = "<space>cl",
			},
			-- If the highlight is on, you can change how it looks
			-- For the available options, check nvim_set_hl
			highlight = {
				italic = true,
			},
			ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
		})

		-- iron also has a list of commands, see :h iron-commands for all available commands
		map_explicit({
			mode = "n",
			sequence = "<space>rf",
			action = "<cmd>IronFocus<cr>",
		})
		map_explicit({
			mode = "n",
			sequence = "<space>rh",
			action = "<cmd>IronHide<cr>",
		})
	end)
end

local function setup_resin()
	-- https://github.com/fdschmidt93/resin.nvim
	-- repl plugin for neovim built on textobjects
	local resin_defaults = {
		filetype = {
			python = {
				-- A receiver is set up for each sender
				setup_receiver = function()
					local bufnr = vim.tbl_filter(function(b)
						return vim.bo[b].buftype == "terminal"
					end, vim.api.nvim_list_bufs())
					if #bufnr > 1 then
						print("Too many terminals open")
						return
					end
					if bufnr then
						bufnr = bufnr[1]
						return require("resin.receiver.neovim_terminal")({
							bufnr = bufnr,
						})
					end
				end,
			},
		},
	}
	setup_plugin("resin", resin_defaults)
end

--─────────────────────────────────────────────────────────────────────────────
--──── to vendor ──────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

local function setup_officer()
	-- https://github.com/pianocomposer321/officer.nvim
	-- Like dispatch.vim but using overseer.nvim:
	--     allows you to run programs asynchronously either using :h makeprg or using an arbitrary command
	local officer_defaults = {} -- TODO: reverse engineer config
	setup_plugin("officer", officer_defaults)
end

local function setup_compiler()
	-- https://github.com/Zeioth/compiler.nvim
	-- Neovim compiler for building and running your code without having to configure anything
	local compiler_defaults = {} -- TODO: figure out how per-language config works, maybe reverse-engineer
	setup_plugin("compiler", function(compiler_defaults) end)
end

local function setup_jupytext()
	-- SORT
	-- https://github.com/GCBallesteros/jupytext.nvim
	-- Jupyter notebooks on neovim powered by Jupytext
	local jupytext_defaults = {
		style = "hydrogen",
		output_extension = "auto", -- Default extension. Don't change unless you know what you are doing
		force_ft = nil, -- Default filetype. Don't change unless you know what you are doing
		custom_language_formatting = {},
	}
	setup_plugin("jupytext", jupytext_defaults)
end

local function setup_quarto()
	-- https://github.com/quarto-dev/quarto-nvim
	-- https://quarto.org/docs/tools/neovim.html
	-- Quarto mode for Neovim
	local quarto_defaults = {
		debug = false,
		closePreviewOnExit = true,
		lspFeatures = {
			enabled = true,
			chunks = "curly",
			languages = { "r", "python", "julia", "bash", "html" },
			diagnostics = {
				enabled = true,
				triggers = { "BufWritePost" },
			},
			completion = {
				enabled = true,
			},
		},
		codeRunner = {
			enabled = true,
			default_method = "slime", -- "molten", "slime", "iron" or <function>
			ft_runners = {}, -- filetype to runner, ie. `{ python = "molten" }`.
			-- Takes precedence over `default_method`
			never_run = { "yaml" }, -- filetypes which are never sent to a code runner
		},
	}

	setup_plugin("quarto", quarto_defaults)
end

local function setup_asyncrun()
	-- TODO: install as lua module (?)
	-- https://github.com/skywind3000/asyncrun.vim
	-- Run Async Shell Commands in Vim 8.0 / NeoVim and Output to the Quickfix Window !!
	utils.packadd("asyncrun")
end

--─────────────────────────────────────────────────────────────────────────────
--──── CALL SETUPS ────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

setup_conjure()
setup_sniprun()
setup_live_command()
setup_channelot()
setup_vim_slime()
setup_jaq()
setup_iron()
setup_resin()
setup_officer()
setup_compiler()
setup_jupytext()
setup_quarto()
setup_asyncrun()

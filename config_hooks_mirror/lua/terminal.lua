--─────────────────────────────────────────────────────────────────────────────
--──── general mappings ───────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

local function create_keymaps()
	map_explicit({
		mode = "t",
		sequence = "<Esc>",
		action = [[<C-\><C-n>]],
		desc = "Exit terminal mode",
	})
	map_explicit({
		mode = "t",
		sequence = "kj",
		action = [[<C-\><C-n>]],
		desc = "Exit terminal mode",
	})
	map_explicit({
		mode = "t",
		sequence = "<C-o>",
		action = [[<C-\><C-o>]],
		desc = "Temporary normal mode",
	})
end

--─────────────────────────────────────────────────────────────────────────────
--──── terminal plugins ───────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

local function setup_vim_floaterm()
	-- https://github.com/voldikss/vim-floaterm
	-- Terminal manager for (neo)vim
	utils.packadd("vim-floaterm", function()
		vim.g.floaterm_width = 0.8
		vim.g.floaterm_height = 0.8

		map_explicit({
			mode = "n",
			sequence = "<leader>ft",
			action = "<Cmd>FloatermToggle<CR>",
			desc = "Toggle floaterm",
		})
		map_explicit({
			mode = "t",
			sequence = "<leader>ft",
			action = "<C-\\><C-n><Cmd>FloatermToggle<CR>",
			desc = "Toggle floaterm",
		})
	end)
end

local function setup_toggleterm()
	-- https://github.com/akinsho/toggleterm.nvim
	-- A neovim lua plugin to help easily manage multiple terminal windows
	setup_plugin("toggleterm", {
		open_mapping = [[<c-\>]],
		direction = "float",
		-- this is the key to inheriting your colorscheme's background
		highlights = {
			Normal = {
				link = "Normal",
			},
			NormalFloat = {
				link = "NormalFloat",
			},
		},
	})
end

local function setup_neaterm()
	-- TODO: add plenary and fzf-lua to dependencies
	-- https://github.com/Dan7h3x/neaterm.nvim
	-- A little (smart maybe) terminal plugin for neovim.
	local neaterm_defaults = {
		-- Terminal settings
		shell = vim.o.shell,
		float_width = 0.5,
		float_height = 0.4,
		move_amount = 3,
		resize_amount = 2,
		border = "rounded",

		-- Appearance
		highlights = {
			normal = "Normal",
			border = "FloatBorder",
			title = "Title",
		},

		-- Window management
		min_width = 20,
		min_height = 3,

		-- custom terminals
		terminals = {
			ranger = {
				name = "Ranger",
				cmd = "ranger",
				type = "float",
				float_width = 0.8,
				float_height = 0.8,
				keymaps = {
					quit = "q",
					select = "<CR>",
					preview = "p",
				},
				on_exit = function(selected_file)
					if selected_file then
						vim.cmd("edit " .. selected_file)
					end
				end,
			},
			lazygit = {
				name = "LazyGit",
				cmd = "lazygit",
				type = "float",
				float_width = 0.9,
				float_height = 0.9,
				keymaps = {
					quit = "q",
					commit = "c",
					push = "P",
				},
			},
			btop = {
				name = "Btop",
				cmd = "btop",
				type = "float",
				float_width = 0.8,
				float_height = 0.8,
				keymaps = {
					quit = "q",
					help = "h",
				},
			},
		},

		-- Default keymaps
		use_default_keymaps = true,
		keymaps = {
			toggle = "<A-t>",
			new_vertical = "<C-\\>",
			new_horizontal = "<C-.>",
			new_float = "<C-A-t>",
			close = "<A-d>",
			next = "<C-PageDown>",
			prev = "<C-PageUp>",
			move_up = "<C-A-Up>",
			move_down = "<C-A-Down>",
			move_left = "<C-A-Left>",
			move_right = "<C-A-Right>",
			resize_up = "<C-S-Up>",
			resize_down = "<C-S-Down>",
			resize_left = "<C-S-Left>",
			resize_right = "<C-S-Right>",
			focus_bar = "<C-A-b>",
			repl_toggle = "<leader>rt",
			repl_send_line = "<leader>rl",
			repl_send_selection = "<leader>rs",
			repl_send_buffer = "<leader>rb",
			repl_clear = "<leader>rc",
			repl_history = "<leader>rh",
			repl_variables = "<leader>rv",
			repl_restart = "<leader>rR",
		},

		-- REPL configurations
		repl = {
			float_width = 0.6,
			float_height = 0.4,
			save_history = true,
			history_file = vim.fn.stdpath("data") .. "/neaterm_repl_history.json",
			max_history = 100,
			update_interval = 5000,
		},

		-- REPL language configurations
		repl_configs = {
			python = {
				name = "Python (IPython)",
				cmd = "ipython --no-autoindent --colors='Linux'",
				startup_cmds = {
					-- "import sys",
					-- "sys.ps1 = 'In []: '",
					-- "sys.ps2 = '   ....: '",
				},
				get_variables_cmd = "whos",
				inspect_variable_cmd = "?",
				exit_cmd = "exit()",
			},
			r = {
				name = "R (Radian)",
				cmd = "radian",
				startup_cmds = {
					-- "options(width = 80)",
					-- "options(prompt = 'R> ')",
				},
				get_variables_cmd = "ls.str()",
				inspect_variable_cmd = "str(",
				exit_cmd = "q(save='no')",
			},
			lua = {
				name = "Lua",
				cmd = "lua",
				exit_cmd = "os.exit()",
			},
			node = {
				name = "Node.js",
				cmd = "node",
				get_variables_cmd = "Object.keys(global)",
				exit_cmd = ".exit",
			},
			sh = {
				name = "Shell",
				cmd = vim.o.shell,
				startup_cmds = {
					"PS1='$ '",
					"TERM=xterm-256color",
				},
				get_variables_cmd = "set",
				inspect_variable_cmd = "echo $",
				exit_cmd = "exit",
			},
		},

		-- Terminal features
		features = {
			auto_insert = true,
			auto_close = true,
			restore_layout = true,
			smart_sizing = true,
			persistent_history = true,
			native_search = true,
			clipboard_sync = true,
			shell_integration = true,
		},
	}
	setup_plugin("neaterm", neaterm_defaults)
end

local function setup_termim()
	-- https://github.com/2KAbhishek/termim.nvim
	-- Neovim Terminal, Improved
	utils.packadd("termim")
end

local function setup_yarepl()
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

local function setup_neomux()
	-- TODO: debug nvr-go
	-- https://github.com/nikvdp/neomux
	-- Control Neovim from shells running inside Neovim.
	utils.packadd("neomux")
end

--─────────────────────────────────────────────────────────────────────────────
--──── CALL SETUPS ────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

create_keymaps()
setup_vim_floaterm()
setup_toggleterm()
setup_neaterm()
setup_termim()
setup_yarepl()
setup_neomux()

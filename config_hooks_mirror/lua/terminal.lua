utils.packadd("vim-floaterm", function()
	vim.g.floaterm_width = 0.8
	vim.g.floaterm_height = 0.8
end)

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

setup_plugin("neaterm", {})
utils.packadd("termim")

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

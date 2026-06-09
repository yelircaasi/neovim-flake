
-- ============== TESTING =======================

-- utils.packadd("neomux")         TODO: debug nvr-go
-- setup_plugin("kubernetes", {})  TODO: install kubectl

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
setup_plugin("octohub", {}) -- TODO: install gh
setup_plugin("worktrees", {})
setup_plugin("nvim-quicktype", {})
setup_plugin("hypersonic", {}) -- https://github.com/tomiis4/hypersonic.nvim A Neovim plugin that provides an explanation for regular expressions.", {})
setup_plugin("nvim-lightbulb", {})
setup_plugin("nvim-monorepos", {})
setup_plugin("kubectl", {})
setup_plugin("kpops", {}) -- TODO: install https://github.com/bakdata/kpops
setup_plugin("diagflow", {})
setup_plugin("unimpaired-which-key", function(_) end)

utils.packadd("termim")
-- use which-key to ncreate commands
--[[
t = {
	name = "Terminal",
	["`"] = { "<cmd>Sterm<cr>", "Horizontal Terminal" },
	e = { "<cmd>Sterm iex<cr>", "Elixir" },
	f = { "<cmd>Fterm<cr>", "Floating Terminal" },
	g = { "<cmd>Fterm lazygit<cr>", "Lazygit" },
	n = { "<cmd>Sterm node<cr>", "Node" },
	p = { "<cmd>Sterm bpython<cr>", "Python" },
	r = { "<cmd>Sterm irb<cr>", "Ruby" },
	s = { "<cmd>Sterm<cr>", "Horizontal Terminal" },
	t = { "<cmd>Tterm<cr>", "Terminal" },
	v = { "<cmd>Vterm<cr>", "Vertical Terminal" },
},
--]]

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
setup_plugin("marks-nvim", {})
setup_plugin("modicator", {})
setup_plugin("smartcolumn", {})
setup_plugin("urlview", {})
setup_plugin("wrapping", {})
setup_plugin("nvim-highlight-colors", {})
setup_plugin("projector", function(_) end)
setup_plugin("neoconf", {})
setup_plugin("windex-nvim", {})

setup_plugin("kubels", {})
utils.packadd("vim-helm")

setup_plugin("ax") -- https://github.com/mikeslattery/ax.nvim  Delete all the things!
setup_plugin("sortjson", {})
setup_plugin("qfview-nvim", {})
setup_plugin("rgflow-nvim", {})
setup_plugin("forgit", {}) -- TODO: install delta, huihua

utils.packadd("error-jump")

setup_plugin("gx-extended-nvim", {})
setup_plugin("bafa", {}) -- A minimal 🤏🏾 BufExplorer alternative
setup_plugin("ssr", {})
setup_plugin("substitute", {})

-- TODO: vendor/PR to fix old LspStart command -> new Lua LSP API
-- setup_plugin("scratch-buffer", function(scratch_buffer)
-- 	scratch_buffer.setup(
-- 		{ with_lsp = false }
-- 	)
-- end)

-- https://github.com/Olical/conjure Interactive evaluation for Neovim (Clojure, Fennel, Scheme, Python, JavaScript, PHP, R, Lua, Rust and more!)
vim.g["conjure#mapping#doc_word"] = true -- Disable the documentation mapping
vim.g["conjure#mapping#doc_word"] = { "gk" } -- Reset it to the default unprefixed K (note the special table wrapped syntax)
vim.cmd.packadd("conjure")

utils.packadd("vim-caser") -- cycle a word through snake_case, camelCase, PascalCase, SCREAMING_SNAKE

setup_plugin("splitjoin", {})
utils.packadd("switch.vim")
utils.packadd("vim-abolish")
setup_plugin("spider", {})
setup_plugin("bqf", {})
setup_plugin("FeMaco", {})
setup_plugin("live-command", {})
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

setup_plugin("yanky", {})
setup_plugin("lazyclip", {})
setup_plugin("pasta", function(pasta)
	vim.keymap.set({ "n", "x" }, "p", require("pasta.mapping").p)
	vim.keymap.set({ "n", "x" }, "P", require("pasta.mapping").P)

	-- This is the default. You can omit `setup` call if you don't want to change this.
	require("pasta").config.next_key = vim.keycode("<C-n>")
	require("pasta").config.prev_key = vim.keycode("<C-p>")
	require("pasta").config.indent_key = vim.keycode(",")
	require("pasta").config.indent_fix = true
end)

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

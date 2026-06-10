-- ============== TESTING =======================
local PREVIOUS = false
local NEXT = true

if PREVIOUS then
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
end

require("miscellaneous")

if NEXT then
	-------------------------------------------------------------------------------
	-- GET IMPORTING NEXT
	-------------------------------------------------------------------------------

	-- setup_plugin("control-panel", {})
	-- setup_plugin("doc-window", {}) DEPENDS ON ts_utils
	-- setup_plugin("edit-list", {}) -- expects /home/isaac/.cache/nvim/edit-list.json
	-- setup_plugin("feed", {}) FIX OPTIONS
	-- setup_plugin("hierarchy", {}) -- null global error
	-- setup_plugin("ido", {}) -- module 'fzy.lua' not found
	-- setup_plugin("indent-tools", {}) -- archlib.quick not found
	setup_plugin("date-time-inserter", {})
	setup_plugin("dmap", {})
	setup_plugin("doing", {})
	setup_plugin("dotdot", {})
	setup_plugin("easycolor", {})
	setup_plugin("equals", {})
	setup_plugin("export-colorscheme", function(_) end)
	setup_plugin("flashcards", {})
	setup_plugin("flote", {})
	setup_plugin("fsplash", {})
	setup_plugin("highlight-current-n-nvim", {})
	setup_plugin("http-codes", function(http_codes) end)  -- use vim.g.http_codes
	setup_plugin("inlayhint-filler", {})
	setup_plugin("interlaced", {})
	-- setup_plugin("ivy", {}) -- libivyrs.so not found
	-- setup_plugin("jvim", {})  -- DEPENDS ON nvim-treesitter
	-- setup_plugin("keymapper", {}) -- TODO: rebuild nix
	setup_plugin("keyseer", {})
	setup_plugin("Launch", {})
	-- setup_plugin("nvim-license", {}) -- TODO: rebuild nix
	setup_plugin("live-server", function(live_server) end)  -- use vim.g.live_server
	-- setup_plugin("lvim-ui-config", {}) -- not requirable
	-- setup_plugin("menu", {}) -- TODO: rebuild nix
	setup_plugin("metrics", {})
	setup_plugin("minimal-narrow-region", function(_) end)
	setup_plugin("moonicipal", {})
	setup_plugin("navigator", {})
	setup_plugin("neocomposer-nvim", {})
	setup_plugin("neotest-plenary", {})
	setup_plugin("neowell-lua", {})
	setup_plugin("neowords", function(_) end)
	setup_plugin("nerdy", {})
	-- setup_plugin("nvim_winpick", {}) REQUIRES BUILD
	setup_plugin("nvim-genghis", {}) -- https://github.com/chrisgrieser/nvim-genghis Lightweight and quick file operations without being a full-blown file manager.
	-- setup_plugin("output_panel", {}) -- TODO: rebuild nix
	setup_plugin("paint", {})
	-- setup_plugin("pathlib", {}) -- use as lua module / vendor
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
	-- setup_plugin("sg", {}) -- requires interactive input
	setup_plugin("sort", {})
	setup_plugin("spaceport-nvim", {})
	setup_plugin("spear", {})
	setup_plugin("strict", {})
	setup_plugin("symbols", {})
	setup_plugin("tdo", {})
	setup_plugin("treemonkey", function(_) end)
	-- setup_plugin("TreePin", {}) REQUIRES UPDATE FROM nvim-treesitter
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
	-- setup_plugin("windows", {}) ERRORRED

	-------------------------------------------------------------------------------
	-- DEFERRED: ---------------------------------------------------------------------
	-------------------------------------------------------------------------------
	-- TODO: rebuild nix setup_plugin("knap", {}) -- https://github.com/frabjous/knap
	setup_plugin("zpragmatic", {}) -- https://github.com/muhammadzkralla/zpragmatic.nvim  prompts you with alert dialog questions whenever you attempt to save changes in a file
	-- setup_plugin("commons", {}) TODO: use as lua module
	setup_plugin("volt", function(_) end) -- https://github.com/nvzone/volt  Create blazing fast & beautiful reactive UI in Neovim

	-- setup_plugin("panvimdoc", {}) USE AS EXECUTRABLE / LUA MODULE
	setup_plugin("qalc", {})
	setup_plugin("channelot", function(_) end)
	-- NIX REBUILD setup_plugin("nvmm", {}) -- nvim-mail-merge

	setup_plugin("jaq-nvim", {}) -- https://github.com/is0n/jaq-nvim Just Another Quickrun Plugin for Neovim in Lua

	setup_plugin("xkbswitch", {})
	setup_plugin("cyrillic", {})
	setup_plugin("present", {})

	setup_plugin("cmdTree", {}) -- https://github.com/CWood-sdf/cmdTree.nvim  Declaratively make your neovim user commands

	setup_plugin("better-digraphs", function(_) end)

	utils.packadd("vim-slime")

	setup_plugin("keymap-amend-nvim", {}) -- https://github.com/anuvyklack/keymap-amend.nvim

	setup_plugin("carbon-now-nvim", {})
	setup_plugin("showkeys", {}) -- https://github.com/nvzone/showkeys

	setup_plugin("drop", {}) -- https://github.com/folke/drop.nvim  Fun little plugin that can be used as a screensaver and on your dashboard

	-- NIX REBUILD setup_plugin("api-browser", {})

	---------------- time -------------
	setup_plugin("pommodoro-clock", {})
	setup_plugin("pomodoro", {})
	setup_plugin("timerly", {})
	setup_plugin("timew", {})
	setup_plugin("nomodoro", {})

	---------------- pkm -------------
	utils.packadd("vimwiki", {})
	setup_plugin("obsidian", { legacy_commands = false })
	setup_plugin("orgmode", {})
	setup_plugin("Calendar", {})
	setup_plugin("zettelkasten", {})
	-- config error setup_plugin("daily-focus", {})

	---------------- performance -------------
	setup_plugin("keylab", {}) -- https://github.com/BooleanCube/keylab.nvim
	-- nix rebuild setup_plugin("nvim-apm", {})

	---------------- ai -------------
	setup_plugin("avante", {}) -- https://github.com/yetone/avante.nvim
	setup_plugin("codecompanion", {}) --
	setup_plugin("llm", {})
	utils.packadd("vim-ai")

	---------------- alternative lines -------------
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

	---------------- alternative explorers -------------
	setup_plugin("chadtree", {})
	setup_plugin("neo-tree", {})

	---------------- build -------------

	setup_plugin("compiler", function(_) end)
	setup_plugin("compiler-nvim", {})
	-- setup_plugin("xmake", {}) TODO: install xmake
	-- nix rebuild setup_plugin("officer", {})

	---------------- color -------------
	setup_plugin("text-to-colorscheme", {})
	setup_plugin("minty", {})
	setup_plugin("color-picker", {})
	setup_plugin("baleia", {}) -- Colorize text with ANSI escape sequences (8, 16, 256 or TrueColor)
	if false then
	    setup_plugin("bamboo", {})
	    setup_plugin("kreative", function(_) end) -- https://github.com/katawful/kreative  A colorscheme creation tool for Neovim, written in Fennel with Aniseed
    end

	-------------------------------------------------------------------------------
	-- PROBABLY NOT, BUT WORTH A TRY: ------------------------------------------------
	-------------------------------------------------------------------------------


	-- nix rebuild setup_plugin("ts_context_commentstring", {})
	utils.packadd("vim-wordmotion")
	setup_plugin("hop", {}) --
	utils.packadd("clever-f.vim") --
	setup_plugin("better-escape", {}) --
	setup_plugin("hlsearch-nvim", {}) --
	setup_plugin("improved-search-nvim", {}) --
	utils.packadd("vim-edgemotion") --
	setup_plugin("notify", {}) -- (== nvim-notify ?)
	setup_plugin("lsp_signature", {}) --
	-- nix rebuild setup_plugin("whichkey_setup", {}) --
	setup_plugin("nvim-teal-maker", {}) --
	setup_plugin("cmdbuf", {}) -- https://github.com/notomo/cmdbuf.nvim
	setup_plugin("nvim-rg", {}) -- https://github.com/duane9/nvim-rg
	setup_plugin("homerows", {}) -- https://github.com/unode/homerow.vim/blob/master/autoload/homerow.vim

	utils.packadd("vim-multiple-cursors")

	setup_plugin("savior", {})
	utils.packadd("vim-auto-save")

	-- SEEM TO HANG INDEFINITELY
	-- setup_plugin("shade", {})
	-- setup_plugin("sunglasses", {})

	-------------------------------------------------------------------------------
	-- DECIDED AGAINST: --------------------------------------------------------------
	-------------------------------------------------------------------------------
	
	-- setup_plugin("tree-sitter-just", {})
	-- setup_plugin("guard", {})
	-- setup_plugin("nvim-treesitter", {})
	-- setup_plugin("splitjoin.vim", {})   -- kept lua version
	-- setup_plugin("none-ls", {})
	-- setup_plugin("nvim-alt-substitute", {})-- archived; superseded by nvim-rip-substitute
	-- setup_plugin("pylsp-rope", {})

	--]]
end

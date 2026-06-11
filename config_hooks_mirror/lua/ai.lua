setup_plugin("copilot", function(copilot)
	local function setup_copilot()
		-- MINIMAL
		-- copilot.setup({
		-- 	suggestion = { enabled = true },
		-- 	panel = { enabled = true },
		-- })

		copilot.setup({
			panel = {
				enabled = true,
				auto_refresh = false,
				keymap = {
					jump_prev = "[[",
					jump_next = "]]",
					accept = "<CR>",
					refresh = "gr",
					open = "<M-CR>",
				},
				layout = {
					position = "bottom", -- | top | left | right | bottom |
					ratio = 0.4,
				},
			},
			suggestion = {
				enabled = true,
				auto_trigger = false,
				hide_during_completion = true,
				debounce = 15,
				trigger_on_accept = true,
				keymap = {
					accept = "<M-l>",
					accept_word = false,
					accept_line = false,
					next = "<M-]>",
					prev = "<M-[>",
					dismiss = "<C-]>",
					toggle_auto_trigger = false,
				},
			},
			nes = {
				enabled = false, -- requires copilot-lsp as a dependency
				auto_trigger = false,
				keymap = {
					accept_and_goto = false,
					accept = false,
					dismiss = false,
				},
			},
			auth_provider_url = nil, -- URL to authentication provider, if not "https://github.com/"
			logger = {
				file = vim.fn.stdpath("log") .. "/copilot-lua.log",
				file_log_level = vim.log.levels.OFF,
				print_log_level = vim.log.levels.WARN,
				trace_lsp = "off", -- "off" | "debug" | "verbose"
				trace_lsp_progress = false,
				log_lsp_messages = false,
			},
			copilot_node_command = "node", -- Node.js version must be > 22
			workspace_folders = {},
			copilot_model = "",
			disable_limit_reached_message = false, -- Set to `true` to suppress completion limit reached popup
			root_dir = function()
				return vim.fs.dirname(vim.fs.find(".git", { upward = true })[1])
			end,
			should_attach = function(buf_id, _)
				if not vim.bo[buf_id].buflisted then
					logger.debug("not attaching, buffer is not 'buflisted'")
					return false
				end

				if vim.bo[buf_id].buftype ~= "" then
					logger.debug("not attaching, buffer 'buftype' is " .. vim.bo[buf_id].buftype)
					return false
				end

				return true
			end,
			server = {
				type = "nodejs", -- "nodejs" | "binary"
				custom_server_filepath = nil,
			},
			server_opts_overrides = {},
		})
	end
	setup_copilot()
	vim.api.nvim_create_user_command("Copilot", setup_copilot)
	vim.api.nvim_create_autocmd("InsertEnter", setup_copilot)
end)

---@type opencode.Opts
local opencode_defaults = {
	server = {
		url = nil,
		username = vim.env.OPENCODE_SERVER_USERNAME or "opencode", -- Same env vars and defaults as `opencode`
		password = vim.env.OPENCODE_SERVER_PASSWORD,
		start = function()
			vim.cmd("vsplit term://opencode --port | wincmd p")
		end,
	},
  -- stylua: ignore
  contexts = {
    ["@this"] = function(context) return context:this() end,
    ["@buffer"] = function(context) return context:buffer() end,
    ["@buffers"] = function(context) return context:buffers() end,
    ["@visible"] = function(context) return context:visible_text() end,
    ["@diagnostics"] = function(context) return context:diagnostics() end,
    ["@quickfix"] = function(context) return context:quickfix() end,
    ["@diff"] = function(context) return context:git_diff() end,
    ["@marks"] = function(context) return context:marks() end,
    ["@grapple"] = function(context) return context:grapple_tags() end,
  },
	ask = {
		prompt = "Ask opencode: ",
		completion = "customlist,v:lua.opencode_completion",
		snacks = {
			icon = "󰚩 ",
			win = {
				title_pos = "left",
				relative = "cursor",
				row = -3, -- Row above the cursor
				col = 0, -- Align with the cursor
				keys = {
					i_cr = {
						desc = "submit",
					},
				},
				b = {
					completion = true,
				},
				bo = {
					filetype = "opencode_ask",
				},
				on_buf = function(win)
					-- Make sure your completion plugin has the LSP source enabled,
					-- either by default or for the `opencode_ask` filetype!
					vim.lsp.start(require("opencode.ui.ask.cmp"), {
						bufnr = win.buf,
					})
				end,
			},
		},
	},
	select = {
		prompt = "opencode: ",
		prompts = {
			ask = "...",
			diagnostics = "Explain @diagnostics",
			diff = "Review the following git diff for correctness and readability: @diff",
			document = "Add comments documenting @this",
			explain = "Explain @this and its context",
			fix = "Fix @diagnostics",
			implement = "Implement @this",
			optimize = "Optimize @this for performance and readability",
			review = "Review @this for correctness and readability",
			test = "Add tests for @this",
		},
		commands = {
			["agent.cycle"] = "Cycle selected agent",
			["prompt.clear"] = "Clear current prompt",
			["prompt.submit"] = "Submit current prompt",
			["session.compact"] = "Compact current session",
			["session.interrupt"] = "Interrupt current session",
			["session.new"] = "Start new session",
			["session.redo"] = "Redo last undone action in current session",
			["session.select"] = "Select session",
			["session.undo"] = "Undo last action in current session",
		},
		server = true,
		snacks = {
			preview = "preview",
			layout = {
				preset = "vscode",
				hidden = {}, -- preview is hidden by default in `vim.ui.select`
			},
		},
	},
	events = {
		enabled = true,
		reload = true,
		permissions = {
			enabled = true,
			edits = {
				enabled = true,
			},
		},
	},
	lsp = {
		enabled = false,
		filetypes = nil,
		handlers = {
			hover = {
				enabled = true,
				model = nil,
			},
			code_action = { enabled = true },
		},
	},
}
setup_plugin("opencode", function(opencode)
	---@type opencode.Opts
	vim.g.opencode_opts = opencode_defaults

	vim.o.autoread = true -- Required for `vim.g.opencode_opts.events.reload`

	-- Recommended/example keymaps
	vim.keymap.set({ "n", "x" }, "<leader>oa", function()
		require("opencode").ask("@this: ")
	end, { desc = "Ask opencode…" })
	vim.keymap.set({ "n", "x" }, "<leader>os", function()
		require("opencode").select()
	end, { desc = "Select opencode…" })

	vim.keymap.set({ "n", "x" }, "go", function()
		return require("opencode").operator("@this ")
	end, { desc = "Add range to opencode", expr = true })
	vim.keymap.set("n", "goo", function()
		return require("opencode").operator("@this ") .. "_"
	end, { desc = "Add line to opencode", expr = true })

	vim.keymap.set("n", "<S-C-u>", function()
		require("opencode").command("session.half.page.up")
	end, { desc = "Scroll opencode up" })
	vim.keymap.set("n", "<S-C-d>", function()
		require("opencode").command("session.half.page.down")
	end, { desc = "Scroll opencode down" })
end)

local function setup_opencode_snacks()
	local opencode_cmd = "opencode --port"
	---@type snacks.terminal.Opts
	local snacks_terminal_opts = {
		win = {
			position = "right",
			enter = false,
		},
	}

	vim.g.opencode_opts = {
		server = {
			start = function()
				require("snacks.terminal").open(opencode_cmd, snacks_terminal_opts)
			end,
		},
	}

	vim.keymap.set({ "n", "t" }, "<C-.>", function()
		require("snacks.terminal").toggle(opencode_cmd, snacks_terminal_opts)
	end, { desc = "Toggle opencode" })

	vim.api.nvim_create_autocmd("User", {
		pattern = "OpencodeEvent:*", -- Optionally filter event types
		callback = function(args)
			---@type opencode.server.Event
			local event = args.data.event
			---@type string
			local url = args.data.url

			-- See the available event types and their properties
			vim.notify(vim.inspect(event))
			-- Do something useful
			if event.type == "session.idle" then
				vim.notify("`opencode` finished responding")
			end
		end,
	})
end

-- Optionally show upon submitting prompt
vim.api.nvim_create_autocmd("User", {
	pattern = { "OpencodeEvent:tui.command.execute" },
	callback = function(args)
		---@type opencode.server.Event
		local event = args.data.event
		if event.properties.command == "prompt.submit" then
			local win = require("snacks.terminal").get(opencode_cmd, { create = false })
			if win then
				win:show()
			end
		end
	end,
})

---------------- ai -------------
setup_plugin("avante", {}) -- https://github.com/yetone/avante.nvim
setup_plugin("codecompanion", {}) --
setup_plugin("llm", {})
utils.packadd("vim-ai")

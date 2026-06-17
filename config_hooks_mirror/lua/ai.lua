local function setup_copilot()
	local copilot_defaults = {
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
	}
	setup_plugin("copilot", function(copilot)
		-- MINIMAL
		-- copilot.setup({
		-- 	suggestion = { enabled = true },
		-- 	panel = { enabled = true },
		-- })

		local function setup_copilot()
			copilot.setup(copilot_defaults)
		end
		setup_copilot() -- TODO: remove to make fully lazy
		vim.api.nvim_create_user_command("Copilot", setup_copilot)
		vim.api.nvim_create_autocmd("InsertEnter", setup_copilot)
	end)
end

local function setup_opencode()
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
		map_explicit({
			mode = { "n", "x" },
			sequence = "<leader>oa",
			action = function()
				require("opencode").ask("@this: ")
			end,
			desc = "Ask opencode…",
		})
		map_explicit({
			mode = { "n", "x" },
			sequence = "<leader>os",
			action = function()
				require("opencode").select()
			end,
			desc = "Select opencode…",
		})

		map_explicit({
			mode = { "n", "x" },
			sequence = "go",
			action = function()
				return require("opencode").operator("@this ")
			end,
			opts = { desc = "Add range to opencode", expr = true },
		})
		map_explicit({
			mode = "n",
			sequence = "goo",
			action = function()
				return require("opencode").operator("@this ") .. "_"
			end,
			opts = { desc = "Add line to opencode", expr = true },
		})

		map_explicit({
			mode = "n",
			sequence = "<S-C-u>",
			action = function()
				require("opencode").command("session.half.page.up")
			end,
			opts = { desc = "Scroll opencode up" },
		})
		map_explicit({
			mode = "n",
			sequence = "<S-C-d>",
			action = function()
				require("opencode").command("session.half.page.down")
			end,
			opts = { desc = "Scroll opencode down" },
		})

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

			map_explicit({
				mode = { "n", "t" },
				sequence = "<C-.>",
				action = function()
					require("snacks.terminal").toggle(opencode_cmd, snacks_terminal_opts)
				end,
				desc = "Toggle opencode",
			})

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

		setup_opencode_snacks()
	end)
end

local function setup_avante()
	local avante_defaults = {
		---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
		---@type Provider
		provider = "claude", -- The provider used in Aider mode or in the planning phase of Cursor Planning Mode
		---@alias Mode "agentic" | "legacy"
		---@type Mode
		mode = "agentic", -- The default mode for interaction. "agentic" uses tools to automatically generate code, "legacy" uses the old planning method to generate code.
		-- WARNING: Since auto-suggestions are a high-frequency operation and therefore expensive,
		-- currently designating it as `copilot` provider is dangerous because: https://github.com/yetone/avante.nvim/issues/1048
		-- Of course, you can reduce the request frequency by increasing `suggestion.debounce`.
		auto_suggestions_provider = "claude",
		providers = {
			claude = {
				endpoint = "https://api.anthropic.com",
				auth_type = "api", -- Set to "max" to sign in with Claude Pro/Max subscription
				model = "claude-3-5-sonnet-20241022",
				extra_request_body = {
					temperature = 0.75,
					max_tokens = 4096,
				},
			},
		},
		---Specify the special dual_boost mode
		---1. enabled: Whether to enable dual_boost mode. Default to false.
		---2. first_provider: The first provider to generate response. Default to "openai".
		---3. second_provider: The second provider to generate response. Default to "claude".
		---4. prompt: The prompt to generate response based on the two reference outputs.
		---5. timeout: Timeout in milliseconds. Default to 60000.
		---How it works:
		--- When dual_boost is enabled, avante will generate two responses from the first_provider and second_provider respectively. Then use the response from the first_provider as provider1_output and the response from the second_provider as provider2_output. Finally, avante will generate a response based on the prompt and the two reference outputs, with the default Provider as normal.
		---Note: This is an experimental feature and may not work as expected.
		dual_boost = {
			enabled = false,
			first_provider = "openai",
			second_provider = "claude",
			prompt = "Based on the two reference outputs below, generate a response that incorporates elements from both but reflects your own judgment and unique perspective. Do not provide any explanation, just give the response directly. Reference Output 1: [{{provider1_output}}], Reference Output 2: [{{provider2_output}}]",
			timeout = 60000, -- Timeout in milliseconds
		},
		behaviour = {
			auto_suggestions = false, -- Experimental stage
			auto_set_highlight_group = true,
			auto_set_keymaps = true,
			auto_apply_diff_after_generation = false,
			support_paste_from_clipboard = false,
			minimize_diff = true, -- Whether to remove unchanged lines when applying a code block
			enable_token_counting = true, -- Whether to enable token counting. Default to true.
			auto_add_current_file = true, -- Whether to automatically add the current file when opening a new chat. Default to true.
			auto_approve_tool_permissions = true, -- Default: auto-approve all tools (no prompts)
			-- Examples:
			-- auto_approve_tool_permissions = false,                -- Show permission prompts for all tools
			-- auto_approve_tool_permissions = {"bash", "str_replace"}, -- Auto-approve specific tools only
			---@type "popup" | "inline_buttons"
			confirmation_ui_style = "inline_buttons",
			--- Whether to automatically open files and navigate to lines when ACP agent makes edits
			---@type boolean
			acp_follow_agent_locations = true,
		},
		prompt_logger = { -- logs prompts to disk (timestamped, for replay/debugging)
			enabled = true, -- toggle logging entirely
			log_dir = vim.fn.stdpath("cache") .. "/avante_prompts", -- directory where logs are saved
			fortune_cookie_on_success = false, -- shows a random fortune after each logged prompt (requires `fortune` installed)
			next_prompt = {
				normal = "<C-n>", -- load the next (newer) prompt log in normal mode
				insert = "<C-n>",
			},
			prev_prompt = {
				normal = "<C-p>", -- load the previous (older) prompt log in normal mode
				insert = "<C-p>",
			},
		},
		mappings = {
			--- @class AvanteConflictMappings
			diff = {
				ours = "co",
				theirs = "ct",
				all_theirs = "ca",
				both = "cb",
				cursor = "cc",
				next = "]x",
				prev = "[x",
			},
			suggestion = {
				accept = "<M-l>",
				next = "<M-]>",
				prev = "<M-[>",
				dismiss = "<C-]>",
			},
			jump = {
				next = "]]",
				prev = "[[",
			},
			submit = {
				normal = "<CR>",
				insert = "<C-s>",
			},
			cancel = {
				normal = { "<C-c>", "<Esc>", "q" },
				insert = { "<C-c>" },
			},
			sidebar = {
				apply_all = "A",
				apply_cursor = "a",
				retry_user_request = "r",
				edit_user_request = "e",
				switch_windows = "<Tab>",
				reverse_switch_windows = "<S-Tab>",
				remove_file = "d",
				add_file = "@",
				close = { "<Esc>", "q" },
				close_from_input = nil, -- e.g., { normal = "<Esc>", insert = "<C-d>" }
			},
		},
		selection = {
			enabled = true,
			hint_display = "delayed",
		},
		windows = {
			---@type "right" | "left" | "top" | "bottom"
			position = "right", -- the position of the sidebar
			wrap = true, -- similar to vim.o.wrap
			width = 30, -- default % based on available width
			sidebar_header = {
				enabled = true, -- true, false to enable/disable the header
				align = "center", -- left, center, right for title
				rounded = true,
			},
			spinner = {
				editing = {
					"⡀",
					"⠄",
					"⠂",
					"⠁",
					"⠈",
					"⠐",
					"⠠",
					"⢀",
					"⣀",
					"⢄",
					"⢂",
					"⢁",
					"⢈",
					"⢐",
					"⢠",
					"⣠",
					"⢤",
					"⢢",
					"⢡",
					"⢨",
					"⢰",
					"⣰",
					"⢴",
					"⢲",
					"⢱",
					"⢸",
					"⣸",
					"⢼",
					"⢺",
					"⢹",
					"⣹",
					"⢽",
					"⢻",
					"⣻",
					"⢿",
					"⣿",
				},
				generating = { "·", "✢", "✳", "∗", "✻", "✽" }, -- Spinner characters for the 'generating' state
				thinking = { "🤯", "🙄" }, -- Spinner characters for the 'thinking' state
			},
			input = {
				prefix = "> ",
				height = 8, -- Height of the input window in vertical layout
			},
			edit = {
				border = "rounded",
				start_insert = true, -- Start insert mode when opening the edit window
			},
			ask = {
				floating = false, -- Open the 'AvanteAsk' prompt in a floating window
				start_insert = true, -- Start insert mode when opening the ask window
				border = "rounded",
				---@type "ours" | "theirs"
				focus_on_apply = "ours", -- which diff to focus after applying
			},
		},
		highlights = {
			---@type AvanteConflictHighlights
			diff = {
				current = "DiffText",
				incoming = "DiffAdd",
			},
		},
		--- @class AvanteConflictUserConfig
		diff = {
			autojump = true,
			---@type string | fun(): any
			list_opener = "copen",
			--- Override the 'timeoutlen' setting while hovering over a diff (see :help timeoutlen).
			--- Helps to avoid entering operator-pending mode with diff mappings starting with `c`.
			--- Disable by setting to -1.
			override_timeoutlen = 500,
		},
		suggestion = {
			debounce = 600,
			throttle = 600,
		},
	}
	setup_plugin("avante", avante_defaults) -- https://github.com/yetone/avante.nvim | Use your Neovim like using Cursor AI IDE!
end

local function setup_codecompanion()
	local codecompanion_opts = {
		interactions = {
			chat = {
				adapter = "anthropic",
				model = "claude-sonnet-4-20250514",
			},
		},
		opts = {
			log_level = "DEBUG",
		},
	}
	-- https://github.com/olimorris/codecompanion.nvim |  AI Coding, Vim Style
	-- https://codecompanion.olimorris.dev/
	setup_plugin("codecompanion", function(codecompanion)
		codecompanion.setup(codecompanion_opts)

		map_explicit({
			mode = { "n", "v" },
			sequence = "<C-a>",
			action = "<cmd>CodeCompanionActions<cr>",
			opts = { noremap = true, silent = true },
		})
		map_explicit({
			mode = { "n", "v" },
			sequence = "<LocalLeader>a",
			action = "<cmd>CodeCompanionChat Toggle<cr>",
			opts = { noremap = true, silent = true },
		})
		map_explicit({
			mode = "v",
			sequence = "ga",
			action = "<cmd>CodeCompanionChat Add<cr>",
			opts = { noremap = true, silent = true },
		})

		-- Expand 'cc' into 'CodeCompanion' in the command line
		vim.cmd([[cab cc CodeCompanion]])
	end)
end

local function setup_llm()
	setup_plugin("llm", function(llm)
		local tools = require("llm.tools") -- for app tools
		local llm_defaults = {
			prompt = "You are a professional programmer.",

			------------------- set your model parameters -------------------
			-- You can choose to configure multiple models as needed.
			-----------------------------------------------------------------

			--- style1: set single model parameters
			url = "https://models.inference.ai.azure.com/chat/completions",
			model = "gpt-4o-mini",
			api_type = "openai",

			-- style2: set parameters of multiple models
			-- (If you need to use multiple models and frequently switch between them.)
			models = {
				{
					name = "ChatGPT",
					url = "https://models.inference.ai.azure.com/chat/completions",
					model = "gpt-4o-mini",
					api_type = "openai",
				},
				{
					name = "ChatGLM",
					url = "https://open.bigmodel.cn/api/paas/v4/chat/completions",
					model = "glm-4-flash",
					api_type = "zhipu",
					max_tokens = 8000,
					fetch_key = function()
						return vim.env.GLM_KEY
					end,
					temperature = 0.3,
					top_p = 0.7,
				},
			},

			---------------- set your keymaps for interaction ---------------
			keys = {
				["Input:Submit"] = { mode = "n", key = "<cr>" },
				["Input:Cancel"] = { mode = { "n", "i" }, key = "<C-c>" },
				["Input:Resend"] = { mode = { "n", "i" }, key = "<C-r>" },

				-- ...
			},

			---------------------- set your app tools  ----------------------
			app_handler = {
				OptimCompare = {
					handler = tools.action_handler,
					opts = {
						fetch_key = function()
							return vim.env.GITHUB_TOKEN
						end,
						url = "https://models.inference.ai.azure.com/chat/completions",
						model = "gpt-4o-mini",
						api_type = "openai",
						language = "Chinese",
					},
					["Your Tool Name"] = {
						-- handler =
						-- opts = {
						--    fetch_key = function() return <your api key> end
						-- }
						-- url = "https://xxx",
						-- model = "xxx"
						-- api_type = ""
					},
					-- ...
				},
			},
		}

		llm.setup(llm_defaults)
	end)
end

local function setup_vim_ai()
	utils.packadd("vim-ai", vim_ai_setup)
end

setup_copilot()
setup_opencode()
setup_avante()
setup_codecompanion()
setup_llm()
setup_vim_ai()

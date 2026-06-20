local function general_config()
	-- unnamed register syncs with system clipboard
	vim.opt.clipboard = "unnamedplus"

	-- alternate (default, keep separate)
	-- vim.opt.clipboard = ""
	--> then use "+y / "+p explicitly

	local nv = { "n", "v" }
	map_explicit({
		mode = nv,
		sequence = "<leader>y",
		action = '"+y',
		desc = "Yank to clipboard",
	})
	map_explicit({
		mode = "n",
		sequence = "<leader>Y",
		action = '"+Y',
		desc = "Yank line to clipboard",
	})
	map_explicit({
		mode = nv,
		sequence = "<leader>p",
		action = '"+p',
		desc = "Put from system (unnamedplus) clipboard",
	})
	map_explicit({
		mode = nv,
		sequence = "<leader>P",
		action = '"+P',
		desc = "Put from system (unnamedplus) clipboard (before)",
	})
	map_explicit({
		mode = nv,
		sequence = "<leader>d",
		action = '"_d',
		desc = "Delete to blackhole",
	})

	-- for SSH
	if vim.env.SSH_TTY or vim.env.SSH_CLIENT then
		vim.g.clipboard = {
			name = "OSC 52",
			copy = {
				["+"] = require("vim.ui.clipboard.osc52").copy("+"),
				["*"] = require("vim.ui.clipboard.osc52").copy("*"),
			},
			paste = {
				["+"] = require("vim.ui.clipboard.osc52").paste("+"),
				["*"] = require("vim.ui.clipboard.osc52").paste("*"),
			},
		}
	else
		vim.opt.clipboard = "unnamedplus"
	end

	-- TODO: use a yank history plugin like yanky.nvim or snacks' yank history,
	-- which lets me cycle through previous yanks after pasting.
	-- That way you never lose a yank regardless of what `d` does
end

local function create_autocommands()
	vim.api.nvim_create_autocmd("TextYankPost", {
		callback = function()
			vim.hl.on_yank()
		end,
	})
end
--─────────────────────────────────────────────────────────────────────────────
--──── yanky ──────────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

local function setup_yanky()
	local yanky_defaults = {
		ring = {
			history_length = 100,
			storage = "shada",
			storage_path = vim.fn.stdpath("data") .. "/databases/yanky.db", -- Only for sqlite storage
			sync_with_numbered_registers = true,
			cancel_event = "update",
			ignore_registers = { "_" },
			update_register_on_cycle = false,
			permanent_wrapper = nil,
		},
		picker = {
			select = {
				action = nil, -- nil to use default put action
			},
			telescope = {
				use_default_mappings = true, -- if default mappings should be used
				mappings = nil, -- nil to use default mappings or no mappings (see `use_default_mappings`)
			},
		},
		system_clipboard = {
			sync_with_ring = true,
			clipboard_register = nil,
		},
		highlight = {
			on_put = true,
			on_yank = true,
			timer = 500,
		},
		preserve_cursor_position = {
			enabled = true,
		},
		textobj = {
			enabled = false,
		},
	}
	setup_plugin("yanky", function(yanky)
		yanky.setup(yanky_defaults)

		map_explicit({
			mode = { "n", "x" },
			sequence = "p",
			action = "<Plug>(YankyPutAfter)",
		})
		map_explicit({
			mode = { "n", "x" },
			sequence = "P",
			action = "<Plug>(YankyPutBefore)",
		})
		map_explicit({
			mode = { "n", "x" },
			sequence = "gp",
			action = "<Plug>(YankyGPutAfter)",
		})
		map_explicit({
			mode = { "n", "x" },
			sequence = "gP",
			action = "<Plug>(YankyGPutBefore)",
		})

		map_explicit({
			mode = "n",
			sequence = "<c-p>",
			action = "<Plug>(YankyPreviousEntry)",
		})
		map_explicit({
			mode = "n",
			sequence = "<c-n>",
			action = "<Plug>(YankyNextEntry)",
		})

		-- And these keymaps for tpope/vim-unimpaired like usage:
		map_explicit({
			mode = "n",
			sequence = "]p",
			action = "<Plug>(YankyPutIndentAfterLinewise)",
		})
		map_explicit({
			mode = "n",
			sequence = "[p",
			action = "<Plug>(YankyPutIndentBeforeLinewise)",
		})
		map_explicit({
			mode = "n",
			sequence = "]P",
			action = "<Plug>(YankyPutIndentAfterLinewise)",
		})
		map_explicit({
			mode = "n",
			sequence = "[P",
			action = "<Plug>(YankyPutIndentBeforeLinewise)",
		})

		map_explicit({
			mode = "n",
			sequence = ">p",
			action = "<Plug>(YankyPutIndentAfterShiftRight)",
		})
		map_explicit({
			mode = "n",
			sequence = "<p",
			action = "<Plug>(YankyPutIndentAfterShiftLeft)",
		})
		map_explicit({
			mode = "n",
			sequence = ">P",
			action = "<Plug>(YankyPutIndentBeforeShiftRight)",
		})
		map_explicit({
			mode = "n",
			sequence = "<P",
			action = "<Plug>(YankyPutIndentBeforeShiftLeft)",
		})

		map_explicit({
			mode = "n",
			sequence = "=p",
			action = "<Plug>(YankyPutAfterFilter)",
		})
		map_explicit({
			mode = "n",
			sequence = "=P",
			action = "<Plug>(YankyPutBeforeFilter)",
		})

		-- yank-ring:
		map_explicit({
			mode = "n",
			sequence = "<c-p>",
			action = "<Plug>(YankyPreviousEntry)",
		})
		map_explicit({
			mode = "n",
			sequence = "<c-n>",
			action = "<Plug>(YankyNextEntry)",
		})
	end)
end

local function setup_neoclip()
	local neoclip_defaults = {
		history = 1000,
		enable_persistent_history = false,
		length_limit = 1048576,
		continuous_sync = false,
		db_path = vim.fn.stdpath("data") .. "/databases/neoclip.sqlite3",
		filter = nil,
		preview = true,
		prompt = nil,
		default_register = '"',
		default_register_macros = "q",
		enable_macro_history = true,
		content_spec_column = false,
		disable_keycodes_parsing = false,
		dedent_picker_display = false,
		initial_mode = "insert",
		on_select = {
			move_to_front = false,
			close_telescope = true,
		},
		on_paste = {
			set_reg = false,
			move_to_front = false,
			close_telescope = true,
		},
		on_replay = {
			set_reg = false,
			move_to_front = false,
			close_telescope = true,
		},
		on_custom_action = {
			close_telescope = true,
		},
		keys = {
			telescope = {
				i = {
					select = "<cr>",
					paste = "<c-p>",
					paste_behind = "<c-k>",
					replay = "<c-q>", -- replay a macro
					delete = "<c-d>", -- delete an entry
					edit = "<c-e>", -- edit an entry
					custom = {},
				},
				n = {
					select = "<cr>",
					paste = "p",
					--- It is possible to map to more than one key.
					-- paste = { 'p', '<c-p>' },
					paste_behind = "P",
					replay = "q",
					delete = "d",
					edit = "e",
					custom = {},
				},
			},
			fzf = {
				select = "default",
				paste = "ctrl-p",
				paste_behind = "ctrl-k",
				custom = {},
			},
		},
	}
	setup_plugin("neoclip", function(neoclip)
		neoclip.setup({
			history = 1000,
			enable_persistent_history = true,
			continuous_sync = true,
			enable_system_clipboard = true,
			default_register = '"',
			default_register_macros = "q",
			enable_macro_history = true,
			content_spec_column = true,
			preview = true,
			on_select = { move_to_front = true },
			on_paste = { move_to_front = true },
			keys = {
				fzf = {
					select = "default",
					paste = "ctrl-p",
					paste_behind = "ctrl-P",
					custom = {},
				},
			},
		})

		vim.keymap.set("n", "<leader>ry", function()
			require("neoclip.fzf")()
		end, { desc = "Yank history (neoclip)" })
		vim.keymap.set("n", "<leader>rq", function()
			require("neoclip.fzf").macro()
		end, { desc = "Macro history (neoclip)" })
	end)
end

--─────────────────────────────────────────────────────────────────────────────
--──── lazyclip ───────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

local function setup_lazyclip()
	local lazyclip_defaults = {
		-- Core settings
		max_history = 100, -- Maximum number of items to keep in history
		items_per_page = 9, -- Number of items to show per page
		min_chars = 5, -- Minimum characters required to store item

		-- Window appearance
		window = {
			relative = "editor",
			width = 70, -- Width of the floating window
			height = 12, -- Height of the floating window
			border = "rounded", -- Border style
		},

		-- Internal keymaps for the lazyclip window
		keymaps = {
			close_window = "q", -- Close the clipboard window
			prev_page = "h", -- Go to previous page
			next_page = "l", -- Go to next page
			paste_selected = "<CR>", -- Paste the selected item
			move_up = "k", -- Move selection up
			move_down = "j", -- Move selection down
			delete_item = "d", -- Delete selected item
		},
	}
	setup_plugin("lazyclip", lazyclip_defaults)
end
--─────────────────────────────────────────────────────────────────────────────
--──── pasta ──────────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

local function setup_pasta()
	setup_plugin("pasta", function(pasta)
		local mapping = require("pasta.mapping")
		map_explicit({
			mode = { "n", "x" },
			sequence = "p",
			action = mapping.p,
		})
		map_explicit({
			mode = { "n", "x" },
			sequence = "P",
			action = mapping.P,
		})

		local pasta_config = pasta.config
		pasta_config.next_key = vim.api.nvim_replace_termcodes("<C-n>", true, true, true) -- vim.keycode("<C-n>")
		pasta_config.prev_key = vim.api.nvim_replace_termcodes("<C-p>", true, true, true) -- vim.keycode("<C-p>")
		pasta_config.indent_key = vim.keycode(",")
		pasta_config.indent_fix = true
		-- p/P are remapped by pasta automatically; C-n/C-p cycle through paste history
	end)
end

--─────────────────────────────────────────────────────────────────────────────
--──── wastebin ───────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- TODO: install https://github.com/matze/wastebin

local function setup_wastebin()
	local wastebin_defaults = {
		-- URL of wastebin service to POST pastes to
		url = vim.env.WASTEBIN_URL or "https://foo.bar.com",
		-- argv list used to POST the content; the URL is appended automatically
		post_cmd = { "curl", "-s", "-H", "Content-Type: application/json", "--data-binary", "@-" },
		-- argv list used to open the resulting URL; the URL is appended automatically
		open_cmd = { "open" },
		-- Ask for confirmation
		ask = true,
	}
	setup_plugin("wastebin", wastebin_defaults)
end

--─────────────────────────────────────────────────────────────────────────────
--──── CALL SETUPS ────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

general_config()
create_autocommands()
setup_yanky()
setup_lazyclip()
setup_pasta()
setup_wastebin()

-- MAPPINGS ========================================================================================

local function map_explicit(spec)
	vim.keymap.set(spec.mode, spec.sequence or spec.lhs, spec.action or spec.rhs, spec.opts)
end
local map = utils.map
-- WAS:
-- local map = vim.keymap.set
if mappings_lua then
	--[[
	DESIRED MAPPINGS/ACTIONS

	- open quickfix window
	- open floating terminal
	- copy selection to new file
	- jump to reference (next, previous)
	- jump to definition
	- open search and replace (with preview)
	- fold block
	- fold/unfold all of given level
	- toggle value under cursor
	- rename everywhere (optionally with preview)
	- search pattern/regex in given files -> save results list & use it to navigate
	- show keybinds available
	- add/view/edit comment/annotation pointing to given location
	- view/navigate TODOs and comments
	- insert snippet
	- format code (optionally only under selection)
	- edit selection in new buffer
	- dull colors outside of selection
	- edit filesystem as a buffer (oil.nvim?)
	- get autocomplete suggestion
	- check spelling in file (ONLY on command!)
	- view diff (with saved, last commit, etc.)
	- file tree view
	- navigate between search results
	- toggle to light colors (or even lighten/darken colors, increase contrast -> write plugin?)
	- jump to next syntactic object ( 
	- command to run changed tests (use testmon or analogous)
	- get LLM feedback
	- unified preview_+accept/reject framework
	- multi-line / multi-location edits

	AUTOMATIC/TOGGLABLE FUNCTIONALITIES
	--> dull colors everywhere except in active block (via treesitter?)
	--> custom syntax highlighting for my special formats (from consilium-notes: jn, ...)

	--]]

	-- Set up a local map function for convenience

	-- floaterm -----------------------------------------------------------------------------------------------------------
	vim.keymap.set("n", "<leader>ft", "<Cmd>FloatermToggle<CR>", { desc = "Toggle floaterm" })
	vim.keymap.set("t", "<leader>ft", "<C-\\><C-n><Cmd>FloatermToggle<CR>", { desc = "Toggle floaterm" })

	-- LSP ----------------------------------------------------------------------------------------------------------------
	-- We will create an autocommand group to attach keymaps only to buffers with an active LSP client.
	local lsp_keymaps_group = vim.api.nvim_create_augroup("LspKeymaps", { clear = true })

	vim.api.nvim_create_autocmd("LspAttach", {
		group = lsp_keymaps_group,
		callback = function(ev)
			local lsp_map = function(keys, func, desc)
				vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = "LSP: " .. desc })
			end

			-- Navigation and Information
			lsp_map("gd", vim.lsp.buf.definition, "Go to Definition")
			lsp_map("gD", vim.lsp.buf.declaration, "Go to Declaration")
			lsp_map("gr", vim.lsp.buf.references, "Go to References")
			lsp_map("gI", vim.lsp.buf.implementation, "Go to Implementation")
			lsp_map("K", vim.lsp.buf.hover, "Hover Documentation")
			lsp_map("<C-k>", vim.lsp.buf.signature_help, "Signature Help")

			-- Actions
			lsp_map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
			lsp_map("<leader>rn", vim.lsp.buf.rename, "Rename")

			-- Diagnostics
			lsp_map("[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
			lsp_map("]d", vim.diagnostic.goto_next, "Next Diagnostic")
			lsp_map("<leader>dl", vim.diagnostic.open_float, "Show Line Diagnostics")

			-- format on save (to use LSP formatter instead of conform)
			-- vim.api.nvim_buf_create_autocmd("BufWritePre", {
			--   buffer = ev.buf,
			--   callback = function() vim.lsp.buf.format { async = false } end
			-- })
			--
			local bufopts = { noremap = true, silent = true, buffer = bufnr }
		end,
	})

	-- other LSP maps

	local lsp_map_opts = { buffer = bufnr, silent = true }
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, lsp_map_opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, lsp_map_opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, lsp_map_opts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, lsp_map_opts)
	vim.keymap.set("n", "<leader>cf", function()
		conform.format({ bufnr = bufnr })
	end, lsp_map_opts)

	-- quickfix -----------------------------------------------------------------------------------------------------------
	vim.keymap.set("i", "kj", "<escape>")
	vim.keymap.set("n", "<leader>wq", function()
		vim.cmd("wq")
	end)
	vim.keymap.set("n", "<leader>ww", function()
		vim.cmd("w")
	end)
	vim.keymap.set("n", "<leader>q", function()
		-- Populates the Quickfix list with all diagnostics from the current buffer
		vim.diagnostic.setqflist({ bufnr = 0 })
		vim.cmd("copen")
	end, { desc = "Open Quickfix with diagnostics" })

	--- zen-mode ----------------------------------------------------------------------------------------------------------

	map("n", "<leader>zm", function()
		require("zen-mode").toggle({
			window = {
				width = 0.85, -- width will be 85% of the editor width
			},
		})
	end)
end

if other_mappings then
	---------------------------------------------------------------------------------------------------------------- KEYMAPS
	local nvx = { "n", "v", "x" }
	map_explicit({
		mode = "n",
		sequence = "<leader>o",
		action = ":update<CR> :source<CR>",
		opts = {},
	})
	map_explicit({
		mode = "n",
		sequence = "<leader>ww",
		action = ":write<CR>",
		opts = {},
	})
	map_explicit({
		mode = "n",
		sequence = "<leader>qq",
		action = ":quit<CR>",
		opts = {},
	})
	map_explicit({
		mode = "n",
		sequence = "<leader>wq",
		action = ":wq<CR>",
		opts = {},
	})
	map_explicit({
		mode = "n",
		sequence = "<leader>f",
		action = ":Pick files<CR>",
		opts = {},
	})
	map_explicit({
		mode = "t",
		sequence = "<Esc>",
		action = [[<C-\><C-n>]],
		opts = { desc = "Exit terminal mode" },
	})
	map_explicit({
		mode = "t",
		sequence = "kj",
		action = [[<C-\><C-n>]],
		opts = { desc = "Exit terminal mode" },
	})
	map_explicit({
		mode = "t",
		sequence = "<C-o>",
		action = [[<C-\><C-o>]],
		opts = { desc = "Temporary normal mode" },
	})
	map_explicit({
		mode = "n",
		sequence = "<leader>lf",
		action = vim.lsp.buf.format,
		opts = { desc = "" },
	})
	map_explicit({
		mode = "n",
		sequence = "<leader>h",
		action = ":Pick help",
	})
	map_explicit({
		mode = "n",
		sequence = "<leader>e",
		action = ":Oil<CR>",
	})
	map_explicit({
		mode = nvx,
		sequence = "<leader>y",
		action = "+y<CR>",
		opts = { desc = "Yank to system clipboard" },
	})
	map_explicit({
		mode = nvx,
		sequence = "<leader>d",
		action = "+d<CR>",
		opts = { desc = "Paste from system clipboard" },
	})
	-- map_explicit({
	--     mode = "",
	--     sequence = "",\
	--     action = [[]],
	--     opts = { desc = "" }
	-- })
	-- map_explicit({
	--     mode = "",
	--     sequence = "",
	--     action = [[]],
	--     opts = { desc = "" }
	-- })
	-- map('t', '^[', "^\^N")
	-- map('t', '^O', '^\^O')
	map_explicit({
		mode = "x",
		sequence = "<leader>mf",
		action = ":'<,'>lua move_selection_to_new_file()<CR>",
		opts = { desc = "Move selection to new file (split)" },
	})
	map_explicit({
		mode = "n",
		sequence = "<leader>lu",
		action = function()
			-- Create a new empty floating window or split
			vim.cmd("vsplit | enew")
			vim.bo.filetype = "lua"
			vim.bo.bufhidden = "hide"

			-- Map <CR> to execute the current line or selection
			vim.keymap.set("n", "<CR>", ":.lua<CR>", { buffer = true })
			vim.keymap.set("v", "<CR>", ":lua<CR>", { buffer = true })
		end,
		opts = { desc = "Open Lua Scratchpad" },
	})
	map_explicit({
		mode = "v",
		sequence = "<leader>ms",
		action = move_selection_to_new_file,
	})
	map_explicit({ ------------------------------------------------------------------------------------------------------ diagnostics
		mode = "n",
		sequence = "<leader>dt",
		action = function()
			diagnostics_active = not diagnostics_active
			set_diagnostics_mode()
		end,
		opts = { desc = "Toggle LSP Diagnostics" },
	})
	map_explicit({
		mode = "n",
		sequence = "<leader>dm",
		action = function()
			-- only cycle if active; otherwise turn on and reset to 1
			if not diagnostics_active then
				diagnostics_active = true
				current_mode_index = 1
			else
				current_mode_index = current_mode_index + 1
				if current_mode_index > #diagnostic_modes then
					current_mode_index = 1
				end
			end
			set_diagnostics_mode()
		end,
		opts = { desc = "Cycle LSP Diagnostic Modes" },
	})
	map_explicit({ -------------------------------------------------------------------------------------------------------- telescope
		mode = "n",
		sequence = "<leader>ff",
		action = make_setup_function(function()
			require("telescope.builtin").find_files()
		end),
		opts = { desc = "Find Files" },
	})
	map_explicit({
		mode = "n",
		sequence = "<leader>gf",
		action = function()
			require("telescope.builtin").git_files()
		end,
		opts = { desc = "Find Git Files" },
	})
	map_explicit({
		mode = "n",
		sequence = "<leader>fg",
		action = function()
			require("telescope.builtin").live_grep()
		end,
		opts = { desc = "Live Grep" },
	})
	map_explicit({
		mode = "n",
		sequence = "<leader>fb",
		action = function()
			require("telescope.builtin").buffers()
		end,
		opts = { desc = "Find Buffers" },
	})
	map_explicit({
		mode = "n",
		sequence = "<leader>fh",
		action = function()
			require("telescope.builtin").help_tags()
		end,
		opts = { desc = "Find Help Tags" },
	})
	map_explicit({ --------------------------------------------------------------------------------------------------------- floaterm
		mode = "n",
		sequence = "<leader>ft",
		action = "<Cmd>FloatermToggle<CR>",
		opts = { desc = "Toggle floaterm" },
	})
	map_explicit({
		mode = "t",
		sequence = "<leader>ft",
		action = "<C-\\><C-n><Cmd>FloatermToggle<CR>",
		opts = { desc = "Toggle floaterm" },
	})
	-------------------------------------------------------------------------------------------------------------------- LSP

	map_explicit({ --------------------------------------------------------------------------------------------------------- quickfix
		mode = { "i" },
		sequence = "kj",
		action = "<escape>",
	})
	map_explicit({
		mode = "n",
		sequence = "<leader>wq",
		action = function()
			vim.cmd("wq")
		end,
	})
	map_explicit({
		mode = "n",
		sequence = "<leader>ww",
		action = function()
			vim.cmd("w")
		end,
	})
	map_explicit({
		mode = "n",
		sequence = "<leader>q",
		action = function()
			-- Populates the Quickfix list with all diagnostics from the current buffer
			vim.diagnostic.setqflist({ bufnr = 0 })
			vim.cmd("copen")
		end,
		opts = { desc = "Open Quickfix with diagnostics" },
	})
	map_explicit({ ------------------------------------------------------------------------------------------------------------- dial
		mode = "n",
		sequence = "<C-a>",
		action = function()
			require("dial.map").manipulate("increment", "normal")
		end,
		opts = { desc = "" },
	})
	map_explicit({
		mode = "n",
		sequence = "<C-x>",
		action = function()
			require("dial.map").manipulate("decrement", "normal")
		end,
		opts = { desc = "" },
	})
	map_explicit({
		mode = "n",
		sequence = "g<C-a>",
		action = function()
			require("dial.map").manipulate("increment", "gnormal")
		end,
		opts = { desc = "" },
	})
	map_explicit({
		mode = "n",
		sequence = "g<C-x>",
		action = function()
			require("dial.map").manipulate("decrement", "gnormal")
		end,
		opts = { desc = "" },
	})
	map_explicit({
		mode = "x",
		sequence = "<C-a>",
		action = function()
			require("dial.map").manipulate("increment", "visual")
		end,
		opts = { desc = "" },
	})
	map_explicit({
		mode = "x",
		sequence = "<C-x>",
		action = function()
			require("dial.map").manipulate("decrement", "visual")
		end,
		opts = { desc = "" },
	})
	map_explicit({
		mode = "x",
		sequence = "g<C-a>",
		action = function()
			require("dial.map").manipulate("increment", "gvisual")
		end,
		opts = { desc = "" },
	})
	map_explicit({
		mode = "x",
		sequence = "g<C-x>",
		action = function()
			require("dial.map").manipulate("decrement", "gvisual")
		end,
		opts = { desc = "" },
	})
	map_explicit({ --------------------------------------------------------------------------------------------------------- zen-mode
		mode = "n",
		sequence = "<leader>zm",
		action = function()
			-- width will be 85% of the editor width
			require("zen-mode").toggle({ window = { width = 0.85 } })
		end,
		opts = { desc = "" },
	})

	map_explicit({
		mode = { "n", "v" },
		sequence = "<leader>-",
		action = function()
			load_yazi()
			vim.cmd("Yazi")
		end,
		opts = { desc = "Open yazi at the current file." },
	})
	map_explicit({
		mode = { "n", "v" },
		sequence = "<leader>cw",
		action = function()
			load_yazi()
			vim.cmd("Yazi cwd")
		end,
		opts = { desc = "Open the file manager in nvim's working directory." },
	})
	map_explicit({
		mode = { "n", "v" },
		sequence = "<c-up>",
		action = function()
			load_yazi()
			vim.cmd("Yazi toggle")
		end,
		opts = { desc = "Resume the last yazi session." },
	})
end

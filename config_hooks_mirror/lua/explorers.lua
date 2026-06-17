local function setup_yazi()
	local yazi_defaults = {
		-- Below is the default configuration. It is optional to set these values.
		-- You can customize the configuration for each yazi call by passing it to
		-- yazi() explicitly

		-- enable this if you want to open yazi instead of netrw.
		-- Note that if you enable this, you need to call yazi.setup() to
		-- initialize the plugin. lazy.nvim does this for you in certain cases.
		--
		-- If you are also using neotree, you may prefer not to bring it up when
		-- opening a directory:
		-- {
		--   "nvim-neo-tree/neo-tree.nvim",
		--   opts = {
		--     filesystem = {
		--       hijack_netrw_behavior = "disabled",
		--     },
		--   },
		-- }
		open_for_directories = false,

		-- open visible splits and quickfix items as yazi tabs for easy navigation
		-- https://github.com/mikavilpas/yazi.nvim/pull/359
		open_multiple_tabs = false,

		-- when yazi is closed with no file chosen, change the Neovim working
		-- directory to the directory that yazi was in before it was closed. Defaults
		-- to being off (`false`)
		change_neovim_cwd_on_close = false,

		highlight_groups = {
			-- See https://github.com/mikavilpas/yazi.nvim/pull/180
			hovered_buffer = nil,
			-- See https://github.com/mikavilpas/yazi.nvim/pull/351
			hovered_buffer_in_same_directory = nil,
		},

		-- the floating window scaling factor. 1 means 100%, 0.9 means 90%, etc.
		floating_window_scaling_factor = 0.9,

		-- the transparency of the yazi floating window (0-100). See :h winblend
		yazi_floating_window_winblend = 0,

		-- the type of border to use for the floating window. Can be many values,
		-- including 'none', 'rounded', 'single', 'double', 'shadow', etc. For
		-- more information, see :h nvim_open_win
		yazi_floating_window_border = "rounded",

		-- the zindex of the yazi floating window. Can be used to make the yazi
		-- window fullscreen. See `:h nvim_open_win()` for more information.
		yazi_floating_window_zindex = nil,

		-- the log level to use. Off by default, but can be used to diagnose
		-- issues. You can find the location of the log file by running
		-- `:checkhealth yazi` in Neovim. Also check out the "reproducing issues"
		-- section below
		log_level = vim.log.levels.OFF,

		-- what Neovim should do a when a file was opened (selected) in yazi.
		-- Defaults to simply opening the file.
		open_file_function = function(chosen_file, config, state) end,

		-- customize the keymaps that are active when yazi is open and focused. The
		-- defaults are listed below. Note that the keymaps simply hijack input and
		-- they are never sent to yazi, so only try to map keys that are never
		-- needed by yazi.
		--
		-- Also:
		-- - use e.g. `open_file_in_tab = false` to disable a keymap
		-- - you can customize only some of the keymaps (not all of them)
		-- - you can opt out of all keymaps by setting `keymaps = false`
		keymaps = {
			show_help = "<f1>",
			open_file_in_vertical_split = "<c-v>",
			open_file_in_horizontal_split = "<c-x>",
			open_file_in_tab = "<c-t>",
			grep_in_directory = "<c-s>",
			replace_in_directory = "<c-g>",
			cycle_open_buffers = "<tab>",
			copy_relative_path_to_selected_files = "<c-y>",
			send_to_quickfix_list = "<c-q>",
			change_working_directory = "<c-\\>",
			open_and_pick_window = "<c-o>",
		},

		-- completely override the keymappings for yazi. This function will be
		-- called in the context of the yazi terminal buffer.
		set_keymappings_function = function(yazi_buffer_id, config, context) end,

		-- some yazi.nvim commands copy text to the clipboard. This is the register
		-- yazi.nvim should use for copying. Defaults to "*", the system clipboard
		clipboard_register = "*",

		hooks = {
			-- if you want to execute a custom action when yazi has been opened,
			-- you can define it here.
			yazi_opened = function(preselected_path, yazi_buffer_id, config)
				-- you can optionally modify the config for this specific yazi
				-- invocation if you want to customize the behaviour
			end,

			-- when yazi was successfully closed
			yazi_closed_successfully = function(chosen_file, config, state) end,

			-- when yazi opened multiple files. The default is to send them to the
			-- quickfix list, but if you want to change that, you can define it here
			yazi_opened_multiple_files = function(chosen_files, config, state) end,

			-- This function is called when yazi is ready to process events.
			on_yazi_ready = function(buffer, config, process_api) end,

			before_opening_window = function(window_options) end,
		},

		-- highlight buffers in the same directory as the hovered buffer
		highlight_hovered_buffers_in_same_directory = true,

		integrations = {
			--- What should be done when the user wants to grep in a directory
			grep_in_directory = function(directory)
				-- the default implementation uses telescope if available, otherwise nothing
			end,

			grep_in_selected_files = function(selected_files)
				-- similar to grep_in_directory, but for selected files
			end,

			--- Similarly, search and replace in the files in the directory
			replace_in_directory = function(directory)
				-- default: grug-far.nvim
			end,

			replace_in_selected_files = function(selected_files)
				-- default: grug-far.nvim
			end,

			-- `grealpath` on OSX, (GNU) `realpath` otherwise
			resolve_relative_path_application = "",

			-- the way to resolve relative paths. The default_implementation can be
			-- customized with a function. See
			-- documentation/copy-relative-path-to-files.md for more information.
			resolve_relative_path_implementation = function(args, get_relative_path) end,

			-- how to delete (close) a buffer. Defaults to a bundled version of
			-- `snacks.bufdelete`, copied from https://github.com/folke/snacks.nvim,
			-- which maintains the window layout. See the `types.lua` file for more
			-- information for the available options.
			bufdelete_implementation = "bundled-snacks",

			-- add an action to a file picker to copy the relative path to the
			-- selected file(s). The implementation is the same as for the
			-- `copy_relative_path_to_selected_files` yazi.nvim keymap. Currently
			-- only snacks.nvim is supported. Documentation can be found in the
			-- keybindings section of the readme.
			--
			-- available options:
			-- - nil (default, no action added)
			-- - "snacks.picker" (snacks.nvim)
			picker_add_copy_relative_path_action = nil,
		},

		future_features = {
			-- use a file to store the last directory that yazi was in before it was
			-- closed. Defaults to `true`.
			use_cwd_file = true,
		},
	}
	local yazi = setup_plugin("yazi", function(yazi)
		utils.packadd("plenary")
		yazi.setup({
			open_for_directories = true,
			keymaps = { show_help = "<f1>" },
		})
		map_explicit({
			mode = { "n", "v" },
			sequence = "<leader>-",
			action = "<cmd>Yazi<cr>",
			opts = { desc = "Open yazi at the current file" },
		})
		map_explicit({
			mode = { "n", "v" },
			sequence = "<leader>cw",
			action = "<cmd>Yazi cwd<cr>",
			opts = { desc = "Open the file manager in nvim's working directory" },
		})
		map_explicit({
			mode = { "n", "v" },
			sequence = "<c-up>",
			action = "<cmd>Yazi toggle<cr>",
			opts = { desc = "Resume the last yazi session" },
		})
	end)
end

local function setup_oil()
	---@type oil.SetupOpts
	local oil_defaults = {
		-- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
		-- Set to false if you want some other plugin (e.g. netrw) to open when you edit directories.
		default_file_explorer = true,
		-- Id is automatically added at the beginning, and name at the end
		-- See :help oil-columns
		columns = {
			"icon",
			-- "permissions",
			-- "size",
			-- "mtime",
		},
		-- Buffer-local options to use for oil buffers
		buf_options = {
			buflisted = false,
			bufhidden = "hide",
		},
		-- Window-local options to use for oil buffers
		win_options = {
			wrap = false,
			signcolumn = "no",
			cursorcolumn = false,
			foldcolumn = "0",
			spell = false,
			list = false,
			conceallevel = 3,
			concealcursor = "nvic",
		},
		-- Send deleted files to the trash instead of permanently deleting them (:help oil-trash)
		delete_to_trash = false,
		-- Skip the confirmation popup for simple operations (:help oil.skip_confirm_for_simple_edits)
		skip_confirm_for_simple_edits = false,
		-- Selecting a new/moved/renamed file or directory will prompt you to save changes first
		-- (:help prompt_save_on_select_new_entry)
		prompt_save_on_select_new_entry = true,
		-- Oil will automatically delete hidden buffers after this delay
		-- You can set the delay to false to disable cleanup entirely
		-- Note that the cleanup process only starts when none of the oil buffers are currently displayed
		cleanup_delay_ms = 2000,
		lsp_file_methods = {
			-- Enable or disable LSP file operations
			enabled = true,
			-- Time to wait for LSP file operations to complete before skipping
			timeout_ms = 1000,
			-- Set to true to autosave buffers that are updated with LSP willRenameFiles
			-- Set to "unmodified" to only save unmodified buffers
			autosave_changes = false,
		},
		-- Constrain the cursor to the editable parts of the oil buffer
		-- Set to `false` to disable, or "name" to keep it on the file names
		constrain_cursor = "editable",
		-- Set to true to watch the filesystem for changes and reload oil
		watch_for_changes = false,
		-- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
		-- options with a `callback` (e.g. { callback = function() ... end, desc = "", mode = "n" })
		-- Additionally, if it is a string that matches "actions.<name>",
		-- it will use the mapping at require("oil.actions").<name>
		-- Set to `false` to remove a keymap
		-- See :help oil-actions for a list of all available actions
		keymaps = {
			["g?"] = { "actions.show_help", mode = "n" },
			["<CR>"] = "actions.select",
			["<C-s>"] = { "actions.select", opts = { vertical = true } },
			["<C-h>"] = { "actions.select", opts = { horizontal = true } },
			["<C-t>"] = { "actions.select", opts = { tab = true } },
			["<C-p>"] = "actions.preview",
			["<C-c>"] = { "actions.close", mode = "n" },
			["<C-l>"] = "actions.refresh",
			["-"] = { "actions.parent", mode = "n" },
			["_"] = { "actions.open_cwd", mode = "n" },
			["`"] = { "actions.cd", mode = "n" },
			["g~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
			["gs"] = { "actions.change_sort", mode = "n" },
			["gx"] = "actions.open_external",
			["g."] = { "actions.toggle_hidden", mode = "n" },
			["g\\"] = { "actions.toggle_trash", mode = "n" },
		},
		-- Set to false to disable all of the above keymaps
		use_default_keymaps = true,
		view_options = {
			-- Show files and directories that start with "."
			show_hidden = false,
			-- This function defines what is considered a "hidden" file
			is_hidden_file = function(name, bufnr)
				local m = name:match("^%.")
				return m ~= nil
			end,
			-- This function defines what will never be shown, even when `show_hidden` is set
			is_always_hidden = function(name, bufnr)
				return false
			end,
			-- Sort file names with numbers in a more intuitive order for humans.
			-- Can be "fast", true, or false. "fast" will turn it off for large directories.
			natural_order = "fast",
			-- Sort file and directory names case insensitive
			case_insensitive = false,
			sort = {
				-- sort order can be "asc" or "desc"
				-- see :help oil-columns to see which columns are sortable
				{ "type", "asc" },
				{ "name", "asc" },
			},
			-- Customize the highlight group for the file name
			highlight_filename = function(entry, is_hidden, is_link_target, is_link_orphan)
				return nil
			end,
		},
		-- Extra arguments to pass to SCP when moving/copying files over SSH
		extra_scp_args = {},
		-- Extra arguments to pass to aws s3 when creating/deleting/moving/copying files using aws s3
		extra_s3_args = {},
		-- EXPERIMENTAL support for performing file operations with git
		git = {
			-- Return true to automatically git add/mv/rm files
			add = function(path)
				return false
			end,
			mv = function(src_path, dest_path)
				return false
			end,
			rm = function(path)
				return false
			end,
		},
		-- Configuration for the floating window in oil.open_float
		float = {
			-- Padding around the floating window
			padding = 2,
			-- max_width and max_height can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
			max_width = 0,
			max_height = 0,
			border = nil,
			win_options = {
				winblend = 0,
			},
			-- optionally override the oil buffers window title with custom function: fun(winid: integer): string
			get_win_title = nil,
			-- preview_split: Split direction: "auto", "left", "right", "above", "below".
			preview_split = "auto",
			-- This is the config that will be passed to nvim_open_win.
			-- Change values here to customize the layout
			override = function(conf)
				return conf
			end,
		},
		-- Configuration for the file preview window
		preview_win = {
			-- Whether the preview window is automatically updated when the cursor is moved
			update_on_cursor_moved = true,
			-- How to open the preview window "load"|"scratch"|"fast_scratch"
			preview_method = "fast_scratch",
			-- A function that returns true to disable preview on a file e.g. to avoid lag
			disable_preview = function(filename)
				return false
			end,
			-- Window-local options to use for preview window buffers
			win_options = {},
		},
		-- Configuration for the floating action confirmation window
		confirmation = {
			-- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
			-- min_width and max_width can be a single value or a list of mixed integer/float types.
			-- max_width = {100, 0.8} means "the lesser of 100 columns or 80% of total"
			max_width = 0.9,
			-- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
			min_width = { 40, 0.4 },
			-- optionally define an integer/float for the exact width of the preview window
			width = nil,
			-- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
			-- min_height and max_height can be a single value or a list of mixed integer/float types.
			-- max_height = {80, 0.9} means "the lesser of 80 columns or 90% of total"
			max_height = 0.9,
			-- min_height = {5, 0.1} means "the greater of 5 columns or 10% of total"
			min_height = { 5, 0.1 },
			-- optionally define an integer/float for the exact height of the preview window
			height = nil,
			border = nil,
			win_options = {
				winblend = 0,
			},
		},
		-- Configuration for the floating progress window
		progress = {
			max_width = 0.9,
			min_width = { 40, 0.4 },
			width = nil,
			max_height = { 10, 0.9 },
			min_height = { 5, 0.1 },
			height = nil,
			border = nil,
			minimized_border = "none",
			win_options = {
				winblend = 0,
			},
		},
		-- Configuration for the floating SSH window
		ssh = {
			border = nil,
		},
		-- Configuration for the floating keymaps help window
		keymaps_help = {
			border = nil,
		},
	}
	setup_plugin("oil", function(oil)
		-- utils.packadd("mini.icons")
		-- OR: utils.packadd("nvim-web-devicons")
		-- ^ should be handled by dependencies

		---@module 'oil'
		---@type oil.SetupOpts
		oil.setup(oil_defaults)
		-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
	end)
end

local function setup_neotree()
	---@type neotree.Config.Base
	local neotree_defaults = {
		-- If a user has a sources list it will replace this one.
		-- Only sources listed here will be loaded.
		-- You can also add an external source by adding it's name to this list.
		-- The name used here must be the same name you would use in a require() call.
		sources = {
			"filesystem",
			"buffers",
			"git_status",
			-- "document_symbols",
		},
		add_blank_line_at_top = false, -- Add a blank line at the top of the tree.
		auto_clean_after_session_restore = false, -- Automatically clean up broken neo-tree buffers saved in sessions
		clipboard = {
			sync = "none", -- or "global"/"universal" to share a clipboard for each/all Neovim instance(s), respectively
		},
		close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
		default_source = "filesystem", -- you can choose a specific source `last` here which indicates the last used source
		enable_diagnostics = true,
		enable_git_status = true,
		enable_modified_markers = true, -- Show markers for files with unsaved changes.
		enable_opened_markers = true, -- Enable tracking of opened files. Required for `components.name.highlight_opened_files`
		enable_refresh_on_write = true, -- Refresh the tree when a file is written. Only used if `use_libuv_file_watcher` is false.
		enable_cursor_hijack = false, -- If enabled neotree will keep the cursor on the first letter of the filename when moving in the tree.
		git_status_async = true,
		-- These options are for people with VERY large git repos
		git_status_async_options = {
			batch_size = 1000, -- how many lines of git status results to process at a time
			batch_delay = 10, -- delay in ms between batches. Spreads out the workload to let other processes run.
			max_lines = 10000, -- How many lines of git status results to process. Anything after this will be dropped.
			-- Anything before this will be used. The last items to be processed are the untracked files.
		},
		git_status_scope_to_path = false, -- Scope git status to the displayed path instead of the entire worktree root.
		-- Improves performance in monorepos where the worktree root is far above the
		-- directory being browsed. When enabled, `git status` receives a `-- <path>`
		-- pathspec limiting it to the current neo-tree root directory.
		hide_root_node = false, -- Hide the root node.
		retain_hidden_root_indent = false, -- IF the root node is hidden, keep the indentation anyhow.
		-- This is needed if you use expanders because they render in the indent.
		keep_altfile = false, -- Whether the `:h alternate-file` should stay as the file used before opening Neo-tree
		-- The minimum level of log statements that should be logged to the log file.
		log_level = vim.log.levels.INFO, -- or other vim.log.levels (up to .ERROR), or "trace", "debug", "info", "warn", "error", "fatal"
		-- For usabiliity, the minimum console log level = max(log_level, INFO) unless set explicitly using a table:
		-- log_level = {
		--   file = vim.log.levels.INFO,
		--   console = vim.log.levels.INFO,
		-- },

		-- true, false, "/path/to/file.log", use ':lua require("neo-tree").show_logs()' to show the file.
		-- Default location is `vim.fn.stdpath("data") .. "/" .. "neo-tree.nvim.log"`
		log_to_file = false,
		open_files_in_last_window = true, -- false = open files in top left window
		open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "edgy" }, -- when opening files, do not use windows containing these filetypes or buftypes
		open_files_using_relative_paths = false,
		-- popup_border_style is for input and confirmation dialogs.
		-- Configurtaion of floating window is done in the individual source sections.
		-- "NC" is a special style that works well with NormalNC set
		popup_border_style = "NC", -- "double", "rounded", "single", "solid", (or "" to use 'winborder' on Neovim v0.11+)
		resize_timer_interval = 500, -- in ms, needed for containers to redraw right aligned and faded content
		-- set to -1 to disable the resize timer entirely
		--                           -- NOTE: this will speed up to 50 ms for 1 second following a resize
		sort_case_insensitive = false, -- used when sorting files and directories in the tree
		sort_function = nil, -- uses a custom function for sorting files and directories in the tree
		use_popups_for_input = true, -- If false, inputs will use vim.ui.input() instead of custom floats.
		use_default_mappings = true,
		trash = {
			command = nil, -- by default: powershell script on windows, `trash` or `osascript` on macOS, and `gio trash` or Neo-tree's freedesktop trash implementation on other Unixes
		},
		-- source_selector provides clickable tabs to switch between sources.
		source_selector = {
			winbar = false, -- toggle to show selector on winbar
			statusline = false, -- toggle to show selector on statusline
			show_scrolled_off_parent_node = false, -- this will replace the tabs with the parent path
			-- of the top visible node when scrolled down.
			sources = {
				{ source = "filesystem" },
				{ source = "buffers" },
				{ source = "git_status" },
			},
			content_layout = "start", -- only with `tabs_layout` = "equal", "active"
			--                start  : |/ 󰓩 bufname     \/...
			--                end    : |/     󰓩 bufname \/...
			--                center : |/   󰓩 bufname   \/...
			tabs_layout = "equal", -- start, end, center, equal, active
			--             start  : |/  a  \/  b  \/  c  \            |
			--             end    : |            /  a  \/  b  \/  c  \|
			--             center : |      /  a  \/  b  \/  c  \      |
			--             equal  : |/    a    \/    b    \/    c    \|
			--             active : |/  focused tab    \/  b  \/  c  \|
			truncation_character = "…", -- character to use when truncating the tab label
			tabs_min_width = nil, -- nil | int: if int padding is added based on `content_layout`
			tabs_max_width = nil, -- this will truncate text even if `text_trunc_to_fit = false`
			padding = 0, -- can be int or table
			-- padding = { left = 2, right = 0 },
			-- separator = "▕", -- can be string or table, see below
			separator = { left = "▏", right = "▕" },
			-- separator = { left = "/", right = "\\", override = nil },     -- |/  a  \/  b  \/  c  \...
			-- separator = { left = "/", right = "\\", override = "right" }, -- |/  a  \  b  \  c  \...
			-- separator = { left = "/", right = "\\", override = "left" },  -- |/  a  /  b  /  c  /...
			-- separator = { left = "/", right = "\\", override = "active" },-- |/  a  / b:active \  c  \...
			-- separator = "|",                                              -- ||  a  |  b  |  c  |...
			separator_active = nil, -- set separators around the active tab. nil falls back to `source_selector.separator`
			show_separator_on_edge = false,
			--                       true  : |/    a    \/    b    \/    c    \|
			--                       false : |     a    \/    b    \/    c     |
			highlight_tab = "NeoTreeTabInactive",
			highlight_tab_active = "NeoTreeTabActive",
			highlight_background = "NeoTreeTabInactive",
			highlight_separator = "NeoTreeTabSeparatorInactive",
			highlight_separator_active = "NeoTreeTabSeparatorActive",
		},
		--
		--event_handlers = {
		--  {
		--    event = "before_render",
		--    handler = function (state)
		--      -- add something to the state that can be used by custom components
		--    end
		--  },
		--  {
		--    event = "file_opened",
		--    handler = function(file_path)
		--      --auto close
		--      require("neo-tree.command").execute({ action = "close" })
		--    end
		--  },
		--  {
		--    event = "file_opened",
		--    handler = function(file_path)
		--      --clear search after opening a file
		--      require("neo-tree.sources.filesystem").reset_search()
		--    end
		--  },
		--  {
		--    event = "file_renamed",
		--    handler = function(args)
		--      -- fix references to file
		--      print(args.source, " renamed to ", args.destination)
		--    end
		--  },
		--  {
		--    event = "file_moved",
		--    handler = function(args)
		--      -- fix references to file
		--      print(args.source, " moved to ", args.destination)
		--    end
		--  },
		--  {
		--    event = "neo_tree_buffer_enter",
		--    handler = function()
		--      vim.cmd 'highlight! Cursor blend=100'
		--    end
		--  },
		--  {
		--    event = "neo_tree_buffer_leave",
		--    handler = function()
		--      vim.cmd 'highlight! Cursor guibg=#5f87af blend=0'
		--    end
		--  },
		-- {
		--   event = "neo_tree_window_before_open",
		--   handler = function(args)
		--     print("neo_tree_window_before_open", vim.inspect(args))
		--   end
		-- },
		-- {
		--   event = "neo_tree_window_after_open",
		--   handler = function(args)
		--     vim.cmd("wincmd =")
		--   end
		-- },
		-- {
		--   event = "neo_tree_window_before_close",
		--   handler = function(args)
		--     print("neo_tree_window_before_close", vim.inspect(args))
		--   end
		-- },
		-- {
		--   event = "neo_tree_window_after_close",
		--   handler = function(args)
		--     vim.cmd("wincmd =")
		--   end
		-- }
		--},
		default_component_configs = {
			container = {
				enable_character_fade = true,
				width = "100%",
				right_padding = 0,
			},
			--diagnostics = {
			--  symbols = {
			--    hint = "H",
			--    info = "I",
			--    warn = "!",
			--    error = "X",
			--  },
			--  highlights = {
			--    hint = "DiagnosticSignHint",
			--    info = "DiagnosticSignInfo",
			--    warn = "DiagnosticSignWarn",
			--    error = "DiagnosticSignError",
			--  },
			--},
			indent = {
				indent_size = 2,
				padding = 1,
				-- indent guides
				with_markers = true,
				indent_marker = "│",
				last_indent_marker = "└",
				highlight = "NeoTreeIndentMarker",
				-- expander config, needed for nesting files
				with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
				expander_collapsed = "",
				expander_expanded = "",
				expander_highlight = "NeoTreeExpander",
			},
			icon = {
				folder_closed = "",
				folder_open = "",
				folder_empty = "󰉖",
				folder_empty_open = "󰷏",
				selected = "󰐾",
				use_filtered_colors = true, -- Whether to use a different highlight when the file is filtered (hidden, dotfile, etc.).
				-- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
				-- then these will never be used.
				default = "*",
				highlight = "NeoTreeFileIcon",
				provider = function(icon, node, state) -- default icon provider utilizes nvim-web-devicons if available
					if node.type == "file" or node.type == "terminal" then
						local success, web_devicons = pcall(require, "nvim-web-devicons")
						local name = node.type == "terminal" and "terminal" or node.name
						if success then
							local devicon, hl = web_devicons.get_icon(name)
							icon.text = devicon or icon.text
							icon.highlight = hl or icon.highlight
						end
					end
				end,
			},
			modified = {
				symbol = "[+] ",
				highlight = "NeoTreeModified",
			},
			name = {
				trailing_slash = false,
				highlight_opened_files = false, -- Requires `enable_opened_markers = true`.
				-- Take values in { false (no highlight), true (only loaded),
				-- "all" (both loaded and unloaded)}. For more information,
				-- see the `show_unloaded` config of the `buffers` source.
				use_filtered_colors = true, -- Whether to use a different highlight when the file is filtered (hidden, dotfile, etc.).
				use_git_status_colors = true,
				highlight = "NeoTreeFileName",
			},
			git_status = {
				symbols = {
					-- Change type
					added = "✚", -- NOTE: you can set any of these to an empty string to not show them
					deleted = "✖",
					modified = "",
					renamed = "󰁕",
					-- Status type
					untracked = "",
					ignored = "",
					unstaged = "󰄱",
					staged = "",
					conflict = "",
				},
				align = "right",
			},
			-- If you don't want to use these columns, you can set `enabled = false` for each of them individually
			file_size = {
				enabled = true,
				width = 12, -- width of the column
				required_width = 64, -- min width of window required to show this column
			},
			type = {
				enabled = true,
				width = 10, -- width of the column
				required_width = 110, -- min width of window required to show this column
			},
			last_modified = {
				enabled = true,
				width = 20, -- width of the column
				required_width = 88, -- min width of window required to show this column
				format = "%Y-%m-%d %I:%M %p", -- format string for timestamp (see `:h os.date()`)
				-- or use a function that takes in the date in seconds and returns a string to display
				--format = require("neo-tree.utils").relative_date, -- enable relative timestamps
			},
			created = {
				enabled = false,
				width = 20, -- width of the column
				required_width = 120, -- min width of window required to show this column
				format = "%Y-%m-%d %I:%M %p", -- format string for timestamp (see `:h os.date()`)
				-- or use a function that takes in the date in seconds and returns a string to display
				--format = require("neo-tree.utils").relative_date, -- enable relative timestamps
			},
			symlink_target = {
				enabled = false,
				target_display = "auto", -- "auto", "force_relative", or "force_absolute"
				text_format = " ➛ %s", -- %s will be replaced with the symlink target's path.
			},
		},
		-- The renderer section provides the renderers that will be used to render the tree.
		--   The first level is the node type.
		--   For each node type, you can specify a list of components to render.
		--       Components are rendered in the order they are specified.
		--         The first field in each component is the name of the function to call.
		--         The rest of the fields are passed to the function as the "config" argument.
		renderers = {
			directory = {
				{ "indent" },
				{ "icon" },
				{ "current_filter" },
				{
					"container",
					content = {
						{ "name", zindex = 10 },
						{
							"symlink_target",
							zindex = 10,
							highlight = "NeoTreeSymbolicLinkTarget",
						},
						{ "clipboard", zindex = 10 },
						{ "diagnostics", errors_only = true, zindex = 20, align = "right", hide_when_expanded = true },
						{ "git_status", zindex = 10, align = "right", hide_when_expanded = true },
						{ "file_size", zindex = 10, align = "right" },
						{ "type", zindex = 10, align = "right" },
						{ "last_modified", zindex = 10, align = "right" },
						{ "created", zindex = 10, align = "right" },
					},
				},
			},
			file = {
				{ "indent" },
				{ "icon" },
				{
					"container",
					content = {
						{
							"name",
							zindex = 10,
						},
						{
							"symlink_target",
							zindex = 10,
							highlight = "NeoTreeSymbolicLinkTarget",
						},
						{ "clipboard", zindex = 10 },
						{ "bufnr", zindex = 10 },
						{ "modified", zindex = 20, align = "right" },
						{ "diagnostics", zindex = 20, align = "right" },
						{ "git_status", zindex = 10, align = "right" },
						{ "file_size", zindex = 10, align = "right" },
						{ "type", zindex = 10, align = "right" },
						{ "last_modified", zindex = 10, align = "right" },
						{ "created", zindex = 10, align = "right" },
					},
				},
			},
			message = {
				{ "indent", with_markers = false },
				{ "name", highlight = "NeoTreeMessage" },
			},
			terminal = {
				{ "indent" },
				{ "icon" },
				{ "name" },
				{ "bufnr" },
			},
		},
		nesting_rules = {},
		-- Global custom commands that will be available in all sources (if not overridden in `opts[source_name].commands`)
		--
		-- You can then reference the custom command by adding a mapping to it:
		--    globally    -> `opts.window.mappings`
		--    locally     -> `opt[source_name].window.mappings` to make it source specific.
		--
		-- commands = {              |  window {                 |  filesystem {
		--   hello = function()      |    mappings = {           |    commands = {
		--     print("Hello world")  |      ["<C-c>"] = "hello"  |      hello = function()
		--   end                     |    }                      |        print("Hello world in filesystem")
		-- }                         |  }                        |      end
		--
		-- see `:h neo-tree-custom-commands-global`
		commands = {}, -- A list of functions

		window = { -- see https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/popup for
			-- possible options. These can also be functions that return these options.
			position = "left", -- left, right, top, bottom, float, current
			width = 40, -- applies to left and right positions
			height = 15, -- applies to top and bottom positions
			auto_expand_width = false, -- expand the window when file exceeds the window width. does not work with position = "float"
			popup = { -- settings that apply to float position only
				size = {
					height = "80%",
					width = "50%",
				},
				position = "50%", -- 50% means center it
				title = function(state) -- format the text that appears at the top of a popup window
					return "Neo-tree " .. state.name:gsub("^%l", string.upper)
				end,
				-- you can also specify border here, if you want a different setting from
				-- the global popup_border_style.
			},
			insert_as = "child", -- Affects how nodes get inserted into the tree during creation/pasting/moving of files if the node under the cursor is a directory:
			-- "child":   Insert nodes as children of the directory under cursor.
			-- "sibling": Insert nodes  as siblings of the directory under cursor.
			-- Mappings for tree window. See `:h neo-tree-mappings` for a list of built-in commands.
			-- You can also create your own commands by providing a function instead of a string.
			mapping_options = {
				noremap = true,
				nowait = true,
			},
			mappings = {
				["<C-s>"] = {
					"quick_jump",
					config = {
						-- This will automaticly open / toggle the target node after jumping.
						-- You can set it to `nil` to perform only the jump action,
						-- or write your own callback function.
						on_jump = "open_or_toggle",
						jump_labels = "jfkdlsahgnuvrbytmiceoxwpqz",
					},
				},
				["<Tab>"] = "select",
				["<C-;>"] = "clear_selection",
				["<space>"] = {
					"toggle_node",
					nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
				},
				["<2-LeftMouse>"] = "open",
				["<cr>"] = "open",
				-- ["<cr>"] = { "open", config = { expand_nested_files = true } }, -- expand nested file takes precedence
				["<esc>"] = "cancel", -- close preview or floating neo-tree window
				["P"] = {
					"toggle_preview",
					config = {
						use_float = true,
						use_snacks_image = true,
						use_image_nvim = true,
						-- title = "Neo-tree Preview", -- You can define a custom title for the preview floating window.
					},
				},
				["<C-f>"] = { "scroll_preview", config = { direction = -10 } },
				["<C-b>"] = { "scroll_preview", config = { direction = 10 } },
				["l"] = "focus_preview",
				["S"] = "open_split",
				-- ["S"] = "split_with_window_picker",
				["s"] = "open_vsplit",
				-- ["sr"] = "open_rightbelow_vs",
				-- ["sl"] = "open_leftabove_vs",
				-- ["s"] = "vsplit_with_window_picker",
				["t"] = "open_tabnew",
				-- ["<cr>"] = "open_drop",
				-- ["t"] = "open_tab_drop",
				["w"] = "open_with_window_picker",
				["C"] = "close_node",
				--["C"] = "close_all_subnodes",
				["z"] = "close_all_nodes",
				--["Z"] = "expand_all_nodes",
				--["Z"] = "expand_all_subnodes",
				["R"] = "refresh",
				["a"] = {
					"add",
					-- some commands may take optional config options, see `:h neo-tree-mappings` for details
					config = {
						show_path = "none", -- "none", "relative", "absolute"
					},
				},
				["A"] = "add_directory", -- also accepts the config.show_path and config.insert_as options.
				["d"] = "delete",
				["T"] = "trash",
				["u"] = "undo", -- currently only supports trash.
				["U"] = "restore_from_trash", -- only works on files that are in the recycle bin
				["r"] = "rename",
				["y"] = "copy_to_clipboard",
				["x"] = "cut_to_clipboard",
				["p"] = "paste_from_clipboard",
				["<C-r>"] = "clear_clipboard",
				["c"] = "copy", -- takes text input for destination, also accepts the config.show_path and config.insert_as options
				["m"] = "move", -- takes text input for destination, also accepts the config.show_path and config.insert_as options
				["e"] = "toggle_auto_expand_width",
				["q"] = "close_window",
				["?"] = "show_help",
				-- You can sort by command name with:
				-- ["?"] = { "show_help", config = { sorter = function(a, b) return a.mapping.text < b.mapping.text end } },
				-- The type of a and b are neotree.Help.Mapping
				["<"] = "prev_source",
				[">"] = "next_source",
			},
		},
		filesystem = {
			window = {
				mappings = {
					["H"] = "toggle_hidden",
					["/"] = "fuzzy_finder",
					--["/"] = {"fuzzy_finder", config = { keep_filter_on_submit = true }},
					--["/"] = "filter_as_you_type", -- this was the default until v1.28
					["D"] = "fuzzy_finder_directory",
					-- ["D"] = "fuzzy_sorter_directory",
					["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
					["f"] = "filter_on_submit",
					["<C-x>"] = "clear_filter",
					["<bs>"] = "navigate_up",
					["."] = "set_root",
					["[g"] = "prev_git_modified",
					["]g"] = "next_git_modified",
					["i"] = "show_file_details", -- see `:h neo-tree-file-actions` for options to customize the window.
					["b"] = "rename_basename",
					["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
					["oc"] = { "order_by_created", nowait = false },
					["od"] = { "order_by_diagnostics", nowait = false },
					["og"] = { "order_by_git_status", nowait = false },
					["om"] = { "order_by_modified", nowait = false },
					["on"] = { "order_by_name", nowait = false },
					["os"] = { "order_by_size", nowait = false },
					["ot"] = { "order_by_type", nowait = false },
				},
				fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
					["<down>"] = "move_cursor_down",
					["<C-n>"] = "move_cursor_down",
					["<up>"] = "move_cursor_up",
					["<C-p>"] = "move_cursor_up",
					["<Esc>"] = "close",
					["<S-CR>"] = "close_keep_filter",
					["<C-CR>"] = "close_clear_filter",
					["<C-w>"] = { "<C-S-w>", raw = true },
					{
						-- normal mode mappings
						n = {
							["j"] = "move_cursor_down",
							["k"] = "move_cursor_up",
							["<S-CR>"] = "close_keep_filter",
							["<C-CR>"] = "close_clear_filter",
							["<esc>"] = "close",
						},
					},
					-- ["<esc>"] = "noop", -- if you want to use normal mode
					-- ["key"] = function(state, scroll_padding) ... end,
				},
			},
			async_directory_scan = "auto", -- "auto"   means refreshes are async, but it's synchronous when called from the Neotree commands.
			-- "always" means directory scans are always async.
			-- "never"  means directory scans are never async.
			scan_mode = "shallow", -- "shallow": Don't scan into directories to detect possible empty directory a priori
			-- "deep": Scan into directories to detect empty or grouped empty directories a priori.
			bind_to_cwd = true, -- true creates a 2-way binding between vim's cwd and neo-tree's root
			cwd_target = {
				sidebar = "tab", -- sidebar is when position = left or right
				current = "window", -- current is when position = current
			},
			-- check gitignore status for files/directories when searching.
			-- setting this to false will speed up searches, but gitignored
			-- items won't be marked if they are visible.
			check_gitignore_in_search = true,
			filtered_items = {
				visible = false, -- when true, they will just be displayed differently than normal items
				force_visible_in_empty_folder = false, -- when true, hidden files will be shown if the root folder is otherwise empty
				children_inherit_highlights = true, -- whether children of filtered parents should inherit their parent's highlight group
				show_hidden_count = true, -- when true, the number of hidden items in each folder will be shown as the last entry
				hide_dotfiles = true,
				hide_gitignored = true,
				hide_ignored = true, -- hide files that are ignored by other gitignore-like files
				-- other gitignore-like files, in descending order of precedence.
				ignore_files = {
					".neotreeignore",
					".ignore",
					-- ".rgignore"
				},
				hide_hidden = true, -- only works on Windows for hidden files/directories
				hide_by_name = {
					".DS_Store",
					"thumbs.db",
					--"node_modules",
				},
				hide_by_pattern = { -- uses glob style patterns
					--"*.meta",
					--"*/src/*/tsconfig.json"
				},
				always_show = { -- remains visible even if other settings would normally hide it
					--".gitignored",
				},
				always_show_by_pattern = { -- uses glob style patterns
					--".env*",
				},
				never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
					--".DS_Store",
					--"thumbs.db"
				},
				never_show_by_pattern = { -- uses glob style patterns
					--".null-ls_*",
				},
			},
			find_by_full_path_words = false, -- `false` means it only searches the tail of a path.
			-- `true` will change the filter into a full path
			-- search with space as an implicit ".*", so
			-- `fi init`
			-- will match: `./sources/filesystem/init.lua
			--find_command = "fd", -- this is determined automatically, you probably don't need to set it
			--find_args = {  -- you can specify extra args to pass to the find command.
			--  fd = {
			--  "--exclude", ".git",
			--  "--exclude",  "node_modules"
			--  }
			--},
			---- or use a function instead of list of strings
			--find_args = function(cmd, path, search_term, args)
			--  if cmd ~= "fd" then
			--    return args
			--  end
			--  --maybe you want to force the filter to always include hidden files:
			--  table.insert(args, "--hidden")
			--  -- but no one ever wants to see .git files
			--  table.insert(args, "--exclude")
			--  table.insert(args, ".git")
			--  -- or node_modules
			--  table.insert(args, "--exclude")
			--  table.insert(args, "node_modules")
			--  --here is where it pays to use the function, you can exclude more for
			--  --short search terms, or vary based on the directory
			--  if string.len(search_term) < 4 and path == "/home/cseickel" then
			--    table.insert(args, "--exclude")
			--    table.insert(args, "Library")
			--  end
			--  return args
			--end,
			group_empty_dirs = false, -- when true, empty folders will be grouped together
			search_limit = 50, -- max number of search results when using filters
			follow_current_file = {
				enabled = false, -- This will find and focus the file in the active buffer every time
				--               -- the current file is changed while the tree is open.
				leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
			},
			hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
			-- in whatever position is specified in window.position
			-- "open_current",-- netrw disabled, opening a directory opens within the
			-- window like netrw would, regardless of window.position
			-- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
			use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
			-- instead of relying on nvim autocmd events.
		},
		buffers = {
			bind_to_cwd = true,
			follow_current_file = {
				enabled = true, -- This will find and focus the file in the active buffer every time
				--              -- the current file is changed while the tree is open.
				leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
			},
			group_empty_dirs = true, -- when true, empty directories will be grouped together
			show_unloaded = false, -- When working with sessions, for example, restored but unfocused buffers
			-- are mark as "unloaded". Turn this on to view these unloaded buffer.
			terminals_first = false, -- when true, terminals will be listed before file buffers
			window = {
				mappings = {
					["<bs>"] = "navigate_up",
					["."] = "set_root",
					["d"] = "buffer_delete",
					["bd"] = "buffer_delete",
					["i"] = "show_file_details", -- see `:h neo-tree-file-actions` for options to customize the window.
					["b"] = "rename_basename",
					["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
					["oc"] = { "order_by_created", nowait = false },
					["od"] = { "order_by_diagnostics", nowait = false },
					["om"] = { "order_by_modified", nowait = false },
					["on"] = { "order_by_name", nowait = false },
					["os"] = { "order_by_size", nowait = false },
					["ot"] = { "order_by_type", nowait = false },
				},
			},
		},
		git_status = {
			window = {
				mappings = {
					["A"] = "git_add_all",
					["gu"] = "git_unstage_file",
					["gU"] = "git_undo_last_commit",
					["ga"] = "git_add_file",
					["gt"] = "git_toggle_file_stage",
					["gr"] = "git_revert_file",
					["gc"] = "git_commit",
					["gp"] = "git_push",
					["gl"] = "git_pull",
					["gg"] = "git_commit_and_push",
					["i"] = "show_file_details", -- see `:h neo-tree-file-actions` for options to customize the window.
					["b"] = "rename_basename",
					["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
					["oc"] = { "order_by_created", nowait = false },
					["od"] = { "order_by_diagnostics", nowait = false },
					["om"] = { "order_by_modified", nowait = false },
					["on"] = { "order_by_name", nowait = false },
					["os"] = { "order_by_size", nowait = false },
					["ot"] = { "order_by_type", nowait = false },
				},
			},
		},
		document_symbols = {
			follow_cursor = false,
			follow_tree_cursor = false, -- Automatically show symbol location when moving cursor in the tree
			client_filters = "first",
			ignore_symbols = {}, -- LSP symbol kind names to hide, e.g. { "Variable", "Field" }
			renderers = {
				root = {
					{ "indent" },
					{ "icon", default = "C" },
					{ "name", zindex = 10 },
				},
				symbol = {
					{ "indent", with_expanders = true },
					{ "kind_icon", default = "?" },
					{
						"container",
						content = {
							{ "name", zindex = 10 },
							{ "kind_name", zindex = 20, align = "right" },
						},
					},
				},
			},
			window = {
				mappings = {
					["<cr>"] = "jump_to_symbol",
					["o"] = "jump_to_symbol",
					["A"] = "noop", -- also accepts the config.show_path and config.insert_as options.
					["d"] = "noop",
					["y"] = "noop",
					["x"] = "noop",
					["p"] = "noop",
					["c"] = "noop",
					["m"] = "noop",
					["a"] = "noop",
					["T"] = "noop",
					["<C-r>"] = "noop",
					["u"] = "noop",
					["U"] = "noop",
					["/"] = "filter",
					["f"] = "filter_on_submit",
				},
			},
			custom_kinds = {
				-- define custom kinds here (also remember to add icon and hl group to kinds)
				-- ccls
				-- [252] = 'TypeAlias',
				-- [253] = 'Parameter',
				-- [254] = 'StaticMethod',
				-- [255] = 'Macro',
			},
			kinds = {
				Unknown = { icon = "?", hl = "" },
				Root = { icon = "", hl = "NeoTreeRootName" },
				File = { icon = "󰈙", hl = "Tag" },
				Module = { icon = "", hl = "Exception" },
				Namespace = { icon = "󰌗", hl = "Include" },
				Package = { icon = "󰏖", hl = "Label" },
				Class = { icon = "󰌗", hl = "Include" },
				Method = { icon = "", hl = "Function" },
				Property = { icon = "󰆧", hl = "@property" },
				Field = { icon = "", hl = "@field" },
				Constructor = { icon = "", hl = "@constructor" },
				Enum = { icon = "󰒻", hl = "@number" },
				Interface = { icon = "", hl = "Type" },
				Function = { icon = "󰊕", hl = "Function" },
				Variable = { icon = "", hl = "@variable" },
				Constant = { icon = "", hl = "Constant" },
				String = { icon = "󰀬", hl = "String" },
				Number = { icon = "󰎠", hl = "Number" },
				Boolean = { icon = "", hl = "Boolean" },
				Array = { icon = "󰅪", hl = "Type" },
				Object = { icon = "󰅩", hl = "Type" },
				Key = { icon = "󰌋", hl = "" },
				Null = { icon = "", hl = "Constant" },
				EnumMember = { icon = "", hl = "Number" },
				Struct = { icon = "󰌗", hl = "Type" },
				Event = { icon = "", hl = "Constant" },
				Operator = { icon = "󰆕", hl = "Operator" },
				TypeParameter = { icon = "󰊄", hl = "Type" },

				-- ccls
				-- TypeAlias = { icon = ' ', hl = 'Type' },
				-- Parameter = { icon = ' ', hl = '@parameter' },
				-- StaticMethod = { icon = '󰠄 ', hl = 'Function' },
				-- Macro = { icon = ' ', hl = 'Macro' },
			},
		},
		example = {
			renderers = {
				custom = {
					{ "indent" },
					{ "icon", default = "C" },
					{ "custom" },
					{ "name" },
				},
			},
			window = {
				mappings = {
					["<cr>"] = "toggle_node",
					["<C-e>"] = "example_command",
					["d"] = "show_debug_info",
				},
			},
		},
	}
	setup_plugin("neo-tree", neotree_defaults)
end

local function setup_nvimtree()
	vim.g.loaded_netrw = 1
	vim.g.loaded_netrwPlugin = 1

	-- optionally enable 24-bit colour
	vim.opt.termguicolors = true

	-- empty setup using defaults
	require("nvim-tree").setup()

	-- OR setup with a config

	---@type nvim_tree.config
	local nvimtree_defaults = {
		sort = {
			sorter = "case_sensitive",
		},
		view = {
			width = 30,
		},
		renderer = {
			group_empty = true,
		},
		filters = {
			dotfiles = true,
		},
	}
	setup_plugin("nvim-tree", nvimtree_defaults)
end

setup_nvimtree()
setup_oil()
setup_neotree()
setup_nvimtree()

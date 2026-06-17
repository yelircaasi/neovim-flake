local selections = {}
local elements = {
	["octo"] = false,
	["octohub"] = false,
	["worktrees"] = false,
	["forgit"] = false,
	["official-gitlab"] = false,
	["gitlab"] = false,
	["gitsigns"] = false,
	["jj"] = false,
	["jujutsu"] = false,
	["jiejie"] = false,
	["lazygit"] = false,
	["git-conflict"] = false,
	["neogit"] = false,
	["vim-fugitive"] = false,
	["blame"] = false,
}

local function setup_octo()
	local octo_default_config = {
		picker = "telescope", -- or "fzf-lua" or "snacks" or "default"
		picker_config = {
			use_emojis = false, -- only used by "fzf-lua" picker for now
			search_static = true, -- Whether to use static search results (true) or dynamic search (false)
			mappings = { -- mappings for the pickers
				open_in_browser = { lhs = "<C-b>", desc = "open issue in browser" },
				copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
				copy_sha = { lhs = "<C-e>", desc = "copy commit SHA to system clipboard" },
				checkout_pr = { lhs = "<C-o>", desc = "checkout pull request" },
				merge_pr = { lhs = "<C-r>", desc = "merge pull request" },
			},
			snacks = { -- snacks specific config
				-- Initialize actions as empty arrays
				actions = { -- custom actions for specific snacks pickers (array of tables)
					issues = { -- actions for the issues picker
						-- { name = "my_issue_action", fn = function(picker, item) print("Issue action:", vim.inspect(item)) end, lhs = "<leader>a", desc = "My custom issue action" },
					},
					pull_requests = { -- actions for the pull requests picker
						-- { name = "my_pr_action", fn = function(picker, item) print("PR action:", vim.inspect(item)) end, lhs = "<leader>b", desc = "My custom PR action" },
					},
					notifications = {}, -- actions for the notifications picker
					issue_templates = {}, -- actions for the issue templates picker
					search = {}, -- actions for the search picker
					-- ... add actions for other pickers as needed
					changed_files = {},
					commits = {},
					review_commits = {},
				},
			},
		},
		default_remote = { "upstream", "origin" }, -- order to try remotes
		default_merge_method = "merge", -- default merge method which should be used for both `Octo pr merge` and merging from picker, could be `merge`, `rebase` or `squash`
		default_delete_branch = false, -- whether to delete branch when merging pull request with either `Octo pr merge` or from picker (can be overridden with `delete`/`nodelete` argument to `Octo pr merge`)
		ssh_aliases = {}, -- SSH aliases. e.g. `ssh_aliases = {["github.com-work"] = "github.com"}`. The key part will be interpreted as an anchored Lua pattern.
		reaction_viewer_hint_icon = " ", -- marker for user reactions
		commands = {}, -- additional subcommands made available to `Octo` command
		users = "search", -- Users for assignees or reviewers. Values: "search" | "mentionable" | "assignable"
		user_icon = " ", -- user icon
		ghost_icon = "󰊠 ", -- ghost icon
		copilot_icon = " ", -- copilot icon
		dependabot_icon = " ",
		comment_icon = "▎",
		outdated_icon = "󰅒 ",
		resolved_icon = " ",
		timeline_marker = " ",
		timeline_indent = 2,
		use_timeline_icons = true,
		timeline_icons = {
			auto_squash = "  ",
			blocking = "  ",
			commit_push = "  ",
			comment_deleted = "  ",
			duplicate = "  ",
			force_push = "  ",
			draft = "  ",
			ready = " ",
			commit = "  ",
			deployed = "  ",
			issue_type = "  ",
			label = "  ",
			reference = "  ",
			project = "  ",
			connected = "  ",
			subissue = "  ",
			cross_reference = "  ",
			transferred = "  ",
			parent_issue = "  ",
			head_ref = "  ",
			pinned = "  ",
			milestone = "  ",
			renamed = "  ",
			automatic_base_change_succeeded = "  ",
			base_ref_changed = "  ",
			merged = { "  ", "OctoPurple" },
			closed = {
				closed = { "  ", "OctoRed" },
				completed = { "  ", "OctoPurple" },
				not_planned = { "  ", "OctoWhite" },
				duplicate = { "  ", "OctoWhite" },
			},
			reopened = { "  ", "OctoGreen" },
			assigned = "  ",
			locked = "  ",
			review_requested = "  ",
		},
		right_bubble_delimiter = "", -- bubble delimiter
		left_bubble_delimiter = "", -- bubble delimiter
		github_hostname = "", -- GitHub Enterprise host
		use_local_fs = false, -- use local files on right side of reviews
		enable_builtin = false, -- shows a list of builtin actions when no action is provided
		snippet_context_lines = 4, -- number of lines around commented lines
		gh_cmd = "gh", -- Command to use when calling Github CLI
		gh_env = {}, -- extra environment variables to pass on to GitHub CLI, can be a table or function returning a table
		timeout = 5000, -- timeout for requests between the remote server
		default_to_projects_v2 = false, -- use projects v2 for the `Octo card ...` command by default. Both legacy and v2 commands are available under `Octo cardlegacy ...` and `Octo cardv2 ...` respectively.
		suppress_missing_scope = {
			projects_v2 = false,
		},
		ui = {
			use_signcolumn = false, -- show "modified" marks on the sign column
			use_statuscolumn = true, -- show "modified" marks on the status column
			use_foldtext = true,
		},
		issues = {
			order_by = { -- criteria to sort results of `Octo issue list`
				field = "CREATED_AT", -- either COMMENTS, CREATED_AT or UPDATED_AT (https://docs.github.com/en/graphql/reference/enums#issueorderfield)
				direction = "DESC", -- either DESC or ASC (https://docs.github.com/en/graphql/reference/enums#orderdirection)
			},
		},
		discussions = {
			order_by = {
				field = "CREATED_AT",
				direction = "DESC",
			},
		},
		notifications = {
			current_repo_only = false, -- show notifications for current repo only
		},
		reviews = {
			auto_show_threads = true, -- automatically show comment threads on cursor move
			focus = "right", -- focus right buffer on diff open
		},
		runs = {
			icons = {
				pending = "🕖",
				in_progress = "🔄",
				failed = "❌",
				succeeded = "",
				skipped = "⏩",
				cancelled = "✖",
			},
		},
		pull_requests = {
			order_by = { -- criteria to sort the results of `Octo pr list`
				field = "CREATED_AT", -- either COMMENTS, CREATED_AT or UPDATED_AT (https://docs.github.com/en/graphql/reference/enums#issueorderfield)
				direction = "DESC", -- either DESC or ASC (https://docs.github.com/en/graphql/reference/enums#orderdirection)
			},
			always_select_remote_on_create = false, -- always give prompt to select base remote repo when creating PRs
			use_branch_name_as_title = false, -- sets branch name to be the name for the PR
		},
		file_panel = {
			size = 10, -- changed files panel rows
			icons = true, -- true = nvim-web-devicons, false = disabled, function = custom provider
		},
		colors = { -- used for highlight groups (see Colors section below)
			white = "#ffffff",
			grey = "#2A354C",
			black = "#000000",
			red = "#fdb8c0",
			dark_red = "#da3633",
			green = "#acf2bd",
			dark_green = "#238636",
			yellow = "#d3c846",
			dark_yellow = "#735c0f",
			blue = "#58A6FF",
			dark_blue = "#0366d6",
			purple = "#6f42c1",
		},
		mappings_disable_default = false, -- disable default mappings if true, but will still adapt user mappings
		mappings = {
			discussion = {
				discussion_options = { lhs = "<CR>", desc = "show discussion options" },
				open_in_browser = { lhs = "<C-b>", desc = "open discussion in browser" },
				copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
				add_comment = { lhs = "<localleader>ca", desc = "add comment" },
				add_reply = { lhs = "<localleader>cr", desc = "add reply" },
				delete_comment = { lhs = "<localleader>cd", desc = "delete comment" },
				comment_edits = { lhs = "<localleader>ce", desc = "show comment edit history" },
				reference_in_new_issue = { lhs = "<localleader>ri", desc = "reference comment in new issue" },
				add_label = { lhs = "<localleader>la", desc = "add label" },
				remove_label = { lhs = "<localleader>ld", desc = "remove label" },
				next_comment = { lhs = "]c", desc = "go to next comment" },
				prev_comment = { lhs = "[c", desc = "go to previous comment" },
				react_hooray = { lhs = "<localleader>rp", desc = "add/remove 🎉 reaction" },
				react_heart = { lhs = "<localleader>rh", desc = "add/remove ❤️ reaction" },
				react_eyes = { lhs = "<localleader>re", desc = "add/remove 👀 reaction" },
				react_thumbs_up = { lhs = "<localleader>r+", desc = "add/remove 👍 reaction" },
				react_thumbs_down = { lhs = "<localleader>r-", desc = "add/remove 👎 reaction" },
				react_rocket = { lhs = "<localleader>rr", desc = "add/remove 🚀 reaction" },
				react_laugh = { lhs = "<localleader>rl", desc = "add/remove 😄 reaction" },
				react_confused = { lhs = "<localleader>rc", desc = "add/remove 😕 reaction" },
			},
			runs = {
				expand_step = { lhs = "o", desc = "expand workflow step" },
				next_step = { lhs = "]s", desc = "next workflow step" },
				prev_step = { lhs = "[s", desc = "previous workflow step" },
				next_job = { lhs = "]j", desc = "next workflow job" },
				prev_job = { lhs = "[j", desc = "previous workflow job" },
				open_in_browser = { lhs = "<C-b>", desc = "open workflow run in browser" },
				refresh = { lhs = "<C-r>", desc = "refresh workflow" },
				rerun = { lhs = "<C-o>", desc = "rerun workflow" },
				rerun_failed = { lhs = "<C-f>", desc = "rerun failed workflow" },
				cancel = { lhs = "<C-x>", desc = "cancel workflow" },
				copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
			},
			issue = {
				issue_options = { lhs = "<CR>", desc = "show issue options" },
				close_issue = { lhs = "<localleader>ic", desc = "close issue" },
				reopen_issue = { lhs = "<localleader>io", desc = "reopen issue" },
				list_issues = { lhs = "<localleader>il", desc = "list open issues on same repo" },
				reload = { lhs = "<C-r>", desc = "reload issue" },
				open_in_browser = { lhs = "<C-b>", desc = "open issue in browser" },
				copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
				add_assignee = { lhs = "<localleader>aa", desc = "add assignee" },
				remove_assignee = { lhs = "<localleader>ad", desc = "remove assignee" },
				create_label = { lhs = "<localleader>lc", desc = "create label" },
				add_label = { lhs = "<localleader>la", desc = "add label" },
				remove_label = { lhs = "<localleader>ld", desc = "remove label" },
				goto_issue = { lhs = "<localleader>gi", desc = "navigate to a local repo issue" },
				add_comment = { lhs = "<localleader>ca", desc = "add comment" },
				add_reply = { lhs = "<localleader>cr", desc = "add reply" },
				delete_comment = { lhs = "<localleader>cd", desc = "delete comment" },
				comment_edits = { lhs = "<localleader>ce", desc = "show comment edit history" },
				reference_in_new_issue = { lhs = "<localleader>ri", desc = "reference comment in new issue" },
				next_comment = { lhs = "]c", desc = "go to next comment" },
				prev_comment = { lhs = "[c", desc = "go to previous comment" },
				react_hooray = { lhs = "<localleader>rp", desc = "add/remove 🎉 reaction" },
				react_heart = { lhs = "<localleader>rh", desc = "add/remove ❤️ reaction" },
				react_eyes = { lhs = "<localleader>re", desc = "add/remove 👀 reaction" },
				react_thumbs_up = { lhs = "<localleader>r+", desc = "add/remove 👍 reaction" },
				react_thumbs_down = { lhs = "<localleader>r-", desc = "add/remove 👎 reaction" },
				react_rocket = { lhs = "<localleader>rr", desc = "add/remove 🚀 reaction" },
				react_laugh = { lhs = "<localleader>rl", desc = "add/remove 😄 reaction" },
				react_confused = { lhs = "<localleader>rc", desc = "add/remove 😕 reaction" },
			},
			pull_request = {
				pr_options = { lhs = "<CR>", desc = "show PR options" },
				checkout_pr = { lhs = "<localleader>po", desc = "checkout PR" },
				merge_pr = { lhs = "<localleader>pm", desc = "merge commit PR" },
				squash_and_merge_pr = { lhs = "<localleader>psm", desc = "squash and merge PR" },
				rebase_and_merge_pr = { lhs = "<localleader>prm", desc = "rebase and merge PR" },
				merge_pr_queue = {
					lhs = "<localleader>pq",
					desc = "merge commit PR and add to merge queue (Merge queue must be enabled in the repo)",
				},
				squash_and_merge_queue = {
					lhs = "<localleader>psq",
					desc = "squash and add to merge queue (Merge queue must be enabled in the repo)",
				},
				rebase_and_merge_queue = {
					lhs = "<localleader>prq",
					desc = "rebase and add to merge queue (Merge queue must be enabled in the repo)",
				},
				list_commits = { lhs = "<localleader>pc", desc = "list PR commits" },
				list_changed_files = { lhs = "<localleader>pf", desc = "list PR changed files" },
				show_pr_diff = { lhs = "<localleader>pd", desc = "show PR diff" },
				add_reviewer = { lhs = "<localleader>va", desc = "add reviewer" },
				remove_reviewer = { lhs = "<localleader>vd", desc = "remove reviewer request" },
				close_issue = { lhs = "<localleader>ic", desc = "close PR" },
				reopen_issue = { lhs = "<localleader>io", desc = "reopen PR" },
				list_issues = { lhs = "<localleader>il", desc = "list open issues on same repo" },
				reload = { lhs = "<C-r>", desc = "reload PR" },
				approve_pr = { lhs = "<leader>qa", desc = "approve PR" },
				open_in_browser = { lhs = "<C-b>", desc = "open PR in browser" },
				copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
				copy_sha = { lhs = "<C-e>", desc = "copy commit SHA to system clipboard" },
				goto_file = { lhs = "gf", desc = "go to file" },
				add_assignee = { lhs = "<localleader>aa", desc = "add assignee" },
				remove_assignee = { lhs = "<localleader>ad", desc = "remove assignee" },
				create_label = { lhs = "<localleader>lc", desc = "create label" },
				add_label = { lhs = "<localleader>la", desc = "add label" },
				remove_label = { lhs = "<localleader>ld", desc = "remove label" },
				goto_issue = { lhs = "<localleader>gi", desc = "navigate to a local repo issue" },
				add_comment = { lhs = "<localleader>ca", desc = "add comment" },
				add_reply = { lhs = "<localleader>cr", desc = "add reply" },
				delete_comment = { lhs = "<localleader>cd", desc = "delete comment" },
				comment_edits = { lhs = "<localleader>ce", desc = "show comment edit history" },
				reference_in_new_issue = { lhs = "<localleader>ri", desc = "reference comment in new issue" },
				next_comment = { lhs = "]c", desc = "go to next comment" },
				prev_comment = { lhs = "[c", desc = "go to previous comment" },
				react_hooray = { lhs = "<localleader>rp", desc = "add/remove 🎉 reaction" },
				react_heart = { lhs = "<localleader>rh", desc = "add/remove ❤️ reaction" },
				react_eyes = { lhs = "<localleader>re", desc = "add/remove 👀 reaction" },
				react_thumbs_up = { lhs = "<localleader>r+", desc = "add/remove 👍 reaction" },
				react_thumbs_down = { lhs = "<localleader>r-", desc = "add/remove 👎 reaction" },
				react_rocket = { lhs = "<localleader>rr", desc = "add/remove 🚀 reaction" },
				react_laugh = { lhs = "<localleader>rl", desc = "add/remove 😄 reaction" },
				react_confused = { lhs = "<localleader>rc", desc = "add/remove 😕 reaction" },
				review_start = { lhs = "<localleader>vs", desc = "start a review for the current PR" },
				review_resume = { lhs = "<localleader>vr", desc = "resume a pending review for the current PR" },
				resolve_thread = { lhs = "<localleader>rt", desc = "resolve PR thread" },
				unresolve_thread = { lhs = "<localleader>rT", desc = "unresolve PR thread" },
			},
			review_thread = {
				goto_issue = { lhs = "<localleader>gi", desc = "navigate to a local repo issue" },
				add_comment = { lhs = "<localleader>ca", desc = "add comment" },
				add_reply = { lhs = "<localleader>cr", desc = "add reply" },
				add_suggestion = { lhs = "<localleader>sa", desc = "add suggestion" },
				delete_comment = { lhs = "<localleader>cd", desc = "delete comment" },
				comment_edits = { lhs = "<localleader>ce", desc = "show comment edit history" },
				reference_in_new_issue = { lhs = "<localleader>ri", desc = "reference comment in new issue" },
				next_comment = { lhs = "]c", desc = "go to next comment" },
				prev_comment = { lhs = "[c", desc = "go to previous comment" },
				select_next_entry = { lhs = "]q", desc = "move to next changed file" },
				select_prev_entry = { lhs = "[q", desc = "move to previous changed file" },
				select_first_entry = { lhs = "[Q", desc = "move to first changed file" },
				select_last_entry = { lhs = "]Q", desc = "move to last changed file" },
				select_next_unviewed_entry = { lhs = "]u", desc = "move to next unviewed file" },
				select_prev_unviewed_entry = { lhs = "[u", desc = "move to previous unviewed file" },
				close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
				react_hooray = { lhs = "<localleader>rp", desc = "add/remove 🎉 reaction" },
				react_heart = { lhs = "<localleader>rh", desc = "add/remove ❤️ reaction" },
				react_eyes = { lhs = "<localleader>re", desc = "add/remove 👀 reaction" },
				react_thumbs_up = { lhs = "<localleader>r+", desc = "add/remove 👍 reaction" },
				react_thumbs_down = { lhs = "<localleader>r-", desc = "add/remove 👎 reaction" },
				react_rocket = { lhs = "<localleader>rr", desc = "add/remove 🚀 reaction" },
				react_laugh = { lhs = "<localleader>rl", desc = "add/remove 😄 reaction" },
				react_confused = { lhs = "<localleader>rc", desc = "add/remove 😕 reaction" },
				resolve_thread = { lhs = "<localleader>rt", desc = "resolve PR thread" },
				unresolve_thread = { lhs = "<localleader>rT", desc = "unresolve PR thread" },
			},
			submit_win = {
				approve_review = { lhs = "<C-a>", desc = "approve review", mode = { "n" } },
				comment_review = { lhs = "<C-m>", desc = "comment review", mode = { "n" } },
				request_changes = { lhs = "<C-r>", desc = "request changes review", mode = { "n" } },
				close_review_tab = { lhs = "<C-c>", desc = "close review tab", mode = { "n" } },
			},
			review_diff = {
				submit_review = { lhs = "<localleader>vs", desc = "submit review" },
				discard_review = { lhs = "<localleader>vd", desc = "discard review" },
				add_review_comment = { lhs = "<localleader>ca", desc = "add a new review comment", mode = { "n", "x" } },
				add_review_suggestion = {
					lhs = "<localleader>sa",
					desc = "add a new review suggestion",
					mode = { "n", "x" },
				},
				focus_files = { lhs = "<localleader>e", desc = "move focus to changed file panel" },
				toggle_files = { lhs = "<localleader>b", desc = "hide/show changed files panel" },
				next_thread = { lhs = "]t", desc = "move to next thread" },
				prev_thread = { lhs = "[t", desc = "move to previous thread" },
				select_next_entry = { lhs = "]q", desc = "move to next changed file" },
				select_prev_entry = { lhs = "[q", desc = "move to previous changed file" },
				select_first_entry = { lhs = "[Q", desc = "move to first changed file" },
				select_last_entry = { lhs = "]Q", desc = "move to last changed file" },
				select_next_unviewed_entry = { lhs = "]u", desc = "move to next unviewed file" },
				select_prev_unviewed_entry = { lhs = "[u", desc = "move to previous unviewed file" },
				close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
				toggle_viewed = { lhs = "<localleader><space>", desc = "toggle viewer viewed state" },
				goto_file = { lhs = "gf", desc = "go to file" },
				copy_sha = { lhs = "<C-e>", desc = "copy commit SHA to system clipboard" },
				review_commits = { lhs = "<localleader>C", desc = "review PR commits" },
			},
			file_panel = {
				submit_review = { lhs = "<localleader>vs", desc = "submit review" },
				discard_review = { lhs = "<localleader>vd", desc = "discard review" },
				next_entry = { lhs = "j", desc = "move to next changed file" },
				prev_entry = { lhs = "k", desc = "move to previous changed file" },
				select_entry = { lhs = "<cr>", desc = "show selected changed file diffs" },
				refresh_files = { lhs = "R", desc = "refresh changed files panel" },
				focus_files = { lhs = "<localleader>e", desc = "move focus to changed file panel" },
				toggle_files = { lhs = "<localleader>b", desc = "hide/show changed files panel" },
				select_next_entry = { lhs = "]q", desc = "move to next changed file" },
				select_prev_entry = { lhs = "[q", desc = "move to previous changed file" },
				select_first_entry = { lhs = "[Q", desc = "move to first changed file" },
				select_last_entry = { lhs = "]Q", desc = "move to last changed file" },
				select_next_unviewed_entry = { lhs = "]u", desc = "move to next unviewed file" },
				select_prev_unviewed_entry = { lhs = "[u", desc = "move to previous unviewed file" },
				close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
				toggle_viewed = { lhs = "<localleader><space>", desc = "toggle viewer viewed state" },
				review_commits = { lhs = "<localleader>C", desc = "review PR commits" },
			},
			notification = {
				read = { lhs = "<localleader>nr", desc = "mark notification as read" },
				done = { lhs = "<localleader>nd", desc = "mark notification as done" },
				unsubscribe = { lhs = "<localleader>nu", desc = "unsubscribe from notifications" },
			},
			repo = {
				repo_options = { lhs = "<CR>", desc = "show repo options" },
				create_issue = { lhs = "<localleader>ic", desc = "create issue" },
				create_discussion = { lhs = "<localleader>dc", desc = "create discussion" },
				contributing_guidelines = { lhs = "<localleader>cg", desc = "view contributing guidelines" },
				open_in_browser = { lhs = "<C-b>", desc = "open repo in browser" },
			},
			release = {
				open_in_browser = { lhs = "<C-b>", desc = "open release in browser" },
			},
		},
		poll = {
			enabled = false, -- opt-in polling for remote changes
			interval = 10000, -- polling interval in milliseconds (default: 10s)
			notify_on_refresh = true, -- notify when a buffer is auto-refreshed
			notify_on_change = true, -- notify when remote changed but buffer has local edits
		},
		search = {
			completion_overrides = {}, -- key is a qualifier, value is an array table or a function returning a table
		},
		debug = {
			notify_missing_timeline_items = false,
		},
	}
	setup_plugin("octo")
end

local function setup_octohub()
	-- TODO: install gh
	-- https://github.com/2kabhishek/octohub.nvim
	-- All Your GitHub repos and more in Neovim
	local octohub_defaults = {
		icons = { -- List of icons used by Octohub
			user = " ",
			star = " ", -- for more, check out config.lua
			contribution_icons = { "", "", "", "", "", "", "" }, -- Icons for different contribution levels
		},
		repos = {
			per_user_dir = true, -- Create a directory for each user
			projects_dir = "~/Projects/", -- Directory where repositories are cloned
			sort_by = "", -- Sort repositories by various parameters
			repo_type = "", -- Type of repositories to display
			language = "", -- Repositories language filter
		},
		stats = {
			max_contributions = 50, -- Max number of contributions per day to use for icon selection
			top_lang_count = 5, -- Number of top languages to display in stats
			event_count = 5, -- Number of activity events to show
			window_width = 90, -- Width in percentage of the window to display stats
			window_height = 60, -- Height in percentage of the window to display stats
			show_recent_activity = true, -- Show recent activity in the stats window
			show_contributions = true, -- Show contributions in the stats window
			show_repo_stats = true, -- Show repository stats in the stats window
		},
		cache = {
			events = 3600 * 6, -- Time in seconds to cache activity events
			contributions = 3600 * 6, -- Time in seconds to cache contributions data
			repos = 3600 * 24 * 7, -- Time in seconds to cache repositories
			username = 3600 * 24 * 7, -- Time in seconds to cache username
			user = 3600 * 24 * 7, -- Time in seconds to cache user data
		},
		add_default_keybindings = true, -- Add default keybindings for the plugin
	}
	setup_plugin("octohub", octohub_defaults)
end

local function setup_worktrees()
	-- TODO: review examples in README
	-- https://github.com/Juksuu/worktrees.nvim
	-- Git worktree wrapper for neovim
	local worktrees_config = {
		log_level = vim.log.levels.WARN,
		log_status = true,
		worktree_path = "..",
		switch_file_command = "Ex",
		hooks = {
			on_add = function(name, path, branch)
				-- your action here
			end,
			on_before_switch = function(from, to, git_path_info)
				-- your action here
			end,
			on_switch = function(from, to, git_path_info)
				-- your action here
			end,
			on_remove = function(name)
				-- your action here
			end,
		},
	}
	setup_plugin("worktrees", worktrees_defaults)
end

local function setup_forgit()
	-- TODO: install delta, guihua
	-- https://github.com/ray-x/forgit.nvim
	-- Interactive fzf+git for Neovim. I remembered the git commands so you wont forget.
	local forgit_defaults = {
		debug = false, -- enable debug logging default path is ~/.cache/nvim/forgit.log
		diff_pager = "delta", -- you can use `diff`, `diff-so-fancy`
		diff_cmd = "DiffviewOpen", -- you can use `DiffviewOpen`, `Gvdiffsplit` or `!git diff`, auto if not set
		fugitive = false, -- git fugitive installed?
		gitsigns = true, -- integrate with gitsigns.nvim
		flog = false, -- integrate with gitsigns.nvim
		git_fuzzy = false, -- integrate with git-fuzzy
		abbreviate = false, -- abvreviate some of the commands e.g. gps -> git push
		git_alias = true, -- git command extensions see: Git command alias
		show_result = "quickfix", -- show cmd result in quickfix or notify

		shell_mode = true, -- set to true if you using zsh/bash and can not run forgit commands
		height_ratio = 0.7, -- height ratio of floating window when split horizontally
		width_ratio = 0.8, -- width ratio of floating window when split vertically
		cmds_list = {}, -- additional commands to show in Forgit command list
		--  e.g. cmd_list = {text = 'Gs get_hunks', cmd = 'Gitsigns get_hunks'}
	}
	setup_plugin("forgit", forgit_defaults)
end

local function setup_official_gitlab()
	local official_gitlab_config = {
		statusline = {
			enabled = false,
		},
		minimal_message_level = vim.log.levels.ERROR,
		code_suggestions = {
			-- For the full list of default languages, see the 'auto_filetypes' array in
			-- https://gitlab.com/gitlab-org/editor-extensions/gitlab.vim/-/blob/main/lua/gitlab/config/defaults.lua
			auto_filetypes = { "ruby", "javascript" }, -- Default is { 'ruby' }
			ghost_text = {
				enabled = false, -- ghost text is an experimental feature
				toggle_enabled = "<C-h>",
				accept_suggestion = "<C-l>",
				clear_suggestions = "<C-k>",
				stream = true,
			},
		},
	}

	local include_gitlab = true

	utils.packadd("gitlab-nvim") -- https://docs.gitlab.com/editor_extensions/neovim/
	setup_plugin("gitlab", function(gitlab)
		gitlab.setup(official_gitlab_config)
		map_explicit({
			mode = "n",
			sequence = "<C-g>",
			action = "<Plug>(GitLabToggleCodeSuggestions)",
		})
	end)

	setup_gitlab_nvim()
end

local function setup_gitlab()
	setup_plugin("gitlab", { -- https://github.com/harrisoncramer/gitlab.nvim
		-- auth_provider = function()
		-- 	return "my_token", "https://custom.gitlab.instance.url", nil
		-- end,
	})
end

local function setup_gitsigns()
	setup_plugin("gitsigns", function(gitsigns)
		gitsigns.setup({
			signs = {
				add = { text = "┃" },
				change = { text = "┃" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
			signs_staged = {
				add = { text = "┃" },
				change = { text = "┃" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
			signs_staged_enable = true,
			signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
			numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
			linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
			word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
			watch_gitdir = {
				follow_files = true,
			},
			auto_attach = true,
			attach_to_untracked = false,
			current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
				delay = 1000,
				ignore_whitespace = false,
				virt_text_priority = 100,
				use_focus = true,
			},
			current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
			blame_formatter = nil, -- Use default
			sign_priority = 6,
			update_debounce = 100,
			status_formatter = nil, -- Use default
			max_file_length = 40000, -- Disable if file is longer than this (in lines)
			preview_config = {
				-- Options passed to nvim_open_win
				style = "minimal",
				relative = "cursor",
				row = 0,
				col = 1,
			},
		})
		vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
			callback = function()
				gitsigns.setup({})
			end,
		})
	end)
end

local function setup_jj()
	local jj_default_config = {
		-- Setup snacks as a picker
		picker = {
			-- Here you can pass the options as you would for snacks.
			-- It will be used when using the picker
			snacks = {},
		},

		-- Configure editor behavior for describe/commit buffers
		editor = {
			-- When true, automatically enter insert mode only if the description is empty.
			-- If a description already exists, stay in normal mode.
			auto_insert = false,

			-- Configure the describe/commit editor buffer window
			window = {
				type = "hsplit", -- Type of window (hsplit/vsplit/floating/tab)
				split_size = 0.5, -- Size % of split (height for hsplit, width for vsplit)
				floating_width = 0.99, -- Width % for floating window (0.1 to 1.0)
				floating_height = 0.95, -- Height % for floating window (0.1 to 1.0)
			},
		},

		-- Customize syntax highlighting colors for the describe buffer
		-- Note: added, modified, deleted use Neovim's built-in highlight groups (Added, Changed, Removed)
		-- Only renamed has a custom default since Neovim doesn't have a built-in group for it
		highlights = {
			editor = {
				-- added = { fg = "#3fb950", ctermfg = "Green" },   -- Optional: override Added highlight
				-- modified = { fg = "#56d4dd", ctermfg = "Cyan" }, -- Optional: override Changed highlight
				-- deleted = { fg = "#f85149", ctermfg = "Red" },   -- Optional: override Removed highlight
				renamed = { fg = "#d29922", ctermfg = "Yellow" }, -- Renamed files (custom default)
			},
			log = {
				selected = { bg = "#3d2c52", ctermbg = "DarkMagenta" },
				targeted = { fg = "#5a9e6f", ctermfg = "Green" },
			},
		},

		-- Configure terminal behavior
		terminal = {
			-- Cursor render delay in milliseconds (default: 10)
			-- If cursor column is being reset to 0 when refreshing commands, try increasing this value
			-- This delay allows the terminal emulator to complete rendering before restoring cursor position
			cursor_render_delay = 10,

			-- Configure terminal window
			window = {
				type = "hsplit", -- Type of window the terminal is displayed in (hsplit/vsplit/floating/tab)
				split_size = 0.5, -- Size % of the split window, either height (hsplit) or width (vsplit) (between 0.1 and 1.0)
				floating_width = 0.99, -- Width % of the floating window (between 0.1 and 1.0)
				floating_height = 0.95, -- Height % of the floating window (between 0.1 and 1.0)
			},
		},

		-- Configure diff module
		diff = {
			-- Default backend for viewing diffs
			-- "native" - Built-in split diff using Neovim's diff mode (default)
			-- "diffview" - Use diffview.nvim plugin (requires diffview.nvim)
			-- "codediff" - Use codediff.nvim plugin (requires codediff.nvim)
			-- Or any custom backend name you've registered
			backend = "native",
		},

		-- Configure cmd module (describe editor, keymaps)
		cmd = {
			-- Configure describe editor
			describe = {
				editor = {
					-- Choose the editor mode for describe command
					-- "buffer" - Opens a Git-style commit message buffer with syntax highlighting (default)
					-- "input" - Uses a simple vim.ui.input prompt
					type = "buffer",
					-- Customize keymaps for the describe editor buffer
					keymaps = {
						close = { "<C-c>", "q" }, -- Keys to close editor without saving
					},
				},
			},

			-- Configure log command behavior
			log = {
				close_on_edit = false, -- Close log buffer after editing a change
			},

			-- Configure bookmark command
			bookmark = {
				prefix = "",
			},

			-- Configure keymaps for command buffers
			keymaps = {
				-- Log buffer keymaps (set to nil to disable)
				log = {
					edit = "<CR>", -- Edit revision under cursor
					edit_immutable = "<S-CR>", -- Edit revision (ignore immutability)
					describe = "d", -- Describe revision under cursor
					diff = "<S-d>", -- Diff revision under cursor
					edit = "e", -- Edit revision under cursor
					new = "n", -- Create new change branching off
					new_after = "<C-n>", -- Create new change after revision
					new_after_immutable = "<S-n>", -- Create new change after (ignore immutability)
					undo = "<S-u>", -- Undo last operation
					redo = "<S-r>", -- Redo last undone operation
					abandon = "a", -- Abandon revision under cursor
					bookmark = "b", -- Create or move bookmark to revision under cursor
					bookmark_del = "B", -- Delete bookmark of revision under cursor
					fetch = "f", -- Fetch from remote
					push = "p", -- Push bookmark of revision under cursor
					push_all = "<S-p>", -- Push all changes to remote
					open_pr = "o", -- Open PR/MR for revision under cursor
					open_pr_list = "<S-o>", -- Open PR/MR by selecting from all bookmarks
					rebase = "r", -- Enter rebase mode targeting revision under cursor or selected revisions
					rebase_mode = {
						onto = { "<CR>", "o" }, -- Select revision under cursor as rebase onto destination
						after = "a", -- Rebase after revision under cursor
						before = "b", -- Rebase before revision under cursor
						onto_immutable = { "<S-CR>", "<S-o>" }, -- Select revision  as a rebase onto destination (ignore immutability)
						after_immutable = "<S-a>", -- Rebase after revision under cursor (ignore immutability)
						before_immutable = "<S-b>", -- Rebase before revision under cursor (ignore immutability)
						exit_mode = { "<Esc>", "<C-c>" }, -- Exit rebase mode
					},
					duplicate = "<C-y>", -- Enter duplicate mode targeting revision under cursor or selected revisions
					duplicate_mode = {
						onto = { "<CR>", "o" }, -- Select revision under cursor as duplicate onto destination
						after = "a", -- Duplicate after revision under cursor
						before = "b", -- Duplicate before revision under cursor
						onto_immutable = { "<S-CR>", "<S-o>" }, -- Duplicate onto revision under cursor (ignore immutability)
						after_immutable = "<S-a>", -- Duplicate after revision under cursor (ignore immutability)
						before_immutable = "<S-b>", -- Duplicate before revision under cursor (ignore immutability)
						exit_mode = { "<Esc>", "<C-c>" }, -- Exit duplicate mode
					},
					squash = "s", -- Enter squash mode targeting revision under cursor or selected revisions
					squash_mode = {
						into = "<CR>", -- Squash into revision under cursor
						into_immutable = "<S-CR>", -- Squash into revision under cursor (ignore immutability)
						exit_mode = { "<Esc>", "<C-c>" }, -- Exit squash mode
					},
					quick_squash = "<S-s>", -- Quick squash revision under cursor into its parent (ignore immutability)
					split = "<C-s>", -- Split the revision under cursor
					history = "<S-h>", -- Show a history-aware diff for the selected revision range
					change_revset = "<C-r>", -- Change the revset(s) being viewed in the log buffer
					tag_set = "<S-t>", -- Create a tag on the revision under cursor
					summary = "<S-k>", -- Show summary tooltip for revision under cursor
					select_next_revision = "gj", -- Move cursor to the next revision in the log
					select_prev_revision = "gk", -- Move cursor to the previous revision in the log
					summary_tooltip = {
						diff = "<S-d>", -- Diff file at this revision
						edit = "<CR>", -- Edit revision and open file
						edit_immutable = "<S-CR>", -- Edit revision (ignore immutability) and open file
						edit_file = "o", -- Open the file under cursor in a new tab like `:Jtabedit` would
					},
				},
				-- Status buffer keymaps (set to nil to disable)
				status = {
					open_file = "<CR>", -- Open file under cursor
					restore_file = "<S-x>", -- Restore file under cursor
				},
				-- Close keymaps (shared across all buffers)
				close = { "q", "<Esc>" },
				-- Floating buffer keymaps
				floating = {
					close = "q", -- Close floating buffer
					hide = "<Esc>", -- Hide floating buffer
				},
			},
		},
	}
	setup_plugin("jj", jj_default_config)
end

local function setup_jujutsu()
	local jujutsu_default_config = {
		-- Diff viewer: "difftastic", "diffview", "codediff", none"
		diff_preset = "difftastic", -- default

		-- Help window position: "center", "bottom_right"
		help_position = "center", -- default
	}
	setup_plugin("jujutsu-nvim", jujutsu_default_config)
end

local function setup_jiejie()
	local jiejie_default_config = {
		-- Excluded revset expression, see https://docs.jj-vcs.dev/latest/revsets/ for the full language
		excluded_revset = 'bookmarks(glob:"renovate/*") | tracked_remote_bookmarks(glob:"renovate/*") | untracked_remote_bookmarks(glob:"renovate/*")',
		default_view = 1,
		dynamic_views = {
			-- Dynamic view that dispalys all merges, see https://docs.jj-vcs.dev/latest/revsets/ for the full language
			{ revset = "merges()" },
		},
		log_revisions = 10,
	}
	setup_plugin("jiejie", jiejie_default_config)
end

local function setup_lazygit()
	setup_plugin("lazygit", function(lazygit)
		vim.g.lazygit_floating_window_winblend = 0 -- transparency of floating window
		vim.g.lazygit_floating_window_scaling_factor = 0.9 -- scaling factor for floating window
		vim.g.lazygit_floating_window_border_chars = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" } -- customize lazygit popup window border characters
		vim.g.lazygit_floating_window_use_plenary = 0 -- use plenary.nvim to manage floating window if available
		vim.g.lazygit_use_neovim_remote = 1 -- fallback to 0 if neovim-remote is not installed

		vim.g.lazygit_use_custom_config_file_path = 0 -- config file path is evaluated if this value is 1
		vim.g.lazygit_config_file_path = "" -- custom config file path
		-- OR
		vim.g.lazygit_config_file_path = {} -- table of custom config file paths

		vim.g.lazygit_on_exit_callback = nil -- optional function callback when exiting lazygit (useful for example to refresh some UI elements after lazy git has made some changes)
	end)
end

local function setup_git_conflict()
	setup_plugin("git-conflict", {
		default_mappings = true, -- disable buffer local mapping created by this plugin
		default_commands = true, -- disable commands created by this plugin
		disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
		list_opener = "copen", -- command or function to open the conflicts list
		highlights = { -- They must have background color, otherwise the default color will be used
			incoming = "DiffAdd",
			current = "DiffText",
		},
	})
end

local function setup_neogit()
	local neogit_default_config = {
		-- Use Treesitter to apply syntax highlighting to diff hunks
		treesitter_diff_highlight = true,
		-- Apply word-diff highlights to diff hunks
		word_diff_highlight = true,
		-- Hides the hints at the top of the status buffer
		disable_hint = false,
		-- Disables changing the buffer highlights based on where the cursor is.
		disable_context_highlighting = false,
		-- Disables signs for sections/items/hunks
		disable_signs = false,
		-- Path to git executable. Defaults to "git". Can be used to specify a custom git binary or wrapper script.
		git_executable = "git",
		-- Offer to force push when branches diverge
		prompt_force_push = true,
		-- Request confirmation when amending already published commits
		prompt_amend_commit = true,
		-- Changes what mode the Commit Editor starts in. `true` will leave nvim in normal mode, `false` will change nvim to
		-- insert mode, and `"auto"` will change nvim to insert mode IF the commit message is empty, otherwise leaving it in
		-- normal mode.
		disable_insert_on_commit = "auto",
		-- When enabled, will watch the `.git/` directory for changes and refresh the status buffer in response to filesystem
		-- events.
		filewatcher = {
			interval = 1000,
			enabled = true,
		},
		-- "ascii"   is the graph the git CLI generates
		-- "unicode" is the graph like https://github.com/rbong/vim-flog
		-- "kitty"   is the graph like https://github.com/isakbm/gitgraph.nvim - use https://github.com/rbong/flog-symbols if you don't use Kitty
		graph_style = "ascii",
		-- Show relative date by default. When set, use `strftime` to display dates
		commit_date_format = nil,
		log_date_format = nil,
		-- When set, used to format the diff. Requires *baleia* to colorize text with ANSI escape sequences. An example for `Delta` is `{ 'delta', '--width', '117' }`. For `Delta`, hyperlinks must be disabled when called by `neogit`, for text to be colorized properly.
		log_pager = nil,
		-- Show message with spinning animation when a git command is running.
		process_spinner = false,
		-- Used to generate URL's for branch popup action "pull request", "open commit" and "open tree"
		git_services = {
			["github.com"] = {
				pull_request = "https://github.com/${owner}/${repository}/compare/${branch_name}?expand=1",
				commit = "https://github.com/${owner}/${repository}/commit/${oid}",
				tree = "https://${host}/${owner}/${repository}/tree/${branch_name}",
			},
			["bitbucket.org"] = {
				pull_request = "https://bitbucket.org/${owner}/${repository}/pull-requests/new?source=${branch_name}&t=1",
				commit = "https://bitbucket.org/${owner}/${repository}/commits/${oid}",
				tree = "https://bitbucket.org/${owner}/${repository}/branch/${branch_name}",
			},
			["gitlab.com"] = {
				pull_request = "https://gitlab.com/${owner}/${repository}/merge_requests/new?merge_request[source_branch]=${branch_name}",
				commit = "https://gitlab.com/${owner}/${repository}/-/commit/${oid}",
				tree = "https://gitlab.com/${owner}/${repository}/-/tree/${branch_name}?ref_type=heads",
			},
			["azure.com"] = {
				pull_request = "https://dev.azure.com/${owner}/_git/${repository}/pullrequestcreate?sourceRef=${branch_name}&targetRef=${target}",
				commit = "",
				tree = "",
			},
			["codeberg.org"] = {
				pull_request = "https://${host}/${owner}/${repository}/compare/${branch_name}",
				commit = "https://${host}/${owner}/${repository}/commit/${oid}",
				tree = "https://${host}/${owner}/${repository}/src/branch/${branch_name}",
			},
		},
		-- Allows a different telescope sorter. Defaults to 'fuzzy_with_index_bias'. The example below will use the native fzf
		-- sorter instead. By default, this function returns `nil`.
		telescope_sorter = function()
			return require("telescope").extensions.fzf.native_fzf_sorter()
		end,
		-- Persist the values of switches/options within and across sessions
		remember_settings = true,
		-- Scope persisted settings on a per-project basis
		use_per_project_settings = true,
		-- Table of settings to never persist. Uses format "Filetype--cli-value"
		ignored_settings = {},
		-- Configure highlight group features
		highlight = {
			italic = true,
			bold = true,
			underline = true,
		},
		-- Set to false if you want to be responsible for creating _ALL_ keymappings
		use_default_keymaps = true,
		-- Neogit refreshes its internal state after specific events, which can be expensive depending on the repository size.
		-- Disabling `auto_refresh` will make it so you have to manually refresh the status after you open it.
		auto_refresh = true,
		-- Value used for `--sort` option for `git branch` command
		-- By default, branches will be sorted by commit date descending
		-- Flag description: https://git-scm.com/docs/git-branch#Documentation/git-branch.txt---sortltkeygt
		-- Sorting keys: https://git-scm.com/docs/git-for-each-ref#_options
		sort_branches = "-committerdate",
		-- Value passed to the `--<commit_order>-order` flag of the `git log` command
		-- Determines how commits are traversed and displayed in the log / graph:
		--   "topo"         topological order (parents always before children, good for graphs, slower on large repos)
		--   "date"         chronological order by commit date
		--   "author-date"  chronological order by author date
		--   ""             disable explicit ordering (fastest, recommended for very large repos)
		commit_order = "topo",
		-- Default for new branch name prompts
		initial_branch_name = "",
		-- Default for rename branch prompt. If not set, the current branch name is used
		initial_branch_rename = nil,
		-- Change the default way of opening neogit
		kind = "tab",
		-- Floating window style
		floating = {
			relative = "editor",
			width = 0.8,
			height = 0.7,
			style = "minimal",
			border = "rounded",
		},
		-- Disable line numbers
		disable_line_numbers = true,
		-- Disable relative line numbers
		disable_relative_line_numbers = true,
		-- The time after which an output console is shown for slow running commands
		console_timeout = 2000,
		-- Automatically show console if a command takes more than console_timeout milliseconds
		auto_show_console = true,
		-- Automatically close the console if the process exits with a 0 (success) status
		auto_close_console = true,
		notification_icon = "󰊢",
		status = {
			show_head_commit_hash = true,
			recent_commit_count = 10,
			HEAD_padding = 10,
			HEAD_folded = false,
			mode_padding = 3,
			mode_text = {
				M = "modified",
				N = "new file",
				A = "added",
				D = "deleted",
				C = "copied",
				U = "updated",
				R = "renamed",
				T = "changed",
				DD = "unmerged",
				AU = "unmerged",
				UD = "unmerged",
				UA = "unmerged",
				DU = "unmerged",
				AA = "unmerged",
				UU = "unmerged",
				["?"] = "",
			},
		},
		commit_editor = {
			kind = "tab",
			show_staged_diff = true,
			-- Accepted values:
			-- "split" to show the staged diff below the commit editor
			-- "vsplit" to show it to the right
			-- "split_above" Like :top split
			-- "vsplit_left" like :vsplit, but open to the left
			-- "auto" "vsplit" if window would have 80 cols, otherwise "split"
			staged_diff_split_kind = "split",
			spell_check = true,
		},
		commit_select_view = {
			kind = "tab",
		},
		commit_view = {
			kind = "vsplit",
			verify_commit = vim.fn.executable("gpg") == 1, -- Can be set to true or false, otherwise we try to find the binary
		},
		log_view = {
			kind = "tab",
		},
		rebase_editor = {
			kind = "auto",
		},
		reflog_view = {
			kind = "tab",
		},
		merge_editor = {
			kind = "auto",
		},
		preview_buffer = {
			kind = "floating_console",
		},
		popup = {
			kind = "split",
			show_title = false,
		},
		stash = {
			kind = "tab",
		},
		refs_view = {
			kind = "tab",
		},
		signs = {
			-- { CLOSED, OPENED }
			hunk = { "", "" },
			item = { ">", "v" },
			section = { ">", "v" },
		},
		-- Each Integration is auto-detected through plugin presence, however, it can be disabled by setting to `false`
		integrations = {
			-- If enabled, use telescope for menu selection rather than vim.ui.select.
			-- Allows multi-select and some things that vim.ui.select doesn't.
			telescope = nil,
			-- Neogit only provides inline diffs. If you want a more traditional way to look at diffs, you can use `diffview`.
			-- The diffview integration enables the diff popup.
			--
			-- Requires you to have `sindrets/diffview.nvim` installed.
			diffview = nil,

			-- Alternative diff viewer integration.
			-- Requires you to have `esmuellert/codediff.nvim` installed.
			codediff = nil,

			-- If enabled, uses fzf-lua for menu selection. If the telescope integration
			-- is also selected then telescope is used instead
			-- Requires you to have `ibhagwan/fzf-lua` installed.
			fzf_lua = nil,

			-- If enabled, uses mini.pick for menu selection. If the telescope integration
			-- is also selected then telescope is used instead
			-- Requires you to have `echasnovski/mini.pick` installed.
			mini_pick = nil,

			-- If enabled, uses snacks.picker for menu selection. If the telescope integration
			-- is also selected then telescope is used instead
			-- Requires you to have `folke/snacks.nvim` installed.
			snacks = nil,
		},
		-- Which diff viewer to use. nil = auto-detect (tries diffview first, then codediff).
		-- Can be "diffview" or "codediff".
		diff_viewer = nil,
		sections = {
			-- Reverting/Cherry Picking
			sequencer = {
				folded = false,
				hidden = false,
			},
			untracked = {
				folded = false,
				hidden = false,
			},
			unstaged = {
				folded = false,
				hidden = false,
			},
			staged = {
				folded = false,
				hidden = false,
			},
			stashes = {
				folded = true,
				hidden = false,
			},
			unpulled_upstream = {
				folded = true,
				hidden = false,
			},
			unmerged_upstream = {
				folded = false,
				hidden = false,
			},
			unpulled_pushRemote = {
				folded = true,
				hidden = false,
			},
			unmerged_pushRemote = {
				folded = false,
				hidden = false,
			},
			recent = {
				folded = true,
				hidden = false,
			},
			rebase = {
				folded = true,
				hidden = false,
			},
		},
		mappings = {
			commit_editor = {
				["q"] = "Close",
				["<c-c><c-c>"] = "Submit",
				["<c-c><c-k>"] = "Abort",
				["<m-p>"] = "PrevMessage",
				["<m-n>"] = "NextMessage",
				["<m-r>"] = "ResetMessage",
			},
			commit_editor_I = {
				["<c-c><c-c>"] = "Submit",
				["<c-c><c-k>"] = "Abort",
			},
			rebase_editor = {
				["p"] = "Pick",
				["r"] = "Reword",
				["e"] = "Edit",
				["s"] = "Squash",
				["f"] = "Fixup",
				["x"] = "Execute",
				["d"] = "Drop",
				["b"] = "Break",
				["q"] = "Close",
				["<cr>"] = "OpenCommit",
				["gk"] = "MoveUp",
				["gj"] = "MoveDown",
				["<c-c><c-c>"] = "Submit",
				["<c-c><c-k>"] = "Abort",
				["[c"] = "OpenOrScrollUp",
				["]c"] = "OpenOrScrollDown",
			},
			rebase_editor_I = {
				["<c-c><c-c>"] = "Submit",
				["<c-c><c-k>"] = "Abort",
			},
			finder = {
				["<cr>"] = "Select",
				["<c-c>"] = "Close",
				["<esc>"] = "Close",
				["<c-n>"] = "Next",
				["<c-p>"] = "Previous",
				["<down>"] = "Next",
				["<up>"] = "Previous",
				["<tab>"] = "InsertCompletion",
				["<c-y>"] = "CopySelection",
				["<space>"] = "MultiselectToggleNext",
				["<s-space>"] = "MultiselectTogglePrevious",
				["<c-j>"] = "NOP",
				["<ScrollWheelDown>"] = "ScrollWheelDown",
				["<ScrollWheelUp>"] = "ScrollWheelUp",
				["<ScrollWheelLeft>"] = "NOP",
				["<ScrollWheelRight>"] = "NOP",
				["<LeftMouse>"] = "MouseClick",
				["<2-LeftMouse>"] = "NOP",
			},
			-- Setting any of these to `false` will disable the mapping.
			popup = {
				["?"] = "HelpPopup",
				["A"] = "CherryPickPopup",
				["d"] = "DiffPopup",
				["M"] = "RemotePopup",
				["P"] = "PushPopup",
				["X"] = "ResetPopup",
				["Z"] = "StashPopup",
				["i"] = "IgnorePopup",
				["t"] = "TagPopup",
				["b"] = "BranchPopup",
				["B"] = "BisectPopup",
				["w"] = "WorktreePopup",
				["c"] = "CommitPopup",
				["f"] = "FetchPopup",
				["l"] = "LogPopup",
				["m"] = "MergePopup",
				["p"] = "PullPopup",
				["r"] = "RebasePopup",
				["v"] = "RevertPopup",
			},
			status = {
				["j"] = "MoveDown",
				["k"] = "MoveUp",
				["o"] = "OpenTree",
				["q"] = "Close",
				["I"] = "InitRepo",
				["1"] = "Depth1",
				["2"] = "Depth2",
				["3"] = "Depth3",
				["4"] = "Depth4",
				["Q"] = "Command",
				["<tab>"] = "Toggle",
				["za"] = "Toggle",
				["zo"] = "OpenFold",
				["x"] = "Discard",
				["s"] = "Stage",
				["S"] = "StageUnstaged",
				["<c-s>"] = "StageAll",
				["u"] = "Unstage",
				["K"] = "Untrack",
				["U"] = "UnstageStaged",
				["y"] = "ShowRefs",
				["$"] = "CommandHistory",
				["Y"] = "YankSelected",
				["gp"] = "GoToParentRepo",
				["<c-r>"] = "RefreshBuffer",
				["<cr>"] = "GoToFile",
				["<s-cr>"] = "PeekFile",
				["<c-v>"] = "VSplitOpen",
				["<c-x>"] = "SplitOpen",
				["<c-t>"] = "TabOpen",
				["{"] = "GoToPreviousHunkHeader",
				["}"] = "GoToNextHunkHeader",
				["[c"] = "OpenOrScrollUp",
				["]c"] = "OpenOrScrollDown",
				["<c-k>"] = "PeekUp",
				["<c-j>"] = "PeekDown",
				["<c-n>"] = "NextSection",
				["<c-p>"] = "PreviousSection",
			},
		},
	}
	setup_plugin("neogit", function(neogit)
		neogit.setup(neogit_default_config)
		map_explicit({
			mode = "n",
			sequence = "<leader>gg",
			action = "<cmd>Neogit<cr>",
			opts = { desc = "Open Neogit UI" },
		})
	end)
end

local function setup_vim_fugitive()
	utils.packadd("vim-fugitive", function()
		-- print("Installed vim-fugitive.")
	end)
end

local function setup_blame()
	-- https://github.com/FabijanZulj/blame.nvim
	-- Neovim fugitive style git blame plugin
	local blame_defaults = {
		date_format = "%d.%m.%Y",
		virtual_style = "right_align",
		relative_date_if_recent = true, -- this is relative only for the latest month
		views = {
			window = window_view,
			virtual = virtual_view,
			default = window_view,
		},
		focus_blame = true,
		merge_consecutive = false,
		max_summary_width = 30,
		colors = nil,
		blame_options = nil,
		commit_detail_view = "vsplit",
		format_fn = formats.commit_date_author_fn,
		mappings = {
			commit_info = "i",
			stack_push = "<TAB>",
			stack_pop = "<BS>",
			show_commit = "<CR>",
			close = { "<esc>", "q" },
			copy_hash = "y",
			open_in_browser = "o",
		},
	}
	setup_plugin("blame", blame_defaults)
end

local functions = {
	["octo"] = setup_octo,
	["octohub"] = setup_octohub,
	["worktrees"] = setup_worktrees,
	["forgit"] = setup_forgit,
	["official-gitlab"] = setup_official_gitlab,
	["gitlab"] = setup_gitlab,
	["gitsigns"] = setup_gitsigns,
	["jj"] = setup_jj,
	["jujutsu"] = setup_jujutsu,
	["jiejie"] = setup_jiejie,
	["lazygit"] = setup_lazygit,
	["git-conflict"] = setup_git_conflict,
	["neogit"] = setup_neogit,
	["vim-fugitive"] = setup_vim_fugitive,
	["blame"] = setup_blame,
}
local function maybe_call(element_name)
	local include = elements[element_name]
	if include then
		print("Calling '" .. element_name .. "'")
		local func = functions[element_name]
		func()
	end
end

maybe_call("octo")
maybe_call("octohub")
maybe_call("worktrees")
maybe_call("forgit")
maybe_call("official-gitlab")
maybe_call("gitlab")
maybe_call("gitsigns")
maybe_call("jj")
maybe_call("jujutsu")
maybe_call("jiejie")
maybe_call("lazygit")
maybe_call("git-conflict")
maybe_call("neogit")
maybe_call("vim-fugitive")
maybe_call("blame")

-- TODO: rename to version-control

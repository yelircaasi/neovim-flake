setup_plugin("auto-session", {
	suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
})
setup_plugin("persistence", {
	{
		dir = vim.fn.stdpath("state") .. "/sessions/", -- directory where session files are saved
		-- minimum number of file buffers that need to be open to save
		-- Set to 0 to always save
		need = 1,
		branch = true, -- use git branch to save session
	},
})
setup_plugin("project_nvim", {
	-- Manual mode doesn't automatically change your root directory, so you have
	-- the option to manually do so using `:ProjectRoot` command.
	manual_mode = false,

	-- Methods of detecting the root directory. **"lsp"** uses the native neovim
	-- lsp, while **"pattern"** uses vim-rooter like glob pattern matching. Here
	-- order matters: if one is not detected, the other is used as fallback. You
	-- can also delete or rearangne the detection methods.
	detection_methods = { "lsp", "pattern" },

	-- All the patterns used to detect root dir, when **"pattern"** is in
	-- detection_methods
	patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },

	-- Table of lsp clients to ignore by name
	-- eg: { "efm", ... }
	ignore_lsp = {},

	-- Don't calculate root dir on specific directories
	-- Ex: { "~/.cargo/*", ... }
	exclude_dirs = {},

	-- Show hidden files in telescope
	show_hidden = false,

	-- When set to false, you will get a message when project.nvim changes your
	-- directory.
	silent_chdir = true,

	-- What scope to change the directory, valid options are
	-- * global (default)
	-- * tab
	-- * win
	scope_chdir = "global",

	-- Don't chdir for certain buffers
	exclude_chdir = {
		filetype = { "", "OverseerList", "alpha" },
		buftype = { "nofile", "terminal" },
	},

	-- Path where project.nvim will store the project history for use in
	-- telescope
	datapath = vim.fn.stdpath("data"),
})

setup_plugin("mini.sessions", {
	-- Whether to read default session if Neovim opened without file arguments
	autoread = false,

	-- Whether to write currently read session before leaving it
	autowrite = true,

	-- Directory where global sessions are stored (use `''` to disable)
	--   directory = --<"session" subdir of user data directory from |stdpath()|>,

	-- File for local session (use `''` to disable)
	file = "Session.vim",

	-- Whether to force possibly harmful actions (meaning depends on function)
	force = { read = false, write = true, delete = false },

	-- Hook functions for actions. Default `nil` means 'do nothing'.
	-- Takes table with active session data as argument.
	hooks = {
		-- Before successful action
		pre = { read = nil, write = nil, delete = nil },
		-- After successful action
		post = { read = nil, write = nil, delete = nil },
	},

	-- Whether to print session path after action
	verbose = { read = false, write = true, delete = true },
})

setup_plugin("projector", function(_) end)

-- https://github.com/folke/neoconf.nvim
-- Neovim plugin to manage global and project-local settings
local neoconf_defaults = {

	-- name of the local settings files
	local_settings = ".neoconf.json",
	-- name of the global settings file in your Neovim config directory
	global_settings = "neoconf.json",
	-- import existing settings from other plugins
	import = {
		vscode = true, -- local .vscode/settings.json
		coc = true, -- global/local coc-settings.json
		nlsp = true, -- global/local nlsp-settings.nvim json settings
	},
	-- send new configuration to lsp clients when changing json settings
	live_reload = true,
	-- set the filetype to jsonc for settings files, so you can use comments
	-- make sure you have the jsonc treesitter parser installed!
	filetype_jsonc = true,
	plugins = {
		-- configures lsp clients with settings in the following order:
		-- - lua settings passed in lspconfig setup
		-- - global json settings
		-- - local json settings
		lspconfig = {
			enabled = true,
		},
		-- configures jsonls to get completion in .neoconf.json files
		jsonls = {
			enabled = true,
			-- only show completion in json settings for configured lsp servers
			configured_servers_only = true,
		},
		-- configures lua_ls to get completion of lspconfig server settings
		lua_ls = {
			-- by default, lua_ls annotations are only enabled in your neovim config directory
			enabled_for_neovim_config = true,
			-- explicitly enable adding annotations. Mostly relevant to put in your local .neoconf.json file
			enabled = false,
		},
	},
}
setup_plugin("neoconf", neoconf_defaults)

-- https://github.com/folke/lazydev.nvim
-- Faster LuaLS setup for Neovim
local lazydev_defaults = {} -- TODO
setup_plugin("lazydev", lazydev_defaults)

setup_plugin("neorepl")

vim.lsp.config["luals"] = { ---------------------------------------------------------------------------------------- LUA
	-- Command and arguments to start the server.
	cmd = { "lua-language-server" },
	-- Filetypes to automatically attach to.
	filetypes = { "lua" },
	-- Sets the "workspace" to the directory where any of these files is found.
	-- Files that share a root directory will reuse the LSP server connection.
	-- Nested lists indicate equal priority, see |vim.lsp.Config|.
	root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
	-- Specific settings to send to the server. The schema is server-defined.
	-- Example: https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
			diagnostics = {
				globals = {
					"vim",
				},
			},
		},
	},
}

vim.lsp.config["lua_ls"] = { -- TODO (?)
	settings = {
		Lua = {
			workspace = { library = vim.api.nvim_get_runtime_file("", true) },
		},
	},
}

--TODO: pick one
vim.lsp.enable("lua_ls")
vim.lsp.enable("luals")

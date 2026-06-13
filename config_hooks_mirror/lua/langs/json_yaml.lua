-- https://github.com/2nthony/sortjson.nvim
-- DESC
-- written in go
local sortjson_defaults = {
	log_level = "WARN", -- log level, see `:h vim.log.levels`, print error info when parsing json failed
}
setup_plugin("sortjson", sortjson_defaults)
--[[
local commands = {
	"SortJSONByAlphaNum",
	"SortJSONByAlphaNumReverse",
	"SortJSONByKeyLength",
	"SortJSONByKeyLengthReverse",
}
--]]

-- https://tangled.org/cuducos.me/yaml.nvim
-- Simple tools to help developers working YAML in Neovim.
local yaml_nvim_defaults = {} -- TODO
setup_plugin("yaml_nvim", yaml_nvim_defaults)

-- https://github.com/phelipetls/jsonpath.nvim
-- A Neovim plugin to help you access JSON values, powered by treesitter
local jsonpath_defaults = {
	show_on_winbar = true,
}
setup_plugin("jsonpath", function(jsonpath)
	jsonpath.setup(jsonpath_defaults)

	-- maybe move to after/ftplugin/json.lua

	-- show json path in the winbar
	if vim.fn.exists("+winbar") == 1 then
		vim.opt_local.winbar = "%{%v:lua.require'jsonpath'.get()%}"
	end

	-- send json path to clipboard
	vim.keymap.set("n", "y<C-p>", function()
		vim.fn.setreg("+", require("jsonpath").get())
	end, { desc = "copy json path", buffer = true })
end)

-- https://github.com/b0o/SchemaStore.nvim
-- JSON schemas for Neovim
local jsonpath_defaults = {} -- TODO
setup_plugin("schemastore", function(schemastore)
	schemastore.json.schemas({
		extra = {
			{
				description = "Local JSON schema",
				fileMatch = "local.json",
				name = "local.json",
				url = "file:///path/to/your/schema.json", -- or '/path/to/your/schema.json'
			},
		},
	})
end)

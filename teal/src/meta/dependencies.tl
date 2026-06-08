local M: {string: {string}} = {
	["nvim-navbuddy"] = { "nui" },
	["yazi"]          = { "plenary" },
	["telescope"]     = { "plenary", "telescope-fzf-native", "telescope-project" },
	["luasnip"]       = { "friendly-snippets", "jsregexp" },
	["neotest"]       = { "nio", "plenary", "neotest-python", "dap" },
	["markit"]        = { "pickme", "snacks" },
	["pickme"]        = { "snacks" },
	["oil"]           = { "nvim-web-devicons" },
	["nvim-cmp"]      = { "LuaSnip", "cmp-nvim-lsp", "cmp-buffer", "cmp-path", "cmp_luasnip", "lazydev", "luasnip" },
    ["diffview"]      = { "plenary" },
	["neocomposer"]   = { "sqlite" },
	["recorder"]      = { "notify" },
	["refactoring"]   = { "async" },
	["ufo"]           = { "promise-async" },
}
return M

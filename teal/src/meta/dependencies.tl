local M: {string: {string}} = {
	["nvim-navbuddy"] = { "nui" },
	["yazi"]          = { "plenary" },
	["telescope"]     = { "plenary", "telescope-fzf-native" },
	["LuaSnip"]       = { "friendly-snippets", },
	["neotest"]       = { "nio", "plenary", "neotest-python" },
	["markit"]        = { "pickme", "snacks" },
	["pickme"]        = { "snacks" },
	["oil"]           = { "nvim-web-devicons" },
	["nvim-cmp"]      = { "LuaSnip", "cmp-nvim-lsp", "cmp-buffer", "cmp-path", "cmp_luasnip", "lazydev", "luasnip" },

}
return M

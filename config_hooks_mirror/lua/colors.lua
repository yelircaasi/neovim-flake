-- https://github.com/lukas-reineke/headlines.nvim
-- adds horizontal highlights for text filetypes, like markdown, orgmode, and neorg
setup_plugin("headlines", { -- TODO: move to colors (?)
	markdown = {
		headline_highlights = {
			"Headline1",
			"Headline2",
			"Headline3",
			"Headline4",
			"Headline5",
			"Headline6",
		},
		codeblock_highlight = "CodeBlock",
	},
})

vim.api.nvim_set_hl(0, "NonText", { fg = "#5b5e5a" })
vim.api.nvim_set_hl(0, "SpecialKey", { fg = "#5b5e5a" })

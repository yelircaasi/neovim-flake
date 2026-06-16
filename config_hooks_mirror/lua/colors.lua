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

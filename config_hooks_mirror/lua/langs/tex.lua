-- https://github.com/lervag/vimtex
-- modern Vim and neovim filetype plugin for LaTeX files
utils.packadd("vimtex", function()
	vim.g.vimtex_view_method = "zathura"

	-- This is necessary for VimTeX to load properly. The "indent" is optional.
	-- Note: Most plugin managers will do this automatically!
	vim.cmd("filetype plugin indent on")

	-- This enables Vim's and neovim's syntax-related features. Without this, some
	-- VimTeX features will not work (see ":help vimtex-requirements" for more
	-- info).
	-- Note: Most plugin managers will do this automatically!
	vim.cmd("syntax enable")

	-- Viewer options: One may configure the viewer either by specifying a built-in
	-- viewer method:
	vim.g.vimtex_view_method = "zathura"

	-- Or with a generic interface:
	vim.g.vimtex_view_general_viewer = "okular"
	vim.g.vimtex_view_general_options = "--unique file:@pdf#src:@line@tex"

	-- VimTeX uses latexmk as the default compiler backend. If you use it, which is
	-- strongly recommended, you probably don't need to configure anything. If you
	-- want another compiler backend, you can change it as follows. The list of
	-- supported backends and further explanation is provided in the documentation,
	-- see ":help vimtex-compiler".
	vim.g.vimtex_compiler_method = "latexrun"

	-- Most VimTeX mappings rely on localleader and this can be changed with the
	-- following line. The default is usually fine and is the symbol "\".
	vim.g.maplocalleader = ","
end)

-- https://github.com/jakewvincent/texmagic.nvim
-- facilitates LaTeX build engine selection via magic comments
-- designed with the TexLab LSP server's build service in mind
local texmagic_config = {
	engines = {
		pdflatex = { -- This has the same name as a default engine but would
			-- be preferred over the same-name default if defined
			executable = "latexmk",
			args = {
				"-pdflatex",
				"-interaction=nonstopmode",
				"-synctex=1",
				"-outdir=.build",
				"-pv",
				"%f",
			},
			isContinuous = false,
		},
		lualatex = { -- This is *not* one of the defaults, but it can be
			-- called via magic comment if defined here
			executable = "latexmk",
			args = {
				"-pdflua",
				"-interaction=nonstopmode",
				"-synctex=1",
				"-pv",
				"%f",
			},
			isContinuous = false,
		},
	},
}
setup_plugin("texmagic", texmagic_config)

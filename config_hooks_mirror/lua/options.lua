local function set_options()
	local global_options = {
		mapleader = " ",
		loaded_netrwPlugin = 1, -- for yazi
		nerdfont = true,
	}
	local options = {
		number = true, -- Show absolute line number on the current line
		relativenumber = true, -- Show relative numbers on other lines
		shiftwidth = 4,
		wrap = false,
		signcolumn = "yes",
		tabstop = 4,
		swapfile = false,
		winborder = "rounded",
		termguicolors = true,
		cursorline = true,
		undofile = true,
		incsearch = true,
		timeout = true,
		timeoutlen = 300,
		laststatus = 3,
	}

	for name, value in pairs(global_options) do
		vim.g[name] = value
	end

	for name, value in pairs(options) do
		vim.opt[name] = value
	end
end

set_options()

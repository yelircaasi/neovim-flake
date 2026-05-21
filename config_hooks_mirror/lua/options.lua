-- OPTIONS ========================================================================================

-- local o = vim.opt
-- local g = vim.g
vim.opt.number = true -- Show absolute line number on the current line
vim.opt.relativenumber = true -- Show relative numbers on other lines
vim.g.mapleader = " "
vim.opt.termguicolors = true

local function set_options()
	local global_options = {
		mapleader = " ",
	}
	local options = {
		number = true,
		relativenumber = true,
		shiftwidth = 4,
		wrap = false,
		signcolumn = "yes",
		tabstop = 4,
		swapfile = false,
		winborder = "rounded",
		termguicolors = true,
		undofile = true,
		incsearch = true,
		timeout = true,
		timeoutlen = 300,
	}
	for name, value in pairs(options) do
		vim.opt[name] = value
	end
	for name, value in pairs(global_options) do
		vim.g[name] = value
	end
end

set_options()

vim.g.loaded_netrwPlugin = 1 -- for yazi

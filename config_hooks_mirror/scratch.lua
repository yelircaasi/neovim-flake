no_skip = false
if no_skip then
	utils.printv("CONFIG_DIR: " .. CONFIG_DIR)
	utils.printv("PLUGINS INCLUDED: " .. vim.inspect(utils.PLUGINS_INCLUDED))
	utils.printbv(#utils.PLUGINS_INCLUDED .. " plugins included")

	local CONFIG_DIR = vim.fn.fnamemodify(debug.getinfo(1).source:sub(2), ":p:h")
	local PWD = vim.fn.getcwd()
	local NVIM_DIR = vim.fn.expand("~/.config/nvim")
	HAS_NIX, PLUGIN_LOCATIONS = pcall(dofile, NVIM_DIR .. "/nix_plugins.lua")
	BE_VERBOSE = false
end

-- utils.printbv(#utils.PLUGINS_INCLUDED .. " plugins included")

-- PATH MANAGEMENT ========================================================================================

if no_skip then
	local config_dir = vim.fn.fnamemodify(debug.getinfo(1).source:sub(2), ":p:h")
	-- print(config_dir)
	vim.opt.runtimepath:prepend(config_dir)

	if HAS_NIX then
		vim.opt.runtimepath:remove("/home/isaac/.local/share/nvim/site")
	end

	package.path = config_dir .. "/lua/?.lua;" .. config_dir .. "/lua/?/init.lua;" .. package.path

	vim.opt.runtimepath:prepend("/nix/store/ydlwparyk4mxl6wzhlp3x54zl3nk82c5-pde")
	vim.opt.runtimepath:remove("/home/isaac/.local/share/nvim/site")
end

local function prequire(plugin_name)
	success, plugin = pcall(require, plugin_name)
	if not success then
		print(plugin_name .. " failed.")
		print("ERROR: " .. plugin)
	end
end

vim.filetype.add({
	extension = {
		hs = "haskell",
		rs = "rust",
		xit = "xit",
	},
})

vim.keymap.set({ "n", "v" }, "<leader>pp", function()
	print("This is working!")
end)

vim.fn.expand("%:p") -- full path
vim.fn.expand("%") -- path as opened (may be relative)
vim.fn.expand("%:t") -- filename only (tail)
vim.fn.expand("%:h") -- directory only (head)

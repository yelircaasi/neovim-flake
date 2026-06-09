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

local pytest_exec = utils.get_executable("pytest")
local python_exec = utils.get_executable("python")
print(pytest_exec)
print(python_exec)

-- ===================================================================================

local setup_plugin_explicit = function(info_table)
	local name = info_table.name
	local config = info_table.config
end

-- MISC ========================================================================================

-- debug.getinfo(2, "S").source:sub(2):match("(.*/)") or "./"

-- xpcall example

local function my_function()
	error("Oops!")
end

local function my_handler(err)
	return "Custom Error Handler: " .. debug.traceback(err)
end

local status, err_msg = xpcall(my_function, my_handler)

if not status then
	print(err_msg) -- Will print the error + the line-by-line stack trace
end

-- pcall example
local status, telescope = pcall(require, "telescope")
if not status then
	return -- Silently exit if plugin isn't installed
end

-- symlinking

local plugins = {
	["user/repo-name"] = { path = "source_path/repo1" },
	["another-user/cool-plugin"] = { path = "/home/user/dev/cool-plugin" },
	["someone/awesome-nvim"] = { path = "~/projects/awesome-nvim" },
}

local PLUGIN_DIR = vim.fn.stdpath("data") .. "/site/pack/plugins/start"

-- Extract repo name from "user/repo-name" format
local function get_repo_name(plugin_id)
	return plugin_id:match("([^/]+)$")
end

-- Create symbolic links
for plugin_id, config in pairs(plugins) do
	local repo_name = get_repo_name(plugin_id)
	local source_path = vim.fn.expand(config.path)
	local target_path = PLUGIN_DIR .. "/" .. repo_name

	-- Check if source exists
	if vim.fn.isdirectory(source_path) == 0 then
		vim.notify(string.format("Warning: Source path does not exist: %s", source_path), vim.log.levels.WARN)
	else
		-- Remove existing link/directory if it exists
		vim.fn.delete(target_path, "rf")

		-- Create symbolic link
		local success = vim.loop.fs_symlink(source_path, target_path)

		if success then
			vim.notify(string.format("✓ Linked: %s -> %s", repo_name, source_path), vim.log.levels.INFO)
		else
			vim.notify(string.format("✗ Failed to link: %s", plugin_id), vim.log.levels.ERROR)
		end
	end
end

print("Symbolic links created!")

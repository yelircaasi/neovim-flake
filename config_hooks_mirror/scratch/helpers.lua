-- UTILS ========================================================================================

local function disable_builtins()
	local builtin_plugs = {
		"2html_plugin",
		"gzip",
		"man",
		"matchit",
		"matchparen",
		"netrwPlugin",
		"remote_plugins",
		"shada_plugin",
		"spellfile_plugin",
		"tarPlugin",
		"tutor_mode_plugin",
		"zipPlugin",
	}
	for i = 1, #builtin_plugs do
		vim.g["loaded_" .. builtin_plugs[i]] = 1
	end
end

local function list_loaded_vars()
	-- Use Vim's completion engine to find all global variables
	local all_vars = vim.fn.getcompletion("", "var")

	local loaded_vars = {}
	for _, var in ipairs(all_vars) do
		if var:match("^loaded_") then
			table.insert(loaded_vars, var)
		end
	end

	-- Print them nicely
	table.sort(loaded_vars)
	print(table.concat(loaded_vars, "\n"))
end

-- list_loaded_vars()

local function cd_config_dir()
	vim.cmd.cd(config_dir)
	printv("Beginning of init.lua; cd to " .. CONFIG_DIR)
end

local function cd_back()
	lua.cmd.cd(PWD)
	printv("Reached end of init.lua; cd back to " .. PWD)
end

local gh = function(id)
	return "https://github.com/" .. id
end

local gl = function(id)
	return "https://gitlab.com/" .. id
end

local cb = function(id)
	return "https://codeberg.org/" .. id
end

local split_id = function(id)
	local user, repo = string.match(id, "([^/]+)/([^/]+)")
	return user, repo
end

local printv = function(msg)
	if BE_VERBOSE then
		print(msg)
	end
end

local setup_lazy = function() -- not in use; kept for reference
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
	printv(lazypath)
	if not vim.loop.fs_stat(lazypath) then
		-- vim.fn.system({
		--     "git",
		--     "clone",
		--     "--filter=blob:none",
		--     "https://github.com/folke/lazy.nvim",
		--     lazypath,
		-- })
	end
	vim.opt.rtp:prepend(lazypath)
end

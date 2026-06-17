-- NEEDED TO PREVENT WARNINGS ON NON-CODE BUFFERS

-- local orig_ts_start = vim.treesitter.start

-- local ts_disabled = {
-- 	snacks_notif = true,
-- 	["blink-cmp-menu"] = true,
-- 	yazi = true,
-- 	oil = true,
-- 	telescope = true,
-- 	TelescopePrompt = true,
-- 	TelescopeResults = true,
-- 	TelescopePreview = true,
-- 	dmap = true,
-- 	SymbolsSearch = true,
-- 	SymbolsSidebar = true,
-- 	["zenmode-bg"] = true,
-- }

-- vim.treesitter.start = function(bufnr, lang)
-- 	bufnr = bufnr or 0
-- 	local ft = vim.bo[bufnr].filetype

-- 	if ts_disabled[ft] then
-- 		return
-- 	end

-- 	return orig_ts_start(bufnr, lang)
-- end

local old_config = {
	-- directory to install parsers and queries to (prepended to `runtimepath` to have priority)
	install_dir = (not HAS_NIX) and vim.fn.stdpath("data") .. "/site" or nil,
	parser_install_dir = (not HAS_NIX) and vim.fn.stdpath("data") .. "/parsers" or nil,
	ensure_installed = HAS_NIX and {} or TS_LANGUAGES,
	highlight = { enable = true },
	indent = { enable = true },
}

if false then
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "lua",
		callback = function()
			vim.treesitter.start()
		end,
	})

	vim.api.nvim_create_autocmd("FileType", {
		pattern = "python",
		callback = function(ev)
			vim.treesitter.start(ev.buf, "python")
		end,
	})

	vim.api.nvim_create_autocmd("FileType", {
		callback = function()
			pcall(vim.treesitter.start) -- pcall: silently skips if no parser
		end,
	})
end

pcall(vim.treesitter.language.register, "markdown", "snacks_notif")
pcall(vim.treesitter.language.register, "markdown", "blink-cmp-menu")
pcall(vim.treesitter.language.register, "markdown", "yazi")
pcall(vim.treesitter.language.register, "markdown", "oil")

-- vim.api.nvim_create_autocmd('FileType', {
--   callback = function(ev)
--     if vim.treesitter.language.get_lang(vim.bo[ev.buf].filetype) == nil then
--       return
--     end
--     vim.treesitter.start(ev.buf)
--   end,
-- })

-- local no_ts = { oil = true, yazi = true, lazy = true, }

-- vim.api.nvim_create_autocmd('FileType', {
--   callback = function(ev)
--     if no_ts[vim.bo[ev.buf].filetype] then return end
--     pcall(vim.treesitter.start, ev.buf)
--   end,
-- })

-- NEW TREESITTER CONFIG COMPILED FROM OLD

-- PREAMBLE / VARS ----------------------------------------------

-- PATHS
-- print(vim.o.runtimepath:find(vim.env.VIMRUNTIME) ~= nil)
-- print(vim.inspect(vim.opt.runtimepath))

-- SETUP / CHECKS

-- REGISTER LANGUAGES
-- vim.treesitter.language.register("py", "python")

-- QUERIES
-- vim.treesitter.query.add_predicate("python", "highlights", [[(function_definition name: (identifier) @function.def)]])

-- AUTOCOMMANDS
-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = { "rust", "go", "python" }, -- add languages
-- 	callback = function()
-- 		if not vim.treesitter.language.get_lang(vim.bo.filetype) then
-- 			-- Or use a plugin/helper for installation
-- 			print("No Treesitter parser for " .. vim.bo.filetype)
-- 		end
-- 	end,
-- })

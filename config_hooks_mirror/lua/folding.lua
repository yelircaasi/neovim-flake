vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = "v:lua.vim.treesitter.foldtext()"
vim.opt.foldenable = true
vim.opt.foldlevel = 99 -- start with all folds open
vim.opt.foldlevelstart = 99 -- same on buffer open
vim.opt.foldminlines = 1

-- Persist fold level per buffer rather than globally
vim.api.nvim_create_autocmd("BufWritePost", {
	callback = function()
		vim.cmd("mkview")
	end,
})
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		pcall(vim.cmd, "loadview")
	end,
})

-- Keymaps
map_explicit({
	mode = "n",
	sequence = "zR",
	action = function()
		vim.opt.foldlevel = 99
	end,
	desc = "Open all folds",
})
map_explicit({
	mode = "n",
	sequence = "zM",
	action = function()
		vim.opt.foldlevel = 0
	end,
	desc = "Close all folds",
})
map_explicit({
	mode = "n",
	sequence = "za",
	action = "za",
	desc = "Toggle fold",
})
map_explicit({
	mode = "n",
	sequence = "zp",
	action = function()
		-- Preview fold contents in a floating window
		local start = vim.fn.foldclosed(".")
		if start == -1 then
			return
		end
		local end_ = vim.fn.foldclosedend(".")
		local lines = vim.api.nvim_buf_get_lines(0, start - 1, end_, false)
		local buf = vim.api.nvim_create_buf(false, true)
		vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
		vim.api.nvim_open_win(buf, false, {
			relative = "cursor",
			row = 1,
			col = 0,
			width = math.min(80, vim.o.columns - 4),
			height = math.min(#lines, 20),
			style = "minimal",
			border = "rounded",
		})
	end,
	desc = "Preview fold",
})

vim.cmd("packadd promise-async")
require("promise")
require("async")

setup_plugin("ufo", function(ufo)
	vim.o.fillchars = "eob: ,fold: ,foldopen:,foldsep: ,foldinner: ,foldclose:"
	vim.o.foldcolumn = "1" -- '0' is not bad
	vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
	vim.o.foldlevelstart = 99
	vim.o.foldenable = true

	vim.cmd("packadd promise-async")
	-- require("promise")
	-- require("async")

	-- ALTERNATIVE: TREESITTER
	-- ufo.setup({
	--     provider_selector = function(bufnr, filetype, buftype)
	--         return {'treesitter', 'indent'}
	--     end
	-- })

	-- ALTERNATIVE: LSP
	--[[
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true
    }
    local language_servers = vim.lsp.get_clients() -- or list servers manually like {'gopls', 'clangd'}
    for _, ls in ipairs(language_servers) do
        require('lspconfig')[ls].setup({
            capabilities = capabilities
            -- add other fields for setting up lsp server in this table
        })
    end
    --]]
	ufo.setup({})

	vim.keymap.set("n", "zR", ufo.openAllFolds)
	vim.keymap.set("n", "zM", ufo.closeAllFolds)
end)
-- utils.packadd("ufo")
-- require("ufo").setup()

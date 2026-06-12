vim.g.rustaceanvim = {
	-- Plugin configuration
	tools = {},
	-- LSP configuration
	server = {
		on_attach = function(client, bufnr)
			-- you can also put keymaps in here
		end,
		default_settings = {
			-- rust-analyzer language server configuration
			["rust-analyzer"] = {},
		},
	},
	-- DAP configuration
	dap = {},
}

local rnv = setup_plugin("rustaceanvim")
setup_plugin("crates", {
	lsp = {
		enabled = true,
		on_attach = function(client, bufnr)
			-- the same on_attach function as for your other language servers
			-- can be ommited if you're using the `LspAttach` autocmd
		end,
		actions = true,
		completion = true,
		hover = true,
	},
	completion = {
		cmp = {
			use_custom_kind = true,
			-- optionally change the text and highlight groups
			kind_text = {
				version = "Version",
				feature = "Feature",
			},
			kind_highlight = {
				version = "CmpItemKindVersion",
				feature = "CmpItemKindFeature",
			},
		},
	},
	-- TODO: https://github.com/Saecki/crates.nvim/wiki/Documentation-unstable#nvim-cmp-source
})
setup_plugin("cargo", function(crates)
	crates.setup({
		float_window = true,
		window_width = 0.8,
		window_height = 0.8,
		border = "rounded",
		auto_close = true,
		close_timeout = 5000,
	})

	local opts = { silent = true }

	vim.keymap.set("n", "<leader>ct", crates.toggle, opts)
	vim.keymap.set("n", "<leader>cr", crates.reload, opts)

	vim.keymap.set("n", "<leader>cv", crates.show_versions_popup, opts)
	vim.keymap.set("n", "<leader>cf", crates.show_features_popup, opts)
	vim.keymap.set("n", "<leader>cd", crates.show_dependencies_popup, opts)

	vim.keymap.set("n", "<leader>cu", crates.update_crate, opts)
	vim.keymap.set("v", "<leader>cu", crates.update_crates, opts)
	vim.keymap.set("n", "<leader>ca", crates.update_all_crates, opts)
	vim.keymap.set("n", "<leader>cU", crates.upgrade_crate, opts)
	vim.keymap.set("v", "<leader>cU", crates.upgrade_crates, opts)
	vim.keymap.set("n", "<leader>cA", crates.upgrade_all_crates, opts)

	vim.keymap.set("n", "<leader>cx", crates.expand_plain_crate_to_inline_table, opts)
	vim.keymap.set("n", "<leader>cX", crates.extract_crate_into_table, opts)

	vim.keymap.set("n", "<leader>cH", crates.open_homepage, opts)
	vim.keymap.set("n", "<leader>cR", crates.open_repository, opts)
	vim.keymap.set("n", "<leader>cD", crates.open_documentation, opts)
	vim.keymap.set("n", "<leader>cC", crates.open_crates_io, opts)
	vim.keymap.set("n", "<leader>cL", crates.open_lib_rs, opts)
end)

local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set("n", "<leader>a", function()
	vim.cmd.RustLsp("codeAction") -- supports rust-analyzer's grouping
	-- or vim.lsp.buf.codeAction() if you don't want grouping.
end, { silent = true, buffer = bufnr })
vim.keymap.set(
	"n",
	"K", -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
	function()
		vim.cmd.RustLsp({ "hover", "actions" })
	end,
	{ silent = true, buffer = bufnr }
)

-- TODO: probably extraneous with rustaceanvim
vim.lsp.config["rust-analyzer"] = { ------------------------------------------------------------------------------- RUST
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
	root_markers = { { "Cargo.toml", "cargo.lock" }, ".git" },
	settings = {},
}

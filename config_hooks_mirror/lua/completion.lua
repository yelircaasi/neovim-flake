setup_plugin("nvim-cmp", function()
	utils.packadd("cmp-nvim-lsp")
	utils.packadd("cmp-buffer")
	utils.packadd("cmp-path")
	utils.packadd("cmp_luasnip")
    utils.packadd("cmp-cmdline")

	vim.lsp.config("*", { capabilities = require("cmp_nvim_lsp").default_capabilities() })
	vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
	local cmp = require("cmp")
	local defaults = require("cmp.config.default")()
	local auto_select = true
	return {
		snippet = {
			-- REQUIRED for luasnip
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		auto_brackets = {},
		completion = {
			completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
		},
		preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
		mapping = cmp.mapping.preset.insert({
			["<C-b>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
			["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
			["<C-Space>"] = cmp.mapping.complete(),
			["<C-e>"] = cmp.mapping.abort(),
			["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept selected suggestion
			--   ["<CR>"] = LazyVim.cmp.confirm({ select = auto_select }),
			--   ["<C-y>"] = LazyVim.cmp.confirm({ select = true }),
			--   ["<S-CR>"] = LazyVim.cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			-- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			["<C-CR>"] = function(fallback)
				cmp.abort()
				fallback()
			end,

			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				else
					fallback()
				end
			end, { "i", "s" }),

			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { "i", "s" }),

			["<tab>"] = function(fallback) -- what goes here?
			end,
			--   ["<tab>"] = function(fallback)
			-- 	return LazyVim.cmp.map_explicit({ "snippet_forward", "ai_nes", "ai_accept" }, fallback)()
			--   end,
		}),
		sources = cmp.config.sources({
			{ name = "lazydev" },
			{ name = "nvim_lsp" },
			{ name = "luasnip" },
		}, {
			{ name = "buffer" },
			{ name = "path" },
		}),
		formatting = {
			format = function(entry, item)
				-- local icons = LazyVim.config.icons.kinds
				-- if icons[item.kind] then
				--   item.kind = icons[item.kind] .. item.kind
				-- end

				local widths = {
					abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
					menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
				}

				for key, width in pairs(widths) do
					if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
						item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. "…"
					end
				end

				return item
			end,
		},
		experimental = {
			-- only show ghost text when we show ai completions
			ghost_text = vim.g.ai_cmp and {
				hl_group = "CmpGhostText",
			} or false,
		},
		sorting = defaults.sorting,
	}
end)

-- FROM LAZY (?): opts_extend = { "sources.default" }
setup_plugin("blink", {
	-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
	-- 'super-tab' for mappings similar to vscode (tab to accept)
	-- 'enter' for enter to accept
	-- 'none' for no mappings
	--
	-- All presets have the following mappings:
	-- C-space: Open menu or open docs if already open
	-- C-n/C-p or Up/Down: Select next/previous item
	-- C-e: Hide menu
	-- C-k: Toggle signature help (if signature.enabled = true)
	--
	-- See :h blink-cmp-config-keymap for defining your own keymap
	keymap = { preset = "default" },

	appearance = {
		-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
		-- Adjusts spacing to ensure icons are aligned
		nerd_font_variant = "mono",
	},

	-- (Default) Only show the documentation popup when manually triggered
	completion = { documentation = { auto_show = false } },

	-- Default list of enabled providers defined so that you can extend it
	-- elsewhere in your config, without redefining it, due to `opts_extend`
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},

	-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
	-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
	-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
	--
	-- See the fuzzy documentation for more information
	fuzzy = { implementation = "prefer_rust_with_warning" },
})

setup_plugin("blink.cmp", { ------------------------------------------------------------------------------------- blink
	fuzzy = { implementation = "lua" }, -- TODO: change to Rust
	keymap = {
		-- 'default' for vim-like (C-y to accept)
		-- 'super-tab' for vscode-like (Tab to accept/jump)
		-- 'enter' for enter to accept
		preset = "super-tab",

		["<C-k>"] = { "select_prev", "fallback" },
		["<C-j>"] = { "select_next", "fallback" },

		["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
		["<C-e>"] = { "hide", "fallback" },
		["<CR>"] = { "accept", "fallback" },

		["<Tab>"] = { "snippet_forward", "fallback" },
		["<S-Tab>"] = { "snippet_backward", "fallback" },

		["<C-b>"] = { "scroll_documentation_up", "fallback" },
		["<C-f>"] = { "scroll_documentation_down", "fallback" },
	},
})

utils.packadd("friendly-snippets")
utils.packadd("ultisnips")

vim.api.nvim_create_autocmd("InsertEnter", {
	callback = function()
		setup_plugin("luasnip", function(luasnip)
			-- TODO: rewrite from lazy.nvim config
			utils.packadd("friendly-snippets") -- Optional: for pre-made snippets
			-- build = "make install_jsregexp" -- For regex snippets -- TODO: check build in Nix
		end)
	end,
})

-- used as sources above
-- setup_plugin("cmp-nvim-lsp")
-- setup_plugin("cmp-buffer")
-- setup_plugin("cmp-path")
-- setup_plugin("cmp-cmdline")

setup_plugin("luasnip")


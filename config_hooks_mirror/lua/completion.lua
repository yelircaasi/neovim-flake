--─────────────────────────────────────────────────────────────────────────────
--──── snippet sources ────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

local function setup_friendly_snippets()
	utils.packadd("friendly-snippets")

	vim.api.nvim_create_autocmd("InsertEnter", {
		callback = function()
			utils.packadd("friendly-snippets") -- Optional: for pre-made snippets

			-- utils.packadd("jsregexp")
			-- require("jsregexp")
			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip.loaders.from_snipmate").lazy_load()
		end,
	})
end

local function setup_ultisnips()
	utils.packadd("ultisnips")
end

--─────────────────────────────────────────────────────────────────────────────
--──── snippet engines ────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

local function setup_luasnip()
	local function setup_luasnip()
		vim.cmd(":packadd luasnip")
		local ls = require("luasnip")

		ls.setup()
		-- print(require("luasnip.util.jsregexp"))

		-- utils.packadd("jsregexp")
		require("jsregexp")

		local s = ls.snippet
		local t = ls.text_node

		ls.add_snippets("all", {
			s({ trig = "a.*b", regTrig = true }, {
				t("REGEX OK"),
			}),
		})

		-- loaders
		-- TODO: https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#lua

		require("luasnip.loaders.from_vscode").lazy_load()
		-- NOTE:
		-- It's mandatory to have a `package.json` file in the snippet directory. For examples, see [friendly-snippets](https://github.com/rafamadriz/friendly-snippets/blob/main/package.json).
		-- require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./my-cool-snippets" } })

		require("luasnip.loaders.from_snipmate").lazy_load()

		map_explicit({
			mode = { "i" },
			sequence = "<C-K>",
			action = function()
				ls.expand()
			end,
			opts = { silent = true },
		})
		map_explicit({
			mode = { "i", "s" },
			sequence = "<C-L>",
			action = function()
				ls.jump(1)
			end,
			opts = { silent = true },
		})
		map_explicit({
			mode = { "i", "s" },
			sequence = "<C-J>",
			action = function()
				ls.jump(-1)
			end,
			opts = { silent = true },
		})

		map_explicit({
			mode = { "i", "s" },
			sequence = "<C-E>",
			action = function()
				if ls.choice_active() then
					ls.change_choice(1)
				end
			end,
			opts = { silent = true },
		})
	end
	setup_luasnip()
end

--─────────────────────────────────────────────────────────────────────────────
--──── completion engines ─────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

local function setup_nvim_cmp()
	-- TODO: clean up, check whether name is "cmp" or "nvim-cmp"

	-- should work (optional dependency): require("jsregexp")

	-- used as sources:
	-- setup_plugin("cmp-nvim-lsp")
	-- setup_plugin("cmp-buffer")
	-- setup_plugin("cmp-path")
	-- setup_plugin("cmp-cmdline")
	utils.packadd("cmp-nvim-lsp")
	utils.packadd("cmp-buffer")
	utils.packadd("cmp-path")
	utils.packadd("cmp_luasnip")
	utils.packadd("cmp-cmdline")

	vim.lsp.config("*", { capabilities = require("cmp_nvim_lsp").default_capabilities() })
	vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
	utils.packadd("cmp")
	local cmp = require("cmp")
	local defaults = require("cmp.config.default")()
	local auto_select = true
	cmp.setup({
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
	})
end

local function setup_blink_cmp()
	local bink_cmp_defaults = {
		-- Enables keymaps, completions and signature help when true (doesn't apply to cmdline or term)
		--
		-- If the function returns 'force', the default conditions for disabling the plugin will be ignored
		-- Default conditions: (vim.bo.buftype ~= 'prompt' and vim.b.completion ~= false)
		-- Note that the default conditions are ignored when `vim.b.completion` is explicitly set to `true`
		--
		-- Exceptions: vim.bo.filetype == 'dap-repl'
		enabled = function()
			return not vim.tbl_contains({ "lua", "markdown" }, vim.bo.filetype)
		end,

		-- Disable cmdline
		cmdline = { enabled = false },

		completion = {
			-- 'prefix' will fuzzy match on the text before the cursor
			-- 'full' will fuzzy match on the text before _and_ after the cursor
			-- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
			keyword = { range = "full" },

			-- Disable auto brackets
			-- NOTE: some LSPs may add auto brackets themselves anyway
			accept = { auto_brackets = { enabled = false } },

			-- Don't select by default, auto insert on selection
			list = { selection = { preselect = false, auto_insert = true } },
			-- or set via a function
			list = {
				selection = {
					preselect = function(ctx)
						return vim.bo.filetype ~= "markdown"
					end,
				},
			},

			menu = {
				-- Don't automatically show the completion menu
				auto_show = false,

				-- nvim-cmp style menu
				draw = {
					columns = {
						{ "label", "label_description", gap = 1 },
						{ "kind_icon", "kind" },
					},
				},
			},

			-- Show documentation when selecting a completion item
			documentation = { auto_show = true, auto_show_delay_ms = 500 },

			-- Display a preview of the selected item on the current line
			ghost_text = { enabled = true },
		},

		sources = {
			-- Remove 'buffer' if you don't want text completions, by default it's only enabled when LSP returns no items
			default = { "lsp", "path", "snippets", "buffer" },
		},

		-- Use a preset for snippets, check the snippets documentation for more information
		snippets = { preset = "default" | "luasnip" | "mini_snippets" | "vsnip" },

		-- Experimental signature help support
		signature = { enabled = true },
	}
	local blink_cmp_opts = { ------------------------------------------------------------------------------------- blink
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
	}
	setup_plugin("blink.cmp", blink_cmp_opts)
end

setup_friendly_snippets()
setup_ultisnips()
setup_luasnip()
setup_nvim_cmp()
setup_blink_cmp()

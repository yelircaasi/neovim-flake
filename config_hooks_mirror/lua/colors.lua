local function setup_headlines()
	-- https://github.com/lukas-reineke/headlines.nvim
	-- adds horizontal highlights for text filetypes, like markdown, orgmode, and neorg
	setup_plugin("headlines", { -- TODO: move to colors (?)
		markdown = {
			headline_highlights = {
				"Headline1",
				"Headline2",
				"Headline3",
				"Headline4",
				"Headline5",
				"Headline6",
			},
			codeblock_highlight = "CodeBlock",
		},
	})
end

local function setup_sunglasses()
	-- https://github.com/miversen33/sunglasses.nvim
	-- Put on your shades so you only see what you care about
	local sunglasses_defaults = {
		filter_percent = 0.65,
		filter_type = "SHADE",
		log_level = "ERROR",
		refresh_timer = 5,
		excluded_filetypes = {
			"dashboard",
			"lspsagafinder",
			"packer",
			"checkhealth",
			"mason",
			"NvimTree",
			"neo-tree",
			"plugin",
			"lazy",
			"TelescopePrompt",
			"alpha",
			"toggleterm",
			"sagafinder",
			"better_term",
			"fugitiveblame",
			"starter",
			"NeogitPopup",
			"NeogitStatus",
			"DiffviewFiles",
			"DiffviewFileHistory",
			"DressingInput",
			"spectre_panel",
			"zsh",
			"registers",
			"startuptime",
			"OverseerList",
			"Outline",
			"Navbuddy",
			"noice",
			"notify",
			"saga_codeaction",
			"sagarename",
		},
		excluded_highlights = {
			"WinSeparator",
			{ "lualine_.*", glob = true },
		},
		can_shade_callback = function(opts)
			local conditions = {
				function()
					return vim.api.nvim_get_option_value("diff", { win = opts.window })
				end,
			}

			for _, condition in ipairs(conditions) do
				if condition() then
					return false
				end
			end

			return true
		end,
	}
	setup_plugin("sunglasses", sunglasses_defaults)
	print("set up sunglasses.nvim")
end

local function configure()
	vim.api.nvim_set_hl(0, "NonText", { fg = "#5b5e5a" })
	vim.api.nvim_set_hl(0, "SpecialKey", { fg = "#5b5e5a" })

	vim.api.nvim_create_autocmd("ColorScheme", {
		-- immediate = true,
		callback = function()
			local win_sep = vim.api.nvim_get_hl(0, { name = "WinSeparator", link = false })
			local statusnc = vim.api.nvim_get_hl(0, { name = "StatusLineNC", link = false })

			-- Make the inactive bar background match so it blends with WinSeparator
			vim.api.nvim_set_hl(0, "StatusLineNC", {
				fg = win_sep.fg,
				bg = statusnc.bg,
			})
		end,
	})
end

setup_headlines()
map_explicit({ mode = "n", sequence = "<leader>su", action = setup_sunglasses })
configure()

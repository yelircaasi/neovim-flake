print("Entering after_init.lua.")

utils.printv("CONFIG_DIR: " .. CONFIG_DIR)
utils.printv("PLUGINS INCLUDED: " .. vim.inspect(utils.PLUGINS_INCLUDED))
utils.printbv(#utils.PLUGINS_INCLUDED .. " plugins included")

if HAS_NIX then 
  vim.opt.runtimepath:remove("/home/isaac/.local/share/nvim/site")
end

local setup_plugin = utils.setup_plugin
local packadd = utils.packadd
local map = utils.map

-- utils.printbv(#utils.PLUGINS_INCLUDED .. " plugins included")


local setup_telescope = function(telescope)
    -- vim.cmd.packadd("telescope-fzf-native")
    -- vim.cmd.packadd("plenary")
    telescope.setup({
        extensions = {
            fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                            -- the default case_mode is "smart_case"
            }
        }
    })
    -- utils.setup_plugin("telescope-fzf-native")

    -- To get fzf loaded and working with telescope, you need to call
    -- load_extension, somewhere after setup function:
    telescope.load_extension('fzf')
    print("loaded telescope with fzf-native")
end

-- vim.cmd.packadd("plenary")
-- vim.cmd.packadd("telescope")
-- vim.cmd.packadd("telescope-fzf-native")
-- setup_telescope(require "telescope")

-- lua require("telescope").load_extension('fzf')
utils.setup_plugin_default("telescope", setup_telescope)

if false then  --=============

setup_plugin("plenary")
setup_plugin("nio")
setup_plugin("nvim-web-devicons")

setup_plugin("bamboo", function(bamboo)
	(bamboo.setup)({
		style = "multiplex",
		colors = {
			bg0 = "#020802",
		},
	});
	(bamboo.load)()
	utils.printbv("Set up bamboo")
end)
setup_plugin("zen-mode")
setup_plugin("lualine")
setup_plugin("nvim-navic")
setup_plugin("bufferline")
setup_plugin("statuscol")

setup_plugin("treesitter-modules")
setup_plugin("dropbar")
utils.packadd("nvim-navbuddy")
setup_plugin("aerial")

setup_plugin("oil")
setup_plugin("yazi")
setup_plugin("neo-tree")
setup_plugin("nvim-tree")

setup_plugin("pickme")
-- setup_plugin("telescope") MOVED

setup_plugin("fzf-lua")
setup_plugin("deck")

setup_plugin("mini.indent")
setup_plugin("mini.keymap")
setup_plugin("mini.sessions")

setup_plugin("snacks")
setup_plugin("blink")

setup_plugin("hlslens")
setup_plugin("hlsearch")

setup_plugin("grug-far")
setup_plugin("spectre")

setup_plugin("flybuf")
setup_plugin("stickybuf")
setup_plugin("swm", function(swm)
	map("n", "<C-w>h", swm.h)
	map("n", "<C-w>j", swm.j)
	map("n", "<C-w>k", swm.k)
	map("n", "<C-w>l", swm.l)
end)

setup_plugin("smart-splits")

setup_plugin("ufo")

setup_plugin("NeoComposer")
setup_plugin("nvim-macros", {
	json_file_path = "./macros.json",
	default_macro_register = "a",
	json_formatter = "jq",
})
setup_plugin("recorder")

utils.packadd("vim-visual-multi")

setup_plugin("leap")
setup_plugin("flash")
setup_plugin("hop")

setup_plugin("rainbow-delimiters")
setup_plugin("nvim-autopairs")

utils.packadd("vim-sandwich")

setup_plugin("nvim-surround")

utils.packadd("vim-mundo")

setup_plugin("mini.keymap")
setup_plugin("hydra")
setup_plugin("insx")
setup_plugin("which-key")

setup_plugin("indentmini")
utils.packadd("indent-blankline")
setup_plugin("nvim-anydent")
setup_plugin("mini.align")
utils.packadd("tabular")

setup_plugin("nvim-treesitter-textobjects")
utils.packadd("nvim-various-textobjs")

setup_plugin("Comment")
setup_plugin("todo-comments")
utils.packadd("vim-commentary")

setup_plugin("treesj")
setup_plugin("dial")
setup_plugin("harpoon-core")
setup_plugin("marks")
setup_plugin("markit")

setup_plugin("nvim-pasta")

setup_plugin("beam")

setup_plugin("blink.cmp")
setup_plugin("nvim-cmp")

setup_plugin("friendly-snippets")
setup_plugin("ultisnips")
setup_plugin("LuaSnip")

setup_plugin("cmp-nvim-lsp")
setup_plugin("cmp-buffer")
setup_plugin("cmp-path")
setup_plugin("cmp-cmdline")

setup_plugin("lsp-format")
setup_plugin("lspkind")

setup_plugin("lspsaga")

setup_plugin("lazydev")
setup_plugin("rustaceanvim")
setup_plugin("crates")
setup_plugin("haskell-tools")

setup_plugin("none-ls")

setup_plugin("guard")
setup_plugin("conform")

setup_plugin("asyncrun")
setup_plugin("neotest-haskell")
setup_plugin("neotest-python")
setup_plugin("neotest")
setup_plugin("dap-python", function(dap_python)
	(dap_python.setup)("debugpy-adapter")
	dap_python.test_runner = "pytest"
	map("n", "<leader>tt", function()
		print("Leader is working!")
	end)
	map("n", "<leader>pp", function()
		print("This works")
	end)
	map("n", "<leader>dn", dap_python.test_method)
	map("n", "<leader>df", dap_python.test_class)
	map("v", "<leader>ds", dap_python.debug_selection)
end)
setup_plugin("dapui")
setup_plugin("nvim-dap-virtual-text")
setup_plugin("dap")
setup_plugin("mypy")
setup_plugin("nvim-lint")

setup_plugin("trouble.nvim")
setup_plugin("quicker")
setup_plugin("nvim-bqf")

setup_plugin("vim-floaterm")
setup_plugin("toggleterm")

setup_plugin("overseer")

setup_plugin("refactoring")

setup_plugin("project")
setup_plugin("telescope-project")

setup_plugin("jj")
setup_plugin("jujutsu")
setup_plugin("lazygit")
setup_plugin("git-conflict")
setup_plugin("neogit")
setup_plugin("jiejie")
setup_plugin("diffview")
setup_plugin("gitsigns")
setup_plugin("vim-fugitive")

setup_plugin("octo")
setup_plugin("gitlab-nvim")
setup_plugin("gitlab")

setup_plugin("dashboard-nvim")
setup_plugin("dashboard")
setup_plugin("noice")
setup_plugin("modes")

setup_plugin("fidget")
setup_plugin("nvim-notify")
setup_plugin("headlines")

setup_plugin("auto-session")
setup_plugin("persistence")

utils.packadd("vimtex", function()
	vim.g.vimtex_view_method = "zathura"
end)
setup_plugin("texmagic")
setup_plugin("schemastore")
setup_plugin("firenvim")
setup_plugin("render-markdown")
setup_plugin("jupytext")
setup_plugin("quarto")
setup_plugin("markdown-preview")

setup_plugin("structlog")
setup_plugin("neorepl")

end

utils.setup_plugin("xit")

vim.treesitter.language.register("py", "python")

vim.filetype.add({
  extension = { xit = "xit" },
})
vim.treesitter.language.register("xit", "xit")
vim.api.nvim_create_autocmd("FileType", {
  pattern = "xit",
  callback = function(ev)
    print("executing xit callback")
    vim.treesitter.language.add('xit', { path = PARSER_DIR .. "/xit.so" })
    vim.treesitter.start(ev.buf, "xit")
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    vim.treesitter.start()
  end,
})
-- print(vim.o.runtimepath:find(vim.env.VIMRUNTIME) ~= nil)

-- print(vim.inspect(vim.opt.runtimepath))


-- setup_plugin("nvim-treesitter", function(treesitter)
-- 	local TS_LANGUAGES = {
-- 		"haskell",
-- 		"javascript",
-- 		"json",
-- 		"lua",
-- 		"markdown",
-- 		"nix",
-- 		"python",
-- 		"rust",
-- 		"toml",
-- 		"typescript",
-- 		"yaml",
-- 		"zig",
-- 	}

-- 	utils.printbv("Setting up treesitter.")
-- 	local my_install_dir = (not HAS_NIX) and ((vim.fn.stdpath("data")) .. "/site") or DERIVATION_DIR
-- 	utils.printv(my_install_dir)
-- 	local my_parser_install_dir = (not HAS_NIX) and (vim.fn.stdpath("data")) .. "/site/parsers" or nil
-- 	utils.printv(my_parser_install_dir)
-- 	local my_ensure_installed = HAS_NIX and {} or TS_LANGUAGES
-- 	utils.printv(vim.inspect(my_ensure_installed))

-- 	utils.printbv("Treesitter exists")
-- 	(treesitter.setup)({
-- 		install_dir = my_install_dir,
-- 		parser_install_dir = my_parser_install_dir,
-- 		ensure_installed = my_ensure_installed,
-- 		highlight = { enable = true },
-- 		indent = { enable = true },
-- 	})
-- end)



local my_install_dir = (not HAS_NIX) and ((vim.fn.stdpath("data")) .. "/site") or DERIVATION_DIR

local my_parser_install_dir = my_install_dir .. "/parser"
-- (not HAS_NIX) and (vim.fn.stdpath("data")) .. "/site/parsers" or DERIVATION_DIR .. 

local my_ensure_installed = HAS_NIX and {} or TS_LANGUAGES

utils.printb("Setting up treesitter.")
utils.printb(my_install_dir)
utils.printb(my_parser_install_dir)
utils.printb(vim.inspect(my_ensure_installed))

-- vim.treesitter.setup(
--     {
-- 		install_dir = my_install_dir,
-- 		parser_install_dir = my_parser_install_dir,
-- 		ensure_installed = my_ensure_installed,
-- 		highlight = { enable = true },
-- 		indent = { enable = true },
-- 	}
-- )

parser_root = vim.fn.fnamemodify(OPT_DIR, ":h:h:h")
vim.opt.runtimepath:prepend(PARSER_DIR)

vim.opt.runtimepath:prepend("/nix/store/ydlwparyk4mxl6wzhlp3x54zl3nk82c5-pde")

vim.opt.runtimepath:remove("/home/isaac/.local/share/nvim/site")


setup_plugin("dial")


-- debug.getinfo(2, "S").source:sub(2):match("(.*/)") or "./"

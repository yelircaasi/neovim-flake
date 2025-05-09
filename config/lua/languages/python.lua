print('python.lua loaded')

vim.opt.rtp:prepend("$LSPCONFIG")
local lspconf = require("lspconfig")

vim.lsp.set_log_level('debug')
lspconf.ruff.setup({
    init_options = {
      settings = {
        args = {
          "--line-length=100",
          "--extend-ignore=E501",
          "--select=I",
          "--ignore=C90",
          "--target-version=py311",
        },
}
  }})
vim.lsp.enable("ruff")

-- lspconf.pylsp.setup({
-- 	on_attach = custom_attach,
-- 	settings = {

-- 		pylsp = {
--             auto_source = true,
    
-- 			plugins = {
-- 				-- autopep8 = { enabled = false },
-- 				-- yapf = { enabled = false },

				
-- 				-- pylsp_mypy = {
-- 				-- 	enabled = true,
-- 				-- 	strict = true,
-- 				-- },
-- 				-- rope = {
-- 				-- 	enabled = true,
-- 				-- },
-- 				-- ruff = {
-- 				-- 	enabled = true,
-- 				-- },
-- 				-- jedi_completion = {
-- 				-- 	fuzzy = true,
-- 				-- },
-- 				-- pylint = {
-- 				-- 	enabled = true,
-- 				-- 	executable = "pylint",
-- 				-- },
--                 ruff = {
--                     enabled = true,  -- Enable the plugin
--                     formatEnabled = true,  -- Enable formatting using ruffs formatter
--                     executable = "<path-to-ruff-bin>",  -- Custom path to ruff
--                     config = "<path_to_custom_ruff_toml>",  -- Custom config for ruff to use
--                     extendSelect = { "I" },  -- Rules that are additionally used by ruff
--                     extendIgnore = { "C90" },  -- Rules that are additionally ignored by ruff
--                     format = { "I" },  -- Rules that are marked as fixable by ruff that should be fixed when running textDocument/formatting
--                     severities = { ["D212"] = "I" },  -- Optional table of rules where a custom severity is desired
--                     unsafeFixes = false,  -- Whether or not to offer unsafe fixes as code actions. Ignored with the "Fix All" action
              
--                     -- Rules that are ignored when a pyproject.toml or ruff.toml is present:
--                     lineLength = 120,  -- Line length to pass to ruff checking and formatting
--                     exclude = { "__about__.py" },  -- Files to be excluded by ruff checking
--                     select = { "F" },  -- Rules to be enabled by ruff
--                     ignore = { "D210" },  -- Rules to be ignored by ruff
--                     perFileIgnores = { ["__init__.py"] = "CPY001" },  -- Rules that should be ignored for specific files
--                     preview = false,  -- Whether to enable the preview style linting and formatting.
--                     targetVersion = "py310",  -- The minimum python version to target (applies for both linting and formatting).
--                   },
-- 			},
-- 		},
-- 		flags = {
-- 			debounce_text_changes = 200,
-- 		},
-- 		capabilities = capabilities,
-- 		formatCommand = { "ruff", "format" },
-- 	},
-- })

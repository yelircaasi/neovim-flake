vim.opt.rtp.prepend("TREESITTER")
require'nvim-treesitter.configs'.setup {
    -- ensure_installed = { "python", "lua", "javascript" },  -- Ensure installed parsers
    highlight = { enable = true },
    fold = { enable = false }  -- Disable folding if necessary
  }

require("colors")
-- require("commands")
-- require("mappings")
-- require("options")

-- require("features.file_browser_tree")
-- require("features.status_line")

require("languages.python")
-- require("languages.xit")


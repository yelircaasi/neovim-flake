vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.xit",
  callback = function()
    vim.bo.filetype = "xit"
  end,
})

-- 

vim.cmd [[
  syntax clear
  syntax on
  highlight TSVariable guifg=Green
  highlight link Identifier TSVariable
]]

--

vim.api.nvim_create_augroup('XitFiletypeGroup', { clear = true })

vim.api.nvim_create_autocmd('FileType', {

  group = 'XitFiletypeGroup',
  pattern = 'xit',
  callback = function()
    vim.opt.rtp:prepend("$TREESITTER")
    print(".xit filetype detected")
    vim.opt.rtp:prepend("$XIT")
    vim.opt.rtp:prepend("$TSXIT")
    
    parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
    parser_configs.xit = {
      install_info = {
        url = "$TSXIT",
        files = {"parser"},
        install_dir = "$TSXIT",
        generate_requires_npm = false,
        requires_generate_from_grammar = false,
      },
      filetype = "xit",
    }
    require('nvim-treesitter.configs').setup({
      highlight = {enable = true,},
      -- ensure_installed = { "xit", "python", "lua", "javascript" },
      auto_install = false,
    })

    require('xit').setup({
      disable_default_highlights = false,
      disable_default_mappings = false,
      default_jump_group = "all", -- possible values: all, open_and_ongoing
      wrap_jumps = true,
    })

    vim.api.nvim_set_hl(0, '@XitHeadline', {
      fg = '#FFD700',
      bg = 'NONE',
      bold = true,
      underline = true,
    })
  end,
})
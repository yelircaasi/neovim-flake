--vim.api.nvim_set_hl(0, "Comment", { bg = "Purple" })
--vim.api.nvim_set_hl(0, 'Normal', { fg = "Green", bg = "Red" })
--vim.api.nvim_set_hl(0, 'Error', { fg = "<white>", undercurl = true })
--vim.api.nvim_set_hl(0, 'Cursor', { reverse = true })

--vim.cmd("highlight clear")

print('colors.lua loaded')
vim.cmd("syntax reset")
--vim.g.colors_name = 'melange'

-- local bg = vim.opt.background:get()

-- package.loaded['melange/palettes/' .. bg] = nil -- Only needed for development
--local palette = require('melange/palettes/' .. bg)

--local a = palette.a -- Grays
--local b = palette.b -- Bright foreground colors
--local c = palette.c -- Foreground colors
--local d = palette.d -- Background colors

-- See https://github.com/neovim/neovim/pull/7406
--[[
vim.g.terminal_color_0 = "$color.terminalColor00$"
vim.g.terminal_color_1 = "$color.terminalColor01$"
vim.g.terminal_color_2 = "$color.terminalColor02$"
vim.g.terminal_color_3 = "$color.terminalColor03$"
vim.g.terminal_color_4 = "$color.terminalColor04$"
vim.g.terminal_color_5 = "$color.terminalColor05$"
vim.g.terminal_color_6 = "$color.terminalColor06$"
vim.g.terminal_color_7 = "$color.terminalColor07$"
vim.g.terminal_color_8 = "$color.terminalColor08$"
vim.g.terminal_color_9 = "$color.terminalColor09$"
vim.g.terminal_color_10 = "$color.terminalColor0A$"
vim.g.terminal_color_11 = "$color.terminalColor0B$"
vim.g.terminal_color_12 = "$color.terminalColor0C$"
vim.g.terminal_color_13 = "$color.terminalColor0D$"
vim.g.terminal_color_14 = "$color.terminalColor0E$"
vim.g.terminal_color_15 = "$color.terminalColor0F$"
--]]
local enable_font_variants = true
--vim.g.melange_enable_font_variants == nil or vim.g.melange_enable_font_variants

local bold = enable_font_variants
local italic = enable_font_variants
local underline = enable_font_variants
local undercurl = enable_font_variants
local strikethrough = enable_font_variants

for name, attrs in pairs({
        ---- :help highlight-default -------------------------------

        Normal = { bg = "#000800", fg = "#808080" },
        NormalFloat = { bg = "#000800", fg = "#808080" },
        NormalNC = "Normal",

        -- Cursor: TODO...

        WinSeparator = { bg = "#000800", fg = "#111211" },
        -- VertSplit = { bg = "<|color.nvim.VertSplit.bg |>", fg = "<|color.nvim.VertSplit.fg |>" },
        -- Special = { fg = "<|%color.nvim.Special |>" },
        -- CursorLine = { bg = "<|%color.nvim.CursorLine.bg |>" },

        Identifier = { fg = "#426989" }, --$color.nvim.Identifier.fg$" },
        ["@variable"] = { fg = "#13446c" },
        Function = { fg = "#246b44" },
        Statement = { fg = "#3f0d08" },
        Directory = { fg = "#13446c" },
        String = { fg = "#808080" },
        Comment = { fg = "#333933" },
        PreProc = { fg = "#123622" },
        Operator = { fg = "#246b44" },
        Delimiter = { fg = "#123622" },
        NeotreeFileName = { fg = "#9a9a9a" },

        -- inheriting background from default Nvim* colors
        Search = { fg = "#8AA88A", bg = "#003600" },
        CurSearch = { fg = "#809880", bg = "#002600" },

        StatusLine = { fg = "#455684", bg = "#111211" },
        StatusLineNC = { fg = "#455684", bg = "#111211" },
        Visual = { fg = "#061815", bg = "#0d8f77" },
        Folded = { fg = "#808080", bg = "#001300" },
        DiffAdd = { fg = "#668366", bg = "#002200" },
        DiffChange = { fg = "#7f86f3", bg = "#050a58" },
        DiffDelete = { fg = "#d5776f" },
        DiffText = { fg = "#050a58", bg = "#7f86f3" },
        Pmenu = { fg = "#505ad6", bg = "#000800" },
        PmenuSel = { fg = "#737df1", bg = "#002600" },
        PmenuThumb = { bg = "#777777" },
        CursorColumn = { bg = "#000e00" },
        CursorLine = { bg = "#000e00" },
        ColorColumn = { bg = "#9b73f1" },
        WinBar = { fg = "#dddddd", bg = "#000800" },
        WinBarNC = { fg = "#dddddd", bg = "#000800" },
        FloatShadow = { bg = "#002600" },
        FloatShadowThrough = {
                bg = "#118811",
        },
        MatchParen = { bg = "#51136e" },
        RedrawDebugClear = { bg = "#dddddd" },
        RedrawDebugComposed = {
                bg = "#dddddd",
        },
        RedrawDebugRecompose = {
                bg = "#dddddd",
        },
        Error = { fg = "#bd1dc5", bg = "#000800" },

        -- inheriting foreground from default Nvim* colors
        SpecialKey = { fg = "#491d5e" },
        NonText = { fg = "#111211" },
        Directory = { fg = "#13446c" },
        ErrorMsg = { fg = "#bd1dc5" },
        MoreMsg = { fg = "#1db6c5" },
        ModeMsg = { fg = "#376808" },
        LineNr = { fg = "#333833" },
        Question = { fg = "#402967" },
        WarningMsg = { fg = "#CBC383" },
        SignColumn = { fg = "#1b8984" },
        Conceal = { fg = "#808080", bg = "#000800" },
        QuickFixLine = { fg = "#A30101" },
        Special = { fg = "#49125e" },

        DiagnosticError = { fg = "#bd1dc5" },
        DiagnosticFloatingWarn = { fg = "#CBC383" },
        DiagnosticWarn = { fg = "#CBC383" },
        DiagnosticFloatingInfo = { fg = "#555555" },
        DiagnosticInfo = { fg = "#555555" },
        DiagnosticFloatingHint = { fg = "#9b73f1" },
        DiagnosticHint = { fg = "#9b73f1" },
        DiagnosticFloatingOk = { fg = "#555555" },
        DiagnosticOk = { fg = "#555555" },
        Added = { fg = "#368366" },
        ["@diff.minus"] = { fg = "#d5776f" },
        Removed = { fg = "#d5776f" },
        Changed = { fg = "#7f86f3" },
        CmpItemAbbrDeprecatedDefault = { fg = "#ffffff" },
        CmpItemKindDefault = { fg = "#eeeeee" },
        RainbowDelimiter1 = { fg = "#2b1400" },
        RainbowDelimiter2 = { fg = "#4f473b" },
        RainbowDelimiter3 = { fg = "#381900" },
        RainbowDelimiter4 = { fg = "#726c62" },
        RainbowDelimiter5 = { fg = "#51331a" },
        RainbowDelimiter6 = { fg = "#959189" },
        RainbowDelimiter7 = { fg = "#78604d" },
}) do
        if type(attrs) == "table" then
                vim.api.nvim_set_hl(0, name, attrs)
        else
                vim.api.nvim_set_hl(0, name, { link = attrs })
        end
end
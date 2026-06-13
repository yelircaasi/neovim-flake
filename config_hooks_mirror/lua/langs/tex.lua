utils.packadd("vimtex", function()
	vim.g.vimtex_view_method = "zathura"
end)

-- LINK
-- DESC
local texmagic_defaults = {} -- TODO
setup_plugin("texmagic", texmagic_defaults)

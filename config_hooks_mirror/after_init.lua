utils.printv("Entering after_init.lua.")
require("options")

--─────────────────────────────────────────────────────────────────────────────
--──── GLOBALS ────────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────
map_explicit = utils.map
setup_plugin = utils.setup_plugin
packadd = utils.packadd

--─────────────────────────────────────────────────────────────────────────────
--──── MODULES ────────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────
-- require("commons.fio")
-- require("nio")
-- require("nui.input")
-- require("jsregexp")
-- require("pathlib")

--─────────────────────────────────────────────────────────────────────────────
--──── colorscheme ────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────
require("colors")

--─────────────────────────────────────────────────────────────────────────────
--──── modules ────────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

local ALL_config_modules = {
	["options"] = true,
	["core"] = true, -- empty
	["ui"] = true,

	["clipboard"] = true,
	["cloud"] = true,
	["colors"] = true,
	["execution"] = true,

	["completion"] = true,
	["explorers"] = true,
	["testing"] = true,
	["lsp_etc"] = true,

	["editing"] = true,
	["folding"] = true,
	["search"] = true,
	["navigation"] = true,

	["telescope_etc"] = true,
	["diff"] = true,
	["terminal"] = true,
	["debugging"] = true,
	["projects"] = true,
	["macros"] = true,

	["task_runner"] = true,
	["replacer"] = true,

	["git"] = true,
	["ai"] = true,

	["mappings"] = true, -- TODO: move out to respective files

	["tmp"] = true,

	["langs.multilang"] = false,
	["langs.go"] = false,
	["langs.haskell"] = true,
	["langs.json_yaml"] = true,
	["langs.lua_language"] = false,
	["langs.markdown"] = false,
	["langs.nix"] = true,
	["langs.rust"] = true,
	["langs.tex"] = false,
	["langs.typst"] = false,
	["langs.xit"] = false,

	["miscellaneous"] = false, -- TODO
	["experimental"] = true,
}
-- TMP
config_modules = {
	["options"] = true,
	["lsp_etc"] = true,
	["editing"] = true,
	["navigation"] = true,
	["ui"] = true,
	["treesitter"] = true,
	["core"] = true,
	["langs.python"] = true,
	["colors"] = true,
	["experimental"] = false,
}
local function maybe_require(mod_name)
	local include = config_modules[mod_name]
	if include then
		-- print("Requiring " .. mod_name)
		require(mod_name)
	end
end

maybe_require("options")
maybe_require("lsp_etc")
maybe_require("editing")
maybe_require("navigation")
maybe_require("treesitter")
maybe_require("core")
maybe_require("langs.python")
maybe_require("colors")
maybe_require("ui")
maybe_require("experimental")

utils.printv("Reached end of after_init.lua.")

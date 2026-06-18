utils.printv("Entering after_init.lua.")

--─────────────────────────────────────────────────────────────────────────────
--──── OPTIONS ────────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────
require("options")

--─────────────────────────────────────────────────────────────────────────────
--──── GLOBALS ────────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────
map_explicit = utils.map
setup_plugin = utils.setup_plugin
packadd = utils.packadd

--─────────────────────────────────────────────────────────────────────────────
--──── DEPENDENCY MODULES ─────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────
-- require("commons.fio")
-- require("nio")
-- require("nui.input")
-- require("jsregexp")
-- require("pathlib")

--─────────────────────────────────────────────────────────────────────────────
--──── COLORSCHEME ────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────
require("colors")

--─────────────────────────────────────────────────────────────────────────────
--──── CONFIG MODULES ─────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────
config_modules = {
	["ui"] = true,
	["treesitter"] = true,
	["lsp_etc"] = true,
	["editing"] = true,
	["navigation"] = true,
	["langs.python"] = true,
	["mappings"] = true,

	["ai"] = false,
	["clipboard"] = true,
	["cloud"] = false,
	["completion"] = false,
	["core"] = false, -- empty
	["debugging"] = true,
	["diff"] = false,
	["execution"] = false,
	["experimental"] = false,
	["explorers"] = true,
	["folding"] = true,
	["git"] = false,
	["langs.go"] = false,
	["langs.haskell"] = false,
	["langs.json_yaml"] = false,
	["langs.lua_language"] = false,
	["langs.markdown"] = false,
	["langs.multilang"] = false,
	["langs.nix"] = false,
	["langs.rust"] = false,
	["langs.tex"] = false,
	["langs.typst"] = false,
	["langs.xit"] = false,
	["lsp_etc"] = false,
	["macros"] = false,
	["miscellaneous"] = false,
	["projects"] = false,
	["replacer"] = false,
	["search"] = false,
	["task_runner"] = false,
	["telescope_etc"] = false,
	["terminal"] = false,
	["testing"] = false,
	["tmp"] = false,
}
local function maybe_require(mod_name)
	local include = config_modules[mod_name]
	if include then
		require(mod_name)
	end
end

maybe_require("lsp_etc")
maybe_require("editing")
maybe_require("navigation")
maybe_require("treesitter")
maybe_require("core")
maybe_require("langs.python")
maybe_require("ui")
maybe_require("experimental")
maybe_require("clipboard")
maybe_require("cloud")
maybe_require("execution")
maybe_require("completion")
maybe_require("explorers")
maybe_require("testing")
maybe_require("folding")
maybe_require("search")
maybe_require("telescope_etc")
maybe_require("diff")
maybe_require("terminal")
maybe_require("debugging")
maybe_require("projects")
maybe_require("macros")
maybe_require("task_runner")
maybe_require("replacer")
maybe_require("git")
maybe_require("ai")
maybe_require("mappings")
maybe_require("langs.multilang")
maybe_require("langs.go")
maybe_require("langs.haskell")
maybe_require("langs.json_yaml")
maybe_require("langs.lua_language")
maybe_require("langs.markdown")
maybe_require("langs.nix")
maybe_require("langs.rust")
maybe_require("langs.tex")
maybe_require("langs.typst")
maybe_require("langs.xit")
maybe_require("miscellaneous")
maybe_require("tmp")
maybe_require("experimental")

--─────────────────────────────────────────────────────────────────────────────
--──── DEBUG INFO ─────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────
utils.printv("Reached end of after_init.lua.")

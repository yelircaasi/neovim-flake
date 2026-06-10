-- OLD utils.packadd("markdown-preview")
-- nix rebuild setup_plugin("mkdp", {})
-- nix rebuild setup_plugin("structlog", {})
setup_plugin("firenvim", function(_) end)
setup_plugin("render-markdown", {})
setup_plugin("jupytext", {})
setup_plugin("quarto", {})
utils.packadd("asyncrun") -- install as lua module

setup_plugin("schemastore", function(_) end)
setup_plugin("render-markdown", {})

-- TODO

-- hacky, but works -> necessary due to name collision
-- local function setup_dashboard()
-- 	utils.packadd("dashboard-nvim")
-- 	local dashboard = require("dashboard")
-- 	dashboard.setup()
-- end

-- TODO: fix error
-- setup_plugin_explicit("dashboard-nvim", "dashboard", {})

setup_plugin("dashboard", {})

local COMPLICATIONS = false

if COMPLICATIONS then
	-- utils.packadd("neomux")         TODO: debug nvr-go
	-- setup_plugin("kubernetes", {})  TODO: install kubectl
	-- setup_plugin("nvim_winpick", {}) -- RUST
	-- setup_plugin("xmake", {}) TODO: install xmake
	-- setup_plugin("feed", {}) FIX OPTIONS
	-- setup_plugin("hierarchy", {}) -- null global error
	-- config error setup_plugin("daily-focus", {})

	-- SEEM TO HANG INDEFINITELY
	-- setup_plugin("shade", {})
	-- setup_plugin("sunglasses", {})
	-- setup_plugin("TreePin", {}) REQUIRES UPDATE FROM nvim-treesitter

	-- setup_plugin("lvim-ui-config", {}) -- not requirable

	-- setup_plugin("edit-list", {}) -- expects /home/isaac/.cache/nvim/edit-list.json

	-- setup_plugin("jvim", {})  -- DEPENDS ON nvim-treesitter
	-- setup_plugin("doc-window", {}) DEPENDS ON ts_utils
	-- setup_plugin("sg", {}) -- requires interactive input
	-- setup_plugin("windows", {}) ERRORRED
	setup_plugin("chadtree", {}) -- annoying messages & non-nix install habits
end

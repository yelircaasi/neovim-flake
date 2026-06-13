local function get_sqlite() -- TODO: move to utils? move sqlite to modules?
	vim.cmd(":packadd sqlite")
	return require("sqlite")
end

local neocomposer_defaults = {
	notify = true,
	delay_timer = 150,
	queue_most_recent = false,
	window = {
		width = 60,
		height = 10,
		border = "rounded",
		winhl = {
			Normal = "ComposerNormal",
		},
	},
	colors = {
		bg = "#16161e",
		fg = "#ff9e64",
		red = "#ec5f67",
		blue = "#5fb3b3",
		green = "#99c794",
	},
	keymaps = {
		play_macro = "Q",
		yank_macro = "yq",
		stop_macro = "cq",
		toggle_record = "q",
		cycle_next = "<c-n>",
		cycle_prev = "<c-p>",
		toggle_macro_menu = "<m-q>",
	},
}
get_sqlite()
setup_plugin("NeoComposer", function(neocomposer)
	neocomposer.setup(neocomposer_defaults)
end)

-- TODO: resolve & remove duplication
-- LINK
-- DESC
local neocomposer_nvim_defaults = {} -- TODO
setup_plugin("neocomposer-nvim", neocomposer_nvim_defaults)

local nvim_macros_defaults = {
	json_file_path = "./macros.json",
	default_macro_register = "a",
	json_formatter = "jq",
}
setup_plugin("nvim-macros", nvim_macros_defaults)

local recorder_defaults = {
	-- Named registers where macros are saved (single lowercase letters only).
	-- The first register is the default register used as macro-slot after
	-- startup.
	slots = { "a", "b" },

	-- specify one of options:
	-- [static]   -> use static slots, this is default behaviour
	-- [rotate]   -> rotates through letters specified in slots[]
	dynamicSlots = "static",

	mapping = {
		startStopRecording = "q",
		playMacro = "Q",
		switchSlot = "<C-q>",
		editMacro = "cq",
		deleteAllMacros = "dq",
		yankMacro = "yq",
		-- ⚠️ this should be a string you don't use in insert mode during a macro
		addBreakPoint = "##",
	},

	-- Clears all macros-slots on startup.
	clear = false,

	-- Log level used for non-critical notifications; mostly relevant for nvim-notify.
	-- (Note that by default, nvim-notify does not show the levels `trace` & `debug`.)
	logLevel = vim.log.levels.INFO, -- :help vim.log.levels

	-- If enabled, only essential notifications are sent.
	-- If you do not use a plugin like nvim-notify, set this to `true`
	-- to remove otherwise annoying messages.
	lessNotifications = false,

	-- Use nerdfont icons in the status bar components and keymap descriptions
	useNerdfontIcons = true,

	-- Performance optimizations for macros with high count. When `playMacro` is
	-- triggered with a count higher than the threshold, nvim-recorder
	-- temporarily changes changes some settings for the duration of the macro.
	performanceOpts = {
		countThreshold = 100,
		lazyredraw = true, -- enable lazyredraw (see `:h lazyredraw`)
		noSystemClipboard = true, -- remove `+`/`*` from clipboard option
		autocmdEventsIgnore = { -- temporarily ignore these autocmd events
			"TextChangedI",
			"TextChanged",
			"InsertLeave",
			"InsertEnter",
			"InsertCharPre",
		},
	},

	-- [experimental] partially share keymaps with nvim-dap.
	-- (See README for further explanations.)
	dapSharedKeymaps = false,
}
setup_plugin("recorder", recorder_defaults)

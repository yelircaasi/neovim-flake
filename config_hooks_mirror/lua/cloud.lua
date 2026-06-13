local kubectl_defaults = {
	log_level = vim.log.levels.INFO,
	auto_refresh = {
		enabled = true,
		interval = 300, -- milliseconds
	},
	diff = {
		bin = "kubediff", -- or any other binary
	},
	kubectl_cmd = { cmd = "kubectl", env = {}, args = {} },
	terminal_cmd = nil, -- Exec will launch in a terminal if set, i.e. "ghostty -e"
	namespace = "All",
	namespace_fallback = {}, -- If you have limited access you can list all the namespaces here
	headers = {
		enabled = true,
		hints = true,
		context = true,
		heartbeat = true,
		blend = 20,
		skew = {
			enabled = true,
			log_level = vim.log.levels.OFF,
		},
	},
	lineage = {
		enabled = true, -- This feature is in beta at the moment
	},
	logs = {
		prefix = true,
		timestamps = true,
		since = "5m",
	},
	alias = {
		apply_on_select_from_history = true,
		max_history = 5,
	},
	filter = {
		apply_on_select_from_history = true,
		max_history = 10,
	},
	filter_label = {
		max_history = 20,
	},
	float_size = {
		-- Almost fullscreen:
		-- width = 1.0,
		-- height = 0.95, -- Setting it to 1 will cause bottom to be cutoff by statuscolumn

		-- For more context aware size:
		width = 0.9,
		height = 0.8,

		-- Might need to tweak these to get it centered when float is smaller
		col = 10,
		row = 5,
	},
	statusline = {
		enabled = true,
	},
	obj_fresh = 5, -- highlight if creation newer than number (in minutes)
	api_resources_cache_ttl = 60 * 60 * 3, -- 3 hours in seconds
}

-- https://github.com/Ramilito/kubectl.nvim
--  Streamline your Kubernetes management within Neovim—control and monitor your cluster seamlessly, all without leaving your coding environment.
local kubectl_defaults = {} -- TODO
setup_plugin("kubectl", kubectl_defaults)

local kpops_defaults = {}
setup_plugin("kpops", kpops_defaults) -- TODO: install https://github.com/bakdata/kpops

local kubels_defaults = {}
setup_plugin("kubels", kubels_defaults)

local function setup_vim_helm() end
utils.packadd("vim-helm", setup_vim_helm)

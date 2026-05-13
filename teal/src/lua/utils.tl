local function setup(config: UtilsConfig): Utils
	local VERBOSE = config.verbose
	local prepend_safe = config.prepend_safe
	local PLUGIN_PATHS = config.plugin_paths
	local DEPENDENCIES = config.dependencies
	local LAYERS = config.layers
	local PLUGINS_BY_LAYER = config.plugins_by_layer

	local M: Utils = {}

	local trivial = function(_: string): nil
	   return nil
	end

	if VERBOSE then
	    M.printv = print as function(msg: string): nil
	else
	    M.printv = trivial
	end

	M.PLUGINS_INCLUDED = {}
	for _, layer in ipairs(LAYERS) do
		M.printv("layer" .. layer)
	    local layer_table: {number: {string}} = PLUGINS_BY_LAYER[layer]
	    if VERBOSE then
			print("--- layer " .. tostring(layer) .. ": " .. #layer_table .. " plugins")
			print(vim.inspect(layer_table))
		end
        
	    for _, names in pairs(layer_table) do
			for _, name in ipairs(names) do
				if VERBOSE then print(name) end
			    table.insert(M.PLUGINS_INCLUDED, name)
			end
	    end
	end

	M.printb = function(msg: string): nil
	    local bar = string.rep("=", 120)
	    local end_bar = string.rep("=", 115 - #msg)
	    print(bar)
	    print("=== " .. msg .. " " .. end_bar)
	    print(bar)
	end

	if VERBOSE then
	    M.printbv = M.printb
	else
	    M.printbv = trivial
	end

	M.call_safe = function<T>(
	   func: function(table): T,
	   single_arg: table,
	   err_msg: string
	): boolean, T
	    local result, return_value = pcall(func, single_arg) as boolean, T
	    if not result then
		   M.printb(err_msg)
		   return false, nil
	    else
		   return true, return_value
	    end
	end

	M.print_status = function(length: integer, prefix: string, name: string, suffix: string)
	    local pad = string.rep(" ", length - #name)
	    M.printv(prefix .. " " .. name .. pad .. " " .. suffix)
	end

	M.is_included = function(plugin_name: string): boolean
	    return vim.tbl_contains(M.PLUGINS_INCLUDED, plugin_name)
	end

	M.get_plugin = function(plugin_name: string): Plugin
	    if not M.is_included(plugin_name) then return nil end
	    local path = PLUGIN_PATHS[plugin_name]
	    local deps = DEPENDENCIES[plugin_name]
	    if deps then
		   for _, dep_name in ipairs(deps) do
			  local dep_path = PLUGIN_PATHS[dep_name]
			  if dep_path then prepend_safe(dep_path) end
		   end
	    end
	    if path then prepend_safe(path) end
		vim.cmd("packadd " .. plugin_name)
	    local required = require(plugin_name) as Plugin
	    return required
	end

	M.packadd_default = function(plugin_name: string, custom_func?: function())
	    if not M.is_included(plugin_name) then return end
	    local path = PLUGIN_PATHS[plugin_name]
	    local deps = DEPENDENCIES[plugin_name]
	    if path then prepend_safe(path) end
	    if deps then
		   for _, dep_name in ipairs(deps) do
			  local dep_path = PLUGIN_PATHS[dep_name]
			  if dep_path then prepend_safe(dep_path) end
		   end
	    end
	    vim.cmd("packadd " .. plugin_name)
	    if custom_func is nil then return end
		custom_func()
	end

	M.packadd_safe = function(plugin_name: string, custom_func?: function())
		local result, plugin = pcall(M.packadd_default, plugin_name, custom_func) as (boolean, Plugin)
	    if not result then
		   M.printv("ERROR: vimscript plugin require unsuccessful: " .. plugin_name)
		   M.printv(plugin as string)
		   return
	    end
	end

	M.setup_plugin_safe = function(plugin_name: string, config_or_function?: PluginConfig | function(Plugin)): nil
	    if not M.is_included(plugin_name) then return end
	    local result, plugin = pcall(M.get_plugin, plugin_name) as (boolean, Plugin)
	    if not result then
		   M.printv("ERROR: plugin require unsuccessful: " .. plugin_name)
		   M.printv(plugin as string)
		   return
	    end
	    if not config_or_function then return end

	    if config_or_function is PluginConfig then
			local plugin_with_setup = plugin as PluginWithSetup
			M.call_safe(plugin_with_setup.setup, config_or_function, "ERROR: configuring" .. plugin_name)
	    elseif config_or_function is function then
			M.call_safe(config_or_function, plugin, "ERROR: custom setup function failed for " .. plugin_name)
	    end
	end

	M.setup_plugin_default = function(plugin_name: string, config_or_function?: PluginConfig | function(Plugin)): nil
	    if not M.is_included(plugin_name) then return end
	    local plugin = M.get_plugin(plugin_name)
	    if not config_or_function then return end

	    if config_or_function is PluginConfig then
			local plugin_with_setup = plugin as PluginWithSetup
			plugin_with_setup.setup(config_or_function) return
	   end
	   if config_or_function is function then
			config_or_function(plugin) return
	    end
	end

	if config.safe then
	    M.setup_plugin = M.setup_plugin_safe
		M.packadd = M.packadd_safe
	else
	    M.setup_plugin = M.setup_plugin_default
	    M.packadd = M.packadd_default
	end

	M.map = function(mode: string | {string}, lhs: string, rhs: string | function(), opts?: vim.keymap.SetOpts): nil
		vim.keymap.set(mode, lhs, rhs, (opts or {}) as vim.keymap.SetOpts)
	end

	return M
end

return { setup = setup }

local function setup(config)
   local VERBOSE = config.verbose
   local prepend_safe = config.prepend_safe
   local PLUGIN_PATHS = config.plugin_paths
   local DEPENDENCIES = config.dependencies
   local LAYERS = config.layers
   local PLUGINS_BY_LAYER = config.plugins_by_layer

   local M = {}

   local trivial = function(_)
      return nil
   end

   if VERBOSE then
      M.printv = print
   else
      M.printv = trivial
   end

   M.PLUGINS_INCLUDED = {}
   for _, layer in ipairs(LAYERS) do
      M.printv("layer" .. layer)
      local layer_table = PLUGINS_BY_LAYER[layer]
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

   M.printb = function(msg)
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

   M.call_safe = function(
      func,
      single_arg,
      err_msg)

      local result, return_value = pcall(func, single_arg), T
      if not result then
         M.printb(err_msg)
         return false, nil
      else
         return true, return_value
      end
   end

   M.print_status = function(length, prefix, name, suffix)
      local pad = string.rep(" ", length - #name)
      M.printv(prefix .. " " .. name .. pad .. " " .. suffix)
   end

   M.is_included = function(plugin_name)
      return vim.tbl_contains(M.PLUGINS_INCLUDED, plugin_name)
   end

   M.get_plugin = function(plugin_name)
      if not M.is_included(plugin_name) then return nil end
      local path = PLUGIN_PATHS[plugin_name]
      local deps = DEPENDENCIES[plugin_name]
      prepend_safe(path)
      if deps then
         for _, dep_name in ipairs(deps) do
            local dep_path = PLUGIN_PATHS[dep_name]
            prepend_safe(dep_path)
         end
      end
      local required = require(plugin_name)
      return required
   end

   local function packadd_default(plugin_name, custom_func)
      if not M.is_included(plugin_name) then return end
      local path = PLUGIN_PATHS[plugin_name]
      prepend_safe(path)
      vim.cmd("packadd " .. plugin_name)
      if custom_func == nil then return end
      custom_func()
   end

   local function packadd_safe(plugin_name, custom_func)
      local result, plugin = pcall(packadd_default, plugin_name, custom_func)
      if not result then
         M.printv("ERROR: vimscript plugin require unsuccessful: " .. plugin_name)
         return
      end
   end

   local function setup_plugin_safe(plugin_name, config_or_function)
      if not M.is_included(plugin_name) then return end
      local result, plugin = pcall(M.get_plugin, plugin_name)
      if not result then
         M.printv("ERROR: plugin require unsuccessful: " .. plugin_name)
         return
      end
      if not config_or_function then return end

      if type(config_or_function) == "table" then
         local plugin_with_setup = plugin
         M.call_safe(plugin_with_setup.setup, config_or_function, "ERROR: configuring" .. plugin_name)
      elseif type(config_or_function) == "function" then
         M.call_safe(config_or_function, plugin, "ERROR: custom setup function failed for " .. plugin_name)
      end
   end

   local function setup_plugin_default(plugin_name, config_or_function)
      if not M.is_included(plugin_name) then return end
      local plugin = M.get_plugin(plugin_name)
      if not config_or_function then return end

      if type(config_or_function) == "table" then
         local plugin_with_setup = plugin
         plugin_with_setup.setup(config_or_function); return
      end
      if type(config_or_function) == "function" then
         config_or_function(plugin); return
      end
   end

   if config.safe then
      M.setup_plugin = setup_plugin_safe
      M.packadd = packadd_safe
   else
      M.setup_plugin = setup_plugin_default
      M.packadd = packadd_default
   end

   M.map = function(mode, lhs, rhs, opts)
      vim.keymap.set(mode, lhs, rhs, (opts or {}))
   end

   return M
end

return { setup = setup }

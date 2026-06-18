global type vim = require("vim")

global record PluginConfig end

global type Plugin = {string: any}

global type Printer = function(string)

global record PluginWithSetup
	setup: function(PluginConfig)
end

global type SetupFunction = function(string, ? PluginConfig | function(Plugin)): Plugin|nil

global type CustomSetupFunction = function(Plugin)

global type MapFunction = function(spec: KeymapSpec): nil

global record KeymapSpec
	mode: string|{string}
	sequence: string
	action: string|function():nil
	opts: vim.keymap.SetOpts|nil
	desc: string|nil
end

global record Utils
	PLUGINS_INCLUDED: {string}
	printv: Printer
	printb: Printer
	printbv: Printer
	mkprint: function(string): Printer
	call_safe: function(function, any, string): boolean, any
	print_status: function(integer, string, string, string)
	is_included: function(string): boolean
	get_plugin: function(string): Plugin
	setup_plugin: SetupFunction
	setup_plugin_default: SetupFunction
	setup_plugin_safe: SetupFunction
	setup_plugin_special: function(string, string, ? PluginConfig | function(Plugin)): Plugin|nil
	packadd: function(string, ? function())
	packadd_default: function(string, ? function())
	packadd_safe: function(string, ? function())
	get_executable: function(string): string
	map: MapFunction
end

global record UtilsConfig
	verbose: boolean
	safe: boolean
	prepend_safe: function(string): nil
	plugin_paths: {string:string}
	dependencies: {string:{string}}
	layers: {number}
	plugins_by_layer: {number:{number:{string}}}
end

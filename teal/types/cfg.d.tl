global type vim = require("vim")

global record PluginConfig end

global type Plugin = {string: any}

global record PluginWithSetup
	setup: function(PluginConfig)
end

global type SetupFunction = function(string, ? PluginConfig | function(Plugin)): Plugin|nil

global type CustomSetupFunction = function(Plugin)

global type MapFunction = function(
	string|{string},
	string,
	string|function(),
	? vim.keymap.SetOpts
)

global record Utils
	PLUGINS_INCLUDED: {string}
	printv: function(string): nil
	printb: function(string): nil
	printbv: function(string): nil
	call_safe: function(function, any, string): boolean, any
	print_status: function(integer, string, string, string)
	is_included: function(string): boolean
	get_plugin: function(string): Plugin
	setup_plugin: SetupFunction
	setup_plugin_default: SetupFunction
	setup_plugin_safe: SetupFunction
	packadd: function(string, ? function())
	packadd_default: function(string, ? function())
	packadd_safe: function(string, ? function())
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

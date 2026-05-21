setup_plugin("NeoComposer")
setup_plugin("nvim-macros", {
	json_file_path = "./macros.json",
	default_macro_register = "a",
	json_formatter = "jq",
})
setup_plugin("recorder")

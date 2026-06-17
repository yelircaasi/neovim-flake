-- https://github.com/figsoda/nix-develop.nvim
-- Run `nix develop` without restarting neovim
local nix_develop_defaults = nil
setup_plugin("nix-develop", function(nd)
	-- examples
	nd.ignored_variables["SHELL"] = false
	nd.separated_variables["LUA_PATH"] = ":"

	-- === functions available for binding: =========
	-- nd.enter_dev_env
	-- nd.devenv_shell
	-- nd.nix_develop
	-- nd.nix_shell
	-- ==============================================

	-- vim:tw=78:ts=8:noet:ft=help:norl:
end)
--[[
:NixDevelop
:NixDevelop .#foo
:NixDevelop --impure

:NixShell
:NixShell nixpkgs#hello

:DevenvShell
:DevenvShell --profile foo
--]]

vim.lsp.config["nixd"] = {
	cmd = { "nixd" },
	filetypes = { "nix" },
	root_markers = { "flake.nix", ".git" },
	settings = {},
}

vim.lsp.enable("nixd")

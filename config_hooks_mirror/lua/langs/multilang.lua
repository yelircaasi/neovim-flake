--─────────────────────────────────────────────────────────────────────────────
--──── live preview ───────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- TODO: set up with qutebrowser, sioyek
-- https://github.com/frabjous/knap
-- Neovim plugin for creating live-updating-as-you-type previews of LaTeX, markdown, and other files in the viewer of your choice.
vim.g.knap_settings = {
	htmloutputext = "html",
	htmltohtml = "none",
	htmltohtmlviewerlaunch = "falkon %outputfile%",
	htmltohtmlviewerrefresh = "none",
	mdoutputext = "html",
	mdtohtml = "pandoc --standalone %docroot% -o %outputfile%",
	mdtohtmlviewerlaunch = "falkon %outputfile%",
	mdtohtmlviewerrefresh = "none",
	mdtopdf = "pandoc %docroot% -o %outputfile%",
	mdtopdfviewerlaunch = "sioyek %outputfile%",
	mdtopdfviewerrefresh = "none",
	markdownoutputext = "html",
	markdowntohtml = "pandoc --standalone %docroot% -o %outputfile%",
	markdowntohtmlviewerlaunch = "falkon %outputfile%",
	markdowntohtmlviewerrefresh = "none",
	markdowntopdf = "pandoc %docroot% -o %outputfile%",
	markdowntopdfviewerlaunch = "sioyek %outputfile%",
	markdowntopdfviewerrefresh = "none",
	texoutputext = "pdf",
	textopdf = "pdflatex -interaction=batchmode -halt-on-error -synctex=1 %docroot%",
	textopdfviewerlaunch = "sioyek --inverse-search 'nvim --headless -es --cmd \"lua require('\"'\"'knaphelper'\"'\"').relayjump('\"'\"'%servername%'\"'\"','\"'\"'%1'\"'\"',%2,%3)\"' --new-window %outputfile%",
	textopdfviewerrefresh = "none",
	textopdfforwardjump = "sioyek --inverse-search 'nvim --headless -es --cmd \"lua require('\"'\"'knaphelper'\"'\"').relayjump('\"'\"'%servername%'\"'\"','\"'\"'%1'\"'\"',%2,%3)\"' --reuse-window --forward-search-file %srcfile% --forward-search-line %line% %outputfile%",
	textopdfshorterror = 'A=%outputfile% ; LOGFILE="${A%.pdf}.log" ; rubber-info "$LOGFILE" 2>&1 | head -n 1',
	delay = 250,
}
setup_plugin("knap", function(knap)
	-- set shorter name for keymap function
	local kmap = vim.keymap.set

	-- F5 processes the document once, and refreshes the view
	kmap({ "n", "v", "i" }, "<F5>", function()
		require("knap").process_once()
	end)

	-- F6 closes the viewer application, and allows settings to be reset
	kmap({ "n", "v", "i" }, "<F6>", function()
		require("knap").close_viewer()
	end)

	-- F7 toggles the auto-processing on and off
	kmap({ "n", "v", "i" }, "<F7>", function()
		require("knap").toggle_autopreviewing()
	end)

	-- F8 invokes a SyncTeX forward search, or similar, where appropriate
	kmap({ "n", "v", "i" }, "<F8>", function()
		require("knap").forward_jump()
	end)
end)

--─────────────────────────────────────────────────────────────────────────────
--──── quicktype ──────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- TODO: install quicktype
-- https://github.com/midoBB/nvim-quicktype
-- Generate types from JSON all inside Neovim
local nvim_quicktype_defaults = {
	global = {
		-- Quicktype global options
		cmd = "quicktype", -- Path to the quicktype executable
		src_lang = "json", -- The language of the input
		no_combine_classes = false, -- Do not combine classes with shared properties into a single base class
		all_properties_optional = false, -- Make all properties optional
		alphabetize_properties = false, -- Alphabetize properties
		telemetry = "disable", -- Send telemetry data to Quicktype (can be "enable", or "disable")
		output_file = nil, -- Output file (if not specified, output is printed to stdout)
		debug_dir = nil, -- Directory to write debug info to (if not specified, no debug info is written)
		clipboard_source_register = nil, -- Register from which to read the copied JSON (if not specified, if will default to system then to unnamed and lastly to 0 register)
	},
	filetypes = {
		-- Quicktype language-specific options
		typescript = {
			lang = "typescript", -- The language to generate types for
			additional_options = {
				-- Add any additional options here
				-- Example:
				-- ["just-types"] = true,
				-- ["prefer-unions"] = true,
			},
		},
		python = {
			lang = "python", -- The language to generate types for
			additional_options = {},
		},
		-- Add more filetypes as needed
	},
}
setup_plugin("nvim-quicktype", nvim_quicktype_defaults)

--─────────────────────────────────────────────────────────────────────────────
--──── embedded code/text ─────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

-- https://github.com/acksld/nvim-femaco.lua
-- Catalyze your Fenced Markdown Code-block editing!
local FeMaco_defaults = {
	-- should prepare a new buffer and return the winid
	-- by default opens a floating window
	-- provide a different callback to change this behaviour
	-- @param opts: the return value from float_opts
	prepare_buffer = function(opts)
		local buf = vim.api.nvim_create_buf(false, false)
		return vim.api.nvim_open_win(buf, true, opts)
	end,
	-- should return options passed to nvim_open_win
	-- @param code_block: data about the code-block with the keys
	--   * range
	--   * lines
	--   * lang
	float_opts = function(code_block)
		return {
			relative = "cursor",
			width = clip_val(5, 120, vim.api.nvim_win_get_width(0) - 10), -- TODO how to offset sign column etc?
			height = clip_val(5, #code_block.lines, vim.api.nvim_win_get_height(0) - 6),
			anchor = "NW",
			row = 0,
			col = 0,
			style = "minimal",
			border = "rounded",
			zindex = 1,
		}
	end,
	-- return filetype to use for a given lang
	-- lang can be nil
	ft_from_lang = function(lang)
		return lang
	end,
	-- what to do after opening the float
	post_open_float = function(winnr)
		vim.wo.signcolumn = "no"
	end,
	-- create the path to a temporary file
	create_tmp_filepath = function(filetype)
		return os.tmpname()
	end,
	-- if a newline should always be used, useful for multiline injections
	-- which separators needs to be on separate lines such as markdown, neorg etc
	-- @param base_filetype: The filetype which FeMaco is called from, not the
	-- filetype of the injected language (this is the current buffer so you can
	-- get it from vim.bo.filetyp).
	ensure_newline = function(base_filetype)
		return false
	end,
	-- Return true if the indentation should be normalized. Useful when the
	-- injected language inherits indentation from the construction scope (e.g. an
	-- inline multiline sql string). If true, the leading indentation is detected,
	-- stripped, and restored before/after editing.
	--
	-- @param base_filetype: The filetype which FeMaco is called from, not the
	-- filetype of the injected language (this is the current buffer, so you can
	-- get it from vim.bo.filetype).
	normalize_indent = function(base_filetype)
		return false
	end,
}
setup_plugin("FeMaco", FeMaco_defaults)

-- https://github.com/jmbuhr/otter.nvim
-- tldr: Otter.nvim provides lsp features, including code completion, for code embedded in other documents
-- now a language server-client combo, which means you don't have to configure keybindings for it.
--     Just call otter.activate()!
local otter_defaults = {
	lsp = {
		-- `:h events` that cause the diagnostics to update. Set to:
		-- { "BufWritePost", "InsertLeave", "TextChanged" } for less performant
		-- but more instant diagnostic updates
		diagnostic_update_events = { "BufWritePost" },
		-- function to find the root dir where the otter-ls is started
		root_dir = function(_, bufnr)
			return vim.fs.root(bufnr or 0, {
				".git",
				"_quarto.yml",
				"package.json",
			}) or vim.fn.getcwd(0)
		end,
	},
	-- options related to the otter buffers
	buffers = {
		-- if set to true, the filetype of the otterbuffers will be set.
		-- otherwise only the autocommand of lspconfig that attaches
		-- the language server will be executed without setting the filetype
		--- this setting is deprecated and will default to true in the future
		set_filetype = true,
		-- write <path>.otter.<embedded language extension> files
		-- to disk on save of main buffer.
		-- usefule for some linters that require actual files.
		-- otter files are deleted on quit or main buffer close
		write_to_disk = false,
		-- a table of preambles for each language. The key is the language and the value is a table of strings that will be written to the otter buffer starting on the first line.
		preambles = {},
		-- a table of postambles for each language. The key is the language and the value is a table of strings that will be written to the end of the otter buffer.
		postambles = {},
		-- A table of patterns to ignore for each language. The key is the language and the value is a lua match pattern to ignore.
		-- lua patterns: https://www.lua.org/pil/20.2.html
		ignore_pattern = {
			-- ipython cell magic (lines starting with %) and shell commands (lines starting with !)
			python = "^(%s*[%%!].*)",
		},
	},
	-- remove whitespace from the beginning of the code chunks when writing to the otter buffers
	-- and calculate it back in when handling lsp requests
	handle_leading_whitespace = true,
	-- mapping of filetypes to extensions for those not already included in otter.tools.extensions
	-- e.g. ["bash"] = "sh"
	extensions = {},
	-- add event listeners for LSP events for debugging
	debug = false,
	verbose = { -- set to false to disable all verbose messages
		no_code_found = false, -- warn if otter.activate is called, but no injected code was found
	},
}
setup_plugin("otter", otter_defaults)

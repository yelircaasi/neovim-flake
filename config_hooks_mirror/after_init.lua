print("Entering after_init.lua.")

utils.printv("CONFIG_DIR: " .. CONFIG_DIR)
utils.printv("PLUGINS INCLUDED: " .. vim.inspect(utils.PLUGINS_INCLUDED))
utils.printbv(#utils.PLUGINS_INCLUDED .. " plugins included")

local setup_plugin = utils.setup_plugin
local packadd = utils.packadd
local map = utils.map

-- utils.printbv(#utils.PLUGINS_INCLUDED .. " plugins included")



-- WEZTERM ========================================================================================

-- WEZTERM SCRATCH

if WEZTERM then
	-- https://github.com/ianhomer/wezterm.nvim/blob/main/lua/wezterm.lua --------------------------------------------------
	local wez = {}

	local directions = {
		h = "Left",
		l = "Right",
		j = "Down",
		k = "Up",
	}

	local arrows = {
		h = "left",
		l = "right",
		j = "down",
		k = "up",
	}

	local function command(args)
		os.execute("wezterm cli " .. args)
	end

	function wez.navigate(direction)
		command("activate-pane-direction " .. directions[direction])
	end

	function wez.go_direction(direction)
		local current_window = vim.fn.win_getid()
		vim.api.nvim_command("wincmd " .. direction)
		local at_edge = current_window == vim.fn.win_getid()
		if at_edge then
			wez.navigate(direction)
		end
	end

	function wez.keys()
		local keys = {}
		for key, _ in pairs(directions) do
			table.insert(keys, {
				"<c-" .. key .. ">",
				function()
					wez.go_direction(key)
				end,
				mode = { "n" },
				desc = "Navigate " .. arrows[key],
			})
		end

		return keys
	end

	function wez.setup(opts)
		for key, _ in pairs(directions) do
			vim.keymap.set("", "<c-" .. key .. ">", function()
				wez.go_direction(key)
			end)
			-- support ctrl arrow keys in normal an insert mode
			vim.keymap.set({ "i", "n", "v", "x", "c" }, "<c-" .. arrows[key] .. ">", function()
				print("D" .. key)
				M.go_direction(key)
			end)
		end
	end

	-- return wez
	--
	-- https://github.com/letieu/wezterm-move.nvim/blob/master/lua/wezterm-move/init.lua ----------------------------------
	local WM = {}

	local wezterm_directions = { h = "Left", j = "Down", k = "Up", l = "Right" }

	-- @param direction: string (h, j, k, l)
	local function at_edge(direction)
		return vim.fn.winnr() == vim.fn.winnr(direction)
	end

	local function wezterm_exec(cmd)
		local command = vim.deepcopy(cmd)
		if vim.fn.executable("wezterm.exe") == 1 then
			table.insert(command, 1, "wezterm.exe")
		else
			table.insert(command, 1, "wezterm")
		end
		table.insert(command, 2, "cli")
		return vim.fn.system(command)
	end

	-- @param direction: string (h, j, k, l)
	local function send_key_to_wezterm(direction)
		wezterm_exec({ "activate-pane-direction", wezterm_directions[direction] })
	end

	-- @param direction: string (h, j, k, l)
	WM.move = function(direction)
		if at_edge(direction) then
			send_key_to_wezterm(direction)
		else
			vim.cmd("wincmd " .. direction)
		end
	end
end


if willothy_wezterm then
	local fmt = string.format

	local wezterm = {
		switch_tab = {},
		switch_pane = {},
		split_pane = {},
	}

	---@private
	local did_setup = false

	---@private
	local wezterm_executable

	---@private
	local function err(e)
		vim.notify("Wezterm failed to " .. e, vim.log.levels.ERROR, {
			title = "Wezterm",
		})
	end

	---@private
	local function exit_handler(msg)
		---@param obj vim.SystemCompleted
		return function(obj)
			if obj.code ~= 0 then
				err(msg)
			end
		end
	end

	---@private
	local function find_wezterm()
		if vim.fn.executable("wezterm") ~= 0 then
			return "wezterm"
		end
		if vim.fn.executable("wezterm.exe") ~= 0 then
			return "wezterm.exe"
		end

		err("find 'wezterm' executable")
		return nil
	end

	---@private
	local function count_non_nil(...)
		local n = 0
		for i = 1, select("#", ...) do
			if select(i, ...) ~= nil then
				n = n + 1
			end
		end
		return n
	end

	---@class wezterm.SplitOpts
	---@field cwd string|nil
	---@field pane number|nil The pane to split (default current)
	---@field top boolean|nil (default false)
	---@field left boolean|nil (default false)
	---@field bottom boolean|nil (default false)
	---@field right boolean|nil (default false)
	---@field move_pane number|nil Move a pane instead of spawning a command in it (default nil/disabled)
	---@field percent number|nil The percentage of the pane to split (default nil)
	---@field program string[]|nil The program to spawn in the new pane (default nil/Wezterm default)
	---@field top_level boolean|nil Split the window instead of the pane (default false)-

	---@class wezterm.SpawnOpts
	---@field pane number|nil Set the current pane
	---@field new_window boolean|nil Open in a new window
	---@field workspace string|nil Set the workspace for the new window (requires new window)
	---@field cwd string|nil Set the cwd for the spawned program
	---@field args string[]|nil Additional args to pass to the spawned program

	---@class wezterm.GetTextOpts
	---@field pane_id number|nil
	---@field start_line number|nil
	---@field end_line number|nil
	---@field escapes boolean|nil Include escape sequences in the output

	---Exec an arbitrary command in wezterm (does not return result)
	---@param args string[]
	---@param handler fun(res: vim.SystemObj)
	---@param stdin string|string[]|boolean If `true`, then a pipe to stdin is opened and can be written to via the `write()` method to SystemObj. If string or string[] then will be written to stdin
	function wezterm.exec(args, handler, stdin)
		if not wezterm.setup({}) then
			return
		end
		vim.system({ wezterm_executable, unpack(args) }, {
			stdin = stdin,
			text = true,
		}, vim.schedule_wrap(handler))
	end

	---Synchronously exec an arbitrary command in wezterm
	---@param args string[]
	---@return boolean success
	---@return string stdout
	---@return string stderr
	function wezterm.exec_sync(args)
		if not wezterm.setup({}) then
			return false, "", ""
		end
		local rv = vim.system({ wezterm_executable, unpack(args) }, {
			text = true,
		}):wait()

		return rv.code == 0, rv.stdout, rv.stderr
	end

	---Set a user var in the current wezterm pane
	---@param name string
	---@param value string | number | boolean | table | nil
	function wezterm.set_user_var(name, value)
		local ty = type(value)

		if ty == "table" then
			value = vim.json.encode(value)
		elseif ty == "function" or ty == "thread" then
			error("cannot serialize " .. ty)
		elseif ty == "boolean" then
			value = value and "true" or "false"
		elseif ty == "nil" then
			value = ""
		end

		local template = "\x1b]1337;SetUserVar=%s=%s\a"
		local command = template:format(name, vim.base64.encode(tostring(value)))
		vim.api.nvim_chan_send(vim.v.stderr, command)
	end

	---Show a desktop notification from wezterm
	---@param title string
	---@param body string
	function wezterm.notify(title, body)
		local template = "\x1b]777;notify;%s;%s\x1b\\"
		local command = template:format(title or "", body or "")
		vim.api.nvim_chan_send(vim.v.stderr, command)
	end

	---Spawn a program in wezterm
	---@param program string
	---@param opts wezterm.SpawnOpts
	function wezterm.spawn(program, opts)
		opts = opts or {}
		local args = { "cli", "spawn" }
		args.insert = table.insert
		if opts.pane then
			args:insert("--pane-id")
			args:insert(fmt("%d", opts.pane))
		end
		if opts.new_window then
			args:insert("--new-window")
		end
		if opts.workspace then
			if not opts.new_window then
				err("workspace option requires new_window")
				return
			end
			args:insert("--workspace")
			args:insert(opts.workspace)
		end
		if opts.cwd then
			args:insert("--cwd")
			args:insert(opts.cwd)
		end
		if program then
			args:insert(program)
			if opts.args then
				for _, arg in ipairs(opts.args) do
					args:insert(arg)
				end
			end
		end

		local emsg = "spawn " .. program .. " " .. table.concat(args, " ")
		wezterm.exec(args, exit_handler(emsg))
	end

	---@param args string[]
	---@param opts wezterm.SplitOpts
	local function split_pane_args(args, opts)
		if opts.cwd then
			table.insert(args, "--cwd")
			table.insert(args, opts.cwd)
		end
		if opts.percent then
			table.insert(args, "--percent")
			table.insert(args, fmt("%d", opts.percent))
		end
		if opts.pane then
			table.insert(args, "--pane-id")
			table.insert(args, fmt("%d", opts.pane))
		end
		if opts.top_level then
			table.insert(args, "--top-level")
		end
		if opts.move_pane then
			if opts.program then
				err("split: move_pane and program are mutually exclusive")
				return
			end
		elseif opts.program then
			for _, arg in ipairs(opts.program) do
				table.insert(args, arg)
			end
		end
	end

	---Split a pane vertically
	---@param opts wezterm.SplitOpts
	function wezterm.split_pane.vertical(opts)
		opts = opts or {}
		local args = { "cli", "split-pane" }
		split_pane_args(args, opts)
		if opts.top then
			table.insert(args, "--top")
		elseif opts.bottom then
			table.insert(args, "--bottom")
		end
		wezterm.exec(args, exit_handler("split pane"))
	end

	---Split a pane horizontally
	---@param opts wezterm.SplitOpts
	function wezterm.split_pane.horizontal(opts)
		opts = opts or {}
		local args = { "cli", "split-pane" }
		split_pane_args(args, opts)
		if opts.left then
			table.insert(args, "--left")
		elseif opts.right then
			table.insert(args, "--right")
		else
			table.insert(args, "--horizontal")
		end
		wezterm.exec(args, exit_handler("split pane"))
	end

	---Set the title of a Wezterm tab
	---@param title string
	---@param id number | nil Tab id
	function wezterm.set_tab_title(title, id)
		if not title then
			return
		end
		local args = { "cli", "set-tab-title" }
		if id then
			table.insert(args, "--tab-id")
			table.insert(args, fmt("%d", id))
			table.insert(args, title)
		else
			table.insert(args, title)
		end
		wezterm.exec(args, exit_handler("set tab title to '" .. title .. (id == nil and "'" or "' for tab " .. id)))
	end

	---Set the the title of a Wezterm window
	---@param title string
	---@param id number | nil Window id
	function wezterm.set_win_title(title, id)
		if not title then
			return
		end
		local args = { "cli", "set-window-title" }
		if id then
			table.insert(args, "--window-id")
			table.insert(args, fmt("%d", id))
			table.insert(args, title)
		else
			table.insert(args, title)
		end
		wezterm.exec(
			args,
			exit_handler("set window title to '" .. title .. (id == nil and "'" or ("' for window " .. id)))
		)
	end

	---Switch to the tab relative to the current tab
	---@param relno number The relative number of tabs to switch
	function wezterm.switch_tab.relative(relno)
		if not relno then
			relno = vim.v.count or 0
		end
		wezterm.exec(
			{ "cli", "activate-tab", "--tab-relative", fmt("%d", relno) },
			exit_handler("activate tab relative " .. relno)
		)
	end

	---Switch to the tab with the given index
	---@param index number The absolute index of the tab to switch to
	function wezterm.switch_tab.index(index)
		if not index then
			index = vim.v.count or 0
		end
		wezterm.exec(
			{ "cli", "activate-tab", "--tab-index", fmt("%d", index) },
			exit_handler("activate tab by index " .. index)
		)
	end

	---Switch to the tab with the given id
	---@param id number The id of the tab to switch to
	function wezterm.switch_tab.id(id)
		if not id then
			id = vim.v.count or 0
		end
		wezterm.exec({ "cli", "activate-tab", "--tab-id", fmt("%d", id) }, exit_handler("activate tab by id " .. id))
	end

	---Switch to the given pane
	---@param id number The id of the pane to switch to
	function wezterm.switch_pane.id(id)
		if not id then
			id = vim.v.count or 0
		end
		wezterm.exec({ "cli", "activate-pane", "--pane-id", fmt("%d", id) }, exit_handler("activate pane by id " .. id))
	end

	---Used for validating directions
	local directions = {
		Up = true,
		Down = true,
		Left = true,
		Right = true,
		Next = true,
		Prev = true,
	}

	---@param dir 'Up' | 'Down' | 'Left' | 'Right' | 'Next' | 'Prev'
	---@param pane integer | nil Specify the current pane
	function wezterm.get_pane_direction(dir, pane)
		if not dir then
			err("dir is required for get-pane-direction")
		end
		local first_char = dir:sub(1, 1)
		dir = first_char:upper() .. dir:sub(2, -1)

		if not directions[dir] then
			err("get pane: invalid direction " .. vim.inspect(dir))
		end

		local args = { "cli", "get-pane-direction" }

		if pane then
			table.insert(args, "--pane-id")
			table.insert(args, pane)
		end

		table.insert(args, dir)

		local ok, pane_id, errmsg = wezterm.exec_sync(args)

		if not ok then
			errmsg("get pane direction: " .. errmsg)
			return
		end

		pane_id = pane_id:gsub("^%s+", ""):gsub("%s+$", "")

		return tonumber(pane_id)
	end

	---Get the id of the current pane
	---@return number | nil
	function wezterm.get_current_pane()
		local id = vim.env.WEZTERM_PANE
		if id then
			id = id:gsub("^%s+", ""):gsub("%s+$", "")
			return tonumber(id)
		end
	end

	---Zoom or unzoom a pane.
	---
	---If no options are provided, toggles zoom for the provided (or current) pane.
	---@param pane number | nil The pane to zoom (default current)
	---@param opts { zoom: boolean, unzoom: boolean, toggle: boolean } # Default: { toggle = true }
	function wezterm.zoom_pane(pane, opts)
		opts = opts or {}
		local args = { "cli", "zoom-pane" }

		if count_non_nil(opts.zoom, opts.unzoom, opts.toggle) > 1 then
			err("zoom pane: 'zoom', 'unzoom', and 'toggle' are mutually exclusive")
			return
		end

		if pane then
			table.insert(args, "--pane-id")
			table.insert(args, pane)
		end

		if opts.zoom then
			table.insert(args, "--zoom")
		elseif opts.unzoom then
			table.insert(args, "--unzoom")
		else
			table.insert(args, "--toggle")
		end
		wezterm.exec(args, exit_handler("zoom pane"))
	end

	---@param opts wezterm.GetTextOpts
	function wezterm.get_text(opts)
		local args = {}

		if opts.pane_id then
			table.insert(args, "--pane-id")
			table.insert(args, opts.pane_id)
		end

		if opts.start_line then
			table.insert(args, "--start-line")
			table.insert(args, opts.start_line)
		end

		if opts.end_line then
			table.insert(args, "--end-line")
			table.insert(args, opts.end_line)
		end

		if opts.escapes then
			table.insert(args, "--escapes")
		end

		local ok, stdout, stderr = wezterm.exec_sync(args)

		if not ok then
			err("get text: " .. stderr)
			return
		end

		return stdout
	end

	---Switch pane in the given direction
	---@param dir 'Up' | 'Down' | 'Left' | 'Right' | 'Next' | 'Prev' The direction to switch to
	---@param pane integer | nil Specify the current pane
	function wezterm.switch_pane.direction(dir, pane)
		if not dir then
			err("dir is required for split-pane")
		end

		local first_char = dir:sub(1, 1)
		dir = first_char:upper() .. dir:sub(2, -1)

		if not directions[dir] then
			err("switch pane: invalid direction " .. vim.inspect(dir))
			return
		end

		local args = { "cli", "activate-pane-direction" }

		if pane then
			table.insert(args, "--pane-id")
			table.insert(args, pane)
		end

		table.insert(args, dir)

		wezterm.exec(args, exit_handler("activate pane by direction " .. dir))
	end

	---Send text to a pane
	---@param text string Text to send
	---@param pane integer | nil Specify thecurrent pane
	---@param no_paste boolean|nil (default false)
	function wezterm.send_text(text, pane, no_paste)
		if not text then
			err("text is required for send-text")
		end

		local args = { "cli", "send-text" }

		if pane then
			table.insert(args, "--pane-id")
			table.insert(args, pane)
		end

		if no_paste then
			table.insert(args, "--no-paste")
		end

		wezterm.exec(args, exit_handler("send text to pane"), text)
	end

	local function trim(str)
		return str:gsub("^%s+", ""):gsub("%s+$", "")
	end

	---@text The size of a Wezterm pane
	---@class Wezterm.PaneSize
	---@field cols integer
	---@field rows integer
	---@field pixel_width integer
	---@field pixel_height integer
	---@field dpi integer

	---@text Information about a Wezterm pane
	---@class Wezterm.Pane
	---@field cursor_shape string
	---@field cursor_visibility string
	---@field cursor_x integer
	---@field cursor_y integer
	---@field cwd string
	---@field is_active boolean
	---@field is_zoomed boolean
	---@field left_col integer
	---@field pane_id integer
	---@field size Wezterm.PaneSize
	---@field tab_id integer
	---@field tab_title string
	---@field title string
	---@field top_row integer
	---@field tty_name string
	---@field window_id integer
	---@field window_title string
	---@field workspace string

	---@text Information about a Wezterm tab
	---@class Wezterm.Tab
	---@field tab_id integer
	---@field tab_title string
	---@field window_id integer
	---@field window_title string
	---@field panes Wezterm.Pane[]

	---@text Information about a Wezterm GUI window
	---@class Wezterm.Window
	---@field window_id integer
	---@field window_title string
	---@field tabs Wezterm.Tab[]

	---@text Wrapper around `wezterm cli list`
	---
	---@return Wezterm.Pane[]?
	function wezterm.list_panes()
		local ok, stdout, stderr = wezterm.exec_sync({ "cli", "list", "--format", "json" })
		if not ok then
			err("list panes: " .. stderr)
			return
		end
		local decoded, obj = pcall(vim.json.decode, trim(stdout), {
			luanil = {
				object = true,
				array = true,
			},
		})
		if not decoded then
			err("list panes: " .. obj)
			return
		end
		return obj
	end

	---@text Wrapper around `wezterm cli list`
	---
	---@return Wezterm.Tab[]?
	function wezterm.list_tabs()
		local tabs = {}
		local by_id = {}
		local panes = wezterm.list_panes()
		if not panes then
			return
		end
		for _, pane in ipairs(panes) do
			local tab_id = pane.tab_id
			if not by_id[tab_id] then
				by_id[tab_id] = {
					tab_id = tab_id,
					tab_title = pane.tab_title,
					window_id = pane.window_id,
					window_title = pane.window_title,
					panes = {},
				}
				table.insert(tabs, by_id[tab_id])
			end
			table.insert(by_id[tab_id].panes, pane)
		end
		return tabs
	end

	---@text Wrapper around `wezterm cli list`
	---
	---@return Wezterm.Window[]?
	function wezterm.list_windows()
		local windows = {}
		local by_id = {}

		local tabs = wezterm.list_tabs()
		if not tabs then
			return
		end

		for _, tab in ipairs(tabs) do
			local window_id = tab.window_id
			if not by_id[window_id] then
				by_id[window_id] = {
					window_id = window_id,
					window_title = tab.window_title,
					tabs = {},
				}
				table.insert(windows, by_id[window_id])
			end
			table.insert(by_id[window_id].tabs, tab)
		end

		return windows
	end

	---Wrapper around `wezterm cli list-clients`
	---
	---@return table[]?
	function wezterm.list_clients()
		local ok, stdout, stderr = wezterm.exec_sync({ "cli", "list-clients", "--format", "json" })
		if not ok then
			err("list panes: " .. stderr)
			return
		end
		local decoded, obj = pcall(vim.json.decode, trim(stdout), {
			luanil = {
				object = true,
				array = true,
			},
		})
		if not decoded then
			err("list panes: " .. obj)
			return
		end
		return obj
	end

	---@private
	function wezterm.create_commands()
		vim.api.nvim_create_user_command("WeztermSpawn", "lua require('wezterm').spawn(<f-args>)", {
			nargs = "*",
			complete = "shellcmd",
		})
	end

	---@private
	---@class wezterm.Config
	---@field create_commands boolean | nil
	local config = {
		create_commands = true,
	}

	---@param opts wezterm.Config
	function wezterm.setup(opts)
		if did_setup then
			return wezterm_executable ~= nil
		end
		did_setup = true

		opts = vim.tbl_deep_extend("force", config, opts or {})

		if vim.system == nil or vim.base64 == nil then
			vim.notify_once(
				"Wezterm.nvim requires Neovim >= 0.10. If you are using an older version, consider upgrading or pinning v0.4.0 of this plugin.",
				vim.log.levels.ERROR,
				{
					title = "Wezterm",
				}
			)
		end

		local exe = find_wezterm()
		if not exe then
			err("find 'wezterm' executable")
			return false
		end
		wezterm_executable = exe

		if opts.create_commands == true then
			wezterm.create_commands()
		end

		return true
	end

	return wezterm
end

-- DAP ========================================================================================

setup_plugin("dap-python", function()
	local dap_python = get_plugin("dap-python")
	dap_python.setup("debugpy-adapter")
	dap_python.test_runner = "pytest"
	vim.keymap.set("n", "<leader>tt", function()
		print("Leader is working!")
	end)
	vim.keymap.set("n", "<leader>pp", function()
		print("This works")
	end)
	vim.keymap.set("n", "<leader>dn", function()
		get_plugin("dap-python").test_method()
	end)
	vim.keymap.set("n", "<leader>df", function()
		get_plugin("dap-python").test_class()
	end)
	vim.keymap.set("v", "<leader>ds", function()
		get_plugin("dap-python").debug_selection()
	end)
end)
setup_plugin("dapui")
setup_plugin("nvim-dap-virtual-text")
setup_plugin("dap")

-- PATH MANAGEMENT ========================================================================================

local config_dir = vim.fn.fnamemodify(debug.getinfo(1).source:sub(2), ":p:h")
vim.opt.runtimepath:prepend(config_dir)
-- print(config_dir)

if HAS_NIX then
	vim.opt.runtimepath:remove("/home/isaac/.local/share/nvim/site")
end

package.path = config_dir .. "/lua/?.lua;" .. config_dir .. "/lua/?/init.lua;" .. package.path

vim.opt.runtimepath:prepend("/nix/store/ydlwparyk4mxl6wzhlp3x54zl3nk82c5-pde")

vim.opt.runtimepath:remove("/home/isaac/.local/share/nvim/site")

-- OPTIONS ========================================================================================

vim.opt.number = true -- Show absolute line number on the current line
vim.opt.relativenumber = true -- Show relative numbers on other lines
vim.g.mapleader = " "
vim.opt.termguicolors = true


-- FILETYPES ========================================================================================

vim.filetype.add({
	extension = { xit = "xit" },
})

-- MAPPINGS ========================================================================================

if mappings_lua then
	--[[
	DESIRED MAPPINGS/ACTIONS

	- open quickfix window
	- open floating terminal
	- copy selection to new file
	- jump to reference (next, previous)
	- jump to definition
	- open search and replace (with preview)
	- fold block
	- fold/unfold all of given level
	- toggle value under cursor
	- rename everywhere (optionally with preview)
	- search pattern/regex in given files -> save results list & use it to navigate
	- show keybinds available
	- add/view/edit comment/annotation pointing to given location
	- view/navigate TODOs and comments
	- insert snippet
	- format code (optionally only under selection)
	- edit selection in new buffer
	- dull colors outside of selection
	- edit filesystem as a buffer (oil.nvim?)
	- get autocomplete suggestion
	- check spelling in file (ONLY on command!)
	- view diff (with saved, last commit, etc.)
	- file tree view
	- navigate between search results
	- toggle to light colors (or even lighten/darken colors, increase contrast -> write plugin?)
	- jump to next syntactic object ( 
	- command to run changed tests (use testmon or analogous)
	- get LLM feedback
	- unified preview_+accept/reject framework
	- multi-line / multi-location edits

	AUTOMATIC/TOGGLABLE FUNCTIONALITIES
	--> dull colors everywhere except in active block (via treesitter?)
	--> custom syntax highlighting for my special formats (from consilium-notes: jn, ...)

	--]]

	-- Set up a local map function for convenience
	local map = vim.keymap.set

	-- telescope ----------------------------------------------------------------------------------------------------------
	map("n", "<leader>ff", function()
		require("telescope.builtin").find_files()
	end, { desc = "Find Files" })
	map("n", "<leader>gf", function()
		require("telescope.builtin").git_files()
	end, { desc = "Find Git Files" })
	map("n", "<leader>fg", function()
		require("telescope.builtin").live_grep()
	end, { desc = "Live Grep" })
	map("n", "<leader>fb", function()
		require("telescope.builtin").buffers()
	end, { desc = "Find Buffers" })
	map("n", "<leader>fh", function()
		require("telescope.builtin").help_tags()
	end, { desc = "Find Help Tags" })

	-- floaterm -----------------------------------------------------------------------------------------------------------
	vim.keymap.set("n", "<leader>ft", "<Cmd>FloatermToggle<CR>", { desc = "Toggle floaterm" })
	vim.keymap.set("t", "<leader>ft", "<C-\\><C-n><Cmd>FloatermToggle<CR>", { desc = "Toggle floaterm" })

	-- LSP ----------------------------------------------------------------------------------------------------------------
	-- We will create an autocommand group to attach keymaps only to buffers with an active LSP client.
	local lsp_keymaps_group = vim.api.nvim_create_augroup("LspKeymaps", { clear = true })

	vim.api.nvim_create_autocmd("LspAttach", {
		group = lsp_keymaps_group,
		callback = function(ev)
			local lsp_map = function(keys, func, desc)
				vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = "LSP: " .. desc })
			end

			-- Navigation and Information
			lsp_map("gd", vim.lsp.buf.definition, "Go to Definition")
			lsp_map("gD", vim.lsp.buf.declaration, "Go to Declaration")
			lsp_map("gr", vim.lsp.buf.references, "Go to References")
			lsp_map("gI", vim.lsp.buf.implementation, "Go to Implementation")
			lsp_map("K", vim.lsp.buf.hover, "Hover Documentation")
			lsp_map("<C-k>", vim.lsp.buf.signature_help, "Signature Help")

			-- Actions
			lsp_map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
			lsp_map("<leader>rn", vim.lsp.buf.rename, "Rename")

			-- Diagnostics
			lsp_map("[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
			lsp_map("]d", vim.diagnostic.goto_next, "Next Diagnostic")
			lsp_map("<leader>dl", vim.diagnostic.open_float, "Show Line Diagnostics")

			-- format on save (to use LSP formatter instead of conform)
			-- vim.api.nvim_buf_create_autocmd("BufWritePre", {
			--   buffer = ev.buf,
			--   callback = function() vim.lsp.buf.format { async = false } end
			-- })
			--
			local bufopts = { noremap = true, silent = true, buffer = bufnr }
		end,
	})

	-- quickfix -----------------------------------------------------------------------------------------------------------
	vim.keymap.set("i", "kj", "<escape>")
	vim.keymap.set("n", "<leader>wq", function()
		vim.cmd("wq")
	end)
	vim.keymap.set("n", "<leader>ww", function()
		vim.cmd("w")
	end)
	vim.keymap.set("n", "<leader>q", function()
		-- Populates the Quickfix list with all diagnostics from the current buffer
		vim.diagnostic.setqflist({ bufnr = 0 })
		vim.cmd("copen")
	end, { desc = "Open Quickfix with diagnostics" })

	--- dial---------------------------------------------------------------------------------------------------------------
	vim.keymap.set("n", "<C-a>", function()
		require("dial.map").manipulate("increment", "normal")
	end)
	vim.keymap.set("n", "<C-x>", function()
		require("dial.map").manipulate("decrement", "normal")
	end)
	vim.keymap.set("n", "g<C-a>", function()
		require("dial.map").manipulate("increment", "gnormal")
	end)
	vim.keymap.set("n", "g<C-x>", function()
		require("dial.map").manipulate("decrement", "gnormal")
	end)
	vim.keymap.set("x", "<C-a>", function()
		require("dial.map").manipulate("increment", "visual")
	end)
	vim.keymap.set("x", "<C-x>", function()
		require("dial.map").manipulate("decrement", "visual")
	end)
	vim.keymap.set("x", "g<C-a>", function()
		require("dial.map").manipulate("increment", "gvisual")
	end)
	vim.keymap.set("x", "g<C-x>", function()
		require("dial.map").manipulate("decrement", "gvisual")
	end)

	--- zen-mode ----------------------------------------------------------------------------------------------------------

	vim.keymap.set("n", "<leader>zm", function()
		require("zen-mode").toggle({
			window = {
				width = 0.85, -- width will be 85% of the editor width
			},
		})
	end)
end

if other_mappings then
	---------------------------------------------------------------------------------------------------------------- KEYMAPS
	local nvx = { "n", "v", "x" }
	map({
		mode = "n",
		sequence = "<leader>o",
		action = ":update<CR> :source<CR>",
		opts = {},
	})
	map({
		mode = "n",
		sequence = "<leader>ww",
		action = ":write<CR>",
		opts = {},
	})
	map({
		mode = "n",
		sequence = "<leader>qq",
		action = ":quit<CR>",
		opts = {},
	})
	map({
		mode = "n",
		sequence = "<leader>wq",
		action = ":wq<CR>",
		opts = {},
	})
	map({
		mode = "n",
		sequence = "<leader>f",
		action = ":Pick files<CR>",
		opts = {},
	})
	map({
		mode = "t",
		sequence = "<Esc>",
		action = [[<C-\><C-n>]],
		opts = { desc = "Exit terminal mode" },
	})
	map({
		mode = "t",
		sequence = "kj",
		action = [[<C-\><C-n>]],
		opts = { desc = "Exit terminal mode" },
	})
	map({
		mode = "t",
		sequence = "<C-o>",
		action = [[<C-\><C-o>]],
		opts = { desc = "Temporary normal mode" },
	})
	map({
		mode = "n",
		sequence = "<leader>lf",
		action = vim.lsp.buf.format,
		opts = { desc = "" },
	})
	map({
		mode = "n",
		sequence = "<leader>h",
		action = ":Pick help",
	})
	map({
		mode = "n",
		sequence = "<leader>e",
		action = ":Oil<CR>",
	})
	map({
		mode = nvx,
		sequence = "<leader>y",
		action = "+y<CR>",
		opts = { desc = "Yank to system clipboard" },
	})
	map({
		mode = nvx,
		sequence = "<leader>d",
		action = "+d<CR>",
		opts = { desc = "Paste from system clipboard" },
	})
	-- map({
	--     mode = "",
	--     sequence = "",\
	--     action = [[]],
	--     opts = { desc = "" }
	-- })
	-- map({
	--     mode = "",
	--     sequence = "",
	--     action = [[]],
	--     opts = { desc = "" }
	-- })
	-- map('t', '^[', "^\^N")
	-- map('t', '^O', '^\^O')
	map({
		mode = "x",
		sequence = "<leader>mf",
		action = ":'<,'>lua move_selection_to_new_file()<CR>",
		opts = { desc = "Move selection to new file (split)" },
	})
	map({
		mode = "n",
		sequence = "<leader>lu",
		action = function()
			-- Create a new empty floating window or split
			vim.cmd("vsplit | enew")
			vim.bo.filetype = "lua"
			vim.bo.bufhidden = "hide"

			-- Map <CR> to execute the current line or selection
			vim.keymap.set("n", "<CR>", ":.lua<CR>", { buffer = true })
			vim.keymap.set("v", "<CR>", ":lua<CR>", { buffer = true })
		end,
		opts = { desc = "Open Lua Scratchpad" },
	})
	map({
		mode = "v",
		sequence = "<leader>ms",
		action = move_selection_to_new_file,
	})
	map({ ------------------------------------------------------------------------------------------------------ diagnostics
		mode = "n",
		sequence = "<leader>dt",
		action = function()
			diagnostics_active = not diagnostics_active
			set_diagnostics_mode()
		end,
		opts = { desc = "Toggle LSP Diagnostics" },
	})
	map({
		mode = "n",
		sequence = "<leader>dm",
		action = function()
			-- only cycle if active; otherwise turn on and reset to 1
			if not diagnostics_active then
				diagnostics_active = true
				current_mode_index = 1
			else
				current_mode_index = current_mode_index + 1
				if current_mode_index > #diagnostic_modes then
					current_mode_index = 1
				end
			end
			set_diagnostics_mode()
		end,
		opts = { desc = "Cycle LSP Diagnostic Modes" },
	})
	map({ -------------------------------------------------------------------------------------------------------- telescope
		mode = "n",
		sequence = "<leader>ff",
		action = make_setup_function(function()
			require("telescope.builtin").find_files()
		end),
		opts = { desc = "Find Files" },
	})
	map({
		mode = "n",
		sequence = "<leader>gf",
		action = function()
			require("telescope.builtin").git_files()
		end,
		opts = { desc = "Find Git Files" },
	})
	map({
		mode = "n",
		sequence = "<leader>fg",
		action = function()
			require("telescope.builtin").live_grep()
		end,
		opts = { desc = "Live Grep" },
	})
	map({
		mode = "n",
		sequence = "<leader>fb",
		action = function()
			require("telescope.builtin").buffers()
		end,
		opts = { desc = "Find Buffers" },
	})
	map({
		mode = "n",
		sequence = "<leader>fh",
		action = function()
			require("telescope.builtin").help_tags()
		end,
		opts = { desc = "Find Help Tags" },
	})
	map({ --------------------------------------------------------------------------------------------------------- floaterm
		mode = "n",
		sequence = "<leader>ft",
		action = "<Cmd>FloatermToggle<CR>",
		opts = { desc = "Toggle floaterm" },
	})
	map({
		mode = "t",
		sequence = "<leader>ft",
		action = "<C-\\><C-n><Cmd>FloatermToggle<CR>",
		opts = { desc = "Toggle floaterm" },
	})
	-------------------------------------------------------------------------------------------------------------------- LSP
	-- autocommand group to attach keymaps only to buffers with an active LSP client.
	local lsp_keymaps_group = vim.api.nvim_create_augroup("LspKeymaps", { clear = true })

	vim.api.nvim_create_autocmd("LspAttach", {
		group = lsp_keymaps_group,
		callback = function(ev)
			local lsp_map = function(keys, func, desc)
				map({
					mode = "n",
					sequence = keys,
					action = func,
					opts = { buffer = ev.buf, desc = "LSP: " .. desc },
				})
			end

			-- Navigation and Information
			lsp_map("gd", vim.lsp.buf.definition, "Go to Definition")
			lsp_map("gD", vim.lsp.buf.declaration, "Go to Declaration")
			lsp_map("gr", vim.lsp.buf.references, "Go to References")
			lsp_map("gI", vim.lsp.buf.implementation, "Go to Implementation")
			lsp_map("K", vim.lsp.buf.hover, "Hover Documentation")
			lsp_map("<C-k>", vim.lsp.buf.signature_help, "Signature Help")

			-- Actions
			lsp_map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
			lsp_map("<leader>rn", vim.lsp.buf.rename, "Rename")

			-- Diagnostics
			lsp_map("[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
			lsp_map("]d", vim.diagnostic.goto_next, "Next Diagnostic")
			lsp_map("<leader>dl", vim.diagnostic.open_float, "Show Line Diagnostics")

			-- format on save (to use LSP formatter instead of conform)
			-- vim.api.nvim_buf_create_autocmd("BufWritePre", {
			--   buffer = ev.buf,
			--   callback = function() vim.lsp.buf.format { async = false } end
			-- })
			--
			local bufopts = { noremap = true, silent = true, buffer = bufnr }
		end,
	})
	map({ --------------------------------------------------------------------------------------------------------- quickfix
		mode = { "i" },
		sequence = "kj",
		action = "<escape>",
	})
	map({
		mode = "n",
		sequence = "<leader>wq",
		action = function()
			vim.cmd("wq")
		end,
	})
	map({
		mode = "n",
		sequence = "<leader>ww",
		action = function()
			vim.cmd("w")
		end,
	})
	map({
		mode = "n",
		sequence = "<leader>q",
		action = function()
			-- Populates the Quickfix list with all diagnostics from the current buffer
			vim.diagnostic.setqflist({ bufnr = 0 })
			vim.cmd("copen")
		end,
		opts = { desc = "Open Quickfix with diagnostics" },
	})
	map({ ------------------------------------------------------------------------------------------------------------- dial
		mode = "n",
		sequence = "<C-a>",
		action = function()
			require("dial.map").manipulate("increment", "normal")
		end,
		opts = { desc = "" },
	})
	map({
		mode = "n",
		sequence = "<C-x>",
		action = function()
			require("dial.map").manipulate("decrement", "normal")
		end,
		opts = { desc = "" },
	})
	map({
		mode = "n",
		sequence = "g<C-a>",
		action = function()
			require("dial.map").manipulate("increment", "gnormal")
		end,
		opts = { desc = "" },
	})
	map({
		mode = "n",
		sequence = "g<C-x>",
		action = function()
			require("dial.map").manipulate("decrement", "gnormal")
		end,
		opts = { desc = "" },
	})
	map({
		mode = "x",
		sequence = "<C-a>",
		action = function()
			require("dial.map").manipulate("increment", "visual")
		end,
		opts = { desc = "" },
	})
	map({
		mode = "x",
		sequence = "<C-x>",
		action = function()
			require("dial.map").manipulate("decrement", "visual")
		end,
		opts = { desc = "" },
	})
	map({
		mode = "x",
		sequence = "g<C-a>",
		action = function()
			require("dial.map").manipulate("increment", "gvisual")
		end,
		opts = { desc = "" },
	})
	map({
		mode = "x",
		sequence = "g<C-x>",
		action = function()
			require("dial.map").manipulate("decrement", "gvisual")
		end,
		opts = { desc = "" },
	})
	map({ --------------------------------------------------------------------------------------------------------- zen-mode
		mode = "n",
		sequence = "<leader>zm",
		action = function()
			-- width will be 85% of the editor width
			require("zen-mode").toggle({ window = { width = 0.85 } })
		end,
		opts = { desc = "" },
	})

	map({
		mode = { "n", "v" },
		sequence = "<leader>-",
		action = function()
			load_yazi()
			vim.cmd("Yazi")
		end,
		opts = { desc = "Open yazi at the current file." },
	})
	map({
		mode = { "n", "v" },
		sequence = "<leader>cw",
		action = function()
			load_yazi()
			vim.cmd("Yazi cwd")
		end,
		opts = { desc = "Open the file manager in nvim's working directory." },
	})
	map({
		mode = { "n", "v" },
		sequence = "<c-up>",
		action = function()
			load_yazi()
			vim.cmd("Yazi toggle")
		end,
		opts = { desc = "Resume the last yazi session." },
	})
end

-- AUTOCOMMANDS =================================================================================================

-- COLORS ========================================================================================

vim.api.nvim_set_hl(0, "Normal", { bg = "#020802" })

vim.cmd("hi link Floaterm Normal")
vim.cmd("hi link FloatermBorder Normal")
vim.api.nvim_set_hl(0, "Normal", { bg = "#020802" })


if custom_colors then
	--vim.api.nvim_set_hl(0, "Comment", { bg = "Purple" })
	--vim.api.nvim_set_hl(0, 'Normal', { fg = "Green", bg = "Red" })
	--vim.api.nvim_set_hl(0, 'Error', { fg = "<white>", undercurl = true })
	--vim.api.nvim_set_hl(0, 'Cursor', { reverse = true })

	--vim.cmd("highlight clear")

	-- print(vim.opt.rtp)
	vim.cmd("syntax reset")
	--vim.g.colors_name = 'melange'

	-- local bg = vim.opt.background:get(n)

	-- package.loaded['melange/palettes/' .. bg] = nil -- Only needed for development
	--local palette = require('melange/palettes/' .. bg)

	--local a = palette.a -- Grays
	--local b = palette.b -- Bright foreground colors
	--local c = palette.c -- Foreground colors
	--local d = palette.d -- Background colors

	-- See https://github.com/neovim/neovim/pull/7406
	--[[
	vim.g.terminal_color_0 = "$color.terminalColor00$"
	vim.g.terminal_color_1 = "$color.terminalColor01$"
	vim.g.terminal_color_2 = "$color.terminalColor02$"
	vim.g.terminal_color_3 = "$color.terminalColor03$"
	vim.g.terminal_color_4 = "$color.terminalColor04$"
	vim.g.terminal_color_5 = "$color.terminalColor05$"
	vim.g.terminal_color_6 = "$color.terminalColor06$"
	vim.g.terminal_color_7 = "$color.terminalColor07$"
	vim.g.terminal_color_8 = "$color.terminalColor08$"
	vim.g.terminal_color_9 = "$color.terminalColor09$"
	vim.g.terminal_color_10 = "$color.terminalColor0A$"
	vim.g.terminal_color_11 = "$color.terminalColor0B$"
	vim.g.terminal_color_12 = "$color.terminalColor0C$"
	vim.g.terminal_color_13 = "$color.terminalColor0D$"
	vim.g.terminal_color_14 = "$color.terminalColor0E$"
	vim.g.terminal_color_15 = "$color.terminalColor0F$"
	--]]
	local enable_font_variants = true
	--vim.g.melange_enable_font_variants == nil or vim.g.melange_enable_font_variants

	local bold = enable_font_variants
	local italic = enable_font_variants
	local underline = enable_font_variants
	local undercurl = enable_font_variants
	local strikethrough = enable_font_variants

	-- local aliases = {
	-- 	DARK_PINK = "#913d55",
	--
	--
	-- }

	for name, attrs in pairs({
		---- :help highlight-default -------------------------------

		Normal = { bg = "#000800", fg = "#808080" },
		NormalFloat = { bg = "#000800", fg = "#808080" },
		NormalNC = "Normal",

		-- Cursor: TODO...

		WinSeparator = { bg = "#000800", fg = "#111211" },
		-- VertSplit = { bg = "<|color.nvim.VertSplit.bg |>", fg = "<|color.nvim.VertSplit.fg |>" },
		-- Special = { fg = "<|%color.nvim.Special |>" },
		-- CursorLine = { bg = "<|%color.nvim.CursorLine.bg |>" },

		Identifier = { fg = "#426989" }, --$color.nvim.Identifier.fg$" },
		["@variable"] = { fg = "#13446c" },
		Function = { fg = "#246b44" },
		Statement = { fg = "#913d55" },
		Constant = { fg = "#7080a8" },
		Type = { fg = "#8888dd" },
		["@module"] = { fg = "#aaaacc" },
		Directory = { fg = "#13446c" },
		String = { fg = "#434f6f" }, --"#3e4966" }, -- 808080 55668f 1c2e8b
		Comment = { fg = "#625c3f" }, -- 333933
		PreProc = { fg = "#123622" },
		Operator = { fg = "#246b44" },
		Delimiter = { fg = "#123622" },
		NeotreeFileName = { fg = "#9a9a9a" },

		-- inheriting background from default Nvim* colors
		Search = { fg = "#8AA88A", bg = "#003600" },
		CurSearch = { fg = "#809880", bg = "#002600" },

		StatusLine = { fg = "#455684", bg = "#111211" },
		StatusLineNC = { fg = "#455684", bg = "#111211" },
		Visual = { fg = "#061815", bg = "#0d8f77" },
		Folded = { fg = "#808080", bg = "#001300" },
		DiffAdd = { fg = "#668366", bg = "#002200" },
		DiffChange = { fg = "#7f86f3", bg = "#050a58" },
		DiffDelete = { fg = "#d5776f" },
		DiffText = { fg = "#050a58", bg = "#7f86f3" },
		Pmenu = { fg = "#505ad6", bg = "#000800" },
		PmenuSel = { fg = "#737df1", bg = "#002600" },
		PmenuThumb = { bg = "#777777" },
		CursorColumn = { bg = "#000e00" },
		CursorLine = { bg = "#000e00" },
		ColorColumn = { bg = "#9b73f1" },
		WinBar = { fg = "#dddddd", bg = "#000800" },
		WinBarNC = { fg = "#dddddd", bg = "#000800" },
		FloatShadow = { bg = "#002600" },
		FloatShadowThrough = {
			bg = "#118811",
		},
		MatchParen = { bg = "#51136e" },
		RedrawDebugClear = { bg = "#dddddd" },
		RedrawDebugComposed = {
			bg = "#dddddd",
		},
		RedrawDebugRecompose = {
			bg = "#dddddd",
		},
		Error = { fg = "#bd1dc5", bg = "#000800" },

		-- inheriting foreground from default Nvim* colors
		SpecialKey = { fg = "#491d5e" },
		NonText = { fg = "#111211" },
		Directory = { fg = "#13446c" },
		ErrorMsg = { fg = "#bd1dc5" },
		MoreMsg = { fg = "#1db6c5" },
		ModeMsg = { fg = "#376808" },
		LineNr = { fg = "#333833" },
		Question = { fg = "#402967" },
		WarningMsg = { fg = "#CBC383" },
		SignColumn = { fg = "#1b8984" },
		Conceal = { fg = "#808080", bg = "#000800" },
		QuickFixLine = { fg = "#A30101" },
		Special = { fg = "#741d96" }, --"#49125e" },

		DiagnosticError = { fg = "#bd1dc5" },
		DiagnosticFloatingWarn = { fg = "#CBC383" },
		DiagnosticWarn = { fg = "#CBC383" },
		DiagnosticFloatingInfo = { fg = "#555555" },
		DiagnosticInfo = { fg = "#555555" },
		DiagnosticFloatingHint = { fg = "#9b73f1" },
		DiagnosticHint = { fg = "#9b73f1" },
		DiagnosticFloatingOk = { fg = "#555555" },
		DiagnosticOk = { fg = "#555555" },
		Added = { fg = "#368366" },
		["@diff.minus"] = { fg = "#d5776f" },
		Removed = { fg = "#d5776f" },
		Changed = { fg = "#7f86f3" },
		CmpItemAbbrDeprecatedDefault = { fg = "#ffffff" },
		CmpItemKindDefault = { fg = "#eeeeee" },
		RainbowDelimiter1 = { fg = "#2b1400" },
		RainbowDelimiter2 = { fg = "#4f473b" },
		RainbowDelimiter3 = { fg = "#381900" },
		RainbowDelimiter4 = { fg = "#726c62" },
		RainbowDelimiter5 = { fg = "#51331a" },
		RainbowDelimiter6 = { fg = "#959189" },
		RainbowDelimiter7 = { fg = "#78604d" },
	}) do
		if type(attrs) == "table" then
			vim.api.nvim_set_hl(0, name, attrs)
		else
			vim.api.nvim_set_hl(0, name, { link = attrs })
		end
	end
end


setup_plugin("bamboo", function(bamboo)
	(bamboo.setup)({
		style = "multiplex",
		colors = {
			bg0 = "#020802",
		},
	});
	(bamboo.load)()
	utils.printbv("Set up bamboo")
end)

if other_colors then

	--vim.api.nvim_set_hl(0, "Comment", { bg = "Purple" })
	--vim.api.nvim_set_hl(0, 'Normal', { fg = "Green", bg = "Red" })
	--vim.api.nvim_set_hl(0, 'Error', { fg = "<white>", undercurl = true })
	--vim.api.nvim_set_hl(0, 'Cursor', { reverse = true })

	--vim.cmd("highlight clear")

	-- print(vim.opt.rtp)
	vim.cmd("syntax reset")
	--vim.g.colors_name = 'melange'

	-- local bg = vim.opt.background:get(n)

	-- package.loaded['melange/palettes/' .. bg] = nil -- Only needed for development
	--local palette = require('melange/palettes/' .. bg)

	--local a = palette.a -- Grays
	--local b = palette.b -- Bright foreground colors
	--local c = palette.c -- Foreground colors
	--local d = palette.d -- Background colors

	-- See https://github.com/neovim/neovim/pull/7406
	--[[
	vim.g.terminal_color_0 = "$color.terminalColor00$"
	vim.g.terminal_color_1 = "$color.terminalColor01$"
	vim.g.terminal_color_2 = "$color.terminalColor02$"
	vim.g.terminal_color_3 = "$color.terminalColor03$"
	vim.g.terminal_color_4 = "$color.terminalColor04$"
	vim.g.terminal_color_5 = "$color.terminalColor05$"
	vim.g.terminal_color_6 = "$color.terminalColor06$"
	vim.g.terminal_color_7 = "$color.terminalColor07$"
	vim.g.terminal_color_8 = "$color.terminalColor08$"
	vim.g.terminal_color_9 = "$color.terminalColor09$"
	vim.g.terminal_color_10 = "$color.terminalColor0A$"
	vim.g.terminal_color_11 = "$color.terminalColor0B$"
	vim.g.terminal_color_12 = "$color.terminalColor0C$"
	vim.g.terminal_color_13 = "$color.terminalColor0D$"
	vim.g.terminal_color_14 = "$color.terminalColor0E$"
	vim.g.terminal_color_15 = "$color.terminalColor0F$"
	--]]
	local enable_font_variants = true
	--vim.g.melange_enable_font_variants == nil or vim.g.melange_enable_font_variants

	local bold = enable_font_variants
	local italic = enable_font_variants
	local underline = enable_font_variants
	local undercurl = enable_font_variants
	local strikethrough = enable_font_variants

	-- local aliases = {
	--     DARK_PINK = "#913d55",
	--
	--
	-- }
	vim.api.nvim_set_hl(0, "Normal", { bg = "#020802" })
	for name, attrs in pairs({
		---- :help highlight-default -------------------------------

		Normal = { bg = "#000800", fg = "#808080" },
		NormalFloat = { bg = "#000800", fg = "#808080" },
		NormalNC = "Normal",

		-- Cursor: TODO...

		WinSeparator = { bg = "#000800", fg = "#111211" },
		-- VertSplit = { bg = "<|color.nvim.VertSplit.bg |>", fg = "<|color.nvim.VertSplit.fg |>" },
		-- Special = { fg = "<|%color.nvim.Special |>" },
		-- CursorLine = { bg = "<|%color.nvim.CursorLine.bg |>" },

		Identifier = { fg = "#426989" }, --$color.nvim.Identifier.fg$" },
		["@variable"] = { fg = "#13446c" },
		Function = { fg = "#246b44" },
		Statement = { fg = "#913d55" },
		Constant = { fg = "#7080a8" },
		Type = { fg = "#8888dd" },
		["@module"] = { fg = "#aaaacc" },
		String = { fg = "#434f6f" }, --"#3e4966" }, -- 808080 55668f 1c2e8b
		Comment = { fg = "#625c3f" }, -- 333933
		PreProc = { fg = "#123622" },
		Operator = { fg = "#246b44" },
		Delimiter = { fg = "#123622" },
		NeotreeFileName = { fg = "#9a9a9a" },

		-- inheriting background from default Nvim* colors
		Search = { fg = "#8AA88A", bg = "#003600" },
		CurSearch = { fg = "#809880", bg = "#002600" },

		StatusLine = { fg = "#455684", bg = "#111211" },
		StatusLineNC = { fg = "#455684", bg = "#111211" },
		Visual = { fg = "#061815", bg = "#0d8f77" },
		Folded = { fg = "#808080", bg = "#001300" },
		DiffAdd = { fg = "#668366", bg = "#002200" },
		DiffChange = { fg = "#7f86f3", bg = "#050a58" },
		DiffDelete = { fg = "#d5776f" },
		DiffText = { fg = "#050a58", bg = "#7f86f3" },
		Pmenu = { fg = "#505ad6", bg = "#000800" },
		PmenuSel = { fg = "#737df1", bg = "#002600" },
		PmenuThumb = { bg = "#777777" },
		CursorColumn = { bg = "#000e00" },
		CursorLine = { bg = "#000e00" },
		ColorColumn = { bg = "#9b73f1" },
		WinBar = { fg = "#dddddd", bg = "#000800" },
		WinBarNC = { fg = "#dddddd", bg = "#000800" },
		FloatShadow = { bg = "#002600" },
		FloatShadowThrough = {
			bg = "#118811",
		},
		MatchParen = { bg = "#51136e" },
		RedrawDebugClear = { bg = "#dddddd" },
		RedrawDebugComposed = {
			bg = "#dddddd",
		},
		RedrawDebugRecompose = {
			bg = "#dddddd",
		},
		Error = { fg = "#bd1dc5", bg = "#000800" },

		-- inheriting foreground from default Nvim* colors
		SpecialKey = { fg = "#491d5e" },
		NonText = { fg = "#111211" },
		Directory = { fg = "#13446c" },
		ErrorMsg = { fg = "#bd1dc5" },
		MoreMsg = { fg = "#1db6c5" },
		ModeMsg = { fg = "#376808" },
		LineNr = { fg = "#333833" },
		Question = { fg = "#402967" },
		WarningMsg = { fg = "#CBC383" },
		SignColumn = { fg = "#1b8984" },
		Conceal = { fg = "#808080", bg = "#000800" },
		QuickFixLine = { fg = "#A30101" },
		Special = { fg = "#741d96" }, --"#49125e" },

		DiagnosticError = { fg = "#bd1dc5" },
		DiagnosticFloatingWarn = { fg = "#CBC383" },
		DiagnosticWarn = { fg = "#CBC383" },
		DiagnosticFloatingInfo = { fg = "#555555" },
		DiagnosticInfo = { fg = "#555555" },
		DiagnosticFloatingHint = { fg = "#9b73f1" },
		DiagnosticHint = { fg = "#9b73f1" },
		DiagnosticFloatingOk = { fg = "#555555" },
		DiagnosticOk = { fg = "#555555" },
		Added = { fg = "#368366" },
		["@diff.minus"] = { fg = "#d5776f" },
		Removed = { fg = "#d5776f" },
		Changed = { fg = "#7f86f3" },
		CmpItemAbbrDeprecatedDefault = { fg = "#ffffff" },
		CmpItemKindDefault = { fg = "#eeeeee" },
		RainbowDelimiter1 = { fg = "#2b1400" },
		RainbowDelimiter2 = { fg = "#4f473b" },
		RainbowDelimiter3 = { fg = "#381900" },
		RainbowDelimiter4 = { fg = "#726c62" },
		RainbowDelimiter5 = { fg = "#51331a" },
		RainbowDelimiter6 = { fg = "#959189" },
		RainbowDelimiter7 = { fg = "#78604d" },
	}) do
		if type(attrs) == "table" then
			vim.api.nvim_set_hl(0, name, attrs)
		else
			vim.api.nvim_set_hl(0, name, { link = attrs })
		end
	end
end

-- MISC ========================================================================================

utils.setup_plugin("xit")

-- ADDED: Initialize which-key
utils.setup_plugin("which-key")

-- debug.getinfo(2, "S").source:sub(2):match("(.*/)") or "./"

-- xpcall example
if false then
	local function my_function()
		error("Oops!")
	end

	local function my_handler(err)
		return "Custom Error Handler: " .. debug.traceback(err)
	end

	local status, err_msg = xpcall(my_function, my_handler)

	if not status then
		print(err_msg) -- Will print the error + the line-by-line stack trace
	end

	-- pcall example
	local status, telescope = pcall(require, "telescope")
	if not status then
		return -- Silently exit if plugin isn't installed
	end
end


-- symlinking
if false then
	local plugins = {
		["user/repo-name"] = { path = "source_path/repo1" },
		["another-user/cool-plugin"] = { path = "/home/user/dev/cool-plugin" },
		["someone/awesome-nvim"] = { path = "~/projects/awesome-nvim" },
	}

	local PLUGIN_DIR = vim.fn.stdpath("data") .. "/site/pack/plugins/start"

	-- Extract repo name from "user/repo-name" format
	local function get_repo_name(plugin_id)
		return plugin_id:match("([^/]+)$")
	end

	-- Create symbolic links
	for plugin_id, config in pairs(plugins) do
		local repo_name = get_repo_name(plugin_id)
		local source_path = vim.fn.expand(config.path)
		local target_path = PLUGIN_DIR .. "/" .. repo_name

		-- Check if source exists
		if vim.fn.isdirectory(source_path) == 0 then
			vim.notify(string.format("Warning: Source path does not exist: %s", source_path), vim.log.levels.WARN)
		else
			-- Remove existing link/directory if it exists
			vim.fn.delete(target_path, "rf")

			-- Create symbolic link
			local success = vim.loop.fs_symlink(source_path, target_path)

			if success then
				vim.notify(string.format("✓ Linked: %s -> %s", repo_name, source_path), vim.log.levels.INFO)
			else
				vim.notify(string.format("✗ Failed to link: %s", plugin_id), vim.log.levels.ERROR)
			end
		end
	end

	print("Symbolic links created!")
end

-- LSP ========================================================================================

lsp = true
if lsp then

	vim.lsp.enable("lua_ls")
	vim.lsp.enable("ruff")
	vim.lsp.enable("tinymist")
	vim.lsp.config("lua_ls", {
		settings = {
			Lua = {
				workspace = { library = vim.api.nvim_get_runtime_file("", true) },
			},
		},
	})
	vim.lsp.config("ruff", {}) -- TODO
	vim.lsp.config("tinymist", {}) -- TODO
	vim.lsp.config("rust-analyzer", {}) -- TODO
	vim.lsp.config("haskell-ls", {}) -- TODO

	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(ev)
			local client = vim.lsp.get_client_by_id(ev.data.client_id)
			if client:supports_method("textDocument/completion") then
				vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
			end
		end,
	})
	vim.cmd("set completeopt+=noselect")
	printv("CHECKPOINT A")
	setup_plugin({ -------------------------------------------------------------------------------------------- conform.nvim
		name = "conform",
		setup_fn = function()
			require("conform").setup({
				formatters_by_ft = {
					python = {
						-- To fix auto-fixable lint errors.
						"ruff_fix",
						-- To run the Ruff formatter.
						"ruff_format",
						-- To organize the imports.
						"ruff_organize_imports",
					},
					nix = {
						"alejandra",
					},
					lua = {
						"stylua",
					},
					haskell = {
						"fourmolu",
					},
					rust = {
						"rustfmt",
					},
					go = {
						"gofmt",
					},
				},
			})

			-- Optional: format on save
			vim.api.nvim_create_autocmd("BufWritePre", {
				callback = function(args)
					require("conform").format({ bufnr = args.buf })
				end,
			})
		end,
	})
end

lsp_with_diagnostics = false
if lsp_with_diagnostics then
	local diagnostic_modes = {
		{
			name = "End of Line (Virtual Text)",
			config = {
				virtual_text = {
					prefix = "●", -- Could be '■', '▎', 'x'
					spacing = 4,
					source = "if_many",
				},
				virtual_lines = false,
				signs = true,
				underline = true,
				update_in_insert = false,
			},
		},
		{
			name = "Under Line (Virtual Lines)",
			config = {
				virtual_text = false,
				-- 'virtual_lines' is now a built-in handler in Nvim 0.10/0.11+
				virtual_lines = {
					only_current_line = true, -- Only show for current line to reduce clutter
					highlight_whole_line = false,
				},
				signs = true,
				underline = true,
				update_in_insert = false,
			},
		},
		{
			name = "Gutter Only (Signs)",
			config = {
				virtual_text = false,
				virtual_lines = false,
				signs = {
					-- Custom mapping for signs if you want specific characters
					text = {
						[vim.diagnostic.severity.ERROR] = "E",
						[vim.diagnostic.severity.WARN] = "W",
						[vim.diagnostic.severity.HINT] = "H",
						[vim.diagnostic.severity.INFO] = "I",
					},
				},
				underline = false, -- Often cleaner to disable underline in "minimal" mode
				update_in_insert = false,
			},
		},
	}

	local function set_diagnostics_mode()
		if not diagnostics_active then
			vim.diagnostic.enable(false)
			printv("LSP Diagnostics: OFF")
			return
		end

		vim.diagnostic.enable(true)
		local mode = diagnostic_modes[current_mode_index]
		vim.diagnostic.config(mode.config)
		printv("LSP Mode: " .. mode.name)
	end

	set_diagnostics_mode()

	vim.lsp.config["haskell-language-server"] =
		{ ------------------------------------------------------------------ HASKELL
			cmd = { "haskell-language-server" },
			filetypes = { "haskell" },
			root_markers = { { "*.cabal" }, ".git" },
			settings = {},
		}
	vim.lsp.config["luals"] =
		{ ---------------------------------------------------------------------------------------- LUA
			-- Command and arguments to start the server.
			cmd = { "lua-language-server" },
			-- Filetypes to automatically attach to.
			filetypes = { "lua" },
			-- Sets the "workspace" to the directory where any of these files is found.
			-- Files that share a root directory will reuse the LSP server connection.
			-- Nested lists indicate equal priority, see |vim.lsp.Config|.
			root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
			-- Specific settings to send to the server. The schema is server-defined.
			-- Example: https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
			settings = {
				Lua = {
					runtime = {
						version = "LuaJIT",
					},
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
					},
					diagnostics = {
						globals = {
							"vim",
						},
					},
				},
			},
		}
	vim.lsp.config["ruff"] =
		{ -------------------------------------------------------------------------------------- PYTHON
			cmd = { "ruff", "server" },
			filetypes = { "python" },
			-- Sets the "workspace" to the directory where any of these files is found.
			-- Files that share a root directory will reuse the LSP server connection.
			-- Nested lists indicate equal priority, see |vim.lsp.Config|.
			root_markers = { { ".ruff_cache", "pyproject.toml" }, ".git" },
			settings = {},
		}
	vim.lsp.config["pyright"] = {
		cmd = { "pyright-langserver", "--stdio" },
		filetypes = { "python" },
		root_markers = {
			{ "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile" },
			".git",
		},
		settings = {
			python = {
				analysis = {
					autoSearchPaths = true,
					useLibraryCodeForTypes = true,
					typeCheckingMode = "basic", -- alternative: "strict"
				},
			},
		},
	}
	vim.lsp.config["nixd"] =
		{ ----------------------------------------------------------------------------------------- NIX
			cmd = { "nixd" },
			filetypes = { "nix" },
			root_markers = { "flake.nix", ".git" },
			settings = {},
		}
	vim.lsp.config["rust-analyzer"] =
		{ ------------------------------------------------------------------------------- RUST
			cmd = { "rust-analyzer" },
			filetypes = { "rust" },
			root_markers = { { "Cargo.toml", "cargo.lock" }, ".git" },
			settings = {},
		}
end

old_lsp = true
if old_lsp then
	vim.lsp.config["rust-analyzer"] = {
		cmd = { "rust-analyzer" },
		filetypes = { "rust" },
		root_markers = { { "Cargo.toml", "cargo.lock" }, ".git" },
		settings = {},
	}

	vim.lsp.config["nixd"] = {
		cmd = { "nixd" },
		filetypes = { "nix" },
		root_markers = { "flake.nix", ".git" },
		settings = {},
	}

	vim.lsp.config["luals"] = {
		-- Command and arguments to start the server.
		cmd = { "lua-language-server" },
		-- Filetypes to automatically attach to.
		filetypes = { "lua" },
		-- Sets the "workspace" to the directory where any of these files is found.
		-- Files that share a root directory will reuse the LSP server connection.
		-- Nested lists indicate equal priority, see |vim.lsp.Config|.
		root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
		-- Specific settings to send to the server. The schema is server-defined.
		-- Example: https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
		settings = {
			Lua = {
				runtime = {
					version = "LuaJIT",
				},
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
				},
				diagnostics = {
					globals = {
						"vim",
					},
				},
			},
		},
	}

	vim.lsp.config["ruff"] = {
		-- Command and arguments to start the server.
		cmd = { "ruff", "server" },
		-- Filetypes to automatically attach to.
		filetypes = { "python" },
		-- Sets the "workspace" to the directory where any of these files is found.
		-- Files that share a root directory will reuse the LSP server connection.
		-- Nested lists indicate equal priority, see |vim.lsp.Config|.
		root_markers = { { ".ruff_cache", "pyproject.toml" }, ".git" },
		-- Specific settings to send to the server. The schema is server-defined.
		-- Example: https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
		settings = {},
	}

	vim.lsp.config["pyright"] = {
		cmd = { "pyright-langserver", "--stdio" },
		filetypes = { "python" },
		root_markers = {
			{ "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile" },
			".git",
		},
		settings = {
			python = {
				analysis = {
					autoSearchPaths = true,
					useLibraryCodeForTypes = true,
					typeCheckingMode = "basic", -- You can change this to "strict"
				},
			},
		},
	}

	local diagnostic_modes = {
		{
			name = "End of Line (Virtual Text)",
			config = {
				virtual_text = {
					prefix = "●", -- Could be '■', '▎', 'x'
					spacing = 4,
					source = "if_many",
				},
				virtual_lines = false,
				signs = true,
				underline = true,
				update_in_insert = false,
			},
		},
		{
			name = "Under Line (Virtual Lines)",
			config = {
				virtual_text = false,
				-- 'virtual_lines' is now a built-in handler in Nvim 0.10/0.11+
				virtual_lines = {
					only_current_line = true, -- Only show for current line to reduce clutter
					highlight_whole_line = false,
				},
				signs = true,
				underline = true,
				update_in_insert = false,
			},
		},
		{
			name = "Gutter Only (Signs)",
			config = {
				virtual_text = false,
				virtual_lines = false,
				signs = {
					-- Custom mapping for signs if you want specific characters
					text = {
						[vim.diagnostic.severity.ERROR] = "E",
						[vim.diagnostic.severity.WARN] = "W",
						[vim.diagnostic.severity.HINT] = "H",
						[vim.diagnostic.severity.INFO] = "I",
					},
				},
				underline = false, -- Often cleaner to disable underline in "minimal" mode
				update_in_insert = false,
			},
		},
	}

	-- State tracking
	local current_mode_index = 1
	local diagnostics_active = false

	-- 2. Function to set the configuration
	local function set_diagnostics_mode()
		if not diagnostics_active then
			vim.diagnostic.enable(false)
			-- print("LSP Diagnostics: OFF")
			return
		end

		vim.diagnostic.enable(true)
		local mode = diagnostic_modes[current_mode_index]
		vim.diagnostic.config(mode.config)
		print("LSP Mode: " .. mode.name)
	end

	-- 3. Keybind: Toggle On/Off
	vim.keymap.set("n", "<leader>dt", function()
		diagnostics_active = not diagnostics_active
		set_diagnostics_mode()
	end, { desc = "Toggle LSP Diagnostics" })

	-- 4. Keybind: Cycle Modes
	vim.keymap.set("n", "<leader>dm", function()
		-- Only cycle if active; otherwise turn on and reset to 1
		if not diagnostics_active then
			diagnostics_active = true
			current_mode_index = 1
		else
			current_mode_index = current_mode_index + 1
			if current_mode_index > #diagnostic_modes then
				current_mode_index = 1
			end
		end
		set_diagnostics_mode()
	end, { desc = "Cycle LSP Diagnostic Modes" })

	-- Initialize on startup
	set_diagnostics_mode()

	vim.lsp.enable("luals")
	vim.lsp.enable("ruff")
	vim.lsp.enable("pyright")
	vim.lsp.enable("nixd")
end

vim.diagnostic.config({ virtual_text = false, virtual_lines = { current_line = true } })


-- lua/lsp/python.lua
-- Neovim 0.12+ native LSP for Python: Ruff + mypy + conform.nvim format-on-save
-- Best practices as of May 2026

local conform = utils.get_plugin("conform")

local function on_attach(client, bufnr)
	-- Disable Ruff hover if you add another server like pyright/basedpyright later
	if client.name == "ruff" then
		client.server_capabilities.hoverProvider = false
	end

	-- Common keymaps (adjust as needed)
	local opts = { buffer = bufnr, silent = true }
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "<leader>cf", function()
		conform.format({ bufnr = bufnr })
	end, opts)
end

-- Ruff LSP (fast linting, formatting, import organization, etc.)
-- Place this in after/lsp/ruff.lua or define inline
vim.lsp.config("ruff", {
	cmd = { "ruff", "server" },
	filetypes = { "python" },
	root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
	on_attach = on_attach,
	init_options = {
		settings = {
			-- Ruff server settings (see Ruff docs)
			logLevel = "info", -- or "debug" for troubleshooting
			-- Example: enable specific rules or configure line length
			-- lint = { select = { "ALL" }, ignore = {} },
			-- format = { preview = true },
		},
	},
})

-- Enable Ruff
vim.lsp.enable("ruff")

-- Optional: Add pyright/basedpyright for richer completion & type checking
-- (Uncomment if desired; it complements Ruff well)
--[[
vim.lsp.config("pyright", {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "setup.py", ... },
  on_attach = on_attach,
  settings = {
    pyright = {
      disableOrganizeImports = true, -- Let Ruff handle imports
    },
    python = {
      analysis = {
        typeCheckingMode = "basic", -- or "strict"
        diagnosticMode = "workspace",
      },
    },
  },
})
vim.lsp.enable("pyright")
--]]

-- Mypy integration
-- Option 1: Via nvim-lint (recommended for live diagnostics)
-- Option 2: Use conform for on-save mypy checks (slower but thorough)

-- Diagnostics config (best practices)
vim.diagnostic.config({
	virtual_text = { prefix = "●", spacing = 2 },
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = { border = "rounded", source = "always" },
})

-- Conform.nvim setup for formatting on save (Ruff + optional mypy)
conform.setup({
	formatters_by_ft = {
		python = {
			"ruff_fix", -- Auto-fix lint errors
			"ruff_format", -- Ruff formatter (replaces Black)
			"ruff_organize_imports",
			-- "mypy"             -- Uncomment for type checking on save (slow; better in CI)
		},
	},
	format_on_save = {
		timeout_ms = 1000,
		lsp_format = "fallback", -- Use LSP formatting if available
	},
	-- Custom mypy formatter (runs mypy and reports errors)
	formatters = {
		mypy = {
			command = "mypy",
			args = { "--no-error-summary", "--show-column-numbers", "--no-color-output", "$FILENAME" },
			stdin = false,
			-- Ignore exit code so it doesn't block save; use for diagnostics instead
			ignore_exitcode = true,
		},
	},
})

-- Auto-format on save via autocmd (fallback / extra control)
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.py",
	callback = function(args)
		conform.format({ bufnr = args.buf })
	end,
	desc = "Format Python on save with conform",
})

-- Optional: nvim-lint for mypy + ruff linting (faster live feedback)
-- Add `mfussenegger/nvim-lint` plugin if you want this
--[[
require("lint").linters_by_ft = {
  python = { "ruff", "mypy" },
}
vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
--]]

-- alternative

vim.lsp.config("ruff", {
	cmd = { "ruff", "server" },
	filetypes = { "python" },
	root_markers = { "pyproject.toml", "ruff.toml", ".git" },
	settings = {
		-- Any specific ruff settings go here
	},
})

-- PyLSP: Specifically configured for Mypy type checking
vim.lsp.config("pylsp", {
	cmd = { "pylsp" },
	filetypes = { "python" },
	settings = {
		pylsp = {
			plugins = {
				-- Disable standard lints/formatters provided by Ruff
				pyflakes = { enabled = false },
				pycodestyle = { enabled = false },
				mccabe = { enabled = false },
				-- Enable Mypy
				pylsp_mypy = {
					enabled = true,
					live_mode = true, -- Provides type-checking as you type
					strict = true,
				},
			},
		},
	},
})

-- Enable both servers
vim.lsp.enable("ruff")
vim.lsp.enable("pylsp")

-- 2. FORMATTING (Conform.nvim)
-- Using conform for "Format on Save" with Ruff
conform.setup({
	formatters_by_ft = {
		python = { "ruff_format", "ruff_organize_imports" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})

-- 3. MODERN LSP KEYMAPS (Neovim 0.12 Defaults)
-- Neovim 0.12 provides better defaults, but here are the standard 2026 mappings:
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local opts = { buffer = args.buf }
		-- Note: 'grn' (rename), 'gra' (code action), and 'grr' (references)
		-- are now built-in defaults in 0.12.
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "<leader>cl", vim.lsp.codelens.run, opts)
	end,
})

-- use Nix to install:
-- pip install "python-lsp-server[all]" pylsp-mypy

-- OLD JUNK BELOW HERE

-- lua/lsp/python.lua
-- Neovim 0.12+ native LSP for Python: Ruff + mypy + conform.nvim format-on-save
-- Best practices as of May 2026

local function on_attach(client, bufnr)
	-- Disable Ruff hover if you add another server like pyright/basedpyright later
	if client.name == "ruff" then
		client.server_capabilities.hoverProvider = false
	end

	-- Common keymaps (adjust as needed)
	local opts = { buffer = bufnr, silent = true }
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "<leader>cf", function()
		require("conform").format({ bufnr = bufnr })
	end, opts)
end

-- Ruff LSP (fast linting, formatting, import organization, etc.)
-- Place this in after/lsp/ruff.lua or define inline
vim.lsp.config("ruff", {
	cmd = { "ruff", "server" },
	filetypes = { "python" },
	root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
	on_attach = on_attach,
	init_options = {
		settings = {
			-- Ruff server settings (see Ruff docs)
			logLevel = "info", -- or "debug" for troubleshooting
			-- Example: enable specific rules or configure line length
			-- lint = { select = { "ALL" }, ignore = {} },
			-- format = { preview = true },
		},
	},
})

-- Enable Ruff
vim.lsp.enable("ruff")

-- Optional: Add pyright/basedpyright for richer completion & type checking
-- (Uncomment if desired; it complements Ruff well)
--[[
vim.lsp.config("pyright", {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "setup.py", ... },
  on_attach = on_attach,
  settings = {
    pyright = {
      disableOrganizeImports = true, -- Let Ruff handle imports
    },
    python = {
      analysis = {
        typeCheckingMode = "basic", -- or "strict"
        diagnosticMode = "workspace",
      },
    },
  },
})
vim.lsp.enable("pyright")
--]]

-- Mypy integration
-- Option 1: Via nvim-lint (recommended for live diagnostics)
-- Option 2: Use conform for on-save mypy checks (slower but thorough)

-- Diagnostics config (best practices)
vim.diagnostic.config({
	virtual_text = { prefix = "●", spacing = 2 },
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = { border = "rounded", source = "always" },
})

-- Conform.nvim setup for formatting on save (Ruff + optional mypy)
require("conform").setup({
	formatters_by_ft = {
		python = {
			"ruff_fix", -- Auto-fix lint errors
			"ruff_format", -- Ruff formatter (replaces Black)
			"ruff_organize_imports",
			-- "mypy"             -- Uncomment for type checking on save (slow; better in CI)
		},
	},
	format_on_save = {
		timeout_ms = 1000,
		lsp_format = "fallback", -- Use LSP formatting if available
	},
	-- Custom mypy formatter (runs mypy and reports errors)
	formatters = {
		mypy = {
			command = "mypy",
			args = { "--no-error-summary", "--show-column-numbers", "--no-color-output", "$FILENAME" },
			stdin = false,
			-- Ignore exit code so it doesn't block save; use for diagnostics instead
			ignore_exitcode = true,
		},
	},
})

-- Auto-format on save via autocmd (fallback / extra control)
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.py",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
	desc = "Format Python on save with conform",
})

-- Optional: nvim-lint for mypy + ruff linting (faster live feedback)
-- Add `mfussenegger/nvim-lint` plugin if you want this
--[[
require("lint").linters_by_ft = {
  python = { "ruff", "mypy" },
}
vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
--]]

-- ALTERNATIVE

-- 1. LSP CONFIGURATION (Native Neovim 0.12+ API)
-- We define configs using vim.lsp.config and activate them with vim.lsp.enable

-- Ruff: Handles linting and primary formatting
vim.lsp.config("ruff", {
	cmd = { "ruff", "server" },
	filetypes = { "python" },
	root_markers = { "pyproject.toml", "ruff.toml", ".git" },
	settings = {
		-- Any specific ruff settings go here
	},
})

-- PyLSP: Specifically configured for Mypy type checking
vim.lsp.config("pylsp", {
	cmd = { "pylsp" },
	filetypes = { "python" },
	settings = {
		pylsp = {
			plugins = {
				-- Disable standard lints/formatters provided by Ruff
				pyflakes = { enabled = false },
				pycodestyle = { enabled = false },
				mccabe = { enabled = false },
				-- Enable Mypy
				pylsp_mypy = {
					enabled = true,
					live_mode = true, -- Provides type-checking as you type
					strict = true,
				},
			},
		},
	},
})

-- Enable both servers
vim.lsp.enable("ruff")
vim.lsp.enable("pylsp")

-- 2. FORMATTING (Conform.nvim)
-- Using conform for "Format on Save" with Ruff
require("conform").setup({
	formatters_by_ft = {
		python = { "ruff_format", "ruff_organize_imports" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})

-- 3. MODERN LSP KEYMAPS (Neovim 0.12 Defaults)
-- Neovim 0.12 provides better defaults, but here are the standard 2026 mappings:
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local opts = { buffer = args.buf }
		-- Note: 'grn' (rename), 'gra' (code action), and 'grr' (references)
		-- are now built-in defaults in 0.12.
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "<leader>cl", vim.lsp.codelens.run, opts)
	end,
})

-- pip install "python-lsp-server[all]" pylsp-mypy
-- [Modern Neovim LSP Setup Guide](https://www.youtube.com/watch?v=lljs_7xB7Ps)

-- TELESCOPE =================================================================================================


local telescope = utils.setup_plugin_default("telescope", function(telescope)
	telescope.setup({
		extensions = {
			fzf = {
				fuzzy = true, -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = "smart_case", -- or "ignore_case" or "respect_case"
				-- the default case_mode is "smart_case"
			},
		},
	})
	telescope.load_extension("fzf")
	print("loaded telescope with fzf-native")
end)

-- TREESITTER =================================================================================================


vim.opt.indentexpr = "v:lua.vim.treesitter.indent()"
-- vim.opt.foldmethod = "expr" + foldexpr
-- vim.treesitter.query.add(lang, name, str) -- TODO
-- vim.treesitter.language.register() -- TODO

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.indentexpr = "v:lua.vim.treesitter.indent()"

-- Register filetype aliases
vim.treesitter.language.register("cpp", "cuda")
vim.treesitter.language.register("javascript", "jsx")
vim.treesitter.language.register("typescript", "tsx")

-- Optional: Auto-install parsers on first run (custom helper)
-- local parsers_to_ensure = { "c", "lua", "python", "javascript", "typescript", "bash", "json" }
-- for _, lang in ipairs(parsers_to_ensure) do
-- 	if not vim.treesitter.language.is_installed(lang) then  TODO
-- 		vim.cmd.TSInstall(lang)
-- 	end
-- end

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.indentexpr = "v:lua.vim.treesitter.indent()"

-- vim.g.treesitter_filetype_exclude = { "markdown", "txt" }

-- TODO: treesitter queries in RTP/queries/<lang>/

vim.treesitter.query.add_predicate(
	"python",
	"highlights",
	[[
  (function_definition
    name: (identifier) @function.def)
]]
)

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "rust", "go", "python" }, -- add languages
	callback = function()
		if not vim.treesitter.language.get_lang(vim.bo.filetype) then
			-- Or use a plugin/helper for installation
			print("No Treesitter parser for " .. vim.bo.filetype)
		end
	end,
})

pcall(vim.api.nvim_del_user_command, "TSInstall")
pcall(vim.api.nvim_del_user_command, "TSInstallSync") -- if it exists
pcall(vim.api.nvim_del_user_command, "TSInstallFromGrammar")

-- OR:
for _, cmd in ipairs({ "TSInstall", "TSInstallSync", "TSInstallFromGrammar" }) do
	pcall(vim.api.nvim_del_user_command, cmd)
end

-- OR:
vim.api.nvim_create_user_command("TSInstall", function()
	vim.notify("TSInstall is disabled. Manage parsers externally.", vim.log.levels.WARN)
end, {
	nargs = "*",
	complete = function()
		return {}
	end,
})

-- To manually toggle highlighting at runtime:
-- ```vim
-- :TSEnable highlight
-- :TSDisable highlight
-- ```

-- print(vim.o.runtimepath:find(vim.env.VIMRUNTIME) ~= nil)

-- print(vim.inspect(vim.opt.runtimepath))

-- setup_plugin("nvim-treesitter", function(treesitter)
-- 	local TS_LANGUAGES = {
-- 		"haskell",
-- 		"javascript",
-- 		"json",
-- 		"lua",
-- 		"markdown",
-- 		"nix",
-- 		"python",
-- 		"rust",
-- 		"toml",
-- 		"typescript",
-- 		"yaml",
-- 		"zig",
-- 	}

-- 	utils.printbv("Setting up treesitter.")
-- 	local my_install_dir = (not HAS_NIX) and ((vim.fn.stdpath("data")) .. "/site") or DERIVATION_DIR
-- 	utils.printv(my_install_dir)
-- 	local my_parser_install_dir = (not HAS_NIX) and (vim.fn.stdpath("data")) .. "/site/parsers" or nil
-- 	utils.printv(my_parser_install_dir)
-- 	local my_ensure_installed = HAS_NIX and {} or TS_LANGUAGES
-- 	utils.printv(vim.inspect(my_ensure_installed))

-- 	utils.printbv("Treesitter exists")
-- 	(treesitter.setup)({
-- 		install_dir = my_install_dir,
-- 		parser_install_dir = my_parser_install_dir,
-- 		ensure_installed = my_ensure_installed,
-- 		highlight = { enable = true },
-- 		indent = { enable = true },
-- 	})
-- end)

local my_install_dir = (not HAS_NIX) and ((vim.fn.stdpath("data")) .. "/site") or DERIVATION_DIR

local my_parser_install_dir = my_install_dir .. "/parser"
-- (not HAS_NIX) and (vim.fn.stdpath("data")) .. "/site/parsers" or DERIVATION_DIR ..

local my_ensure_installed = HAS_NIX and {} or TS_LANGUAGES

utils.printbv("Setting up treesitter.")
utils.printb("my_install_dir:        " .. my_install_dir)
utils.printb("my_parser_install_dir: " .. my_parser_install_dir)
utils.printb("my_ensure_installed:   " .. vim.inspect(my_ensure_installed))

-- vim.treesitter.setup(
--     {
-- 		install_dir = my_install_dir,
-- 		parser_install_dir = my_parser_install_dir,
-- 		ensure_installed = my_ensure_installed,
-- 		highlight = { enable = true },
-- 		indent = { enable = true },
-- 	}
-- )

parser_root = vim.fn.fnamemodify(OPT_DIR, ":h:h:h")
vim.opt.runtimepath:prepend(PARSER_DIR)


vim.treesitter.language.register("py", "python")

vim.filetype.add({
	extension = { xit = "xit" },
})
vim.treesitter.language.register("xit", "xit")
vim.api.nvim_create_autocmd("FileType", {
	pattern = "xit",
	callback = function(ev)
		print("executing xit callback")
		vim.treesitter.language.add("xit", { path = PARSER_DIR .. "/xit.so" })
		vim.treesitter.start(ev.buf, "xit")
	end,
})

-- v_an, v_in, v_]n, v_[n now provide incremental selection of treesitter nodes

-- put in ftplugin/<filetype>.lua ?

-- config/
-- ├── ftdetect/
-- │   └── xit.lua
-- ├── ftplugin/
-- │   └── xit.lua       ← here
-- ├── syntax/
-- │   └── xit.lua
-- └── init.lua

vim.api.nvim_create_autocmd("FileType", {
	pattern = "lua",
	callback = function()
		vim.treesitter.start()
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		pcall(vim.treesitter.start) -- pcall: silently skips if no parser
	end,
})


-- OVERSEER =================================================================================================

local overseer = utils.setup_plugin("overseer", function(overseer)
	overseer.setup({ templates = { "builtin", "my_custom_just_provider" } })
end)

local overseer = utils.get_plugin("overseer")
-- print(overseer)

-- sky.nvim?
-- just.nvim
-- Task.nvim
-- resession.nvim
-- toggleterm.nvim

local function run_just_task()
	local opts = {}
	-- Use vim.system to get just tasks as a table
	local obj = vim.system({ "just", "--summary" }, { text = true }):wait()
	local tasks = vim.split(obj.stdout, " ")

	vim.ui.select(tasks, { prompt = "Run Just Task:" }, function(choice)
		if choice then
			-- Run in a floating terminal (using toggleterm or built-in)
			vim.cmd("TermExec cmd='just " .. choice .. "'")
		end
	end)
end

-- local overseer = require("overseer")

overseer.register_template({
	name = "Taskfile Runner",
	generator = function(opts, cb)
		-- 1. Check for Taskfile
		local taskfile = vim.fs.find({ "Taskfile.yml", "Taskfile.yaml" }, { upward = true, path = opts.dir })[1]
		if not taskfile then
			cb({})
			return
		end

		-- 2. Fetch tasks via CLI
		vim.system({ "task", "--list-all", "--json" }, { text = true }, function(obj)
			if obj.code ~= 0 then
				cb({})
				return
			end

			local data = vim.json.decode(obj.stdout)
			local tasks = {}

			-- 3. Map JSON tasks to Overseer format
			for _, task in ipairs(data.tasks or {}) do
				table.insert(
					tasks,
					overseer.wrap_template({
						name = task.name,
						desc = task.desc or "Taskfile task",
						params = {},
						builder = function()
							return {
								cmd = { "task" },
								args = { task.name },
								components = { "default", "on_result_diagnostics" },
							}
						end,
					}, { name = task.name })
				)
			end

			cb(tasks)
		end)
	end,
	condition = {
		callback = function(opts)
			return vim.fs.find({ "Taskfile.yml", "Taskfile.yaml" }, { upward = true, path = opts.dir })[1] ~= nil
		end,
	},
})

overseer.register_template({
	name = "Taskfile (with Params)",
	generator = function(opts, cb)
		local taskfile = vim.fs.find({ "Taskfile.yml", "Taskfile.yaml" }, { upward = true, path = opts.dir })[1]
		if not taskfile then
			return cb({})
		end

		vim.system({ "task", "--list-all", "--json" }, { text = true }, function(obj)
			if obj.code ~= 0 then
				return cb({})
			end
			local data = vim.json.decode(obj.stdout)
			local tasks = {}

			for _, task in ipairs(data.tasks or {}) do
				table.insert(
					tasks,
					overseer.wrap_template({
						name = task.name,
						desc = task.desc,
						-- Define parameters here
						params = {
							args = {
								type = "string",
								name = "Extra Arguments",
								desc = "Vars to pass (e.g. VERSION=1.0)",
								optional = true,
							},
						},
						builder = function(params)
							local cmd_args = { task.name }
							if params.args and params.args ~= "" then
								table.insert(cmd_args, params.args)
							end

							return {
								cmd = { "task" },
								args = cmd_args,
								components = {
									"default",
									{ "display_duration", detail_level = 2 },
									"on_output_summarize",
									"on_exit_set_status",
								},
							}
						end,
					}, { name = task.name })
				)
			end
			cb(tasks)
		end)
	end,
})

local function run_task_with_ui()
	vim.system({ "task", "--list-all", "--summary" }, { text = true }, function(obj)
		local tasks = {}
		for line in obj.stdout:gmatch("[^\r\n]+") do
			local name = line:match("^%* ([%w%-_]+):")
			if name then
				table.insert(tasks, name)
			end
		end

		vim.schedule(function()
			vim.ui.select(tasks, { prompt = "Execute Task:" }, function(choice)
				if not choice then
					return
				end
				-- Run in a background job or terminal
				vim.cmd("vsplit | term task " .. choice)
			end)
		end)
	end)
end

-- with watcher
overseer.register_template({
	name = "Taskfile (with Watcher)",
	generator = function(opts, cb)
		local taskfile = vim.fs.find({ "Taskfile.yml", "Taskfile.yaml" }, { upward = true, path = opts.dir })[1]
		if not taskfile then
			return cb({})
		end

		vim.system({ "task", "--list-all", "--json" }, { text = true }, function(obj)
			if obj.code ~= 0 then
				return cb({})
			end
			local data = vim.json.decode(obj.stdout)
			local tasks = {}

			for _, task in ipairs(data.tasks or {}) do
				table.insert(
					tasks,
					overseer.wrap_template({
						name = task.name,
						desc = task.desc,
						params = {
							args = { type = "string", name = "Vars", optional = true },
							watch = { type = "boolean", name = "Watch files?", default = false },
						},
						builder = function(params)
							local cmd_args = { task.name }
							if params.args and params.args ~= "" then
								table.insert(cmd_args, params.args)
							end

							local components = { "default" }
							if params.watch then
								-- This component tells Overseer to restart the task on save
								table.insert(components, { "on_save_reload", delay = 500 })
							end

							return {
								cmd = { "task" },
								args = cmd_args,
								components = components,
							}
						end,
					}, { name = task.name })
				)
			end
			cb(tasks)
		end)
	end,
})

utils.setup_plugin("lualine", {
	sections = {
		lualine_x = {
			{
				"overseer",
				label = "Tasks: ", -- Prefix for the section
				unique = true, -- Only show one representative icon per state
			},
		},
	},
})

overseer.register_template({
	name = "Taskfile with Diagnostics",
	generator = function(opts, cb)
		local taskfile = vim.fs.find({ "Taskfile.yml", "Taskfile.yaml" }, { upward = true, path = opts.dir })[1]
		if not taskfile then
			return cb({})
		end

		vim.system({ "task", "--list-all", "--json" }, { text = true }, function(obj)
			if obj.code ~= 0 then
				return cb({})
			end
			local data = vim.json.decode(obj.stdout)
			local tasks = {}

			for _, task in ipairs(data.tasks or {}) do
				table.insert(
					tasks,
					overseer.wrap_template({
						name = task.name,
						params = {
							watch = { type = "boolean", name = "Watch files?", default = false },
						},
						builder = function(params)
							local components = { "default" }
							if params.watch then
								table.insert(components, { "on_save_reload", delay = 500 })
							end

							-- ADDED: This component parses the output into diagnostics
							table.insert(components, {
								"on_result_diagnostics",
								remove_on_restart = true,
								-- Standard Python error format (adjust as needed)
								errorformat = [[%f:%l:%c: %t%*[^ ] %m,%f:%l: %t%*[^ ] %m]],
							})

							return {
								cmd = { "task" },
								args = { task.name },
								components = components,
							}
						end,
					}, { name = task.name })
				)
			end
			cb(tasks)
		end)
	end,
})

-- OverseerRun
-- OverseerToggle

local function taskfile_picker()
	vim.cmd.packadd("telescope")
	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	local conf = require("telescope.config").values
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")

	-- Get tasks from Taskfile
	local handle = io.popen("task --list-all --summary")
	local result = handle:read("*a")
	handle:close()

	local tasks = {}
	for line in result:gmatch("[^\r\n]+") do
		local name = line:match("^%* ([%w%-_]+):")
		if name then
			table.insert(tasks, name)
		end
	end

	pickers
		.new({}, {
			prompt_title = "Taskfile Tasks",
			finder = finders.new_table({ results = tasks }),
			sorter = conf.generic_sorter({}),
			attach_mappings = function(prompt_bufnr, map)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local selection = action_state.get_selected_entry()
					-- Execute in a terminal
					vim.cmd("split | term task " .. selection[1])
				end)
				return true
			end,
		})
		:find()
end

vim.keymap.set("n", "<leader>tk", taskfile_picker, { desc = "Pick Taskfile task" })

-- common formats for
-- Python (Ruff/Flake8):** `%f:%l:%c: %m`
-- Go (golangci-lint):** `%f:%l:%c: %m`
-- Generic (File:Line:Msg):** `%f:%l: %m`


-- UNSORTED =================================================================================================

-- from recent init.lua
recent_init = true
if recent_init then --=============
	setup_plugin("plenary")
	setup_plugin("nio")
	setup_plugin("nvim-web-devicons")

	setup_plugin("zen-mode")
	setup_plugin("lualine")
	setup_plugin("nvim-navic")
	setup_plugin("bufferline")
	setup_plugin("statuscol")

	setup_plugin("treesitter-modules")
	setup_plugin("dropbar")
	utils.packadd("nvim-navbuddy")
	setup_plugin("aerial")

	setup_plugin("oil")
	setup_plugin("yazi")
	setup_plugin("neo-tree")
	setup_plugin("nvim-tree")

	setup_plugin("pickme")
	-- setup_plugin("telescope") MOVED

	setup_plugin("fzf-lua")
	setup_plugin("deck")

	setup_plugin("mini.indent")
	setup_plugin("mini.keymap")
	setup_plugin("mini.sessions")

	setup_plugin("snacks")
	setup_plugin("blink")

	setup_plugin("hlslens")
	setup_plugin("hlsearch")

	setup_plugin("grug-far")
	setup_plugin("spectre")

	setup_plugin("flybuf")
	setup_plugin("stickybuf")
	setup_plugin("swm", function(swm)
		map("n", "<C-w>h", swm.h)
		map("n", "<C-w>j", swm.j)
		map("n", "<C-w>k", swm.k)
		map("n", "<C-w>l", swm.l)
	end)

	setup_plugin("smart-splits")

	setup_plugin("ufo")

	setup_plugin("NeoComposer")
	setup_plugin("nvim-macros", {
		json_file_path = "./macros.json",
		default_macro_register = "a",
		json_formatter = "jq",
	})
	setup_plugin("recorder")

	utils.packadd("vim-visual-multi")

	setup_plugin("leap")
	setup_plugin("flash")
	setup_plugin("hop")

	setup_plugin("rainbow-delimiters")
	setup_plugin("nvim-autopairs")

	utils.packadd("vim-sandwich")

	setup_plugin("nvim-surround")

	utils.packadd("vim-mundo")

	setup_plugin("mini.keymap")
	setup_plugin("hydra")
	setup_plugin("insx")
	setup_plugin("which-key")

	setup_plugin("indentmini")
	utils.packadd("indent-blankline")
	setup_plugin("nvim-anydent")
	setup_plugin("mini.align")
	utils.packadd("tabular")

	setup_plugin("nvim-treesitter-textobjects")
	utils.packadd("nvim-various-textobjs")

	setup_plugin("Comment")
	setup_plugin("todo-comments")
	utils.packadd("vim-commentary")

	setup_plugin("treesj")
	setup_plugin("dial")
	setup_plugin("harpoon-core")
	setup_plugin("marks")
	setup_plugin("markit")

	setup_plugin("nvim-pasta")

	setup_plugin("beam")

	setup_plugin("blink.cmp")
	setup_plugin("nvim-cmp")

	setup_plugin("friendly-snippets")
	setup_plugin("ultisnips")
	setup_plugin("LuaSnip")

	setup_plugin("cmp-nvim-lsp")
	setup_plugin("cmp-buffer")
	setup_plugin("cmp-path")
	setup_plugin("cmp-cmdline")

	setup_plugin("lsp-format")
	setup_plugin("lspkind")

	setup_plugin("lspsaga")

	setup_plugin("lazydev")
	setup_plugin("rustaceanvim")
	setup_plugin("crates")
	setup_plugin("haskell-tools")

	setup_plugin("none-ls")

	setup_plugin("guard")
	setup_plugin("conform")

	setup_plugin("asyncrun")
	setup_plugin("neotest-haskell")
	setup_plugin("neotest-python")
	setup_plugin("neotest")
	setup_plugin("dap-python", function(dap_python)
		(dap_python.setup)("debugpy-adapter")
		dap_python.test_runner = "pytest"
		map("n", "<leader>tt", function()
			print("Leader is working!")
		end)
		map("n", "<leader>pp", function()
			print("This works")
		end)
		map("n", "<leader>dn", dap_python.test_method)
		map("n", "<leader>df", dap_python.test_class)
		map("v", "<leader>ds", dap_python.debug_selection)
	end)
	setup_plugin("dapui")
	setup_plugin("nvim-dap-virtual-text")
	setup_plugin("dap")
	setup_plugin("mypy")
	setup_plugin("nvim-lint")

	setup_plugin("trouble.nvim")
	setup_plugin("quicker")
	setup_plugin("nvim-bqf")

	setup_plugin("vim-floaterm")
	setup_plugin("toggleterm")

	setup_plugin("overseer")

	setup_plugin("refactoring")

	setup_plugin("project")
	setup_plugin("telescope-project")

	setup_plugin("jj")
	setup_plugin("jujutsu")
	setup_plugin("lazygit")
	setup_plugin("git-conflict")
	setup_plugin("neogit")
	setup_plugin("jiejie")
	setup_plugin("diffview")
	setup_plugin("gitsigns")
	setup_plugin("vim-fugitive")

	setup_plugin("octo")
	setup_plugin("gitlab-nvim")
	setup_plugin("gitlab")

	setup_plugin("dashboard-nvim")
	setup_plugin("dashboard")
	setup_plugin("noice")
	setup_plugin("modes")

	setup_plugin("fidget")
	setup_plugin("nvim-notify")
	setup_plugin("headlines")

	setup_plugin("auto-session")
	setup_plugin("persistence")

	utils.packadd("vimtex", function()
		vim.g.vimtex_view_method = "zathura"
	end)
	setup_plugin("texmagic")
	setup_plugin("schemastore")
	setup_plugin("firenvim")
	setup_plugin("render-markdown")
	setup_plugin("jupytext")
	setup_plugin("quarto")
	setup_plugin("markdown-preview")

	setup_plugin("structlog")
	setup_plugin("neorepl")
end

setup_plugin("dial")

local scratch = false
if scratch then
	--------- old implementation

	local has_nix, nix_plugins = pcall(require, "nix_plugins")

	---@param id string The key in the nix_plugins table (e.g., "oil-nvim")
	---@param github_src string Fallback GitHub URL
	local function get_spec(id, github_src)
		local dev_path = vim.fn.expand("~/repos/" .. id)
		if vim.uv.fs_stat(dev_path) then
			return { path = dev_path }
		end

		if has_nix and nix_plugins[id] then
			return { path = nix_plugins[id] }
		end

		return { src = github_src }
	end

	--------- oldest sketch

	local M = {}

	-- Detect if we are on a Nix-managed system
	-- We check for a specific environment variable or the /nix/store directory
	M.is_nix = vim.uv.fs_stat("/nix/store") ~= nil

	---@param name string The plugin folder name (e.g., "oil.nvim")
	---@param repo string The GitHub shorthand (e.g., "stevearc/oil.nvim")
	---@return table
	function M.plug(name, repo)
		if M.is_nix then
			-- On Nix, we assume the plugin is already provided in the packpath
			-- or available in a specific local directory managed by Nix.
			-- Adjust "/etc/profiles/per-user/$USER/share/nvim/site/..." if needed.
			local nix_path = vim.fn.expand("~/.nix-profile/share/nvim/site/pack/dist/start/" .. name)

			if vim.uv.fs_stat(nix_path) then
				return { path = nix_path }
			end
		end

		-- Fallback for Git: use the remote URI
		return { src = "https://github.com/" .. repo }
	end

	-- Example Usage:
	vim.pack.add({
		M.plug("oil.nvim", "stevearc/oil.nvim"),
		M.plug("blink.cmp", "saghen/blink.cmp"),
		M.plug("rustaceanvim", "mrcjkb/rustaceanvim"),
	})

	-- PLUGINS DIR (OLD)
	local plugin_base_dir = vim.fn.expand("~/.local/share/nvim-plugins")

	-- Get a list of all directories inside your custom folder
	local handle = vim.uv.fs_scandir(plugin_base_dir)

	if handle then
		while true do
			local name, type = vim.uv.fs_scandir_next(handle)
			if not name then
				break
			end

			-- Only process directories (skip READMEs, .DS_Store, etc.)
			if type == "directory" and name == "yazi" or name == "plenary" then
				local plugin_path = plugin_base_dir .. "/" .. name

				-- Prepend to RTP so your manual plugins take priority over defaults
				vim.opt.runtimepath:prepend(plugin_path)
			end
		end
	else
		print("Warning: Plugin directory not found: " .. plugin_base_dir)
	end
end

if init_from_stable then
	-- TODO: see https://www.reddit.com/r/neovim/comments/1afw5tc/rustaceanvim_now_with_neotest_integration/

	-- wezterm: TODO: vendor
	-- https://github.com/willothy/wezterm.nvim
	-- https://github.com/ianhomer/wezterm.nvim
	-- https://github.com/aca/wezterm.nvim (in Go)
	-- https://github.com/letieu/wezterm-move.nvim
	-- https://github.com/jonboh/wezterm-mux.nvim -> https://github.com/mrjones2014/smart-splits.nvim

	-- look at https://github.com/yochem/lazy-vimpack

	-- additional LSPs:
	-- https://github.com/latex-lsp/texlab
	-- jsonls and yamlls
	-- https://www.npmjs.com/package/vscode-json-languageserver
	-- https://github.com/redhat-developer/yaml-language-server

	-- on macos:
	-- brew install ruff
	-- brew install lua-language-server
	-- brew install rust-analyzer
	-- brew install haskell-language-server

	--[[ DESIRED MAPPINGS/ACTIONS
	------------------
	--- NAVIGATION ---
	------------------
	- windows: up down left right, fzf menu, menu navigation (up down), move/rearrange
	- tabs: up down left right, fzf menu, menu navigation (up down), move/rearrange
	- buffers: up down left right, fzf menu, menu navigation (up down), move/rearrange

	------------
	--- SORT ---
	------------
	- open quickfix window
	- open floating terminal
	- copy selection to new file
	- jump to reference (next, previous)
	- jump to definition
	- open search and replace (with preview)
	- fold block
	- fold/unfold all of given level
	- toggle value under cursor
	- rename everywhere (optionally with preview)
	- search pattern/regex in given files -> save results list & use it to navigate
	- show keybinds available
	- add/view/edit comment/annotation pointing to given location
	- view/navigate TODOs and comments
	- insert snippet
	- format code (optionally only under selection)
	- edit selection in new buffer
	- dull colors outside of selection
	- edit filesystem as a buffer (oil.nvim?)
	- get autocomplete suggestion
	- check spelling in file (ONLY on command!)
	- view diff (with saved, last commit, etc.)
	- file tree view
	- navigate between search results
	- toggle to light colors (or even lighten/darken colors, increase contrast -> write plugin?)
	- jump to next syntactic object
	- command to run changed tests (use testmon or analogous)
	- get LLM feedback
	- unified preview_+accept/reject framework
	- multi-line / multi-location edits

	AUTOMATIC/TOGGLABLE FUNCTIONALITIES
	--> dull colors everywhere except in active block (via treesitter?)
	--> custom syntax highlighting for my special formats (from consilium-notes: jn, ...)
	--]]
	-------------------------------------------------------------------------------------------------------------- VARIABLES
	-- local o = vim.opt
	-- local g = vim.g

	local CONFIG_DIR = vim.fn.fnamemodify(debug.getinfo(1).source:sub(2), ":p:h")
	local PWD = vim.fn.getcwd()
	local NVIM_DIR = vim.fn.expand("~/.config/nvim")
	HAS_NIX, PLUGIN_LOCATIONS = pcall(dofile, NVIM_DIR .. "/nix_plugins.lua")
	BE_VERBOSE = false

	local current_mode_index = 1
	local diagnostics_active = false

	TS_LANGUAGES = {
		"haskell",
		"javascript",
		"json",
		"lua",
		"markdown",
		"nix",
		"python",
		"rust",
		"toml",
		"typescript",
		"yaml",
		"zig",
	}
	---------------------------------------------------------------------------------------------------------- BASIC OPTIONS
	local function set_options()
		local global_options = {
			mapleader = " ",
		}
		local options = {
			number = true,
			relativenumber = true,
			shiftwidth = 4,
			wrap = false,
			signcolumn = "yes",
			tabstop = 4,
			swapfile = false,
			winborder = "rounded",
			termguicolors = true,
			undofile = true,
			incsearch = true,
			timeout = true,
			timeoutlen = 300,
		}
		for name, value in pairs(options) do
			vim.opt[name] = value
		end
		for name, value in pairs(global_options) do
			vim.g[name] = value
		end
	end

	set_options()
	------------------------------------------------------------------------------------------------------------------ SCRATCH
	local function disable_builtins()
		local builtin_plugs = {
			"2html_plugin",
			"gzip",
			"man",
			"matchit",
			"matchparen",
			"netrwPlugin",
			"remote_plugins",
			"shada_plugin",
			"spellfile_plugin",
			"tarPlugin",
			"tutor_mode_plugin",
			"zipPlugin",
		}
		for i = 1, #builtin_plugs do
			vim.g["loaded_" .. builtin_plugs[i]] = 1
		end
	end

	local function list_loaded_vars()
		-- Use Vim's completion engine to find all global variables
		local all_vars = vim.fn.getcompletion("", "var")

		local loaded_vars = {}
		for _, var in ipairs(all_vars) do
			if var:match("^loaded_") then
				table.insert(loaded_vars, var)
			end
		end

		-- Print them nicely
		table.sort(loaded_vars)
		print(table.concat(loaded_vars, "\n"))
	end

	-- list_loaded_vars()
	------------------------------------------------------------------------------------------------------------------ UTILS
	local function map(spec)
		vim.keymap.set(spec.mode, spec.sequence or spec.lhs, spec.action or spec.rhs, spec.opts)
	end

	local function cd_config_dir()
		vim.cmd.cd(config_dir)
		printv("Beginning of init.lua; cd to " .. CONFIG_DIR)
	end

	local function cd_back()
		lua.cmd.cd(PWD)
		printv("Reached end of init.lua; cd back to " .. PWD)
	end

	local gh = function(id)
		return "https://github.com/" .. id
	end

	local gl = function(id)
		return "https://gitlab.com/" .. id
	end

	local cb = function(id)
		return "https://codeberg.org/" .. id
	end

	local split_id = function(id)
		local user, repo = string.match(id, "([^/]+)/([^/]+)")
		return user, repo
	end

	local printv = function(msg)
		if BE_VERBOSE then
			print(msg)
		end
	end

	local setup_lazy = function() -- not in use; kept for reference
		local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
		printv(lazypath)
		if not vim.loop.fs_stat(lazypath) then
			-- vim.fn.system({
			--     "git",
			--     "clone",
			--     "--filter=blob:none",
			--     "https://github.com/folke/lazy.nvim",
			--     lazypath,
			-- })
		end
		vim.opt.rtp:prepend(lazypath)
	end

	function move_selection_to_new_file()
		local bufnr = 0
		local s_line, e_line = vim.fn.line("'<"), vim.fn.line("'>")

		if s_line == 0 or e_line == 0 then
			vim.notify("No visual selection found", vim.log.levels.ERROR)
			return
		end

		local lines = vim.api.nvim_buf_get_lines(bufnr, s_line - 1, e_line, false)

		-- steps; prompt; delete original text via Ex (simplest & safest); open split; insert text
		local default_path = vim.fn.expand("%:p:h") .. "/"
		local target = vim.fn.input("Move selection to: ", default_path, "file")
		if target == "" then
			return
		end
		vim.cmd(string.format("%d,%dd", s_line, e_line))
		vim.cmd("vsplit " .. vim.fn.fnameescape(target))
		vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
		vim.bo.modified = true
	end
	---------------------------------------------------------------------------------------------------- PLUGIN INSTALLATION
	local PLUGIN_DECLARATION = {
		------------------- "willothy/wezterm.nvim"> just vendor
		-- ["markit"] =  { "2KAbhishek/markit.nvim", expander = gh, lazy = false },
		["bamboo"] = { id = "ribru17/bamboo.nvim", expander = gh, lazy = false },
		["blink.cmp"] = { id = "Saghen/blink.cmp", expander = gh, lazy = false },
		["conform"] = { id = "stevearc/conform.nvim", expander = gh, lazy = false },
		["dial"] = { id = "monaqa/dial.nvim", expander = gh, lazy = false },
		["diffview"] = { id = "sindrets/diffview.nvim", expander = gh, lazy = false },
		["friendly-snippets"] = { id = "rafamadriz/friendly-snippets", expander = gh, lazy = false },
		["gitsigns"] = { id = "lewis6991/gitsigns.nvim", expander = gh, lazy = false },
		["haskell-tools"] = { id = "mrcjkb/haskell-tools.nvim", expander = gh, lazy = false }, -- already lazy
		["lualine"] = { id = "nvim-lualine/lualine.nvim", expander = gh, lazy = false },
		["LuaSnip"] = { id = "L3MON4D3/LuaSnip", expander = gh, lazy = false },
		["marks"] = { id = "chentoast/marks.nvim", expander = gh, lazy = false },
		["mini"] = { id = "nvim-mini/mini.nvim", expander = gh, lazy = false },
		["neotest-haskell"] = { id = "MrcJkb/neotest-haskell", expander = gh, lazy = false }, -- TODO
		["neotest-python"] = { id = "nvim-neotest/neotest-python", expander = gh, lazy = false },
		["neotest"] = { id = "nvim-neotest/neotest", expander = gh, lazy = false },
		["nvim-bqf"] = { id = "kevinhwang91/nvim-bqf", expander = gh, lazy = false },
		["nvim-nio"] = { id = "nvim-neotest/nvim-nio", expander = gh, lazy = false },
		["nvim-treesitter-textobjects"] = {
			id = "nvim-treesitter/nvim-treesitter-textobjects",
			expander = gh,
			lazy = false,
			name = "nvim-treesitter-textobjects",
		},
		["nvim-treesitter"] = { id = "nvim-treesitter/nvim-treesitter", expander = gh, lazy = false },
		["oil"] = { id = "stevearc/oil.nvim", expander = gh, lazy = false },
		["pickme"] = { id = "2KAbhishek/pickme.nvim", expander = gh, lazy = false },
		["plenary"] = { id = "nvim-lua/plenary.nvim", expander = gh, lazy = false },
		["rustaceanvim"] = { id = "mrcjkb/rustaceanvim", expander = gh, lazy = false }, -- already lazy
		["snacks"] = { id = "folke/snacks.nvim", expander = gh, lazy = false },
		["telescope-fzf-native"] = { id = "nvim-telescope/telescope-fzf-native.nvim", expander = gh, lazy = true },
		["telescope"] = { id = "nvim-telescope/telescope.nvim", expander = gh, lazy = false }, --, deps = { "telescope-fzf-native", } },
		["todo-comments"] = { id = "folke/todo-comments.nvim", expander = gh, lazy = false },
		["toggleterm"] = { id = "akinsho/toggleterm.nvim", expander = gh, lazy = false },
		["vim-floaterm"] = { id = "voldikss/vim-floaterm", expander = gh, lazy = false },
		["vim-visual-multi"] = { id = "mg979/vim-visual-multi", expander = gh, lazy = false },
		["which-key"] = { id = "folke/which-key.nvim", expander = gh, lazy = false },
		["yazi"] = { id = "mikavilpas/yazi.nvim", expander = gh, lazy = false },
		["zen-mode"] = { id = "folke/zen-mode.nvim", expander = gh, lazy = false },
	}

	local make_specs = function(plugin_ids)
		local specs = {
			nix = {
				lazy = {},
				eager = {},
			},
			git = {
				lazy = {},
				eager = {},
			},
			mapping = {},
		}

		local get_nix_path = function(_id)
			if HAS_NIX then
				return PLUGIN_LOCATIONS[_id]
			end
		end

		for name, info in pairs(plugin_ids) do
			local nix_path = get_nix_path(id)
			local lazy = info.lazy
			-- local deps = info.deps
			-- if deps then print(vim.inspect(deps)) end
			if nix_path then
				local path = PLUGIN_LOCATIONS[info.id].path
				local nix_path_table = { path = path, deps = deps }
				if lazy then
					specs.nix.lazy[name] = nix_path_table
				else
					table.insert(specs.nix.eager, nix_path_table)
					vim.opt.rtp:prepend(path)
				end
			else
				git_src_table = { src = info.expander(info.id), deps = deps }
				if lazy then
					specs.git.lazy[name] = git_src_table
				else
					table.insert(specs.git.eager, git_src_table)
				end
			end
			specs.mapping[name] = info.id
		end
		return specs
	end

	local PLUGIN_SPECS = make_specs(PLUGIN_DECLARATION)
	printv(vim.inspect(PLUGIN_SPECS))
	printv(vim.uv.fs_stat("/nix/store") ~= nil and "/nix/store exists" or "/nix/store does not exist")

	vim.pack.add(PLUGIN_SPECS.git.eager)

	function setup_plugin(plugin_info)
		local name, setup_fn, config = plugin_info.name, plugin_info.setup_fn, plugin_info.config
		local id = PLUGIN_SPECS.mapping[name]
		local deps = PLUGIN_DECLARATION[name].deps
		if deps then
			printv(vim.inspect(deps))
		end
		if deps then
			for i, dep_name in ipairs(deps) do
				printv(dep_name)
				setup_plugin({ name = dep_name })
			end
		end
		if HAS_NIX then
			local path = PLUGIN_LOCATIONS[id].path
			vim.opt.rtp:prepend(path)
		else
			info = PLUGIN_SPECS.git.lazy[name]
			if info then
				printv(vim.inspect(info))
				vim.pack.add({ info.src })
			end
		end
		if setup_fn and config then
			error("Table 'plugin_info' should contain at most one of 'setup_fn' and 'config', not both.")
		end
		if setup_fn then
			setup_fn()
		else
			require(name).setup(config or {})
		end
	end

	function make_setup_function(plugin_info)
		local setup_function = function()
			setup_plugin(plugin_info)
		end
		return setup_function
	end
	----------------------------------------------------------------------------------------------- OLD FROM PREVIOUS CONFIG
	vim.opt.runtimepath:prepend(CONFIG_DIR)
	package.path = CONFIG_DIR .. "/lua/?.lua;" .. CONFIG_DIR .. "/lua/?/init.lua;" .. package.path
	vim.api.nvim_set_hl(0, "Normal", { bg = "#020802" })
	-- vim.diagnostic.config({ virtual_text = false, virtual_lines = { current_line = true } })
	vim.cmd("hi link Floaterm Normal")
	vim.cmd("hi link FloatermBorder Normal")
	-------------------------------------------------------------------------------------------------------------------- LSP

	------------------------------------------------------------------------------------------------------- COMMANDS (empty)
	----------------------------------------------------------------------------------------------------------------- COLORS

	---------------------------------------------------------------------------------------------------- END VERBATIM COPIED
	setup_plugin({
		name = "bamboo",
		setup_fn = function()
			require("bamboo").setup({
				style = "multiplex",
				colors = {
					bg0 = "#020802",
				},
				-- highlights = { Normal = { bg = "#020802" } },
			})
			require("bamboo").load()
			-- require("vague").setup({ transparent = true })
			vim.cmd("colorscheme bamboo")
			vim.cmd(":hi statusline guibg=#081608")
		end,
	})

	-- require("lazydev").setup({})
	setup_plugin({
		name = "mini",
		setup_fn = function()
			require("mini.pick").setup()
		end,
	})
	setup_plugin({
		name = "oil",
		config = {},
	})
	-- require('nvim-treesitter')
	-- require('nvim-treesitter.install').prefer_git = true
	setup_plugin({
		name = "nvim-treesitter",
		setup_fn = function()
			require("nvim-treesitter").setup({
				-- directory to install parsers and queries to (prepended to `runtimepath` to have priority)
				install_dir = (not HAS_NIX) and vim.fn.stdpath("data") .. "/site" or nil,
				parser_install_dir = (not HAS_NIX) and vim.fn.stdpath("data") .. "/parsers" or nil,
				ensure_installed = HAS_NIX and {} or TS_LANGUAGES,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	})

	-- wait max. 5 minutes
	-- require('nvim-treesitter').install({ "typescript", "javascript", "python", "rust", "haskell", "zig" }):wait(300000)
	-- require('nvim-treesitter.configs').setup({
	--     ensure_installed = { "typescript", "javascript", "python", "rust", "haskell" },
	--     highlight = {
	--         enable = true,
	--         -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
	--         -- Set to `false` if you want only tree-sitter.
	--         additional_vim_regex_highlighting = false,
	--     },
	-- })

	setup_plugin({ ----------------------------------------------------------------------------------------------- blink.cmp
		name = "blink.cmp",
		setup_fn = function()
			require("blink.cmp").setup({
				-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
				-- 'super-tab' for mappings similar to vscode (tab to accept)
				-- 'enter' for enter to accept
				-- 'none' for no mappings
				--
				-- All presets have the following mappings:
				-- C-space: Open menu or open docs if already open
				-- C-n/C-p or Up/Down: Select next/previous item
				-- C-e: Hide menu
				-- C-k: Toggle signature help (if signature.enabled = true)
				--
				-- See :h blink-cmp-config-keymap for defining your own keymap
				keymap = { preset = "default" },

				appearance = {
					-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
					-- Adjusts spacing to ensure icons are aligned
					nerd_font_variant = "mono",
				},

				-- (Default) Only show the documentation popup when manually triggered
				completion = { documentation = { auto_show = false } },

				-- Default list of enabled providers defined so that you can extend it
				-- elsewhere in your config, without redefining it, due to `opts_extend`
				sources = {
					default = { "lsp", "path", "snippets", "buffer" },
				},

				-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
				-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
				-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
				--
				-- See the fuzzy documentation for more information
				fuzzy = { implementation = "lua" }, -- TODO: fix to use Rust
			})
		end,
	})
	setup_plugin({ ------------------------------------------------------------------------------------------- zen-mode.nvim
		name = "zen-mode",
		config = {
			wezterm = {
				enabled = false,
				-- can be either an absolute font size or the number of incremental steps
				font = "+4", -- (10% increase per step)
			},
		},
	})
	setup_plugin({ ------------------------------------------------------------------------------------------------- lualine
		name = "lualine",
	})
	setup_plugin({ ----------------------------------------------------------------------------------------------- dial.nvim
		name = "dial",
		setup_fn = function()
			local augend = require("dial.augend")
			require("dial.config").augends:register_group({
				default = {
					augend.integer.alias.decimal,
					augend.integer.alias.hex,
					augend.date.alias["%Y/%m/%d"],
					augend.constant.alias.bool,
				},
			})
		end,
	})

	printv("CHECKPOINT AA")
	-------------------------------------------------------------------------------------------------------- yazi.nvim: TODO
	local load_yazi = make_setup_function({
		name = "yazi",
		config = {
			open_for_directories = true,
			keymaps = { show_help = "<f1>" },
		},
	})

	-- mark netrw as loaded so it's not loaded at all.
	-- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
	vim.g.loaded_netrwPlugin = 1

	printv("CHECKPOINT AB")
	-------------------------------------------------------------------------------------------------------- toggleterm.nvim
	setup_plugin({
		name = "toggleterm",
		config = {
			open_mapping = [[<c-\>]],
			direction = "float",
			-- this is the key to inheriting your colorscheme's background
			highlights = {
				Normal = {
					link = "Normal",
				},
				NormalFloat = {
					link = "NormalFloat",
				},
			},
		},
	})
	----------------------------------------------------------------------------------------------------------- vim-floaterm
	vim.g.floaterm_width = 0.8
	vim.g.floaterm_height = 0.8
	---------------------------------------------------------------------------------------------------------- zen-mode.nvim
	setup_plugin({
		name = "zen-mode",
		setup_fn = function() end,
	})
	map({
		mode = "n",
		sequence = "<leader>zm",
		action = function()
			require("zen-mode").toggle({
				window = {
					width = 0.85, -- width will be 85% of the editor width
				},
			})
		end,
		opts = { desc = "Toggle zen mode." },
	})
	setup_plugin({ name = "which-key" }) ------------------------------------------------------------------------- which-key
	setup_plugin({ name = "LuaSnip" }) ----------------------------------------------------------------------------- LuaSnip
	-- dependencies = { "rafamadriz/friendly-snippets" }, -- Optional: for pre-made snippets
	-- build = "make install_jsregexp", -- For regex snippets
	-- event = "InsertEnter",
	--------------------------------------------------------------------------------------------------------- nvim-cmp (old)
	-- dependencies = {
	--     "hrsh7th/cmp-nvim-lsp",
	--     "hrsh7th/cmp-buffer",
	--     "hrsh7th/cmp-path",
	--     "saadparwaiz1/cmp_luasnip",
	-- }
	--[[
    local old_setup_nvim_cmp = function()
	vim.lsp.config("*", { capabilities = require("cmp_nvim_lsp").default_capabilities() })
	vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
	local cmp = require("cmp")
	local defaults = require("cmp.config.default")()
	local auto_select = true
	return {
		snippet = {
			-- REQUIRED for luasnip
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		auto_brackets = {},
		completion = {
			completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
		},
		preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
		mapping = cmp.mapping.preset.insert({
			["<C-b>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
			["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
			["<C-Space>"] = cmp.mapping.complete(),
			["<C-e>"] = cmp.mapping.abort(),
			["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept selected suggestion
			--   ["<CR>"] = LazyVim.cmp.confirm({ select = auto_select }),
			--   ["<C-y>"] = LazyVim.cmp.confirm({ select = true }),
			--   ["<S-CR>"] = LazyVim.cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace })
			-- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			["<C-CR>"] = function(fallback)
				cmp.abort()
				fallback()
			end,

			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				else
					fallback()
				end
			end, { "i", "s" }),

			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { "i", "s" }),
			--   ["<tab>"] = function(fallback)
			--     return LazyVim.cmp.map({ "snippet_forward", "ai_nes", "ai_accept" }, fallback)()
			--   end,
		}),
		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			{ name = "luasnip" },
		}, {
			{ name = "buffer" },
			{ name = "path" },
		}),
		formatting = {
			format = function(entry, item)
				-- local icons = LazyVim.config.icons.kinds
				-- if icons[item.kind] then
				--   item.kind = icons[item.kind] .. item.kind
				-- end

				local widths = {
					abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
					menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
				}

				for key, width in pairs(widths) do
					if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
						item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. "…"
					end
				end

				return item
			end,
		},
		experimental = {
			-- only show ghost text when we show ai completions
			ghost_text = vim.g.ai_cmp and {
				hl_group = "CmpGhostText",
			} or false,
		},
		sorting = defaults.sorting,
	}
	end
	]]

	printv("CHECKPOINT AC")
	setup_plugin({ ----------------------------------------------------------------------------------------------- mini.nvim
		name = "mini",
		setup_fn = function()
			require("mini.pick").setup()
			require("mini.surround").setup()
			require("mini.pairs").setup()
			require("mini.comment").setup()
			require("mini.indentscope").setup()
			-- require("mini.hipatterns").setup()
			-- require("mini.marks").setup()
			-- require("mini.fold").setup()
			-- require("mini.terminal").setup()
		end,
	})

	printv("CHECKPOINT B")
	--------------------------------------------------------------------------------------------------------------- nvim-bqf
	-- TODO should lazy load on opening the quickfix window -> ft = "qf"
	setup_plugin({ name = "gitsigns" }) ---------------------------------------------------------------------- gitsigns.nvim
	-- event = { "BufReadPre", "BufNewFile" }
	setup_plugin({ name = "todo-comments" }) ------------------------------------------------------------ t*d*-comments.nvim

	setup_plugin({ ------------------------------------------------------------------------------------ telescope.nvim: TODO
		name = "telescope",
		setup_fn = function()
			-- local fzf_info = PLUGIN_SPECS.git.lazy["telescope-fzf-native"]
			-- if info then
			-- 	print(vim.inspect(info))
			-- 	vim.pack.add({ info.src })
			-- end

			local telescope = require("telescope")
			telescope.setup({
				defaults = {
					file_ignore_patterns = { "%.git/", "node_modules/", "%.venv/" },
				},
			})
			-- telescope.load_extension("fzf") -- TODO: not working with vim.pack.add; need to add custom build logic: https://github.com/nvim-telescope/telescope-fzf-native.nvim
		end,
	})
	-- cmd = "Telescope" -- lazy load on command Telescope
	-- dependencies = {
	--     "nvim-lua/plenary.nvim",
	--     {
	--         "nvim-telescope/telescope-fzf-native.nvim",
	--         build = "make",
	--     },
	-- }
	setup_plugin({ name = "diffview" }) ---------------------------------------------------------------------- diffview.nvim
	-- cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" }
	------------------------------------------------------------------------------------------------------------ markit.nvim
	-- setup_plugin({ name = "markit" })
	setup_plugin({ name = "marks" }) ---------------------------------------------------------------------------- marks.nvim
	setup_plugin({ ------------------------------------------------------------------------------------------------- neotest
		name = "neotest",
		config = {
			-- dependencies = {
			--     "nvim-lua/plenary.nvim",
			--     "nvim-treesitter/nvim-treesitter",
			--     "antoinemadec/FixCursorHold.nvim",
			--     "nvim-neotest/nvim-nio",
			--     "nvim-neotest/neotest-python",
			-- }
			adapters = {
				require("neotest-python")({
					-- Extra arguments for nvim-dap configuration
					-- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
					dap = { justMyCode = false },
					-- Command line arguments for runner
					-- Can also be a function to return dynamic values
					args = { "--log-level", "DEBUG" },
					-- Runner to use. Will use pytest if available by default.
					-- Can be a function to return dynamic value.
					runner = "pytest",
					-- Custom python path for the runner.
					-- Can be a string or a list of strings.
					-- Can also be a function to return dynamic value.
					-- If not provided, the path will be inferred by checking for
					-- virtual envs in the local directory and for Pipenev/Poetry configs
					python = ".venv/bin/python",
					-- Returns if a given file path is a test file.
					-- NB: This function is called a lot so don't perform any heavy tasks within it.
					-- is_test_file = function(file_path)
					-- end,
					-- !!EXPERIMENTAL!! Enable shelling out to `pytest` to discover test
					-- instances for files containing a parametrize mark (default: false)
					pytest_discover_instances = true,
				}),
			},
		},
	})
	setup_plugin({ -------------------------------------------------------------------------------------------------- pickme
		name = "pickme",
		config = {
			picker_provider = "snacks",
		},
	})
	setup_plugin({ ----------------------------------------------------------------------------- nvim-treesitter-textobjects
		name = "nvim-treesitter-textobjects",
		config = {
			select = {
				-- Automatically jump forward to textobj, similar to targets.vim
				lookahead = true,
				-- You can choose the select mode (default is charwise 'v')
				--
				-- Can also be a function which gets passed a table with the keys
				-- * query_string: eg '@function.inner'
				-- * method: eg 'v' or 'o'
				-- and should return the mode ('v', 'V', or '<c-v>') or a table
				-- mapping query_strings to modes.
				selection_modes = {
					["@parameter.outer"] = "v", -- charwise
					["@function.outer"] = "V", -- linewise
					-- ['@class.outer'] = '<c-v>', -- blockwise
				},
				-- If you set this to `true` (default is `false`) then any textobject is
				-- extended to include preceding or succeeding whitespace. Succeeding
				-- whitespace has priority in order to act similarly to eg the built-in
				-- `ap`.
				--
				-- Can also be a function which gets passed a table with the keys
				-- * query_string: eg '@function.inner'
				-- * selection_mode: eg 'v'
				-- and should return true of false
				include_surrounding_whitespace = false,
			},
		},
	})

	printv("CHECKPOINT C")
	------------------------------------------------------------------------------------------------------- vim-visual-multi
	vim.g.VM_default_mappings = true

	require("blink.cmp").setup({ ------------------------------------------------------------------------------------- blink
		fuzzy = { implementation = "lua" }, -- TODO: change to Rust
		keymap = {
			-- 'default' for vim-like (C-y to accept)
			-- 'super-tab' for vscode-like (Tab to accept/jump)
			-- 'enter' for enter to accept
			preset = "super-tab",

			["<C-k>"] = { "select_prev", "fallback" },
			["<C-j>"] = { "select_next", "fallback" },

			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-e>"] = { "hide", "fallback" },
			["<CR>"] = { "accept", "fallback" },

			["<Tab>"] = { "snippet_forward", "fallback" },
			["<S-Tab>"] = { "snippet_backward", "fallback" },

			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },
		},
	})
end

if lazy_configs then
	M = {
		{
			"saghen/blink.cmp",
			-- optional: provides snippets for the snippet source
			dependencies = { "rafamadriz/friendly-snippets" },

			-- use a release tag to download pre-built binaries
			version = "1.*",
			-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
			-- build = 'cargo build --release',
			-- If you use nix, you can build from source using latest nightly rust with:
			-- build = 'nix run .#build-plugin',

			---@module 'blink.cmp'
			---@type blink.cmp.Config
			opts = {
				-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
				-- 'super-tab' for mappings similar to vscode (tab to accept)
				-- 'enter' for enter to accept
				-- 'none' for no mappings
				--
				-- All presets have the following mappings:
				-- C-space: Open menu or open docs if already open
				-- C-n/C-p or Up/Down: Select next/previous item
				-- C-e: Hide menu
				-- C-k: Toggle signature help (if signature.enabled = true)
				--
				-- See :h blink-cmp-config-keymap for defining your own keymap
				keymap = { preset = "default" },

				appearance = {
					-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
					-- Adjusts spacing to ensure icons are aligned
					nerd_font_variant = "mono",
				},

				-- (Default) Only show the documentation popup when manually triggered
				completion = { documentation = { auto_show = false } },

				-- Default list of enabled providers defined so that you can extend it
				-- elsewhere in your config, without redefining it, due to `opts_extend`
				sources = {
					default = { "lsp", "path", "snippets", "buffer" },
				},

				-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
				-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
				-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
				--
				-- See the fuzzy documentation for more information
				fuzzy = { implementation = "prefer_rust_with_warning" },
			},
			opts_extend = { "sources.default" },
		},

		{
			"folke/zen-mode.nvim",
			opts = {
				wezterm = {
					enabled = false,
					-- can be either an absolute font size or the number of incremental steps
					font = "+4", -- (10% increase per step)
				},
			},
		},
		{
			"nvim-lualine/lualine.nvim",
			lazy = false,

			config = function()
				require("lualine").setup()
			end,
		},
		{
			"monaqa/dial.nvim",
			lazy = true,
			config = function()
				local augend = require("dial.augend")
				require("dial.config").augends:register_group({
					default = {
						augend.integer.alias.decimal,
						augend.integer.alias.hex,
						augend.date.alias["%Y/%m/%d"],
						augend.constant.alias.Bool,
						augend.constant.alias.bool,
					},
				})
			end,
		},

		{
			"ribru17/bamboo.nvim",
			lazy = false,
			priority = 1000,
			config = function()
				require("bamboo").setup({
					style = "multiplex",
					colors = {
						bg0 = "#020802",
					},
					-- highlights = { Normal = { bg = "#020802" } },
				})
				require("bamboo").load()
			end,
		},
		{
			"nvim-treesitter/nvim-treesitter",
			build = ":TSUpdate",
			config = function()
				require("nvim-treesitter.configs").setup({
					ensure_installed = {
						"python",
						"lua",
						"javascript",
						"typescript",
						"nix",
						"json",
						"yaml",
						"toml",
						"markdown",
					},
					highlight = { enable = true },
					indent = { enable = true },
				})
			end,
		},
		{
			"stevearc/conform.nvim",
			opts = {
				formatters_by_ft = {
					python = {
						-- To fix auto-fixable lint errors.
						"ruff_fix",
						-- To run the Ruff formatter.
						"ruff_format",
						-- To organize the imports.
						"ruff_organize_imports",
					},
					lua = {
						"stylua",
					},
				},
			},
			config = function(_, opts)
				require("conform").setup(opts)

				-- Optional: format on save
				vim.api.nvim_create_autocmd("BufWritePre", {
					callback = function(args)
						require("conform").format({ bufnr = args.buf })
					end,
				})
			end,
		},
		-- {
		-- 	"nvim-tree/nvim-tree.lua",
		-- 	dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional icons
		-- 	config = function()
		-- 		require("nvim-tree").setup({})
		-- 	end,
		-- },
		-- {
		{
			"mikavilpas/yazi.nvim",
			version = "*", -- use the latest stable version
			event = "VeryLazy",
			dependencies = {
				{ "nvim-lua/plenary.nvim", lazy = true },
			},
			keys = {
				{
					"<leader>-",
					mode = { "n", "v" },
					"<cmd>Yazi<cr>",
					desc = "Open yazi at the current file",
				},
				{
					-- Open in the current working directory
					"<leader>cw",
					"<cmd>Yazi cwd<cr>",
					desc = "Open the file manager in nvim's working directory",
				},
				{
					"<c-up>",
					"<cmd>Yazi toggle<cr>",
					desc = "Resume the last yazi session",
				},
			},
			---@type YaziConfig | {}
			opts = {
				-- if you want to open yazi instead of netrw, see below for more info
				open_for_directories = true,
				keymaps = {
					show_help = "<f1>",
				},
			},
			init = function()
				-- mark netrw as loaded so it's not loaded at all.
				-- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
				vim.g.loaded_netrwPlugin = 1
			end,
		},
		{
			"willothy/wezterm.nvim",
			config = true,
		},
		{
			"akinsho/toggleterm.nvim",
			version = "*",
			opts = {
				-- Your other toggleterm options here...
				open_mapping = [[<c-\>]],
				direction = "float",
				-- This is the key to inheriting your colorscheme's background
				highlights = {
					Normal = {
						link = "Normal",
					},
					NormalFloat = {
						link = "NormalFloat",
					},
				},
			},
			config = function()
				require("toggleterm").setup()
			end,
		},
		{
			"voldikss/vim-floaterm",
			config = function()
				-- Optional: Set global configurations for floaterm if needed
				vim.g.floaterm_width = 0.8
				vim.g.floaterm_height = 0.8

				-- This is the crucial part for color integration
			end,
		},
		{
			"folke/which-key.nvim",
			event = "VeryLazy",
			init = function()
				vim.o.timeout = true
				vim.o.timeoutlen = 300
			end,
			opts = {
				-- your configuration comes here
				-- or leave it empty to use the default settings
			},
		},
		-- {
		-- 	"hrsh7th/nvim-cmp",
		-- 	version = false, -- last release is way too old
		-- 	event = "InsertEnter",
		-- 	dependencies = {
		-- 	  "hrsh7th/cmp-nvim-lsp",
		-- 	  "hrsh7th/cmp-buffer",
		-- 	  "hrsh7th/cmp-path",
		-- 	},
		-- 	-- Not all LSP servers add brackets when completing a function.
		-- 	-- To better deal with this, LazyVim adds a custom option to cmp,
		-- 	-- that you can configure. For example:
		-- 	--
		-- 	-- ```lua
		-- 	-- opts = {
		-- 	--   auto_brackets = { "python" }
		-- 	-- }
		-- 	-- ```
		-- 	opts = function()
		-- 	  -- Register nvim-cmp lsp capabilities
		-- 	  vim.lsp.config("*", { capabilities = require("cmp_nvim_lsp").default_capabilities() })

		-- 	  vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
		-- 	  local cmp = require("cmp")
		-- 	  local defaults = require("cmp.config.default")()
		-- 	  local auto_select = true
		-- 	  return {
		-- 		auto_brackets = {}, -- configure any filetype to auto add brackets
		-- 		completion = {
		-- 		  completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
		-- 		},
		-- 		preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
		-- 		mapping = cmp.mapping.preset.insert({
		-- 		  ["<C-b>"] = cmp.mapping.scroll_docs(-4),
		-- 		  ["<C-f>"] = cmp.mapping.scroll_docs(4),
		-- 		  ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
		-- 		  ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
		-- 		  ["<C-Space>"] = cmp.mapping.complete(),
		-- 		  ["<CR>"] = LazyVim.cmp.confirm({ select = auto_select }),
		-- 		  ["<C-y>"] = LazyVim.cmp.confirm({ select = true }),
		-- 		  ["<S-CR>"] = LazyVim.cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		-- 		  ["<C-CR>"] = function(fallback)
		-- 			cmp.abort()
		-- 			fallback()
		-- 		  end,
		-- 		  ["<tab>"] = function(fallback)
		-- 			return LazyVim.cmp.map({ "snippet_forward", "ai_nes", "ai_accept" }, fallback)()
		-- 		  end,
		-- 		}),
		-- 		sources = cmp.config.sources({
		-- 		  { name = "lazydev" },
		-- 		  { name = "nvim_lsp" },
		-- 		  { name = "path" },
		-- 		}, {
		-- 		  { name = "buffer" },
		-- 		}),
		-- 		formatting = {
		-- 		  format = function(entry, item)
		-- 			local icons = LazyVim.config.icons.kinds
		-- 			if icons[item.kind] then
		-- 			  item.kind = icons[item.kind] .. item.kind
		-- 			end

		-- 			local widths = {
		-- 			  abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
		-- 			  menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
		-- 			}

		-- 			for key, width in pairs(widths) do
		-- 			  if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
		-- 				item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. "…"
		-- 			  end
		-- 			end

		-- 			return item
		-- 		  end,
		-- 		},
		-- 		experimental = {
		-- 		  -- only show ghost text when we show ai completions
		-- 		  ghost_text = vim.g.ai_cmp and {
		-- 			hl_group = "CmpGhostText",
		-- 		  } or false,
		-- 		},
		-- 		sorting = defaults.sorting,
		-- 	  }
		-- 	end,
		-- 	main = "lazyvim.util.cmp",
		--   },
		{
			"L3MON4D3/LuaSnip",
			dependencies = { "rafamadriz/friendly-snippets" }, -- Optional: for pre-made snippets
			build = "make install_jsregexp", -- For regex snippets
			event = "InsertEnter",
		},
		{
			"hrsh7th/nvim-cmp",
			event = "InsertEnter",
			dependencies = {
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"saadparwaiz1/cmp_luasnip",
			},
			config = function()
				vim.lsp.config("*", { capabilities = require("cmp_nvim_lsp").default_capabilities() })
				vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
				local cmp = require("cmp")
				local defaults = require("cmp.config.default")()
				local auto_select = true
				return {
					snippet = {
						-- REQUIRED for luasnip
						expand = function(args)
							luasnip.lsp_expand(args.body)
						end,
					},
					auto_brackets = {},
					completion = {
						completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
					},
					preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
					mapping = cmp.mapping.preset.insert({
						["<C-b>"] = cmp.mapping.scroll_docs(-4),
						["<C-f>"] = cmp.mapping.scroll_docs(4),
						["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
						["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
						["<C-Space>"] = cmp.mapping.complete(),
						["<C-e>"] = cmp.mapping.abort(),
						["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept selected suggestion
						--   ["<CR>"] = LazyVim.cmp.confirm({ select = auto_select }),
						--   ["<C-y>"] = LazyVim.cmp.confirm({ select = true }),
						--   ["<S-CR>"] = LazyVim.cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
						["<C-CR>"] = function(fallback)
							cmp.abort()
							fallback()
						end,

						["<Tab>"] = cmp.mapping(function(fallback)
							if cmp.visible() then
								cmp.select_next_item()
							elseif luasnip.expand_or_jumpable() then
								luasnip.expand_or_jump()
							else
								fallback()
							end
						end, { "i", "s" }),

						["<S-Tab>"] = cmp.mapping(function(fallback)
							if cmp.visible() then
								cmp.select_prev_item()
							elseif luasnip.jumpable(-1) then
								luasnip.jump(-1)
							else
								fallback()
							end
						end, { "i", "s" }),
						--   ["<tab>"] = function(fallback)
						-- 	return LazyVim.cmp.map({ "snippet_forward", "ai_nes", "ai_accept" }, fallback)()
						--   end,
					}),
					sources = cmp.config.sources({
						{ name = "nvim_lsp" },
						{ name = "luasnip" },
					}, {
						{ name = "buffer" },
						{ name = "path" },
					}),
					formatting = {
						format = function(entry, item)
							-- local icons = LazyVim.config.icons.kinds
							-- if icons[item.kind] then
							--   item.kind = icons[item.kind] .. item.kind
							-- end

							local widths = {
								abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
								menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
							}

							for key, width in pairs(widths) do
								if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
									item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. "…"
								end
							end

							return item
						end,
					},
					experimental = {
						-- only show ghost text when we show ai completions
						ghost_text = vim.g.ai_cmp and {
							hl_group = "CmpGhostText",
						} or false,
					},
					sorting = defaults.sorting,
				}
			end,
		},
		{
			"kevinhwang91/nvim-bqf",
			ft = "qf", -- Lazy load on opening the quickfix window
		},
		{
			"echasnovski/mini.nvim",
			version = "*", -- or pin to a specific release
			event = "VeryLazy",
			config = function()
				-- We just setup the modules we want to use
				require("mini.pairs").setup()
				require("mini.icons").setup()
				require("mini.surround").setup()
				require("mini.comment").setup({
					-- No options needed for basic setup
				})
				require("mini.hipatterns").setup()
				require("mini.indentscope").setup()
				-- require("mini.marks").setup()
				-- require("mini.fold").setup()
				-- require("mini.terminal").setup()
			end,
		},

		{
			"lewis6991/gitsigns.nvim",
			event = { "BufReadPre", "BufNewFile" }, -- Load on file read or new file
			config = function()
				require("gitsigns").setup({
					-- You can add configuration here later
				})
			end,
		},

		{
			"folke/todo-comments.nvim",
			event = { "BufReadPre", "BufNewFile" }, -- Load on file read
			dependencies = { "nvim-lua/plenary.nvim" },
			config = function()
				require("todo-comments").setup({
					-- No options needed for basic setup
				})
			end,
		},
		{
			"nvim-telescope/telescope.nvim",
			cmd = "Telescope", -- Lazy load on command
			dependencies = {
				"nvim-lua/plenary.nvim",
				{
					"nvim-telescope/telescope-fzf-native.nvim",
					-- This will build the C extension for faster sorting
					build = "make",
				},
			},
			config = function()
				local telescope = require("telescope")
				telescope.setup({
					defaults = {
						-- We'll keep this simple for now
						file_ignore_patterns = { "%.git/", "node_modules/", "%.venv/" },
					},
				})
				-- This is crucial to load the fzf-native extension
				telescope.load_extension("fzf")
			end,
		},
		{
			"sindrets/diffview.nvim",
			cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
			dependencies = { "nvim-lua/plenary.nvim" },
			config = function()
				require("diffview").setup({})
			end,
		},
		--   {
		-- 	"chentoast/marks.nvim",
		-- 	event = "VeryLazy",
		-- 	opts = {},
		--   },
		{
			"2kabhishek/markit.nvim",
			dependencies = { "2kabhishek/pickme.nvim" },
			config = {}, -- load_config('tools.marks'),
			event = { "BufReadPre", "BufNewFile" },
		},
		{
			"2KAbhishek/pickme.nvim",
			cmd = "PickMe",
			event = "VeryLazy",
			dependencies = {
				-- Include at least one of these pickers:
				"folke/snacks.nvim", -- For snacks.picker
				-- 'nvim-telescope/telescope.nvim', -- For telescope
				-- 'ibhagwan/fzf-lua', -- For fzf-lua
			},
			opts = {
				picker_provider = "snacks", -- Default provider
			},
		},
		-- {
		-- 	'stevearc/oil.nvim',
		-- 	---@module 'oil'
		-- 	---@type oil.SetupOpts
		-- 	opts = {},
		-- 	-- Optional dependencies
		-- 	dependencies = { { "nvim-mini/mini.icons", opts = {} } },
		-- 	-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
		-- 	-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
		-- 	lazy = false,
		--   },
		{
			"nvim-treesitter/nvim-treesitter-textobjects",
			lazy = true,
			dependencies = { "nvim-treesitter/nvim-treesitter" },
		},
		-- TODO: https://tamerlan.dev/setting-up-a-testing-environment-in-neovim/
		{
			"nvim-neotest/neotest",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"nvim-treesitter/nvim-treesitter",
				"antoinemadec/FixCursorHold.nvim",
				"nvim-neotest/nvim-nio",

				"nvim-neotest/neotest-python",
			},
			config = function()
				require("neotest").setup({
					adapters = {
						require("neotest-python")({
							-- Extra arguments for nvim-dap configuration
							-- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
							dap = { justMyCode = false },
							-- Command line arguments for runner
							-- Can also be a function to return dynamic values
							args = { "--log-level", "DEBUG" },
							-- Runner to use. Will use pytest if available by default.
							-- Can be a function to return dynamic value.
							runner = "pytest",
							-- Custom python path for the runner.
							-- Can be a string or a list of strings.
							-- Can also be a function to return dynamic value.
							-- If not provided, the path will be inferred by checking for
							-- virtual envs in the local directory and for Pipenev/Poetry configs
							python = ".venv/bin/python",
							-- Returns if a given file path is a test file.
							-- NB: This function is called a lot so don't perform any heavy tasks within it.
							-- is_test_file = function(file_path)
							-- end,
							-- !!EXPERIMENTAL!! Enable shelling out to `pytest` to discover test
							-- instances for files containing a parametrize mark (default: false)
							pytest_discover_instances = true,
						}),
					},
				})
			end,
		},
		{
			"zbirenbaum/copilot.lua",
			cmd = "Copilot",
			event = "InsertEnter",
			config = function()
				require("copilot").setup({
					suggestion = { enabled = true },
					panel = { enabled = true },
				})
			end,
		},
		{
			"mg979/vim-visual-multi",
			branch = "master",
			init = function()
				vim.g.VM_default_mappings = true
			end,
		},
	}
	return M
end

local helpers = require("helpers")
local wez = require("wezterm-interaction")
local selection = require("selection")

local map = vim.keymap.set

local M = {}

M.opts = {
	create_keymaps = true,
	prefix_send = "<leader>w",
	prefix_run = "<leader>r",
}

-- ─── public API ───────────────────────────────────────────────────────────────

---@class WeztermIntegrationOpts
---@field direction?   "Left"|"Right"|"Up"|"Down"|"Next"|"Prev"
---@field match?       string   Pattern matched against pane title / cwd
---@field pane_id?     string   Explicit pane id (overrides everything else)
---@field pick?        boolean  Show interactive picker (async)
---@field add_newline? boolean  Ensure trailing newline (default true)

--- Resolve a target pane_id from opts (sync paths only; pick is handled separately).
---@param opts WeztermSendOpts
---@return string|nil pane_id, string|nil err
function M.resolve_pane(opts)
	if opts.pane_id then
		return opts.pane_id, nil
	end

	if opts.direction then
		local id = wez.pane_by_direction(opts.direction)
		if not id then
			return nil, ("No pane found in direction '%s'"):format(opts.direction)
		end
		return id, nil
	end

	if opts.match then
		local id = wez.pane_by_match(opts.match)
		if not id then
			return nil, ("No pane matched '%s'"):format(opts.match)
		end
		return id, nil
	end

	return nil, "No targeting strategy given (use direction, match, pane_id, or pick)"
end

--- Send arbitrary text to a WezTerm pane.
---@param text string
---@param opts WeztermSendOpts
function M.send_text(text, opts)
	opts = opts or {}

	if opts.pick then
		wez.pick_pane(function(pane_id)
			if pane_id then
				local ok, err = wez.send_to_pane(pane_id, text)
				if not ok then
					vim.notify("wezterm_send: " .. (err or "unknown error"), vim.log.levels.ERROR)
				else
					vim.notify(("wezterm_send: sent to pane %s"):format(pane_id), vim.log.levels.INFO)
				end
			end
		end)
		return
	end

	local pane_id, err = resolve_pane(opts)
	if not pane_id then
		vim.notify("wezterm_send: " .. (err or "unknown error"), vim.log.levels.WARN)
		return
	end

	local ok, send_err = wez.send_to_pane(pane_id, text)
	if not ok then
		vim.notify("wezterm_send: " .. (send_err or "unknown error"), vim.log.levels.ERROR)
	else
		vim.notify(("wezterm_send: sent to pane %s"):format(pane_id), vim.log.levels.INFO)
	end
end

--- Send the current/last visual selection to a WezTerm pane.
---@param opts WeztermSendOpts
function M.send_selection(opts)
	opts = opts or {}
	-- Capture selection *before* any async operations (picker opens a UI)
	local text = selection.get_visual_selection()

	if text == "" then
		vim.notify("wezterm_send: empty selection", vim.log.levels.WARN)
		return
	end

	M.send_text(text, opts)
end

---@param key string
---@param opts WeztermIntegrationOpts
local function vmap_send(key, opts)
	local lhs = opts.prefix_send .. key
	local direction = opts.directions[key]
	local direction_lower = string.lower(direction)
	local rhs = function()
		print("Sending selection " .. direction_lower .. ".")
		M.send_selection({ direction = direction })
	end
	local desc = "Send selection: WezTerm pane (" .. direction_lower .. ")"
	map("v", lhs, rhs, { desc = desc }) --, silent = true })
end

---@param key string
---@param opts WeztermIntegrationOpts
local function nmap_send(key, opts)
	local lhs = opts.prefix_send .. key
	local direction = opts.directions[key]
	local direction_lower = string.lower(direction)
	local text = selection.get_current_block()
	local rhs = function()
		print("Sending current block " .. direction_lower .. ".")
		M.send_text(text, { direction = direction })
	end
	local desc = "Send current block: WezTerm pane (" .. direction_lower .. ")"
	map("n", lhs, rhs, { desc = desc }) --, silent = true })
end

---@param key string
---@param opts WeztermIntegrationOpts
local function map_run(key, opts)
	local lhs = opts.prefix_send .. key
	local direction = opts.directions[key]
	local direction_lower = string.lower(direction)
	local rhs = function()
		print("Sending selection " .. direction_lower .. ".")
		M.send_selection({ direction = direction })
	end
	local desc = "Running current file: WezTerm pane (" .. direction_lower .. ")"
	map({ "n", "v" }, lhs, rhs, { desc = desc }) --, silent = true })
end

---@param opts? WeztermIntegrationOpts
local function make_current_file_command(opts)
	opts = opts or {}
	local file_path = vim.api.nvim_buf_get_name(0)
	local file_type = vim.bo.filetype

	local runners = {
		python = { prefix = "python3", suffix = "" },
		lua = { prefix = "lua", suffix = "" },
		javascript = { prefix = "node", suffix = "" },
		typescript = { prefix = "npx ts-node", suffix = "" },
		rust = { prefix = "cargo run --manifest-path", suffix = "" },
		haskell = { prefix = "runghc", suffix = "" },
		sh = { prefix = "bash", suffix = "" },
		ruby = { prefix = "ruby", suffix = "" },
	}

	local runner = runners[file_type]
	if not runner then
		vim.notify("wezterm_send: no runner configured for filetype: " .. file_type, vim.log.levels.WARN)
		return nil
	end

	local parts = { runner.prefix, file_path }
	if runner.suffix ~= "" then
		table.insert(parts, runner.suffix)
	end
	return table.concat(parts, " ")
end

function M.run_current_file(opts)
	opts = opts or {}
	local command = M.make_current_file_command(opts)
	if not command then
		return
	end

	-- Prefer a pane that looks like a shell (title matches sh/bash/zsh/fish)
	local shell_pane = wez.pane_by_match(opts.match or "bash")
		or wez.pane_by_match("zsh")
		or wez.pane_by_match("fish")
		or wez.pane_by_match("sh")

	if shell_pane then
		local ok, err = wez.send_to_pane(shell_pane, command)
		if not ok then
			vim.notify("wezterm_send: " .. (err or "unknown error"), vim.log.levels.ERROR)
		end
	else
		-- No shell pane found: spawn one to the right, then send
		local spawn_out, code = helpers.run({ "wezterm", "cli", "split-pane", "--right", "--percent", "40" })
		if code ~= 0 then
			vim.notify("wezterm_send: could not open a new pane", vim.log.levels.ERROR)
			return
		end
		local new_pane_id = vim.trim(spawn_out)
		-- Brief pause to let the shell initialise before sending
		vim.defer_fn(function()
			local ok, err = wez.send_to_pane(new_pane_id, command)
			if not ok then
				vim.notify("wezterm_send: " .. (err or "unknown error"), vim.log.levels.ERROR)
			end
		end, 300)
	end
end

function M.retrieve_output(opts)
	opts = opts or {}

	-- Resolve which pane to read from: explicit id, direction, match, or the
	-- only other visible pane if there's just one.
	local pane_id
	if opts.pane_id then
		pane_id = opts.pane_id
	elseif opts.direction then
		pane_id = wez.pane_by_direction(opts.direction)
	elseif opts.match then
		pane_id = wez.pane_by_match(opts.match)
	else
		-- Fall back: if exactly one other pane exists, use it unambiguously
		local my_id = wez.current_pane_id()
		local others = vim.tbl_filter(function(p)
			return p.pane_id ~= my_id
		end, wez.list_panes())
		if #others == 1 then
			pane_id = others[1].pane_id
		end
	end

	if not pane_id then
		vim.notify("wezterm_send: could not resolve a pane to read from", vim.log.levels.WARN)
		return nil
	end

	local lines = opts.lines or 50 -- how many lines of scrollback to capture
	local out, code = helpers.run({ "wezterm", "cli", "get-text", "--pane-id", pane_id, "--escapes" })
	if code ~= 0 then
		vim.notify("wezterm_send: get-text failed for pane " .. pane_id, vim.log.levels.ERROR)
		return nil
	end

	-- Trim to the last `lines` lines to avoid swamping the caller with scrollback
	local all_lines = vim.split(out, "\n", { plain = true })
	local tail = vim.list_slice(all_lines, math.max(1, #all_lines - lines + 1))
	return table.concat(tail, "\n")
end

---@class WeztermSendSetupOpts
---@field directions? Directions
---@field create_keymaps? boolean   Enable default keymaps (default: true)
---@field prefix_send?  string      Keymap prefix (default: "<leader>w")
---@field prefix_run?  string       Keymap prefix (default: "<leader>r")

---@param config? WeztermIntegrationSetupOpts
function M.setup(config)
	if not wez.is_wezterm() then
		print(
			"Not setting up plugin wezterm-integration.nvim because not running in WezTerm."
				.. " Info: $TERM_PROGRAM is '"
				.. tostring(vim.env.TERM_PROGRAM)
				.. "' (expected "
				.. "'WezTerm')."
		)
		return
	else
		print("TODO")

		M.opts = vim.tbl_deep_extend("force", M.opts, config or {})

		if not M.opts.create_keymaps then
			return
		end

		local prefix_send = M.opts.prefix_send
		local prefix_run = M.opts.prefix_run

		for _, k in pairs({ "h", "j", "k", "l", "n", "p" }) do
			map_send_visual(k)
			map_run(k)
		end

		map("v", prefix_send .. "w", function()
			M.send_selection({ pick = true })
		end, { desc = "Send selection: pick WezTerm pane", silent = true })

		map("v", prefix_run .. "r", function()
			M.send_selection({ pick = true })
		end, { desc = "Run file: pick WezTerm pane", silent = true })

		map("n", prefix .. "o", function()
			M.retrieve_and_deliver()
		end, { desc = "weave: retrieve pane output" })

		-- Toggle capture mode on the fly
		map("n", prefix .. "tc", function()
			options.capture = options.capture == "auto" and "explicit" or "auto"
			vim.notify("weave: capture mode = " .. options.capture, vim.log.levels.INFO)
		end, { desc = "weave: toggle auto/explicit capture" })
	end
end

return M

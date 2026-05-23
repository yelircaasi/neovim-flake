--[[ USAGE:

-- manual setup
local wts = require("wezterm_send")

vim.keymap.set("v", "<leader>wr", function()
  wts.send_selection({ direction = "Right" })
end)

vim.keymap.set("v", "<leader>wp", function()
  wts.send_selection({ match = "python" })  -- matches title or cwd
end)

-- with default keymaps
require("wezterm_send").setup()
-- or customise:
require("wezterm_send").setup({ prefix = "<leader>s" })
]]

--- wezterm_send.lua
--- Send the current (or last) visual selection to a WezTerm pane.
---
--- Two targeting strategies are supported:
---   1. Direction  – send to the pane immediately Left/Right/Up/Down/Next/Prev
---                   relative to the nvim pane.
---   2. Search     – scan all panes and pick the first one whose title or cwd
---                   matches a pattern (e.g. "python", "ipython", "julia").
---
--- Quick-start (lazy.nvim / manual require):
---
---   local wts = require("wezterm_send")
---
---   -- Send selection to the pane on the right
---   vim.keymap.set("v", "<leader>wr", function()
---     wts.send_selection({ direction = "Right" })
---   end, { desc = "Send to WezTerm pane (right)" })
---
---   -- Send selection to a pane running python/ipython
---   vim.keymap.set("v", "<leader>wp", function()
---     wts.send_selection({ match = "python" })
---   end, { desc = "Send to WezTerm python pane" })
---
---   -- Interactive picker (vim.ui.select over all panes)
---   vim.keymap.set("v", "<leader>ww", function()
---     wts.send_selection({ pick = true })
---   end, { desc = "Pick WezTerm pane and send" })

local M = {}

--- Run a shell command and return stdout (trimmed) + exit code.
---@param cmd string[]
---@return string output, integer exit_code
local function run(cmd)
	local out = {}
	local obj = vim.system(cmd, { text = true }):wait()
	return vim.trim(obj.stdout or ""), obj.code
end

--- Get the visual selection as a string.
--- Works in both visual mode (live) and after leaving visual mode ('' mark pair).
---@return string
local function get_visual_selection()
  local mode = vim.fn.mode()
  local start_pos, end_pos

  if mode == "v" or mode == "V" or mode == "\22" then
    -- Called via <Cmd> mapping: still in visual mode, marks not set yet.
    -- 'v' is the anchor point, '.' is the cursor (either can be the "start").
    start_pos = vim.fn.getpos("v")
    end_pos   = vim.fn.getpos(".")
    -- Normalise so start_pos is always the earlier position
    if start_pos[2] > end_pos[2]
      or (start_pos[2] == end_pos[2] and start_pos[3] > end_pos[3])
    then
      start_pos, end_pos = end_pos, start_pos
    end
  else
    -- Called after visual mode was exited normally; marks are reliable.
    start_pos = vim.fn.getpos("'<")
    end_pos   = vim.fn.getpos("'>")
    if start_pos[2] == 0 then return "" end
  end

  local start_line = start_pos[2] - 1
  local start_col  = start_pos[3] - 1
  local end_line   = end_pos[2] - 1
  local end_col    = end_pos[3]

  local line_len = #vim.api.nvim_buf_get_lines(0, end_line, end_line + 1, true)[1]
  end_col = math.min(end_col, line_len)

  local lines = vim.api.nvim_buf_get_text(0, start_line, start_col, end_line, end_col, {})
  return table.concat(lines, "\n")
end

--- Escape text so it is safe to pass as a single shell argument.
--- We write via stdin so this is only needed for the command list itself.
---@param s string
---@return string
local function shell_escape(s)
	return "'" .. s:gsub("'", "'\\''") .. "'"
end

--- Ensure the text ends with a newline (so REPLs execute it).
---@param text string
---@return string
local function ensure_newline(text)
	if text:sub(-1) ~= "\n" then
		return text .. "\n"
	end
	return text
end

--- Return the WEZTERM_PANE env var (set by WezTerm for the current pane).
---@return string|nil
local function current_pane_id()
	local id = vim.env.WEZTERM_PANE
	if id and id ~= "" then
		return id
	end
	return nil
end

--- Get the pane-id of an adjacent pane by direction.
---@param direction "Left"|"Right"|"Up"|"Down"|"Next"|"Prev"
---@return string|nil pane_id
local function pane_by_direction(direction)
	local pane_id = current_pane_id()
	local cmd = { "wezterm", "cli", "get-pane-direction", direction }
	if pane_id then
		vim.list_extend(cmd, { "--pane-id", pane_id })
	end
	local out, code = run(cmd)
	if code == 0 and out ~= "" then
		return out
	end
	return nil
end

--- List all WezTerm panes as a table of records.
--- Each record: { pane_id, window_id, tab_id, title, cwd, workspace }
---@return table[]
local function list_panes()
	local out, code = run({ "wezterm", "cli", "list", "--format", "json" })
	if code ~= 0 or out == "" then
		return {}
	end
	local ok, panes = pcall(vim.json.decode, out)
	if not ok or type(panes) ~= "table" then
		return {}
	end

	-- Normalise field names (wezterm uses snake_case already, but let's be safe)
	local result = {}
	for _, p in ipairs(panes) do
		table.insert(result, {
			pane_id = tostring(p.pane_id),
			window_id = tostring(p.window_id),
			tab_id = tostring(p.tab_id),
			title = p.title or "",
			cwd = p.cwd or "",
			workspace = p.workspace or "",
		})
	end
	return result
end

--- Find the first pane whose title or cwd matches `pattern` (case-insensitive).
--- Excludes the current nvim pane if its id is known.
---@param pattern string  Lua pattern or plain substring
---@return string|nil pane_id
local function pane_by_match(pattern)
	local this_pane = current_pane_id()
	pattern = pattern:lower()

	for _, p in ipairs(list_panes()) do
		if p.pane_id ~= this_pane then
			local title_lowercase = p.title:lower()
			local cwd_lowercase = p.cwd:lower()
			if title_lowercase:find(pattern, 1, true) or cwd_lowercase:find(pattern, 1, true) then
				return p.pane_id
			end
		end
	end
	return nil
end

--- Send `text` to WezTerm pane `pane_id` via stdin.
---@param pane_id string
---@param text string
---@return boolean success, string? err
local function send_to_pane(pane_id, text)
	text = ensure_newline(text)

	-- wezterm cli send-text reads from stdin when no positional TEXT arg is given
	local cmd = { "wezterm", "cli", "send-text", "--no-paste", "--pane-id", pane_id }
	local obj = vim.system(cmd, {
		text = true,
		stdin = text,
	}):wait()

	if obj.code ~= 0 then
		local err = vim.trim(obj.stderr or "")
		return false, ("wezterm exited: exit code %d: %s"):format(obj.code, err)
	end
	return true
end

--- Open a vim.ui.select picker over all panes; resolves to a pane_id.
---@param callback fun(pane_id: string|nil)
local function pick_pane(callback)
	local my_id = current_pane_id()
	local panes = list_panes()

	-- Filter out ourselves so we don't accidentally send to nvim
	local choices = {}
	for _, p in ipairs(panes) do
		if p.pane_id ~= my_id then
			table.insert(choices, p)
		end
	end

	if #choices == 0 then
		vim.notify("wezterm_send: no other panes found", vim.log.levels.WARN)
		callback(nil)
		return
	end

	vim.ui.select(choices, {
		prompt = "Send to WezTerm pane:",
		format_item = function(p)
			local cwd_short = p.cwd:gsub("^file://[^/]*/", "/"):gsub("^/home/[^/]*/", "~/")
			return ("[%s] %s  %s"):format(p.pane_id, p.title, cwd_short)
		end,
	}, function(choice)
		callback(choice and choice.pane_id or nil)
	end)
end

-- ─── public API ───────────────────────────────────────────────────────────────

--- Options accepted by send_selection / send_text:
---@class WeztermSendOpts
---@field direction? "Left"|"Right"|"Up"|"Down"|"Next"|"Prev"
---@field match?     string   Pattern matched against pane title / cwd
---@field pane_id?  string   Explicit pane id (overrides everything else)
---@field pick?     boolean  Show interactive picker (async)
---@field add_newline? boolean  Ensure trailing newline (default true)

--- Resolve a target pane_id from opts (sync paths only; pick is handled separately).
---@param opts WeztermSendOpts
---@return string|nil pane_id, string|nil err
local function resolve_pane(opts)
	if opts.pane_id then
		return opts.pane_id, nil
	end

	if opts.direction then
		local id = pane_by_direction(opts.direction)
		if not id then
			return nil, ("No pane found in direction '%s'"):format(opts.direction)
		end
		return id, nil
	end

	if opts.match then
		local id = pane_by_match(opts.match)
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
		pick_pane(function(pane_id)
			if pane_id then
				local ok, err = send_to_pane(pane_id, text)
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

	local ok, send_err = send_to_pane(pane_id, text)
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
	local text = get_visual_selection()

	if text == "" then
		vim.notify("wezterm_send: empty selection", vim.log.levels.WARN)
		return
	end

	M.send_text(text, opts)
end

local directions = {
	h = "Left",
	l = "Right",
	j = "Down",
	k = "Up",
	n = "Next",
	p = "Prev",
}

---@class WeztermSendSetupOpts
---@field keymaps? boolean   Enable default keymaps (default: true)
---@field prefix?  string    Keymap prefix (default: "<leader>w")

---@param opts? WeztermSendSetupOpts

function M.setup(opts)
	opts = vim.tbl_deep_extend("force", {
		keymaps = true,
		prefix = "<leader>w",
	}, opts or {})

	if not opts.keymaps then
		return
	end

	local prefix = opts.prefix

	local wezmap = function(key)
		local lhs = prefix .. key
		local direction = directions[key]
        local direction_lower = string.lower(direction)
		local rhs = function()
            print("Sending selection " .. direction_lower .. ".")
			M.send_selection({ direction = direction })
		end
		local desc = "Send selection: WezTerm pane (" .. direction_lower .. ")"
		vim.keymap.set("v", lhs, rhs, { desc = desc }) --, silent = true })
	end

	for _, k in pairs({ "h", "j", "k", "l", "n", "p" }) do
		wezmap(k)
	end

	vim.keymap.set(
		"v",
		prefix .. "w",
		function() M.send_selection({ pick = true }) end,
		{ desc = "Send selection: pick WezTerm pane", silent = true }
	)
end

return M

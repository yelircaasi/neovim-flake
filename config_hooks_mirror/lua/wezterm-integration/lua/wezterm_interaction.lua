local helpers = require("helpers")

local M = {}

function M.is_wezterm()
	return vim.env.WEZTERM_PANE ~= nil
end

--- Return the WEZTERM_PANE env var (set by WezTerm for the current pane).
---@return string|nil
function M.current_pane_id()
	local id = vim.env.WEZTERM_PANE
	if id and id ~= "" then
		return id
	end
	return nil
end

--- Get the pane-id of an adjacent pane by direction.
---@param direction "Left"|"Right"|"Up"|"Down"|"Next"|"Prev"
---@return string|nil pane_id
function M.pane_by_direction(direction)
	local pane_id = M.current_pane_id()
	local cmd = { "wezterm", "cli", "get-pane-direction", direction }
	if pane_id then
		vim.list_extend(cmd, { "--pane-id", pane_id })
	end
	local out, code = helpers.run(cmd)
	if code == 0 and out ~= "" then
		return out
	end
	return nil
end

--- List all WezTerm panes as a table of records.
--- Each record: { pane_id, window_id, tab_id, title, cwd, workspace }
---@return table[]
function M.list_panes()
	local out, code = helpers.run({ "wezterm", "cli", "list", "--format", "json" })
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
function M.pane_by_match(pattern)
	local this_pane = M.current_pane_id()
	pattern = pattern:lower()

	for _, p in ipairs(M.list_panes()) do
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

--- Open a vim.ui.select picker over all panes; resolves to a pane_id.
---@param callback fun(pane_id: string|nil)
function M.pick_pane(callback)
	local my_id = M.current_pane_id()
	local panes = M.list_panes()

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

--- Send `text` to WezTerm pane `pane_id` via stdin.
---@param pane_id string
---@param text string
---@return boolean success, string? err
function M.send_to_pane(pane_id, text)
	text = helpers.ensure_newline(text)

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

-- LATEST

-- Call this just before sending
function M.mark_pane(opts)
	local pane_id, err = resolve_pane(opts)
	if not pane_id then
		vim.notify("weave: " .. (err or "unknown error"), vim.log.levels.WARN)
		return
	end

	local output = M.get_output({ pane_id = pane_id }) or ""
	-- Store the pre-snapshot keyed by pane_id
	M._marks[pane_id] = vim.split(output, "\n", { plain = true })
	vim.notify("weave: pane marked", vim.log.levels.INFO)
end

-- Call this after the command has visibly finished
function M.retrieve_output(opts)
	local pane_id, err = resolve_pane(opts)
	if not pane_id then
		vim.notify("weave: " .. (err or "unknown error"), vim.log.levels.WARN)
		return
	end

	local pre_lines = M._marks[pane_id]
	if not pre_lines then
		vim.notify("weave: pane not marked — call mark_pane first", vim.log.levels.WARN)
		return
	end

	local post = M.get_output({ pane_id = pane_id }) or ""
	local post_lines = vim.split(post, "\n", { plain = true })

	-- Find where pre ends in post and take everything after
	local pre_tail = pre_lines[#pre_lines]
	for i = #post_lines, 1, -1 do
		if post_lines[i] == pre_tail then
			local new_lines = vim.list_slice(post_lines, i + 1)
			M._marks[pane_id] = nil
			return table.concat(new_lines, "\n")
		end
	end

	-- Fallback: pre_tail scrolled out of view, return everything
	M._marks[pane_id] = nil
	return post
end

function M.send_selection(opts)
	opts = opts or {}
	local text = get_visual_selection()
	if text == "" then
		vim.notify("weave: empty selection", vim.log.levels.WARN)
		return
	end

	-- Auto-mark so retrieve_output works without a separate mark step
	M.mark_pane(opts)
	M.send_text(text, opts)
end

-- NEXT

local function deliver_output(output, target)
	if target == "clipboard" then
		vim.fn.setreg("+", output)
		vim.fn.setreg('"', output)
		vim.notify("weave: output copied to clipboard", vim.log.levels.INFO)
	elseif target == "scratch" then
		local buf = vim.api.nvim_create_buf(false, true)
		vim.bo[buf].filetype = "text"
		vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(output, "\n", { plain = true }))
		vim.cmd.split()
		vim.api.nvim_win_set_buf(0, buf)
	elseif target == "quickfix" then
		local items = {}
		for _, line in ipairs(vim.split(output, "\n", { plain = true })) do
			table.insert(items, { text = line })
		end
		vim.fn.setqflist(items, "r")
		vim.cmd.copen()
	end
end

function M.send_selection(opts)
	opts = vim.tbl_deep_extend("force", {
		capture = options.capture,
		capture_target = options.capture_target,
	}, opts)

	local text = get_visual_selection()
	if text == "" then
		vim.notify("weave: empty selection", vim.log.levels.WARN)
		return
	end

	M.mark_pane(opts)
	M.send_text(text, opts)

	if opts.capture == "auto" then
		-- Poll until output changes, then deliver
		local pane_id = resolve_pane(opts)
		poll_for_change(pane_id, M._marks[pane_id], function()
			local output = M.retrieve_output(opts)
			if output then
				deliver_output(output, opts.capture_target)
			end
		end)
	end
end

-- Explicit retrieval: user calls this when ready
function M.retrieve_and_deliver(opts)
	opts = vim.tbl_deep_extend("force", {
		capture_target = options.capture_target,
	}, opts or {})

	local output = M.retrieve_output(opts)
	if output then
		deliver_output(output, opts.capture_target)
	end
end

return M

local M = {}

--- Run a shell command and return stdout (trimmed) + exit code.
---@param cmd string[]
---@return string output, integer exit_code
function M.run(cmd)
	local out = {}
	local obj = vim.system(cmd, { text = true }):wait()
	return vim.trim(obj.stdout or ""), obj.code
end

--- Escape text so it is safe to pass as a single shell argument.
--- We write via stdin so this is only needed for the command list itself.
---@param s string
---@return string
function M.shell_escape(s)
	return "'" .. s:gsub("'", "'\\''") .. "'"
end

--- Ensure the text ends with a newline (so REPLs execute it).
---@param text string
---@return string
function M.ensure_newline(text)
	if text:sub(-1) ~= "\n" then
		return text .. "\n"
	end
	return text
end

return M

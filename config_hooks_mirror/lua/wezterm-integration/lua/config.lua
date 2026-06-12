M = {}

---@enum Directions
M.directions = {
	h = "Left",
	l = "Right",
	j = "Down",
	k = "Up",
	n = "Next",
	p = "Prev",
}

M.create_keymaps = true

M.prefix_send = "<leader>w"

M.prefix_run = "<leader>r"

return M

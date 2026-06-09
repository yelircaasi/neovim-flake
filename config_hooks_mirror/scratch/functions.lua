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

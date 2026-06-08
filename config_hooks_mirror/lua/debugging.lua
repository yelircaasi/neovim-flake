setup_plugin("dap-python", function(dap_python)
	-- local dap_python = utils.get_plugin("dap-python")
	dap_python.setup("debugpy-adapter")
	dap_python.test_runner = "pytest"
	vim.keymap.set("n", "<leader>tt", function()
		print("Leader is working!")
	end)
	vim.keymap.set("n", "<leader>pp", function()
		print("This works")
	end)
	vim.keymap.set("n", "<leader>dn", function()
		dap_python.test_method()
	end)
	vim.keymap.set("n", "<leader>df", function()
		dap_python.test_class()
	end)
	vim.keymap.set("v", "<leader>ds", function()
		dap_python.debug_selection()
	end)
	-- OTHER
	dap_python.setup("debugpy-adapter")
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
-- TODO: proposed:
--[[
setup_plugin("dap-python", function(dap_python)
    dap_python.setup("debugpy-adapter")
    dap_python.test_runner = "pytest"

    vim.keymap.set("n", "<leader>dn", dap_python.test_method)
    vim.keymap.set("n", "<leader>df", dap_python.test_class)

    vim.keymap.set("v", "<leader>ds", function()
        dap_python.debug_selection()
    end)
end)
]]
setup_plugin("dapui", function(dapui)
	local dap = utils.get_plugin("dap")

	dapui.setup({
		layouts = {
			{
				elements = {
					"scopes",
					"breakpoints",
					"stacks",
					"watches",
				},
				size = 40,
				position = "left",
			},
			{
				elements = {
					"repl",
					"console",
				},
				size = 10,
				position = "bottom",
			},
		},
	})

	dap.listeners.after.event_initialized["dapui_config"] = function()
		dapui.open()
	end

	dap.listeners.before.event_terminated["dapui_config"] = function()
		dapui.close()
	end

	dap.listeners.before.event_exited["dapui_config"] = function()
		dapui.close()
	end

	vim.keymap.set("n", "<leader>du", dapui.toggle)
end)
setup_plugin("nvim-dap-virtual-text", {
	commented = true,
})
setup_plugin("dap", function(dap)
	vim.keymap.set("n", "<F5>", dap.continue)
	vim.keymap.set("n", "<F10>", dap.step_over)
	vim.keymap.set("n", "<F11>", dap.step_into)
	vim.keymap.set("n", "<F12>", dap.step_out)

	vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)

	vim.keymap.set("n", "<leader>dB", function()
		dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
	end)

	vim.keymap.set("n", "<leader>dr", dap.repl.open)
	vim.keymap.set("n", "<leader>dl", dap.run_last)

	vim.keymap.set("n", "<leader>dc", dap.continue)
	vim.keymap.set("n", "<leader>dx", dap.terminate)
end)

-- QUICKFIX QOL
vim.keymap.set("n", "]q", "<cmd>cnext<cr>")
vim.keymap.set("n", "[q", "<cmd>cprev<cr>")

vim.keymap.set("n", "]l", "<cmd>lnext<cr>")
vim.keymap.set("n", "[l", "<cmd>lprev<cr>")

vim.keymap.set("n", "<leader>q", "<cmd>copen<cr>")
vim.keymap.set("n", "<leader>Q", "<cmd>cclose<cr>")

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "qf" },
	callback = function(ev)
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = ev.buf })
	end,
})

-- OPTIONAL DIAGNOSTIC MAPPINGS
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)

vim.keymap.set("n", "<leader>xx", function()
	vim.diagnostic.setloclist()
end)

vim.keymap.set("n", "<leader>xX", function()
	vim.diagnostic.setqflist()
end)

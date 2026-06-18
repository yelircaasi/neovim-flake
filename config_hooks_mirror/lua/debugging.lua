local function setup_dap_python()
	setup_plugin("dap-python", function(dap_python)
		-- local dap_python = utils.get_plugin("dap-python")
		dap_python.setup("debugpy-adapter")
		dap_python.test_runner = "pytest"
		map_explicit({
			mode = "n",
			sequence = "<leader>tt",
			action = utils.mkprint("Leader is working!"),
		})
		map_explicit({
			mode = "n",
			sequence = "<leader>pp",
			action = utils.mkprint("This works"),
		})
		map_explicit({
			mode = "n",
			sequence = "<leader>dn",
			action = dap_python.test_method,
		})
		map_explicit({
			mode = "n",
			sequence = "<leader>df",
			action = dap_python.test_class,
		})
		map_explicit({
			mode = "v",
			sequence = "<leader>ds",
			action = dap_python.debug_selection,
		})
		-- OTHER
		map_explicit({
			mode = "n",
			sequence = "<leader>dn",
			action = dap_python.test_method,
		})
		map_explicit({
			mode = "n",
			sequence = "<leader>df",
			action = dap_python.test_class,
		})
		map_explicit({
			mode = "v",
			sequence = "<leader>ds",
			action = dap_python.debug_selection,
		})
	end)
	-- TODO: proposed:
	--[[
	setup_plugin("dap-python", function(dap_python)
		dap_python.setup("debugpy-adapter")
		dap_python.test_runner = "pytest"

		map_explicit({
		mode = "n",
		sequence = "<leader>dn",
		action = dap_python.test_method,
	})
		map_explicit({
		mode = "n",
		sequence = "<leader>df",
		action = dap_python.test_class,
	})

		map_explicit({
		mode = "v",
		sequence = "<leader>ds",
		action = function()
			dap_python.debug_selection()
		end,
	})
	end)
	]]
end

local function setup_dapui()
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

		dap.listeners.after.event_initialized["dapui_config"] = dapui.open

		dap.listeners.before.event_terminated["dapui_config"] = dapui.close

		dap.listeners.before.event_exited["dapui_config"] = dapui.close

		map_explicit({
			mode = "n",
			sequence = "<leader>du",
			action = dapui.toggle,
		})
	end)
end

local function setup_dap_virtual_text()
	setup_plugin("nvim-dap-virtual-text", {
		commented = true,
	})
	setup_plugin("dap", function(dap)
		map_explicit({
			mode = "n",
			sequence = "<F5>",
			action = dap.continue,
		})
		map_explicit({
			mode = "n",
			sequence = "<F10>",
			action = dap.step_over,
		})
		map_explicit({
			mode = "n",
			sequence = "<F11>",
			action = dap.step_into,
		})
		map_explicit({
			mode = "n",
			sequence = "<F12>",
			action = dap.step_out,
		})

		map_explicit({
			mode = "n",
			sequence = "<leader>db",
			action = dap.toggle_breakpoint,
		})

		map_explicit({
			mode = "n",
			sequence = "<leader>dB",
			action = function()
				dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end,
		})

		map_explicit({
			mode = "n",
			sequence = "<leader>dr",
			action = dap.repl.open,
		})
		map_explicit({
			mode = "n",
			sequence = "<leader>dl",
			action = dap.run_last,
		})

		map_explicit({
			mode = "n",
			sequence = "<leader>dc",
			action = dap.continue,
		})
		map_explicit({
			mode = "n",
			sequence = "<leader>dx",
			action = dap.terminate,
		})
	end)
end

local function create_keymaps()
	-- QUICKFIX QOL
	map_explicit({
		mode = "n",
		sequence = "]q",
		action = "<cmd>cnext<cr>",
	})
	map_explicit({
		mode = "n",
		sequence = "[q",
		action = "<cmd>cprev<cr>",
	})

	map_explicit({
		mode = "n",
		sequence = "]l",
		action = "<cmd>lnext<cr>",
	})
	map_explicit({
		mode = "n",
		sequence = "[l",
		action = "<cmd>lprev<cr>",
	})

	map_explicit({
		mode = "n",
		sequence = "<leader>q",
		action = "<cmd>copen<cr>",
	})
	map_explicit({
		mode = "n",
		sequence = "<leader>Q",
		action = "<cmd>cclose<cr>",
	})

	-- OPTIONAL DIAGNOSTIC MAPPINGS
	map_explicit({
		mode = "n",
		sequence = "[d",
		action = vim.diagnostic.goto_prev,
	})
	map_explicit({
		mode = "n",
		sequence = "]d",
		action = vim.diagnostic.goto_next,
	})

	map_explicit({
		mode = "n",
		sequence = "<leader>e",
		action = vim.diagnostic.open_float,
	})

	map_explicit({
		mode = "n",
		sequence = "<leader>xx",
		action = vim.diagnostic.setloclist,
	})

	map_explicit({
		mode = "n",
		sequence = "<leader>xX",
		action = vim.diagnostic.setqflist,
	})
end

local function create_autommands()
	vim.api.nvim_create_autocmd("FileType", {
		pattern = { "qf" },
		callback = function(ev)
			map_explicit({ mode = "n", sequence = "q", action = "<cmd>close<cr>", opts = { buffer = ev.buf } })
		end,
	})
end

--─────────────────────────────────────────────────────────────────────────────
--──── CALL SETUPS ────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────

setup_dap_python()
setup_dapui()
setup_dap_virtual_text()
create_keymaps()
create_autommands()

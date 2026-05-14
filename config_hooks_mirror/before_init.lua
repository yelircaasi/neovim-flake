-- print("This ran before.")
-- print()
-- print(vim.inspect(vim.opt.runtimepath))
-- print(vim.inspect(vim.opt.packpath))

-- print(vim.o.runtimepath:find(vim.env.VIMRUNTIME) ~= nil)
-- -- vim.o.runtimepath:prepend(vim.env.VIMRUNTIME)
-- print(vim.o.runtimepath:find(vim.env.VIMRUNTIME) ~= nil)
-- VERBOSE = false
-- SAFE = true
-- print(vim.env.VIMRUNTIME)
-- vim.opt.runtimepath:prepend(vim.env.VIMRUNTIME)
-- print(vim.o.runtimepath:find(vim.env.VIMRUNTIME, 1, true) ~= nil)


utils.printv("CONFIG_DIR: " .. CONFIG_DIR)
utils.printv("PLUGINS INCLUDED: " .. vim.inspect(utils.PLUGINS_INCLUDED))
utils.printbv(#utils.PLUGINS_INCLUDED .. " plugins included")

-- print(vim.inspect(vim.opt.runtimepath))
-- print(vim.inspect(vim.opt.packpath))

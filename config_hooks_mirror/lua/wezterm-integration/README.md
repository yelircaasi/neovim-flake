# wezterm-integration.nvim

```lua
--[[
Some name ideas:

wezterm-integrate.nvim 
wezterm-integration.nvim
- wezterm-weave.nvim - wezterm + neovim, to weave them together
- warp.nvim - send text across pane boundaries
- conduit.nvim - a pipe between editors and terminals
- relay.nvim - relay text to another pane
- sling.nvim - sling text across to a pane
- wez.nvim - short and direct
- pane.nvim - simple, describes the domain
- repane.nvim - send/re-route to a pane
]]

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
```

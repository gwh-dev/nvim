local dap = require "dap"
local dapui = require "dapui"
-- local daptext = require "nvim-dap-virtual-text"
local dapGo = require "dap-go"

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open(1)
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- Providers
dapGo.setup()

-- UI
-- daptext.setup()
dapui.setup {
  layouts = {
    {
      elements = {
        "console",
      },
      size = 7,
      position = "bottom",
    },
    {
      elements = {
        -- Elements can be strings or table with id and size keys.
        { id = "scopes", size = 0.25 },
        "watches",
      },
      size = 40,
      position = "left",
    },
  },
}

local create_cmd = vim.api.nvim_create_user_command
create_cmd("GoTest", function() -- dap golang
  dapGo.debug_test()
end, {})
create_cmd("GoLastTest", function() -- dap golang
  dapGo.debug_last_test()
end, {})
local map = vim.keymap.set
local opts = { nowait = true, silent = true }
map("n", "<localleader>K", function()
  require("dap.ui.widgets").hover()
end, { noremap = true })
map("n", "<localleader>k", function()
  dapui.eval()
end, { noremap = true })

map("n", "<Left>", function()
  dap.step_out()
end, opts)
map("n", "<Right>", function()
  dap.step_into()
end, opts)
map("n", "<Down>", function()
  dap.step_over()
end, opts)

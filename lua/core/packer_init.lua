local fn = vim.fn
local cmd = vim.cmd
local api = vim.api
local bootstrap = false
local install_path = fn.stdpath "data" .. "/site/pack/packer/opt/packer.nvim"
local compile_path = fn.stdpath "config" .. "/lua/packer_compiled.lua"

if fn.empty(fn.glob(install_path)) > 0 then
  print("Clonning packer.nvim inside:", install_path)
  fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  api.nvim_command "packadd packer.nvim"
  bootstrap = true
end

local packer = nil

local function load()
  if packer == nil then
    cmd [[ packadd packer.nvim ]]
    packer = require "packer"
    -- local util = require "packer.util"
    packer.init {
      disable_commands = true,
      display = {
        open_fn = function()
          local result, win, buf = require("packer.util").float {
            border = {
              { "╭", "FloatBorder" },
              { "─", "FloatBorder" },
              { "╮", "FloatBorder" },
              { "│", "FloatBorder" },
              { "╯", "FloatBorder" },
              { "─", "FloatBorder" },
              { "╰", "FloatBorder" },
              { "│", "FloatBorder" },
            },
          }
          api.nvim_win_set_option(win, "winhighlight", "NormalFloat:Normal")
          return result, win, buf
        end,
      },
      git = {
        clone_timeout = 800, -- In Seconds
      },
      compile_path = compile_path,
      auto_clean = true,
      compile_on_sync = true,
      auto_reload_compiled = true,
    }
  end
  packer.reset()
  local use = packer.use
  use { "wbthomason/packer.nvim", opt = true }
  use { "nvim-lua/plenary.nvim" }
  use { "lewis6991/impatient.nvim" }
  require("plugins").plugins(use)
end

local plugins = setmetatable({}, {
  __index = function(_, key)
    if not packer then
      load()
    end
    return packer[key]
  end,
})

if bootstrap then
  plugins.sync()
end

if fn.filereadable(compile_path) == 1 then
  cmd [[packadd packer.nvim]]
  require "packer_compiled"
else
  plugins.clean()
  plugins.compile()
end

local commands = {
  "Compile",
  "Install",
  "Update",
  "Sync",
  "Clean",
  "Status",
}

for _, cmds in pairs(commands) do
  api.nvim_create_user_command("Packer" .. cmds, function()
    cmd [[packadd packer.nvim]]
    plugins[string.lower(cmds)]()
  end, {})
end

return plugins

local BOOTSTRAP = false
local fn = vim.fn
local PATH = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(PATH)) > 0 then
  print "Cloning..."
  fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    PATH,
  }
  vim.cmd "packadd packer.nvim"
  BOOTSTRAP = true
  print "packer is installed"
end

if BOOTSTRAP == true then
  require("plugins").sync()
end

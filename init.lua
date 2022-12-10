local present, impatient = pcall(require, 'impatient')

if present then
  impatient.enable_profile()
end
-- function _G.lazy(plugin, timer)
--     if plugin then
--         timer = timer or 0
--         vim.defer_fn(function()
--             require("packer").loader(plugin)
--         end, timer)
--     end
-- end

require "plugins"
require "config.mappings"
require "config.settings"
require "config.autocmds"
require "config.colorscheme"

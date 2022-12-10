local api, fn = vim.api, vim.fn
local M = {}

-- From: https://github.com/jghauser/mkdir.nvim
-- Create a folder if does not exist
function M.mkdir()
  local dir = fn.expand "<afile>:p:h"
  -- This handles URLs using netrw. See ':help netrw-transparent' for details.
  if dir:find "%l+://" == 1 then
    return
  end
  if fn.isdirectory(dir) == 0 then
    fn.mkdir(dir, "p")
  end
end


-- From: https://github.com/glepnir/hlsearch.nvim
-- Delete the ? or / highligh after getting in insert mode
function StopHighlighting()
  if vim.v.hlsearch == 0 then
    return
  end
  local keycode = api.nvim_replace_termcodes("<Cmd>nohl<CR>", true, false, true)
  api.nvim_feedkeys(keycode, "n", false)
end

function StartHighlighting()
  local res = fn.getreg "/"
  if vim.v.hlsearch == 1 and not fn.search([[\%#\zs]] .. res, "cnW") then
    StopHighlighting()
  end
end

-- local group = api.nvim_create_augroup("Hlsearch", { clear = true })
function M.hs_event(bufnr, group)
  if M[bufnr] then
    return
  end
  M[bufnr] = true
  local cm_id = api.nvim_create_autocmd("CursorMoved", {
    buffer = bufnr,
    group = group,
    callback = function()
      StartHighlighting()
    end,
  })

  local ie_id = api.nvim_create_autocmd("InsertEnter", {
    buffer = bufnr,
    group = group,
    callback = function()
      StopHighlighting()
    end,
  })

  api.nvim_create_autocmd("BufDelete", {
    buffer = bufnr,
    group = group,
    callback = function(opt)
      M[bufnr] = nil
      api.nvim_del_autocmd(cm_id) -- if there is an error i can use pcall here
      api.nvim_del_autocmd(ie_id) -- and here
      api.nvim_del_autocmd(opt.id) -- and here
    end,
  })
end

return M

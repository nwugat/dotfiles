local vim = vim
local m = {}

m.exists = function()
  local path = vim.api.nvim_buf_get_name(0)
  return path ~= '' and vim.loop.fs_stat ~= nil
end

m.check_filetype = function(filetype)
  local ft = vim.bo.filetype
  return ft == filetype
end

return m

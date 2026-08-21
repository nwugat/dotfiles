-- Helper functions

local vim = vim
local m = {}

m.insert_at_cursor = function(txt)
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line_content = vim.api.nvim_get_current_line()
  local new_line = line_content:sub(1, col) .. txt .. line_content:sub(col + 1)
  vim.api.nvim_set_current_line(new_line)
end

m.append_at_cursor = function(txt)
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line_content = vim.api.nvim_get_current_line()
  local new_line = line_content:sub(1, col + 1) .. txt .. line_content:sub(col + 2)
  vim.api.nvim_set_current_line(new_line)
end

m.rand_id = function(length)
  length = length or 8
  local result = ''
  local pool = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
  local pool_length = string.len(pool)
  math.randomseed(os.time())
  for _ = 1, length do
    local char_selected = math.random(1, pool_length)
    result = result .. pool:sub(char_selected, char_selected)
  end
  return result
end

m.paste_img_from_clip = function(location)
  --TODO: detect if file doesn't have an extension
  --TODO  panic properly
  --TODO  prompt to overwrite upon conflict
  --TODO  make OS-agnostic
  vim.fn.system("wl-paste --type image/png > " .. vim.fn.shellescape(location) .. ' 2>/dev/null')
  assert(vim.v.shell_error ~= 127, "wl-paste not found")
  assert(vim.v.shell_error == 0, "Could not paste image")
end

return m

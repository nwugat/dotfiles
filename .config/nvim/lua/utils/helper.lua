-- Helper functions

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

return m

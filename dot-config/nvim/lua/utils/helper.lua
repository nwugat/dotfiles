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

m.sanitize_str = function(str)
  return str
      :lower()
      :gsub("_", "-")
      :gsub("[^%w%.-]", "-")
      :gsub("-+", "-")
      :gsub("^%-", "")
      :gsub("%-$", "")
end

m.platform_is_win = function()
  return vim.loop.os_uname().sysname == "Windows_NT"
end

m.platform_is_mac = function()
  return vim.loop.os_uname().sysname == "Darwin"
end

m.platform_is_lin = function()
  return vim.loop.os_uname().sysname == "Linux"
end

---@return string?
m.get_linux_session = function()
  if vim.env["XDG_SESSION_TYPE"] == "tty" then
    return "tty"
  end

  local de = vim.env["XDG_SESSION_DESKTOP"] or vim.env["XDG_CURRENT_DESKTOP"]
  de = string.lower(de)

  --TODO: add other DEs
  if de:match("kde") then
    return "kde"
  elseif de:match("gnome") then
    return "gnome"
  else
    return nil
  end
end

return m

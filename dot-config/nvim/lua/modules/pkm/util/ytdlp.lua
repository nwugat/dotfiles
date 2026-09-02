--yt-dlp wrapper functions

local m = {}

--use this to check yt-dlp availability instead of checking for the string below
---@return boolean
m.is_ytdlp_available = function()
  return vim.fn.executable('yt-dlp') == 1
end

---@return boolean
m.is_youtube_url = function(url)
  return
      url:match("^https?://www%.youtube%.com/") ~= nil
      or url:match("^https?://youtube%.com/") ~= nil
      or url:match("^https?://www%.youtu%.be/") ~= nil
      or url:match("^https?://youtu%.be/") ~= nil
end

---@param url string
---@param property string
---@return string?
m.ytdlp_get_property_synchr = function(url, property)
  if not m.is_ytdlp_available() then
    vim.notify("yt-dlp not available", vim.log.levels.ERROR)
  end

  if not url or not type(url) == 'string' then
    vim.notify("URL not provided", vim.log.levels.ERROR)
    return nil
  elseif not m.is_youtube_url(url) then
    vim.notify("Not a Youtube URL", vim.log.levels.ERROR)
    return nil
  end


  if not property or not type(property) == 'string' then
    vim.notify("Property not provided", vim.log.levels.ERROR)
    return
  end

  vim.notify("Retrieving video " .. property .. "...", vim.log.levels.INFO)
  local timeout = 10000 -- milliseconds
  local result = vim.system({ 'yt-dlp', '--print', property, url }):wait(timeout)

  if result.code == 0 then
    return result.stdout:gsub('[\r\n]', '')
  elseif result.code == 124 then
    vim.notify("Command timed out", vim.log.levels.ERROR)
    return nil
  else
    vim.notify("Error while retrieving property (" .. property .. ")", vim.log.levels.ERROR)
    return nil
  end
end

return m

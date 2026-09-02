local m = {
  --TODO: use file name as default title
  generic = {
    "---",
    function()
      return "date: " .. os.date('%Y-%m-%d-%H:%M')
    end,
    'up: "[[]]"',
    'related:',
    '    - "[[]]"',
    'development-status: C',
    "---",
    "",
    "# ",
  },
  yt = { --TODO add metadata with yt-dlp
    "---",
    function()
      return "date: " .. os.date('%Y-%m-%d-%H:%M')
    end,
    'up: "[[]]"',
    function()
      local ytdlp = require('modules.pkm.util.ytdlp')
      local url = vim.fn.getreg('+'):gsub('\n', '')
      if ytdlp.is_youtube_url(url) then
        local author = ytdlp.ytdlp_get_property_synchr(url, 'uploader') or 'Unknown'
        return 'author: ' .. author
      else
        return 'author: Unknown'
      end
    end,
    function()
      local url = vim.fn.getreg('+'):gsub('\n', '')
      --TODO check if url is valid
      return 'url: "' .. url .. '"'
    end,
    'development-status: C',
    "---",
    "",
    "#resource/yt",
    "",
    function()
      local ytdlp = require('modules.pkm.util.ytdlp')
      local url = vim.fn.getreg('+'):gsub('\n', '')
      if ytdlp.is_youtube_url(url) then
        --TODO: use file name instead of empty string as fallback
        local title = ytdlp.ytdlp_get_property_synchr(url, 'title') or ''
        return '# ' .. title
      else
        return '# CAUTION: BAD URL'
      end
    end,
  },
}
m['.default'] = m.generic

return m

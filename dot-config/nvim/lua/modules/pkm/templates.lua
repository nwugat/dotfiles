local date_field = function()
  return "date: " .. os.date('%Y-%m-%d-%H:%M')
end

local m = {
  --TODO: use file name as default title
  generic = {
    "---",
    date_field,
    'up: "[[]]"',
    'related:',
    '    - "[[]]"',
    "---",
    "",
    "# ",
  },
  yt = { --TODO add metadata with yt-dlp
    "---",
    date_field,
    'up: "[[]]"',
    function()
      local ytdlp = require('modules.pkm.ytdlp')
      local url = vim.fn.getreg('+')
      local author = ytdlp.ytdlp_get_property(url, 'uploader') or 'Unknown'
      return 'author: ' .. author
    end,
    function()
      local url = vim.fn.getreg('+')
      --TODO check if url is valid
      return 'url: "' .. url .. '"'
    end,
    "---",
    "",
    "#resource/yt",
    "",
    function()
      local ytdlp = require('modules.pkm.ytdlp')
      local url = vim.fn.getreg('+')
      --TODO: use file name instead of empty string as fallback
      local title = ytdlp.ytdlp_get_property(url, 'title') or ''
      return '# ' .. title
    end,
  },
  fleeting = {
    '---',
    date_field,
    'up: "[[]]"',
    'related:',
    --TODO: consultar shiftwidth
    '    - "[[]]"',
    '---',
    '',
    '#fleeting',
    '',
    '# ',
  },
}
m['.default'] = m.generic

return m

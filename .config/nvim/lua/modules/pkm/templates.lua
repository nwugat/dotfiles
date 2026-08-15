local vim = vim
local m = {
  generic = {
    "---",
    function()
      return "date: " .. os.date('%Y-%m-%d-%H:%M')
    end,
    'up: "[[]]"',
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
    'author: "[[]]"',
    function()
      local url = vim.fn.getreg('+')
      --TODO check if url is valid
      return 'url: "' .. url .. '"'
    end,
    "---",
    "",
    "#resource/yt",
    "",
    "# ",
  },
}

return m

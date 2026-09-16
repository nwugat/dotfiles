--Various shorthands for common actions

local ytdlp = require('modules.pkm.util.ytdlp')
local template_actions = require('modules.pkm.features.template_actions')
local dirs = require('modules.pkm.data.paths')
local helper = require('utils.helper') --TODO: get rid of helper


local m = {}

m['YTNote'] = function()
  local url = vim.fn.getreg('+')

  if not ytdlp.is_ytdlp_available() then
    vim.notify('yt-dlp not found', vim.log.levels.WARN)
    return
  end

  if not ytdlp.is_youtube_url(url) then
    vim.notify('Clipboard content is not a yt URL (' .. url .. ')')
    return
  end

  local video_title = ytdlp.ytdlp_get_property_synchr(url, 'title')
  local video_uploader = ytdlp.ytdlp_get_property_synchr(url, 'uploader')
  local file_base_name = 'yt ' .. helper.sanitize_str(video_uploader) .. ' ' .. helper.sanitize_str(video_title) .. '.md'

  vim.cmd('edit ' .. vim.fs.joinpath(dirs.vault_root, file_base_name))

  --HACK: putting the url in the clipboard again, just in case. May be redundant
  vim.fn.setreg('+', url)

  template_actions.apply_template_with_key('yt')
end

return m

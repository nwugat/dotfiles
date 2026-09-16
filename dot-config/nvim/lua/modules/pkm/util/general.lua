--utility functions

local paths = require 'modules.pkm.data.paths'

local m = {}

m.current_buffer_is_md = function()
  return vim.bo.filetype == 'markdown'
end

m.fzf_search_notes = function()
  require('fzf-lua').files({
    -- fd_opts = '.md$  --type f --exclude archive/  --exclude .stversions --exclude .trash ' .. data.vault_root
    fd_opts =
        [[".md$" --type f --exclude "archive/*" --exclude ".trash/*" --exclude ".stversions/*" --exclude "*.sync-conflict*" ]] ..
        paths.vault_root,
  })
end

m.paste_img_from_clip = function()
  --TODO: get rid of helper
  local helper = require 'utils.helper'
  local image_path = vim.fs.joinpath(paths.subdirs.attachments, os.date('%Y%m%d-%H%M%S') .. '.png')
  local ok, err = pcall(function()
    helper.paste_img_from_clip(image_path)
  end)
  if ok then
    helper.insert_at_cursor('![Pasted image](' .. image_path .. ')')
  else
    vim.notify(err, vim.log.levels.WARN)
  end
end

m.get_toc = function()
  if not m.current_buffer_is_md() then
    vim.notify('Current buffer is not a Markdown buffer', vim.log.levels.WARN)
    return nil
  end
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local result = {}
  for i = 1, #lines do
    if string.match(lines[i], '^#+ ') then
      table.insert(result, i .. ' ' .. lines[i])
    end
  end
  return result
end

m.select_toc_fzf = function()
  local fzf_lua = require('fzf-lua')
  local opts = {
    prompt = "TOC>",
    actions = {
      ['default'] = function(selected)
        local line_number
        --HACK:
        for item in selected[1]:gmatch('%S+') do
          line_number = tonumber(item)
          break
        end
        vim.api.nvim_win_set_cursor(0, { line_number, 0 })
      end,
    }
  }
  fzf_lua.fzf_exec(m.get_toc(), opts)
end

return m

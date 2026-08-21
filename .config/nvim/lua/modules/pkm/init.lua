local vim = vim
local root_dir = vim.fn.expand("~/notes/")
local subdirs = {
  archive = 'archive/',
  scripts = '.scripts/',
  attachments = 'attachments/',
}

local templates = require('modules.pkm.templates')
local helper = require('utils.helper')

--util fns

local current_buffer_is_md = function()
  return vim.bo.filetype == 'markdown'
end

local fzf_search_notes = function()
  require('fzf-lua').files({
    fd_opts = '.md$  --type f --exclude archive/  --exclude .stversions* --exclude .trash* ' .. root_dir
  })
end

local compile_template = function(template)
  local result = {}
  for _, line in ipairs(template) do
    if type(line) == "function" then
      table.insert(result, line())
    else
      table.insert(result, line)
    end
  end
  table.insert(result, "")
  return result
end

local paste_img_from_clip = function()
  local relative_path = subdirs.attachments .. os.date('%Y%m%d-%H%M%S') .. '.png'
  local absolute_path = root_dir .. relative_path
  local ok, err = pcall(function()
    helper.paste_img_from_clip(absolute_path)
  end)
  if ok then
    helper.insert_at_cursor('![Pasted image](' .. relative_path .. ')')
  else
    vim.notify(err, vim.log.levels.WARN)
  end
end

local get_toc = function()
  if not current_buffer_is_md() then
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

local select_toc_fzf = function()
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
  fzf_lua.fzf_exec(get_toc(), opts)
end

local try_apply_template = function(template)
  --TODO: also check if template is available
  if not template then
    vim.notify("Not a valid template", vim.log.levels.WARN)
    return
  end
  vim.api.nvim_buf_set_lines(0, 0, 0, false, compile_template(templates[template]))
  print("Inserted template '" .. template .. "'")
end

--TODO:
local fzf_template = function()
  local template_keys = {}
  for k, _ in pairs(templates) do
    template_keys[#template_keys + 1] = k
  end
  table.sort(template_keys)
  local fzf_lua = require('fzf-lua')
  local opts = {
    prompt = "Templates>",
    actions = {
      ['default'] = function(selected)
        try_apply_template(selected[1])
      end
    }
  }
  fzf_lua.fzf_exec(template_keys, opts)
end

--commands

local main_cmd_name = 'Notes'
local subcommand_names = {
  new_note = "New",
  archive_note = "Archive",
  template = "Template"
}

vim.api.nvim_create_user_command(main_cmd_name, function(opts)
  local subcmd = opts.fargs[1]
  table.remove(opts.fargs, 1)
  local args = opts.fargs --just for legibility hehe

  local subcmd_case = {
    [subcommand_names.new_note] = function(_args)
      local filename = table.concat(_args, " ")
      if filename:gsub("%s+", "") == "" then
        vim.notify("Invalid file name", vim.log.levels.ERROR)
        return
      end
      --TODO check if file already exists
      local full_path = root_dir .. filename .. '.md' -- Construct full path
      vim.cmd("edit " .. full_path)                   -- Open file in new buffer
      --TODO: run additional checks on file name
    end,
    [subcommand_names.archive_note] = function(_args)
      -- vim.notify("Not implemented!", vim.log.levels.ERROR)
      local current_file = vim.api.nvim_buf_get_name(0)
      local current_file_stats = vim.loop.fs_stat(current_file)
      if not current_file:find(root_dir, 1, true) or not current_file_stats then
        vim.notify("Invalid buffer.", vim.log.levels.ERROR)
        return
      end
      vim.notify("Still not implemented! " .. current_file .. " " .. tostring(current_file_stats ~= nil),
        vim.log.levels.ERROR)
    end,
    [subcommand_names.template] = function(_args)
      local arg = table.concat(_args, "")
      try_apply_template(arg)
    end,
  }

  if subcmd_case[subcmd] then
    subcmd_case[subcmd](args)
  else
    vim.notify("Wrong subcommand (" .. subcmd .. ")", vim.log.levels.ERROR)
  end
end, {
  nargs = "*",
  complete = function(arg_lead, cmd_line, cursor_pos)
    --TODO split properly (shell-like splitting)
    local args = vim.split(cmd_line, " ", { trimempty = true })
    local subcmds = {}
    for _, v in pairs(subcommand_names) do
      table.insert(subcmds, v)
    end

    if #args == 1 then
      -- complete subcmd
      return vim.tbl_filter(function(item)
        return vim.startswith(item, arg_lead)
      end, subcmds)
    end
    if #args == 2 then
      -- complete subcmd args
      local subcmd_case = {
        [subcommand_names.new_note] = function()
          return vim.fn.getcompletion(arg_lead, "file")
        end,
        [subcommand_names.archive_note] = function()
          return vim.fn.getcompletion(arg_lead, "file")
        end,
        [subcommand_names.template] = function()
          local options = {}
          for k, _ in pairs(templates) do
            table.insert(options, k)
          end
          return options
        end,
      }
      if subcmd_case[args[2]] then
        return subcmd_case[args[2]]()
      end
    end
  end,
})

--autocmds

vim.api.nvim_create_augroup("markdown_check", { clear = true })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = "markdown_check",
  pattern = "*.md",
  callback = function()
    vim.keymap.set('n', '<CR>', vim.lsp.buf.definition)
  end,
})

--keymaps

vim.keymap.set('n', '<leader>on', ':' .. main_cmd_name .. ' ' .. subcommand_names.new_note .. ' ', { desc = 'New note' })
--HACK:
vim.keymap.set('n', '<leader>oN', function()
    vim.fn.feedkeys(':' .. main_cmd_name .. ' ' .. subcommand_names.new_note .. ' ' .. (function()
      math.randomseed(os.time())
      print(os.time())
      return require('utils.helper').rand_id()
    end)())
  end,
  { desc = 'New note w/ random ID prefix' })
vim.keymap.set('n', '<leader>os', fzf_search_notes, { desc = "[S]earch notes" })
vim.keymap.set('n', '<leader>og', ':FzfLua grep_project cwd=' .. root_dir .. '<CR>', { desc = "[G]rep notes" }) --TODO: make this search only .md files
vim.keymap.set('n', '<leader>oi', paste_img_from_clip, { desc = 'Paste copied [I]mage' })
vim.keymap.set('n', '<leader>oc', select_toc_fzf, { desc = 'TO[C]' })
vim.keymap.set('n', '<leader>ot', fzf_template, { desc = '[T]emplates' })
--TODO:
-- vim.keymap.set('n', '<leader>ot', ':Obsidian tags<CR>', { desc = 'Browse [T]ags' })
-- vim.keymap.set('n', '<leader>ob', ':Obsidian backlinks<CR>', { desc = 'Show [B]acklinks' })
-- vim.keymap.set('n', '<leader>ol', ':Obsidian links<CR>', { desc = 'Show [L]inks' })
-- vim.keymap.set('n', '<leader>or', ':Obsidian rename<CR>', { desc = '[R]ename note' })

-- user-commands

local dirs = require('modules.pkm.data.paths')
local templates = require('modules.pkm.data.templates')
local util = require('modules.pkm.util.general')
local cmd_names = require('modules.pkm.features.commands.data_cmd_names')
local shortcuts = require('modules.pkm.features.shortcuts')
local template_actions = require('modules.pkm.features.template_actions')

vim.api.nvim_create_user_command(cmd_names.main_cmd_name, function(opts)
  local subcmd = opts.fargs[1] --subcmd name
  table.remove(opts.fargs, 1)  --remove subcmd name
  local args = opts.fargs      --str[]. just for legibility hehe

  local subcmd_case = {
    [cmd_names.subcommand_names.new_note] = function(_args)
      local filename = table.concat(_args, " ")
      if filename:gsub("%s+", "") == "" then
        vim.notify("Invalid file name", vim.log.levels.ERROR)
        return
      end
      --TODO check if file already exists
      local full_path = vim.fs.joinpath(dirs.vault_root, filename .. '.md')
      --TODO: run additional checks on file name
      vim.cmd("edit " .. full_path)
    end,
    [cmd_names.subcommand_names.archive_note] = function(_args)
      local curr_buf_path = vim.api.nvim_buf_get_name(0)

      --check if file exists
      local current_file_stats = vim.loop.fs_stat(curr_buf_path)
      if not curr_buf_path:find(dirs.vault_root, 1, true) or not current_file_stats then
        vim.notify("Invalid buffer.", vim.log.levels.ERROR)
        return
      end

      --attempt to move file
      local file_base_name = vim.fs.basename(curr_buf_path)
      --TODO: check conflicts
      local new_path = vim.fs.joinpath(dirs.subdirs.archive, file_base_name)
      local ok, err = vim.uv.fs_rename(curr_buf_path, new_path)
      if not ok then
        vim.notify('Could not archive note. ' .. err, vim.log.levels.ERROR)
      end
    end,
    [cmd_names.subcommand_names.template] = function(_args)
      --single argument
      local arg = table.concat(_args, "")
      template_actions.apply_template_with_key(arg)
    end,
    [cmd_names.subcommand_names.shortcut] = function(_args)
      --single argument
      local arg = table.concat(_args, "")
      if shortcuts[arg] ~= nil then
        shortcuts[arg]()
      else
        vim.notify('Unknown action "' .. arg .. '"', vim.log.levels.ERROR)
      end
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
    for _, v in pairs(cmd_names.subcommand_names) do
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
        [cmd_names.subcommand_names.new_note] = function()
          return vim.fn.getcompletion(arg_lead, "file")
        end,
        [cmd_names.subcommand_names.archive_note] = function()
          return vim.fn.getcompletion(arg_lead, "file")
        end,
        [cmd_names.subcommand_names.template] = function()
          local options = {}
          for k, _ in pairs(templates) do
            table.insert(options, k)
          end
          return options
        end,
        [cmd_names.subcommand_names.shortcut] = function()
          local options = {}
          for k, _ in pairs(shortcuts) do
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

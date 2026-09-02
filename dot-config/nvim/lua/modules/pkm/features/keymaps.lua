local util = require('modules.pkm.util.general')
local cmd_names = require('modules.pkm.features.commands.data_cmd_names')
local dirs = require('modules.pkm.data.dirs')
local template_actions = require('modules.pkm.features.template_actions')

vim.keymap.set('n', '<leader>on', '<Cmd>' .. cmd_names.main_cmd_name .. ' ' .. cmd_names.subcommand_names.new_note .. ' ',
  { desc = 'New note' })
--HACK:
vim.keymap.set('n', '<leader>oN', function()
    vim.fn.feedkeys(':' .. cmd_names.main_cmd_name .. ' ' .. cmd_names.subcommand_names.new_note .. ' ' .. (function()
      math.randomseed(os.time())
      print(os.time())
      return require('utils.helper').rand_id()
    end)())
  end,
  { desc = 'New note w/ random ID prefix' })
vim.keymap.set('n', '<leader>os', util.fzf_search_notes, { desc = "[S]earch notes" })
vim.keymap.set('n', '<leader>og', '<Cmd>FzfLua grep_project cwd=' .. dirs.vault_root .. '<CR>', { desc = "[G]rep notes" }) --TODO: make this search only .md files
vim.keymap.set('n', '<leader>oi', util.paste_img_from_clip, { desc = 'Paste copied [I]mage' })
vim.keymap.set('n', '<leader>oc', util.select_toc_fzf, { desc = 'TO[C]' })
vim.keymap.set('n', '<leader>ot', template_actions.fzf_template, { desc = '[T]emplates' })
--TODO:
-- vim.keymap.set('n', '<leader>ot', '<Cmd>Obsidian tags<CR>', { desc = 'Browse [T]ags' })
-- vim.keymap.set('n', '<leader>ob', '<Cmd>Obsidian backlinks<CR>', { desc = 'Show [B]acklinks' })
-- vim.keymap.set('n', '<leader>ol', '<Cmd>Obsidian links<CR>', { desc = 'Show [L]inks' })
-- vim.keymap.set('n', '<leader>or', '<Cmd>Obsidian rename<CR>', { desc = '[R]ename note' })

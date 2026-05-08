local vim = vim
local notes_dir = vim.fn.expand("~/notes/")
local archive_dir = vim.fn.expand("~/notes/archive/")
local scripts_dir = notes_dir .. ".scripts/"

local current_buffer_is_md = function()
  return vim.bo.filetype == 'markdown'
end


--commands

local command_names = {
  new_note = "NewNote",
  archive_note = "ArchiveNote",
}
vim.api.nvim_create_user_command(command_names.new_note, function(opts)
  local filename = opts.args
  local full_path = notes_dir .. filename .. '.md' -- Construct full path
  vim.cmd("edit " .. full_path)                    -- Open file in new buffer
  --TODO: run additional checks on file name
end, {
  nargs = 1,         -- requires one argument
  complete = "file", -- use file completion
})
vim.api.nvim_create_user_command(command_names.archive_note, function()
  -- vim.notify("Not implemented!", vim.log.levels.ERROR)
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_file_stats = vim.loop.fs_stat(current_file)
  if not current_file:find(notes_dir, 1, true) or not current_file_stats then
    vim.notify("Invalid buffer.", vim.log.levels.ERROR)
    return
  end
  vim.notify("Still not implemented! " .. current_file .. " " .. tostring(current_file_stats ~= nil),
    vim.log.levels.ERROR)
end, {})

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

if current_buffer_is_md() then
end
vim.keymap.set('n', '<leader>on', ':' .. command_names.new_note .. ' ', { desc = 'New note' })
vim.keymap.set('n', '<leader>oN', ':' .. command_names.new_note .. ' ' .. require('utils.helper').rand_id(),
  { desc = 'New note w/ random ID prefix' })
vim.keymap.set('n', '<leader>os', function()
  require('fzf-lua').files({
    fd_opts = '.md$  --type f --exclude archive/ ' .. notes_dir
  })
end, { desc = "Search" })
vim.keymap.set('n', '<leader>og', ':FzfLua grep_project cwd=' .. notes_dir .. '<CR>', { desc = "[G]rep notes" }) --TODO: make this search only .md files
--TODO:
-- vim.keymap.set('n', '<leader>ot', ':Obsidian tags<CR>', { desc = 'Browse [T]ags' })
-- vim.keymap.set('n', '<leader>oi', ':Obsidian paste_img<CR>', { desc = 'Paste copied [I]mage' })
-- vim.keymap.set('n', '<leader>ob', ':Obsidian backlinks<CR>', { desc = 'Show [B]acklinks' })
-- vim.keymap.set('n', '<leader>ol', ':Obsidian links<CR>', { desc = 'Show [L]inks' })
-- vim.keymap.set('n', '<leader>or', ':Obsidian rename<CR>', { desc = '[R]ename note' })
-- vim.keymap.set('n', '<leader>oc', ':Obsidian toc<CR>', { desc = 'TO[C]' })
-- local home_note_path = vim.fn.fnamemodify(opts.workspaces[1].path, ':p') .. 'index.md'
-- vim.keymap.set('n', '<leader>oh', ':e ' .. home_note_path .. '<CR>', { desc = 'Open [H]ome page' })

local vim = vim

vim.keymap.set({ 'n', 'x' }, '<leader>y', '"+y') --yank to clipboard
vim.keymap.set({ 'n', 'x' }, '<leader>p', '"+p') --paste from clipboard
vim.keymap.set('n', '<C-h>', '<C-w><C-h>')       --easier split navigation
vim.keymap.set('n', '<C-l>', '<C-w><C-l>')
vim.keymap.set('n', '<C-j>', '<C-w><C-j>')
vim.keymap.set('n', '<C-k>', '<C-w><C-k>')
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")    --move selected lines
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
vim.keymap.set('n', '<leader>e', ':Oil<CR>')    --open oil
vim.keymap.set('n', '<Esc>', ':nohlsearch<CR>') --clear search highlights

-- Toggles

vim.keymap.set('n', '<leader>tw', ':set wrap!<CR>') --toggle wrap
vim.keymap.set('n', '<leader>td', function()
  local new_config = not vim.diagnostic.config().virtual_text
  vim.diagnostic.config({ virtual_text = new_config })
end, { desc = 'Toggle diagnostic virtual_text' })
vim.keymap.set('n', '<leader>tD', function()
  local new_config = not vim.diagnostic.config().virtual_lines
  vim.diagnostic.config({ virtual_lines = new_config })
end, { desc = 'Toggle diagnostic virtual_lines' })

-- Buffer
vim.keymap.set('n', '<leader>bK', ':bufdo bd!<CR>', { desc = 'Kill all Buffers' })
vim.keymap.set('n', '<leader>bk', ':bd! <CR>', { desc = 'Kill current Buffer' })
vim.keymap.set('n', '<leader>br', ':bufdo e<CR>', { desc = 'Reload Buffer' })

-- Tab
vim.keymap.set('n', '<M-n>', ':tabnext<CR>', { desc = 'Next tab' })
vim.keymap.set('n', '<M-p>', ':tabprevious<CR>', { desc = 'Previous tab' })
vim.keymap.set('n', '<M-t>', ':tabnew<CR>', { desc = 'New tab' })
vim.keymap.set('n', '<M-q>', ':tabclose<CR>', { desc = 'Close tab' })

-- Fuzzy
vim.keymap.set('n', '<leader>sf', ':FzfLua files<CR>', { desc = 'Search files' })
vim.keymap.set('n', '<leader>sh', ':FzfLua helptags<CR>', { desc = 'Help' })
vim.keymap.set('n', '<leader>sn', ':FzfLua files cwd=~/.config/nvim<CR>', { desc = 'Nvim config' })
vim.keymap.set('n', '<leader>so', ':FzfLua files cwd=~/notes<CR>', { desc = 'Notes' })
vim.keymap.set('n', '<leader>s.', ':FzfLua oldfiles<CR>', { desc = 'Recent files' })
vim.keymap.set('n', '<leader>s,', ':FzfLua resume<CR>', { desc = 'Resume' })
vim.keymap.set('n', '<leader>sb', ':FzfLua buffers<CR>', { desc = 'Buffers' })
vim.keymap.set('n', '<leader>sg', ':FzfLua grep<CR>', { desc = 'Grep' })
vim.keymap.set('n', '<leader>sG', ':FzfLua git_files<CR>', { desc = 'Git files' })
vim.keymap.set('n', '<leader>sp', ':FzfLua grep_project<CR>', { desc = 'Grep project' })
vim.keymap.set('n', '<leader>s/', ':FzfLua builtin<CR>', { desc = 'FzfLua builtin pickers' })

-- Quick inserts
local helper = require('utils.helper')
vim.keymap.set('n', '<leader>id', function() helper.insert_at_cursor(os.date('%Y-%m-%d')) end, { desc = 'Date' })
vim.keymap.set('n', '<leader>iD', function() helper.insert_at_cursor(os.date('%Y-%m-%d-%H:%M')) end,
  { desc = 'Date time' })
-- vim.keymap.set('n', '<leader>ib', function() helper.insert_at_cursor(vim.fn.expand('%')) end, { desc = 'Buffer name' })
vim.keymap.set('n', '<leader>ad', function() helper.append_at_cursor(os.date('%Y-%m-%d')) end, { desc = 'Date' })
vim.keymap.set('n', '<leader>aD', function() helper.append_at_cursor(os.date('%Y-%m-%d-%H:%M')) end,
  { desc = 'Date time' })

-- Yanks
--vim.keymap.set('n', '<leader>Yr', function() vim.fn.setreg('"', helper.rand_id(8)) end, { desc = 'Random ID' })
--vim.keymap.set('n', '<leader>Cr', function() vim.fn.setreg('+', helper.rand_id(8)) end, { desc = 'Random ID' })
--vim.keymap.set('n', '<leader>Yp', function() vim.fn.setreg('"', vim.fn.expand('%:p')) end, { desc = 'Current file path' })
--vim.keymap.set('n', '<leader>Cp', function() vim.fn.setreg('+', vim.fn.expand('%:p')) end, { desc = 'Current file path' })

-- Session (broken on non-Linux)
--vim.keymap.set('n', '<leader>Sw', ':mksession /tmp/last-neovim-session.vim<CR>', { desc = 'Save session as last' })
--vim.keymap.set('n', '<leader>Sq', ':mksession /tmp/restart-session.vim|wa|qa!<CR>', { desc = 'Save session as restart' })
--vim.keymap.set('n', '<leader>SW', ':mksession ./session.vim<CR>', { desc = 'Save session here' })
--vim.keymap.set('n', '<leader>Se', ':source /tmp/last-neovim-session.vim<CR>', { desc = 'Restore last session' })
--vim.keymap.set('n', '<leader>SE', ':source ./session.vim<CR>', { desc = 'Restore CWD session' })

--GUI/Neovide
if vim.g.neovide then
  vim.api.nvim_set_keymap("n", "<C-+>", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>",
    { silent = true })
  vim.api.nvim_set_keymap("n", "<C-->", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>",
    { silent = true })
  vim.api.nvim_set_keymap("n", "<C-0>", ":lua vim.g.neovide_scale_factor = 1<CR>", { silent = true })
  vim.api.nvim_set_keymap("n", "<C-S-c>", '"+y', { silent = true })
  vim.api.nvim_set_keymap("n", "<C-S-v>", '"+p', { silent = true })
end

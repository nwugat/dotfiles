local map = function(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { desc = desc })
end

-- yank/paste from clip
map({ 'n', 'x' }, '<leader>y', '"+y')
map({ 'n', 'x' }, '<leader>p', '"+p')

-- easier split navigation
map('n', '<C-h>', '<C-w><C-h>')
map('n', '<C-l>', '<C-w><C-l>')
map('n', '<C-j>', '<C-w><C-j>')
map('n', '<C-k>', '<C-w><C-k>')

-- easier split resize
map('n', '<C-Up>', '<C-W>+', 'Increase height')
map('n', '<C-Down>', '<C-W>-', 'Decrease height')
map('n', '<C-Left>', '<C-W><', 'Decrease width')
map('n', '<C-Right>', '<C-W>>', 'Increase width')

-- move selected lines
map('v', 'J', ":m '>+1<CR>gv=gv")
map('v', 'K', ":m '<-2<CR>gv=gv")

-- open oil
map('n', '<leader>e', ':Oil<CR>')

-- clear search highlights
map('n', '<Esc>', ':nohlsearch<CR>')

-- Toggles
map('n', '<leader>tw', ':set wrap!<CR>') --toggle wrap
map('n', '<leader>td', function()
  local new_config = not vim.diagnostic.config().virtual_text
  vim.diagnostic.config({ virtual_text = new_config })
end, { desc = 'Toggle diagnostic virtual_text' })
map('n', '<leader>tD', function()
  local new_config = not vim.diagnostic.config().virtual_lines
  vim.diagnostic.config({ virtual_lines = new_config })
end, { desc = 'Toggle diagnostic virtual_lines' })

-- Buffer
map('n', '<leader>bK', ':bufdo bd!<CR>', { desc = 'Kill all Buffers' })
map('n', '<leader>bk', ':bd! <CR>', { desc = 'Kill current Buffer' })
map('n', '<leader>br', ':bufdo e<CR>', { desc = 'Reload Buffer' })

-- Tab
map('n', '<M-n>', ':tabnext<CR>', { desc = 'Next tab' })
map('n', '<M-p>', ':tabprevious<CR>', { desc = 'Previous tab' })
map('n', '<M-t>', ':tabnew<CR>', { desc = 'New tab' })
map('n', '<M-q>', ':tabclose<CR>', { desc = 'Close tab' })

-- Fuzzy
map('n', '<leader>sf', ':FzfLua files<CR>', { desc = 'Search files' })
map('n', '<leader>sh', ':FzfLua helptags<CR>', { desc = 'Help' })
map('n', '<leader>sn', ':FzfLua files cwd=~/.config/nvim<CR>', { desc = 'Nvim config' })
map('n', '<leader>so', ':FzfLua files cwd=~/notes<CR>', { desc = 'Notes' })
map('n', '<leader>s.', ':FzfLua oldfiles<CR>', { desc = 'Recent files' })
map('n', '<leader>s,', ':FzfLua resume<CR>', { desc = 'Resume' })
map('n', '<leader>sb', ':FzfLua buffers<CR>', { desc = 'Buffers' })
map('n', '<leader>sg', ':FzfLua grep<CR>', { desc = 'Grep' })
map('n', '<leader>sG', ':FzfLua git_files<CR>', { desc = 'Git files' })
map('n', '<leader>sp', ':FzfLua grep_project<CR>', { desc = 'Grep project' })
map('n', '<leader>s/', ':FzfLua builtin<CR>', { desc = 'FzfLua builtin pickers' })

-- Quick inserts
local helper = require('utils.helper')
map('n', '<leader>id', function() helper.insert_at_cursor(os.date('%Y-%m-%d')) end, { desc = 'Date' })
map('n', '<leader>iD', function() helper.insert_at_cursor(os.date('%Y-%m-%d-%H:%M')) end,
  { desc = 'Date time' })
-- map('n', '<leader>ib', function() helper.insert_at_cursor(vim.fn.expand('%')) end, { desc = 'Buffer name' })
map('n', '<leader>ad', function() helper.append_at_cursor(os.date('%Y-%m-%d')) end, { desc = 'Date' })
map('n', '<leader>aD', function() helper.append_at_cursor(os.date('%Y-%m-%d-%H:%M')) end,
  { desc = 'Date time' })

-- Yanks
--map('n', '<leader>Yr', function() vim.fn.setreg('"', helper.rand_id(8)) end, { desc = 'Random ID' })
--map('n', '<leader>Cr', function() vim.fn.setreg('+', helper.rand_id(8)) end, { desc = 'Random ID' })
--map('n', '<leader>Yp', function() vim.fn.setreg('"', vim.fn.expand('%:p')) end, { desc = 'Current file path' })
--map('n', '<leader>Cp', function() vim.fn.setreg('+', vim.fn.expand('%:p')) end, { desc = 'Current file path' })

-- Session (broken on non-Linux)
--map('n', '<leader>Sw', ':mksession /tmp/last-neovim-session.vim<CR>', { desc = 'Save session as last' })
--map('n', '<leader>Sq', ':mksession /tmp/restart-session.vim|wa|qa!<CR>', { desc = 'Save session as restart' })
--map('n', '<leader>SW', ':mksession ./session.vim<CR>', { desc = 'Save session here' })
--map('n', '<leader>Se', ':source /tmp/last-neovim-session.vim<CR>', { desc = 'Restore last session' })
--map('n', '<leader>SE', ':source ./session.vim<CR>', { desc = 'Restore CWD session' })

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

-- Toggle center buffer
map('n', '<leader>c', ':NoNeckPain<CR>', { desc = '[C]enter current buffer' })

vim.pack.add({
  'https://github.com/ibhagwan/fzf-lua',
})

require('fzf-lua').setup {
  border = "thicc",
  backdrop = 0,
  preview = {
    winopts = {
      border = "thicc"
    },
  },
}

local map = function(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { desc = desc or '' })
end
map('n', '<leader>sf', ':FzfLua files<CR>', '[F]iles')
map('n', '<leader>sh', ':FzfLua helptags<CR>', '[H]elp')
map('n', '<leader>sn', ':FzfLua files cwd=~/.config/nvim<CR>', '[N]vim config')
map('n', '<leader>so', ':FzfLua files cwd=~/notes<CR>', '[N]otes')
map('n', '<leader>s.', ':FzfLua oldfiles<CR>', 'Recent files')
map('n', '<leader>s,', ':FzfLua resume<CR>', 'Resume')
map('n', '<leader>sb', ':FzfLua buffers<CR>', '[B]uffers')
map('n', '<leader>sg', ':FzfLua grep_project<CR>', '[G]rep project')
map('n', '<leader>sG', ':FzfLua git_files<CR>', '[G]it files')
map('n', '<leader>s/', ':FzfLua builtin<CR>', 'FzfLua builtin pickers')

vim.opt.cursorline = false --highlight cursor Y position

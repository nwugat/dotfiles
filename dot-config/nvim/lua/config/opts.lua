local vim = vim
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.guicursor = ''       --fat cursor always
vim.opt.mouse = 'a'          --enable mouse support. Useful for resizing splits
vim.opt.undofile = true      --save undo history
vim.opt.smartcase = true     --smart case for cmd suggestions
vim.opt.ignorecase = true    --case-insensitive search unless \C or one or more capital letters in the search term
vim.opt.signcolumn = 'yes'   --always show sign column
vim.opt.updatetime = 250     --decrease update time
vim.opt.timeoutlen = 200     --decrease mapped sequence wait time. Displays which-key popup sooner
vim.opt.splitright = true    --open new hsplits to the right
vim.opt.splitbelow = true    --open new vsplits below
vim.opt.inccommand = 'split' --preview substitutions live, as you type
vim.opt.cursorline = true    --highlight cursor Y position
vim.opt.scrolloff = 10       --cursor vertical scroll offset
vim.opt.conceallevel = 1     --???
vim.opt.tabstop = 2          --tab size
vim.opt.shiftwidth = 2       --space tab size
vim.opt.expandtab = true     --use space tab
vim.opt.title = true         --show title bar
vim.g.mapleader = " "
-- Sets how nvim will display certain whitespace characters
vim.opt.list = true
vim.opt.listchars = {
  tab = '» ',
  --tab = '  ', --so it doesn't conflict with the indent blank line plugin
  trail = '·',
  nbsp = '␣',
}
vim.opt.winborder = "rounded"
vim.opt.spell = false              --spellchecker off
vim.opt.spelllang = { "en", "es" } --spellchecker languages

-- Justify
vim.cmd [[packadd justify]]
vim.schedule(function()
  for _, mode in ipairs({ 'n', 'i', 'v', 'x', 't' }) do
    pcall(vim.keymap.del, mode, '_j')
    pcall(vim.keymap.del, mode, ',gq')
  end
end)
vim.keymap.set({ 'n', 'x' }, '<leader>j', ':Justify<CR>', { desc = 'Justify' })

--GUI
if vim.g.neovide then
  vim.g.neovide_scale_factor = 0.7
end

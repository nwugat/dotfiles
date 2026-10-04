local map = function(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { desc = desc or "" })
end

-- yank/paste from clip
map({ "n", "x" }, "<leader>y", '"+y', "[Y]ank clipboard")
map({ "n", "x" }, "<leader>p", '"+p', "[P]aste clipboard")

-- easier split navigation
map("n", "<C-h>", "<C-w><C-h>")
map("n", "<C-l>", "<C-w><C-l>")
map("n", "<C-j>", "<C-w><C-j>")
map("n", "<C-k>", "<C-w><C-k>")

-- easier split resize
map("n", "<C-Up>", "<C-W>+")
map("n", "<C-Down>", "<C-W>-")
map("n", "<C-Left>", "<C-W><")
map("n", "<C-Right>", "<C-W>>")

-- move selected lines
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- clear search highlights
map("n", "<Esc>", ":nohlsearch<CR>")

-- Toggle word wrap
map("n", "<leader>w", ":set wrap!<CR>", "Toggle [W]rap") --toggle wrap

-- Toggle diagnostics
-- map('n', '<leader>td', function()
--   local new_config = not vim.diagnostic.config().virtual_text
--   vim.diagnostic.config({ virtual_text = new_config })
-- end, 'Toggle diagnostic virtual_text')
-- map('n', '<leader>tD', function()
--   local new_config = not vim.diagnostic.config().virtual_lines
--   vim.diagnostic.config({ virtual_lines = new_config })
-- end, 'Toggle diagnostic virtual_lines')

-- Buffer
map("n", "<leader>bK", ":bufdo bd!<CR>", "Kill all Buffers")
map("n", "<leader>bk", ":bd! <CR>", "Kill current Buffer")
map("n", "<leader>br", ":bufdo e<CR>", "Reload Buffer")

-- Tab
map("n", "<M-n>", ":tabnext<CR>", "Next tab")
map("n", "<M-p>", ":tabprevious<CR>", "Previous tab")
map("n", "<M-t>", ":tabnew<CR>", "New tab")
map("n", "<M-q>", ":tabclose<CR>", "Close tab")

-- Quick inserts
local helper = require("utils.helper")
map("n", "<leader>id", function()
  helper.insert_at_cursor(os.date("%Y-%m-%d"))
end, "Date")
map("n", "<leader>iD", function()
  helper.insert_at_cursor(os.date("%Y-%m-%d-%H:%M"))
end, "Date time")
-- map('n', '<leader>ib', function() helper.insert_at_cursor(vim.fn.expand('%')) end, 'Buffer name' )
map("n", "<leader>ad", function()
  helper.append_at_cursor(os.date("%Y-%m-%d"))
end, "Date")
map("n", "<leader>aD", function()
  helper.append_at_cursor(os.date("%Y-%m-%d-%H:%M"))
end, "Date time")

-- GUI/Neovide
if vim.g.neovide then
  vim.api.nvim_set_keymap(
    "n",
    "<C-+>",
    ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>",
    { silent = true }
  )
  vim.api.nvim_set_keymap(
    "n",
    "<C-->",
    ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>",
    { silent = true }
  )
  vim.api.nvim_set_keymap("n", "<C-0>", ":lua vim.g.neovide_scale_factor = 1<CR>", { silent = true })
  vim.api.nvim_set_keymap("n", "<C-S-c>", '"+y', { silent = true })
  vim.api.nvim_set_keymap("n", "<C-S-v>", '"+p', { silent = true })
end

-- Default height for term splits
local term_height_str = "10"

-- Open terminal split
map("n", "<leader>t", function()
  -- find a term buf
  local a_term_buf = nil
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buftype == "terminal" then
      a_term_buf = buf
      break
    end
  end
  -- if no term buf found, create one
  if not a_term_buf then
    vim.cmd(term_height_str .. "split")
    vim.cmd([[terminal]])
    vim.cmd([[startinsert]])
    vim.notify("Created new terminal split", vim.log.levels.INFO)
    return
  end
  -- if term buf found, find and focus window that has it, else create one
  local term_buf_win = nil
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local win_buf = vim.api.nvim_win_get_buf(win)
    if vim.api.nvim_win_is_valid(win) then
      if win_buf == a_term_buf then
        term_buf_win = win
        break
      end
    end
  end
  if term_buf_win then
    vim.api.nvim_set_current_win(term_buf_win)
    vim.cmd([[startinsert]])
    vim.notify("Focused existing terminal split", vim.log.levels.INFO)
  else
    vim.cmd(term_height_str .. "split")
    local new_split = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(new_split, a_term_buf)
    vim.cmd([[startinsert]])
    vim.notify("Created new split for existing terminal buffer", vim.log.levels.INFO)
  end
end, "[T]erm hsplit")

-- Force new term split
map("n", "<leader>T", function()
  vim.cmd(term_height_str .. "split")
  vim.cmd([[terminal]])
  vim.cmd([[startinsert]])
  vim.notify("Created new terminal split", vim.log.levels.INFO)
end, "Force [T]erm hsplit")

-- Toggle wrap
map("n", "<leader>uw", "<Cmd>set wrap!<CR>", "Toggle [W]rap")

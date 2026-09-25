local _, ok = pcall(require, "love2d")
if not ok then return false end

local maps = {
  {
    mode = 'n',
    keys = '<leader>Lr',
    action = '<Cmd>Love run<CR>',
    desc = '[R]un project'
  },
  {
    mode = 'n',
    keys = '<leader>Lo',
    action = '<Cmd>Love output<CR>',
    desc = 'Toggle [O]utput'
  },
  {
    mode = 'n',
    keys = '<leader>Lw',
    action = '<Cmd>Love watch<CR>',
    desc = '[W]atch project'
  },
}

vim.api.nvim_create_autocmd("User", {
  pattern = "LoveProjectEnter",
  callback = function()
    for _, map in pairs(maps) do
      vim.keymap.set(map.mode, map.keys, map.action, { desc = map.desc })
    end
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "LoveProjectLeave",
  callback = function()
    for _, map in pairs(maps) do
      vim.keymap.del(map.mode, map.keys)
    end
  end,
})

return true

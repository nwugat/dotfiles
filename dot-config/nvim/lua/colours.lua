vim.pack.add({
  -- { src = 'https://github.com/catppuccin/nvim',           name = 'catppuccin' },
  -- { src = 'https://github.com/rose-pine/neovim',          name = 'rose-pine' },
  -- { src = 'https://github.com/rebelot/kanagawa.nvim',     name = 'kanagawa' },
  -- { src = 'https://github.com/rezniqov/soviet.nvim',      name = 'soviet' },
  -- { src = 'https://github.com/ellisonleao/gruvbox.nvim',  name = 'gruvbox' },
  -- { src = 'https://github.com/xero/miasma.nvim',          name = 'miasma' },
  -- { src = 'https://github.com/navarasu/onedark.nvim',     name = 'onedark' },
  { src = 'https://github.com/bluz71/vim-moonfly-colors', name = 'moonfly' },
})

--favourite colourschemes
local use_theme = {
  catppuccin = function()
    vim.cmd [[colorscheme catppuccin-mocha ]]
  end,
  rose = function()
    vim.cmd [[colorscheme rose-pine-main ]]
  end,
  kanagawa = function()
    vim.cmd [[colorscheme kanagawa-dragon ]]
  end,
  soviet = function()
    vim.cmd [[colorscheme soviet-dark ]]
  end,
  gruvbox = function()
    vim.cmd [[colorscheme gruvbox ]]
  end,
  miasma = function()
    vim.cmd [[colorscheme miasma ]]
  end,
  onedark = function()
    require('onedark').setup {
      style = 'warmer'
    }
    require('onedark').load()
    vim.cmd [[colorscheme onedark ]]
  end,
  moonfly = function()
    vim.cmd [[colorscheme moonfly ]]
  end,
}

use_theme.moonfly()

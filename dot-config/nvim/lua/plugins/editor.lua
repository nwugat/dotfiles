-- Editor utilities

vim.pack.add({
  "https://github.com/windwp/nvim-autopairs",
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/lukas-reineke/indent-blankline.nvim",
  "https://github.com/folke/todo-comments.nvim",
  "https://github.com/nvim-treesitter/nvim-treesitter",
  -- latex support
  { src = "https://github.com/lervag/vimtex", version = "v2.15" },
  "https://github.com/micangl/cmp-vimtex",
})

require("nvim-autopairs").setup({})

require("gitsigns").setup({
  current_line_blame = true,
})

--indent-blankline
require("ibl").setup({})

require("todo-comments").setup({ signs = false })

-- vimtex
local helper = require("utils.helper")
if helper.platform_is_lin() then
  local session = helper.get_linux_session()
  if session == "tty" then
    return
  end
  if vim.fn.executable("zathura") then
    vim.g.vimtex_view_general_viewer = "zathura"
    -- vim.g.vimtex_view_general_options = [[--synctex-forward @line:@tex @pdf]]
  elseif session == "kde" and vim.fn.executable("okular") then
    vim.g.vimtex_view_general_viewer = "okular"
    vim.g.vimtex_view_general_options = [[--unique file:@pdf\#src:@line@tex]]
  elseif session == "gnome" and vim.fn.executable("papers") then
    vim.g.vimtex_view_general_viewer = "papers"
    -- vim.g.vimtex_view_general_options = [[--unique file:@pdf\#src:@line@tex]]
  end
end
if vim.fn.executable("latexmk") then
  vim.g.vimtex_compiler_method = "latexmk"
  vim.g.vimtex_compiler_latexmk = {
    options = {
      "-pdf",
      "-interaction=nonstopmode",
      "-synctex=1",
    },
  }
else
  vim.notify("Vimtex: latexmk not found", vim.log.levels.ERROR)
end

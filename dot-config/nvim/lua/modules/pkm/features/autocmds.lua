vim.api.nvim_create_augroup("markdown_check", { clear = true })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = "markdown_check",
  pattern = "*.md",
  callback = function()
    vim.keymap.set('n', '<CR>', vim.lsp.buf.definition)
  end,
})

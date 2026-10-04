vim.pack.add({
  -- completion engine
  { src = 'https://github.com/Saghen/blink.cmp', name = 'blink',                    version = vim.version.range('v1.*') },
  'https://github.com/Saghen/blink.compat',
  -- snippets
  { src = 'https://github.com/L3MON4D3/LuaSnip', version = vim.version.range('2.x') },
  -- nvim  config completions
  'https://github.com/folke/lazydev.nvim',
})

require('lazydev').setup {
  library = {
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
  },
}

-- blink
require('blink.cmp').setup {
  fuzzy = {
    implementation = 'lua',
  },
  sources = {
    default = { "lazydev", "lsp", "path", "snippets", "buffer", "vimtex" },
    providers = {
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        -- make lazydev completions top priority (see `:h blink.cmp`)
        score_offset = 100,
      },
      vimtex = {
        name = "vimtex",
        min_keyword_length = 1,
        module = "blink.compat.source",
        score_offset = 80,
      },
    },
  },
}

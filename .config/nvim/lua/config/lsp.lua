local vim = vim

--Enable with default config
vim.lsp.enable({
  'lua_ls',
  'gdscript',
  'pyright',
  'bashls',
  'rust_analyzer',
  'perlnavigator',
})

local capabilities = require('blink.cmp').get_lsp_capabilities()
vim.lsp.config('*', {
  capabilities = capabilities,
})

vim.diagnostic.config({
  virtual_text = true,
})

--Markdown-oxide
vim.lsp.config('markdown_oxide', {
  -- Ensure that dynamicRegistration is enabled! This allows the LS to take into account actions like the
  -- Create Unresolved File code action, resolving completions for unindexed code blocks, ...
  capabilities = vim.tbl_deep_extend(
    'force',
    capabilities,
    {
      workspace = {
        didChangeWatchedFiles = {
          dynamicRegistration = true,
        },
      },
    }
  ),
})
vim.lsp.enable('markdown_oxide')

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    if not client then
      return
    end

    local map = function(keys, action, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, action, { desc = desc })
    end

    if client:supports_method('textDocument/implementation') then
      -- Create a keymap for vim.lsp.buf.implementation ...
    end

    local fzflua = require('fzf-lua')

    -- Keymaps
    map('grr', fzflua.lsp_references, 'LSP references')
    map('<leader>ls', fzflua.lsp_document_symbols, 'Document symbols')
    -- map('<leader>lS', fzflua.lsp_workspace_symbols, 'Workspace symbols')
    map('<leader>lS', vim.lsp.buf.workspace_symbol, 'Workspace symbols')
    map('<leader>lh', vim.diagnostic.open_float, 'Hover diagnostic')
    map('<leader>ld', fzflua.lsp_document_diagnostics, 'Hover diagnostic')

    -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
    if client:supports_method('textDocument/completion') then
      -- Optional: trigger autocompletion on EVERY keypress. May be slow!
      -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
      -- client.server_capabilities.completionProvider.triggerCharacters = chars
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = false })
    end

    -- Auto-format ("lint") on save.
    -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
    if not client:supports_method('textDocument/willSaveWaitUntil')
        and client:supports_method('textDocument/formatting') then
      local format = function()
        vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
      end
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
        buffer = args.buf,
        callback = format
      })
      map('<leader>bf', format, '[F]ormat buffer')
    end

    -- Symbol highlight
    if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
      local highlight_augroup = vim.api.nvim_create_augroup('nwugat-lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = args.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = args.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })
      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('nwugat-lsp-detach', { clear = true }),
        callback = function(event)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'nwugat-lsp-highlight', buffer = event.buf }
        end,
      })
    end
  end,
})

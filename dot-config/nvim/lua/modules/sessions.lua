-- Simple session management

local session_autosave_name = 'session.vim'
local restart_session_name = 'restart-session.vim'

--fns

local function setup_restart_and_quit()
  vim.cmd('mksession! /tmp/' .. restart_session_name)
  vim.cmd('quitall!')
end

--autocmds

--TODO: save session on quit

--detect and restore session.vim under cwd
vim.api.nvim_create_autocmd({ "DirChanged", "VimEnter" }, {
  callback = function()
    vim.schedule(function()
      local cwd = vim.fn.getcwd()
      if vim.uv.fs_stat(cwd .. '/' .. session_autosave_name) then
        vim.cmd(':source ./' .. session_autosave_name)
        print('Saved session restored.')
      end
    end
    )
  end,
})

--re-open buffers so lsp works as intended
vim.api.nvim_create_autocmd('SessionLoadPost', {
  callback = function()
    vim.schedule(function()
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted then
          vim.api.nvim_buf_call(buf, function()
            vim.cmd('edit %')
          end)
        end
      end
    end
    )
  end,
})

--check if there's any restart session to restore at cwd
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.uv.fs_stat('/tmp/' .. restart_session_name) then
      vim.cmd(':source /tmp/' .. restart_session_name)
      vim.fn.delete('/tmp/' .. restart_session_name)
      print('Restart session restored')
    end
  end,
})

--keybinds

--restart with session restore
vim.keymap.set('n', '<leader>R', setup_restart_and_quit, { desc = 'Setup restart and quit' })

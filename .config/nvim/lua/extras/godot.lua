local vim = vim

--detect godot project root marker
vim.api.nvim_create_autocmd({"DirChanged", "VimEnter"}, {
  callback = function()
    local cwd = vim.fn.getcwd()
    if vim.uv.fs_stat(cwd..'/project.godot') and not vim.uv.fs_stat(cwd..'/server.pipe') then
      -- Start listening remote control pipe file in gd project
      -- vim.fn.serverstart(cwd..'/server.pipe')
      vim.fn.serverstart('/tmp/godot.pipe')
      -- Re-set file picker file marker
      vim.keymap.set('n', '<leader>sf', function()require('fzf-lua').files({
        fd_opts = [[ --type f --hidden --exclude '.git/*' --exclude .git --exclude .godot --exclude .editorconfig --exclude .cache --exclude '*.import' --exclude '*.translation' --exclude '*.uid' --exclude '*/android/*' --exclude '*.tres' --exclude '*.tscn' --exclude '*.svg' --exclude '*.png' --exclude '*.jpg' --exclude '*.jpeg' --exclude '*.ogg' --exclude '*.mp3' ]]
      })end)
      -- print('project.godot detected')
    end
  end,
})

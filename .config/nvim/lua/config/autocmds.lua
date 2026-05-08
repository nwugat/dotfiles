local vim = vim

--highlight yank
vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight yanked text',
	group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

--line length limit marker
vim.cmd [[autocmd FileType markdown setlocal colorcolumn=80]]

-- close nvim-tree if it's last buffer open
-- vim.api.nvim_create_autocmd("BufEnter", {
-- 	pattern = "*",
-- 	callback = function()
-- 		if #vim.api.nvim_list_bufs() == 1 and vim.bo.filetype == "NvimTree" then
-- 	vim.cmd("quit")
-- 	end
-- 	end,
-- })

-- spellcheck in md
-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = "markdown",
-- 	command = "setlocal spell",
-- })

--disable automatic comment on newline
vim.api.nvim_create_autocmd("FileType", {
		pattern = "*",
		callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
		end,
})

--detect and restore session.vim under cwd
vim.api.nvim_create_autocmd({"DirChanged", "VimEnter"}, {
  callback = function()
    local cwd = vim.fn.getcwd()
    if vim.uv.fs_stat(cwd..'/session.vim') then
      vim.cmd(':source ./session.vim')
      print('Saved session restored.')
    end
  end,
})

--check if there's any restart session to restore at cwd
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.uv.fs_stat('/tmp/restart-session.vim') then
      vim.cmd ':source /tmp/restart-session.vim | !rm /tmp/restart-session.vim'
    end
  end,
})

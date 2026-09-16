local m = {}

m.vault_root = vim.fn.expand("~/notes/")

m.subdirs = {}
m.subdirs.archive = vim.fs.joinpath(m.vault_root, 'archive/')
m.subdirs.scripts = vim.fs.joinpath(m.vault_root, '.scripts/')
m.subdirs.attachments = vim.fs.joinpath(m.vault_root, 'attachments/')

return m

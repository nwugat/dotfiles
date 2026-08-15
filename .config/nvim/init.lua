--general
require('plug') --plugin defs
require('config.opts')
require('config.keymaps')
require('config.autocmds')
require('config.lsp') --lsp configs
--use-case specific
require('modules.godot')
require('modules.pkm')
--theme
vim.cmd [[colorscheme catppuccin-mocha]]

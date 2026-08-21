--general
require('plug') --plugin defs
require('config.opts')
require('config.keymaps')
require('config.autocmds')
require('config.lsp') --lsp configs
--use-case specific
require('modules.godot')
require('modules.pkm')
require('modules.sessions')
--theme
vim.cmd [[colorscheme catppuccin-mocha]]

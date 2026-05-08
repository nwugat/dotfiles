--general
require('plug')       --plugin defs
require('config.opts')
require('config.keymaps')
require('config.autocmds')
require('config.lsp') --lsp configs
--use-case specific
require('extras.godot')
require('extras.pkm')
--theme
vim.cmd [[colorscheme catppuccin-mocha]]

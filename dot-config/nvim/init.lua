--general
require('plug') --plugin defs
require('config.opts')
require('config.keymaps')
require('config.autocmds')
require('config.lsp')
require('colours')
--use-case specific
require('modules.godot')
require('modules.pkm')
require('modules.sessions')

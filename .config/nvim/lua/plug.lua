local vim = vim

-- Auto install vim-plug and plugins, if not found
local data_dir = vim.fn.stdpath('data')
if vim.fn.empty(vim.fn.glob(data_dir .. '/site/autoload/plug.vim')) == 1 then
  vim.cmd('silent !curl -fLo ' ..
    data_dir ..
    '/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
  vim.o.runtimepath = vim.o.runtimepath
  vim.cmd('autocmd VimEnter * PlugInstall --sync | source $MYVIMRC')
end

local Plug = function(plugin_name, alias)
  if alias then
    vim.fn['plug#'](plugin_name, { ['as'] = alias })
  else
    vim.fn['plug#'](plugin_name)
  end
end

vim.call('plug#begin')

Plug('ibhagwan/fzf-lua')                                             -- Fuzzy finder
Plug('catppuccin/nvim', 'catppuccin')                                -- Colorscheme
Plug('folke/which-key.nvim')                                         -- Mappings popup
Plug('nvim-treesitter/nvim-treesitter')                              -- Improved syntax
Plug('windwp/nvim-autopairs')                                        -- Autopairs
Plug('lewis6991/gitsigns.nvim')                                      -- Git
-- Plug('emmanueltouzery/decisive.nvim') -- View csv files
Plug('stevearc/oil.nvim', 'oil')                                     -- File manager
Plug('refractalize/oil-git-status.nvim', 'oil-git-status')
Plug('neovim/nvim-lspconfig', 'lspconfig')                           -- Lsp config
Plug('mason-org/mason.nvim', 'mason')                                -- Mason
Plug('MeanderingProgrammer/render-markdown.nvim', 'render-markdown') -- Render markdown inline
Plug('nvim-lua/plenary.nvim')                                        -- Dependency for obsidian and telescope
--Plug('obsidian-nvim/obsidian.nvim', 'obsidian') -- Obsidian (fork)
-- Plug('Saghen/blink.cmp', 'blink')                                    -- Autocompletion
vim.fn['plug#']('Saghen/blink.cmp', { ['as'] = 'blink', ['tag'] = 'v1.*'})                                    -- Autocompletion
-- Plug('niuiic/code-shot.nvim', 'code-shot') -- Screenshot code snippets
Plug('sphamba/smear-cursor.nvim', 'smear-cursor')                    -- Effect. Smear my cursor
-- Plug('andweeb/presence.nvim') -- Discord rich presence
Plug('nvim-tree/nvim-web-devicons')                                  -- Nerdfont devicons

vim.call('plug#end')

-- try to reach module, apply (probably) pending install if not able to
local try_setup = function(module_name, opts)
  local ok, _ = pcall(require, module_name)
  if ok then
    local module = require(module_name)
    if opts then
      module.setup(opts)
    else
      module.setup()
    end
  else
    vim.cmd(':PlugInstall')
  end
end

try_setup('fzf-lua')
try_setup('oil', {
  win_options = {
    signcolumn = 'yes:2',
  }
})
try_setup('oil-git-status')
try_setup('nvim-autopairs')
try_setup('mason')
try_setup('blink.cmp', {
  fuzzy = {
    implementation = 'lua',
  },
})
-- if vim.g.neovide then
try_setup('smear_cursor', {
  stiffness = 0.8,
  trailing_stiffness = 0.5,
  distance_stop_animating = 0.5,
  smear_insert_mode = false,
  smear_between_neighbor_lines = false,
  smear_between_buffers = true,
})
-- else
-- end
try_setup('gitsigns', {
  current_line_blame = true,
})
try_setup('render-markdown', {
  heading = {
    width = 'block',
    right_pad = 1,
    min_width = 80,
  },
  dash = {
    width = 80,
    icon = '-', -- Looks better IMO
  },
  checkbox = {
    bullet = true, -- For consistency w/ markdown syntax
    right_pad = 2, -- For consistency w/ underlying text
  },
  code = {
    conceal_delimiters = false, -- Conceal nodes at the top and bottom of code blocks
    width = 'block',            -- Don't extend to screen width
    right_pad = 1,              -- Add padding of 1 col if content exceeds col 80
    min_width = 80,             -- Extend to col 80
    border = 'thin',            -- Do not conceal lines
  },
  latex = {
    -- Turn on / off latex rendering.
    enabled = false,
    -- Additional modes to render latex.
    render_modes = false,
    -- Executable used to convert latex formula to rendered unicode.
    -- If a list is provided the first command available on the system is used.
    converter = { 'utftex', 'latex2text' },
    -- Highlight for latex blocks.
    highlight = 'RenderMarkdownMath',
    -- Determines where latex formula is rendered relative to block.
    -- | above  | above latex block                               |
    -- | below  | below latex block                               |
    -- | center | centered with latex block (must be single line) |
    position = 'center',
    -- Number of empty lines above latex blocks.
    top_pad = 0,
    -- Number of empty lines below latex blocks.
    bottom_pad = 0,
  },
})
--require('plugins.obsidian') --why can't I try_setup with this????
-- try_setup('presence',{
--   blacklist = {
--     vim.fn.expand('~/notes')..'/?.*',
--   },
-- })
try_setup('nvim-web-devicons')

local helper = require "utils.helper"

vim.pack.add({

  'https://github.com/ibhagwan/fzf-lua',                                                                  -- Fuzzy finder
  'https://github.com/folke/which-key.nvim',                                                              -- Mappings popup
  'https://github.com/nvim-treesitter/nvim-treesitter',                                                   -- Improved syntax
  'https://github.com/windwp/nvim-autopairs',                                                             -- Autopairs
  'https://github.com/lewis6991/gitsigns.nvim',                                                           -- Git
  'https://github.com/emmanueltouzery/decisive.nvim',                                                     -- View csv files
  { src = 'https://github.com/stevearc/oil.nvim',                         name = 'oil' },                 -- File manager
  { src = 'https://github.com/refractalize/oil-git-status.nvim',          name = 'oil-git-status' },      --
  { src = 'https://github.com/neovim/nvim-lspconfig',                     name = 'lspconfig' },           -- Lsp config
  { src = 'https://github.com/mason-org/mason.nvim',                      'mason' },                      -- Mason
  { src = 'https://github.com/MeanderingProgrammer/render-markdown.nvim', name = 'render-markdown' },     -- Render markdown inline
  'https://github.com/nvim-lua/plenary.nvim',                                                             -- Dependency for obsidian and telescope
  { src = 'https://github.com/obsidian-nvim/obsidian.nvim', name = 'obsidian' },                          -- Obsidian (fork)
  { src = 'https://github.com/Saghen/blink.cmp',            name = 'blink' },                             -- Autocompletion
  { src = 'https://github.com/niuiic/code-shot.nvim',       name = 'code-shot' },                         -- Screenshot code snippets
  { src = 'https://github.com/sphamba/smear-cursor.nvim',   name = 'smear-cursor' },                      -- Effect. Smear my cursor
  'https://github.com/andweeb/presence.nvim',                                                             -- Discord rich presence
  'https://github.com/nvim-tree/nvim-web-devicons',                                                       -- Nerdfont devicons
  { src = 'https://github.com/Saghen/blink.cmp', name = 'blink',   version = vim.version.range('v1.*') }, -- Autocompletion
  'https://github.com/Saghen/blink.compat',
  'https://github.com/lukas-reineke/indent-blankline.nvim',                                               -- visual guides for indents
  -- 'https://gitlab.com/HiPhish/rainbow-delimiters.nvim'
  'https://github.com/folke/todo-comments.nvim',
  -- 'https://github.com/Myzel394/easytables.nvim',
  'https://github.com/folke/lazydev.nvim',                            --automaticly sets luals up for editing nvim's config and plugins
  'https://github.com/shortcuts/no-neck-pain.nvim',                   --center current buffer
  { src = 'https://github.com/lervag/vimtex',    version = "v2.15" }, --latex support
  'https://github.com/micangl/cmp-vimtex',                            --autocompletion source for vimtex

})

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
  sources = {
    default = { "lazydev", "lsp", "path", "snippets", "buffer", "vimtex" },
    providers = {
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        -- make lazydev completions top priority (see `:h blink.cmp`)
        score_offset = 100,
      },
      vimtex = {
        name = "vimtex",
        min_keyword_length = 1,
        module = "blink.compat.source",
        score_offset = 80,
      },
    },
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
try_setup('ibl')
try_setup('rainbow-delimiters.setup')
try_setup('todo-comments', {
  highlight = {
    pattern = {
      [[.*<(KEYWORDS)\s*:]],
      [[.*<(KEYWORDS)\s* ]],
    }
  }
})
try_setup('easytables')
try_setup('lazydev', {
  library = {
    -- See the configuration section for more details
    -- Load luvit types when the `vim.uv` word is found
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
  },
})
try_setup('no-neck-pain')

-- vimtex
if helper.platform_is_lin() then
  local session = helper.get_linux_session()
  if session ~= "tty" then
    return
  end
  if vim.fn.executable("zathura") then
    vim.g.vimtex_view_general_viewer = 'zathura'
    vim.g.vimtex_view_general_options = [[--synctex-forward @line:@tex @pdf]]
  elseif session == "kde" and vim.fn.executable("okular") then
    vim.g.vimtex_view_general_viewer = 'okular'
    vim.g.vimtex_view_general_options = [[--unique file:@pdf\#src:@line@tex]]
  elseif session == "gnome" and vim.fn.executable("papers") then
    vim.g.vimtex_view_general_viewer = 'papers'
    -- vim.g.vimtex_view_general_options = [[--unique file:@pdf\#src:@line@tex]]
  end
end

if vim.fn.executable("latexmk") then
  vim.g.vimtex_compiler_method = "latexmk"
  vim.g.vimtex_compiler_latexmk = {
    options = {
      "-pdf",
      "-interaction=nonstopmode",
      "-synctex=1",
    },
  }
else
  vim.notify("Vimtex: latexmk not found", vim.log.levels.ERROR)
end

-- for some reason vimtex complains in gnome with this set to true
-- https://github.com/lervag/vimtex/issues/2944#issuecomment-2081519460
-- vim.g.vimtex_version_check = 0

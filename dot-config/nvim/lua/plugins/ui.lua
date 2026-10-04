vim.pack.add({
  -- keymap cheatsheet popup
  "https://github.com/folke/which-key.nvim",
  -- smear my cursor
  { src = "https://github.com/sphamba/smear-cursor.nvim",        name = "smear-cursor" },
  -- toggable center buffer option
  "https://github.com/shortcuts/no-neck-pain.nvim",
  -- Symbol outline sidebar
  "https://github.com/stevearc/aerial.nvim",
  -- File explorer as a buffer
  { src = "https://github.com/stevearc/oil.nvim",                name = "oil" },           -- File manager
  { src = "https://github.com/refractalize/oil-git-status.nvim", name = "oil-git-status" }, --
  -- vscode-like tree + icons
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/nvim-tree/nvim-tree.lua" },
  -- vscode-like minimap
  "https://github.com/Isrothy/neominimap.nvim",
  -- fun focus mode
  "https://github.com/RedkillTech/focus.nvim",
})

-- which-key
require("which-key").setup({
  preset = "helix",
  delay = 0,
  -- groups
  spec = {
    { "<leader>s", group = "[S]earch" },
    { "<leader>l", group = "[L]SP" },
    { "<leader>b", group = "[B]uffer" },
    { "<leader>i", group = "[I]nsert" },
    { "<leader>a", group = "[A]ppend" },
    { "<leader>o", group = "N[O]tes" },
    { "<leader>u", group = "[U]I" },
  },
  layout = {
    width = { min = 1, max = 30 }, -- min and max width of the columns
    spacing = 1,                 -- spacing between columns
  },
  icons = {
    breadcrumb = "\0", -- symbol used in the command line area that shows your active key combo
    separator = ":",
    group = "",
    mappings = false, -- disable icon between key and action
    colors = false,
    keys = {
      Up = " ",
      Down = " ",
      Left = " ",
      Right = " ",
      C = "󰘴 ",
      M = "󰘵 ",
      D = "󰘳 ",
      S = "󰘶 ",
      CR = "󰌑 ",
      Esc = "󱊷 ",
      ScrollWheelDown = "󱕐 ",
      ScrollWheelUp = "󱕑 ",
      NL = "󰌑 ",
      BS = "󰁮",
      Space = "󱁐 ",
      Tab = "󰌒 ",
      F1 = "󱊫",
      F2 = "󱊬",
      F3 = "󱊭",
      F4 = "󱊮",
      F5 = "󱊯",
      F6 = "󱊰",
      F7 = "󱊱",
      F8 = "󱊲",
      F9 = "󱊳",
      F10 = "󱊴",
      F11 = "󱊵",
      F12 = "󱊶",
    },
  },
  win = {
    no_overlap = false,
    padding = { 0, 0 },
    title = true,
  },
})

-- smearcursor
require("smear_cursor").setup({
  stiffness = 0.8,
  trailing_stiffness = 0.5,
  distance_stop_animating = 0.5,
  smear_insert_mode = false,
  smear_between_neighbor_lines = false,
  smear_between_buffers = true,
})

-- noneckpain
require("no-neck-pain").setup({})
vim.keymap.set("n", "<leader>c", ":NoNeckPain<CR>", { desc = "[C]enter buffers" })

-- aerial: LSP symbol tree
-- toggle with :AerialToggle!
require("aerial").setup({})
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
  callback = function()
    vim.keymap.set("n", "<leader>lt", "<Cmd>AerialToggle!<CR>", { desc = "Symbol [T]ree" })
  end,
})

-- oil
require("oil").setup({
  win_options = {
    signcolumn = "yes:2",
  },
})
require("oil-git-status").setup({})
vim.keymap.set("n", "<leader>e", ":Oil<CR>", { desc = "Oil/[E]xplore" })

-- nvim-tree
require("nvim-tree").setup({
  -- sort = {
  --   sorter = "case_sensitive",
  -- },
  -- view = {
  --   width = 30,
  -- },
  -- renderer = {
  --   group_empty = true,
  -- },
  filters = {
    dotfiles = true,
  },
})
vim.keymap.set("n", "<leader>ut", "<Cmd>NvimTreeToggle<CR>", { desc = "Toggle file [T]ree" })

-- neominimap
vim.g.neominimap = {
  auto_enable = false,
}
vim.keymap.set("n", "<leader>um", "<Cmd>Neominimap Toggle<CR>", { desc = "Toggle [M]inimap" })

require("focus").setup({
  mode = "scramble", -- "dim" | "scramble" | "shape" | "blocks" | "dimshape"
  region = "core",
  radius = 15,
  core = 4,
  curve = "steps",         -- "linear" | "ease" | "steps"
  floor = 0.18,            -- dimmest level, 0.0 .. 1.0
  bands = 20,              -- precomputed highlight groups
  scramble_threshold = 0.8, -- dimshape: falloff fraction before scrambling
  keep_structure = false,  -- keep indent and brackets lit while scrambling
  max_lines = 20000,       -- skip buffers larger than this
  filetype_denylist = { "help", "qf", "terminal", ... },
  buftype_denylist = { "terminal", "quickfix", "prompt", "nofile", "help" },
})
vim.keymap.set("n", "<leader>uf", "<Cmd>FocusToggle<CR>", { desc = "Toggle [F]ocus mode" })
vim.schedule(function()
  vim.cmd([[FocusDisable]])
end)

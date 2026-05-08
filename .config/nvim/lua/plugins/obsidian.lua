---@module 'obsidian'
---@type obsidian.config
local opts = {
  legacy_commands = false,
  workspaces = {
    {
      name = "notes",
      path = "~/notes",
    }
  },
  picker = {
    name = "fzf-lua",
    note_mappings = {
      new = "<C-x>",
      insert_link = "<C-l>",
    },
    tag_mappings = {
      tag_note = "<C-x>",
      insert_tag = "<C-l>",
    },
  },
  ui = {
    enable = false,
  },
  attachments = {
    img_folder = "assets",
    img_text_func = require("obsidian.builtin").img_text_func,
    img_name_func = function()
      return string.format("%s", os.date "%Y%m%d%H%M%S")
    end,
    confirm_img_paste = true,
  },
  note_id_func = function(title)
    local suffix = ''
    -- if title ~= nil then
    --   suffix = title:lower():gsub('[%s%p]+', '-'):gsub('[^%wáéíóúñüÁÉÍÓÚÑÜ-]', '')
    --   local ext_ascii_subs = {
    --     { 'Á', 'á' },
    --     { 'É', 'é' },
    --     { 'Í', 'í' },
    --     { 'Ó', 'ó' },
    --     { 'Ú', 'ú' },
    --     { 'ü', 'ü' },
    --     { 'Ñ', 'ñ' },
    --   }
    --   for _, i in ipairs(ext_ascii_subs) do
    --     suffix = suffix:gsub(i[1], i[2])
    --   end
    if title ~= nil then
      suffix = title
    else
      local char_pool = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'
      math.randomseed(os.time())
      for _ = 1, 8 do
        local rand = math.random(#char_pool)
        suffix = suffix .. char_pool:sub(rand, rand)
      end
    end
    -- return tostring(os.time()) .. '-' .. suffix
    return suffix
  end,
  checkbox = {
    enabled = true,
    create_new = true,
    order = { " ", "x" },
  },
}

require('obsidian').setup(opts)

-- Obsidian keymaps
local vim = vim
vim.keymap.set('n', '<leader>o', '', { desc = '[O]bsidian' })
vim.keymap.set('n', '<leader>ox', ':Obsidian open<CR>', { desc = 'Open app' })
vim.keymap.set('n', '<leader>on', ':Obsidian new<CR>', { desc = '[N]ew note' })
vim.keymap.set('n', '<leader>oN', function()
  local keys = ':Obsidian new<CR>' .. require('utils.helper').rand_id() .. ' '
  keys = vim.api.nvim_replace_termcodes(keys, true, false, true)
  vim.api.nvim_feedkeys(keys, 'n', false)
end, { desc = '[N]ew note with leading random ID' })
vim.keymap.set('n', '<leader>os', ':Obsidian quick_switch<CR>', { desc = 'Quick [S]witch' })
vim.keymap.set('n', '<leader>og', ':Obsidian search<CR>', { desc = "[G]rep notes" })
vim.keymap.set('n', '<leader>ot', ':Obsidian tags<CR>', { desc = 'Browse [T]ags' })
vim.keymap.set('n', '<leader>ow', ':Obsidian workspace<CR>', { desc = 'Switch [W]orkspace' })
vim.keymap.set('n', '<leader>oi', ':Obsidian paste_img<CR>', { desc = 'Paste copied [I]mage' })
vim.keymap.set('n', '<leader>ob', ':Obsidian backlinks<CR>', { desc = 'Show [B]acklinks' })
vim.keymap.set('n', '<leader>ol', ':Obsidian links<CR>', { desc = 'Show [L]inks' })
vim.keymap.set('n', '<leader>or', ':Obsidian rename<CR>', { desc = '[R]ename note' })
vim.keymap.set('n', '<leader>oc', ':Obsidian toc<CR>', { desc = 'TO[C]' })
-- local home_note_path = vim.fn.fnamemodify(opts.workspaces[1].path, ':p') .. 'index.md'
-- vim.keymap.set('n', '<leader>oh', ':e ' .. home_note_path .. '<CR>', { desc = 'Open [H]ome page' })

--template-related actions/fns

local templates = require 'modules.pkm.data.templates'

local m = {}

---@param template table
m.compile_template = function(template)
  local result = {}
  for _, line in ipairs(template) do
    if type(line) == "function" then
      table.insert(result, line())
    elseif type(line) == "string" then
      table.insert(result, line)
    else
      table.insert(result, '')
    end
  end
  table.insert(result, "")
  return result
end

---@param template_key string
m.apply_template_with_key = function(template_key)
  --TODO: also check if template is available
  if not template_key or templates[template_key] == nil then
    vim.notify("Could not apply template: Not a valid template", vim.log.levels.ERROR)
    return
  end
  vim.api.nvim_buf_set_lines(0, 0, 0, false, m.compile_template(templates[template_key]))
  print("Inserted template '" .. template_key .. "'")
end

m.fzf_template = function()
  local template_keys = {}
  for k, _ in pairs(templates) do
    template_keys[#template_keys + 1] = k
  end
  table.sort(template_keys)
  --TODO: fallback if fzf isn't found
  local fzf_lua = require('fzf-lua')
  local opts = {
    prompt = "Templates>",
    actions = {
      ['default'] = function(selected)
        m.apply_template_with_key(selected[1])
      end
    }
  }
  fzf_lua.fzf_exec(template_keys, opts)
end

return m

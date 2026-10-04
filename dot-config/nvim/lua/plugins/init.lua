-- Plugin definitions and config. Files are sourced in alphabetical order.

-- get files under lua/plugins/
local files = vim.api.nvim_get_runtime_file(
  "lua/plugins/**/*.lua",
  true
)

-- get modules from files
local modules = {}
for _, file in ipairs(files) do
  local name = file:match("/lua/plugins/(.+)%.lua$")
  if name and name ~= "init" then
    table.insert(modules, "plugins." .. name:gsub("/", "."))
  end
end
table.sort(modules)

-- require modules
for _, module in ipairs(modules) do
  require(module)
end

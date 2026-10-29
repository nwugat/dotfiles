local m = {}

-- get path to this script, trim leading `@`
local source_path = debug.getinfo(1, "S").source:sub(2)

m.module_root = vim.fn.fnamemodify(source_path, ":p:h")
m.render_assets_dir = m.module_root .. "/render-assets"

return m

--template-related actions/fns

local templates = require("modules.pkm.data.templates")

local m = {}

---@param template any[] | fun(): string[]
---@return string[]
m.compile_template = function(template)
	---@type string[]
	local result = {}
	if type(template) == "function" then
		result = template()
		for k, v in ipairs(result) do
			result[k] = type(v) == "function" and tostring(v()) or tostring(v)
		end
	else
		for _, line in ipairs(template) do
			result[#result + 1] = type(line) == "function" and line() or tostring(line)
		end
	end
	result[#result + 1] = ""
	return result
end

---@deprecated
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

---@param template any[] | fun(): any
---@return nil
m.apply_template = function(template)
	vim.api.nvim_buf_set_lines(0, 0, 0, false, m.compile_template(template))
	vim.notify("Template applied", vim.log.levels.INFO)
end

m.fzf_template = function()
	local template_keys = {}
	for k, _ in pairs(templates) do
		template_keys[#template_keys + 1] = k
	end
	table.sort(template_keys)
	--TODO: fallback if fzf isn't found
	local fzf_lua = require("fzf-lua")
	local opts = {
		prompt = "Templates>",
		actions = {
			["default"] = function(selected)
				m.apply_template_with_key(selected[1])
			end,
		},
	}
	fzf_lua.fzf_exec(template_keys, opts)
end

return m

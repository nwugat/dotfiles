-- Template utitlity functions

local m = {}

m.get_current_buf_filename = function()
	return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), ":t")
end

m.table_concat = function(t1, t2)
	local result = {}
	for _, v in ipairs(t1) do
		result[#result + 1] = v
	end
	for _, v in ipairs(t2) do
		result[#result + 1] = v
	end
	return result
end

m.date_field = function()
	return "date: " .. os.date("%Y-%m-%d-%H:%M")
end

m.default_frontmatter = {
	"---",
	m.date_field,
	'up: "[[]]"',
	"---",
}

m.default_frontmatter_open = {
	"---",
	m.date_field,
	'up: "[[]]"',
}

return m

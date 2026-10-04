vim.pack.add({
	-- Render markdown inline
	"https://github.com/MeanderingProgrammer/render-markdown.nvim",
})

-- render markdown
require("render-markdown").setup({
	heading = {
		width = "block",
		right_pad = 1,
		min_width = 80,
	},
	dash = {
		width = 80,
		icon = "-", -- Looks better IMO
	},
	checkbox = {
		bullet = true, -- For consistency w/ markdown syntax
		right_pad = 2, -- For consistency w/ underlying text
	},
	code = {
		conceal_delimiters = false, -- Conceal nodes at the top and bottom of code blocks
		width = "block", -- Don't extend to screen width
		right_pad = 1, -- Add padding of 1 col if content exceeds col 80
		min_width = 80, -- Extend to col 80
		border = "thin", -- Do not conceal lines
	},
	latex = { enabled = false },
	link = { enabled = false },
	wiki = { conceal_destination = false },
	-- indent = {
	-- 	enabled = true,
	-- },
	win_options = {
		-- conceallevel = {
		-- 	default = vim.o.conceallevel,
		-- 	rendered = 3,
		-- },
		conceallevel = {
			default = 0,
			rendered = 0,
		},
	},
})

vim.api.nvim_set_hl(0, "@spell.markdown", {
	link = "Normal",
})

vim.api.nvim_set_hl(0, "@conceal.markdown_inline", {
	link = "NonText",
})

vim.api.nvim_set_hl(0, "@markup.link.markdown_inline", {
	link = "NonText",
})

vim.api.nvim_set_hl(0, "@markup.link.url.markdown_inline", {
	link = "NonText",
})

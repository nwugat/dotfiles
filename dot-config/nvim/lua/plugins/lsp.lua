vim.pack.add({
	-- LSP config presets
	"https://github.com/neovim/nvim-lspconfig",
	-- install and update LSPs, fomatters, DAPs and linters from a pretty menu
	{ src = "https://github.com/mason-org/mason.nvim", version = "main" },
	-- lsp progress notifications
	{ src = "https://github.com/j-hui/fidget.nvim", version = "main" },
	-- autoformat on save
	"https://github.com/stevearc/conform.nvim",
})

require("mason").setup({})

require("fidget").setup({})

require("conform").setup({
	notify_on_error = false,
	format_on_save = function(bufnr)
		local disable_filetypes = { c = true, cpp = true, markdown = true }
		if disable_filetypes[vim.bo[bufnr].filetype] then
			return nil
		end
		return { timeout_ms = 500, lsp_format = "fallback" }
	end,
	formatters_by_ft = {
		lua = { "stylua" },
		sql = { "sqlfmt" },
		markdown = { "markdownlint" },
		html = { "prettier" },
		js = { "prettier" },
		css = { "prettier" },
	},
})
vim.keymap.set("", "<leader>bf", function()
	require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "[F]ormat buffer" })

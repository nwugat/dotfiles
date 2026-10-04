-- General LSP configs

--Enable with default config
vim.lsp.enable({
	"lua_ls",
	"gdscript",
	"pyright",
	"bashls",
	"rust_analyzer",
	"perlnavigator",
	"clangd",
	"texlab",
	"csharp_ls",
	"sqls",
})

local capabilities = require("blink.cmp").get_lsp_capabilities()
vim.lsp.config("*", {
	capabilities = capabilities,
})

vim.diagnostic.config({
	virtual_text = true,
})

--Markdown-oxide
vim.lsp.config("markdown_oxide", {
	-- Ensure that dynamicRegistration is enabled! This allows the LS to take into account actions like the
	-- Create Unresolved File code action, resolving completions for unindexed code blocks, ...
	capabilities = vim.tbl_deep_extend("force", capabilities, {
		workspace = {
			didChangeWatchedFiles = {
				dynamicRegistration = true,
			},
		},
	}),
})
vim.lsp.enable("markdown_oxide")

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("my.lsp", {}),
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

		if not client then
			return
		end

		-- Keymaps
		local map = function(keys, action, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, action, { desc = desc })
		end

		-- if client:supports_method('textDocument/implementation') then
		--   -- Create a keymap for vim.lsp.buf.implementation ...
		-- end

		map("<leader>lS", vim.lsp.buf.workspace_symbol, "Workspace [S]ymbols")
		map("<leader>lh", vim.diagnostic.open_float, "[H]over diagnostic")
		map("<leader>lt", function()
			vim.diagnostic.enable(vim.diagnostic.is_enabled())
		end, "[T]oggle diagnostics")
		map("<A-]>", function()
			vim.diagnostic.jump({ diagnostic = vim.diagnostic.get_next() })
		end)
		map("<A-[>", function()
			vim.diagnostic.jump({ diagnostic = vim.diagnostic.get_prev() })
		end)
		local fzflua_found, fzflua = pcall(require, "fzf-lua")
		if fzflua_found then
			map("grr", fzflua.lsp_references, "LSP references")
			map("<leader>ls", fzflua.lsp_document_symbols, "Document [S]ymbols")
			map("<leader>ld", fzflua.lsp_document_diagnostics, "Fuzzy buf [D]iagnostics")
			map("<leader>lD", fzflua.lsp_workspace_diagnostics, "Fuzzy worksp [D]iagnostics")
		else
			vim.notify_once("FzfLua not found", vim.log.levels.ERROR)
		end

		-- Enable auto-completion.
		if client:supports_method("textDocument/completion") then
			-- Optional: trigger autocompletion on EVERY keypress. May be slow!
			-- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
			-- client.server_capabilities.completionProvider.triggerCharacters = chars
			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = false })
		end

		-- Auto-format ("lint") on save.
		-- Usually not needed if server supports "textDocument/willSaveWaitUntil".
		-- NOTE: using conform instead of native lsp for formatting

		-- if
		-- 	not client:supports_method("textDocument/willSaveWaitUntil")
		-- 	and client:supports_method("textDocument/formatting")
		-- then
		-- 	local format = function()
		-- 		vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
		-- 	end
		-- 	vim.api.nvim_create_autocmd("BufWritePre", {
		-- 		group = vim.api.nvim_create_augroup("my.lsp", { clear = false }),
		-- 		buffer = args.buf,
		-- 		callback = format,
		-- 	})
		-- 	map("<leader>bf", format, "[F]ormat buffer")
		-- end

		-- Symbol highlight
		if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
			local highlight_augroup = vim.api.nvim_create_augroup("nwugat-lsp-highlight", { clear = false })
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = args.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.document_highlight,
			})
			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = args.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.clear_references,
			})
			vim.api.nvim_create_autocmd("LspDetach", {
				group = vim.api.nvim_create_augroup("nwugat-lsp-detach", { clear = true }),
				callback = function(event)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({ group = "nwugat-lsp-highlight", buffer = event.buf })
				end,
			})
		end
	end,
})

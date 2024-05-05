local M = {}

local signs = {
	{ name = "DiagnosticSignError", text = "" },
	{ name = "DiagnosticSignWarn", text = "" },
	{ name = "DiagnosticSignHint", text = "" },
	{ name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
	vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

M.config = {
	virtual_text = true, -- disable virtual text
	signs = {
		active = signs, -- show signs
	},
	update_in_insert = true,
	underline = true,
	severity_sort = true,
	float = {
		focusable = true,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
M.on_attach = function(client, bufnr)
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({ bufnr = bufnr })
			end,
		})
	end

	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

	nmap("<leader>lr", vim.lsp.buf.rename, "Rename")
	nmap("<leader>la", vim.lsp.buf.code_action, "Code Action")
	nmap("gd", vim.lsp.buf.definition, "Goto Definition")
	nmap("gpd", require("goto-preview").goto_preview_definition, "Peek Definition")
	nmap("gr", require("telescope.builtin").lsp_references, "Goto References")
	nmap("gi", vim.lsp.buf.implementation, "Goto Implementation")
	nmap("gI", vim.lsp.buf.declaration, "Goto Declaration")
	nmap("gD", vim.lsp.buf.type_definition, "Goto Type Definition")
	nmap("gpD", require("goto-preview").goto_preview_type_definition, "Peek Type Definition")
	nmap("gs", require("telescope.builtin").lsp_document_symbols, "Document Symbols")
	nmap("gS", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace Symbols")
	nmap("gw", [[<cmd>Telescope diagnostics bufnr=0<CR>]], "Buffer Diagnostincs")
	nmap("gW", [[<cmd>Telescope diagnostics<CR>]], "Workspace diagnostics")
	nmap("K", vim.lsp.buf.hover, "Hover Documentation")
	-- nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
	nmap("W", vim.diagnostic.goto_prev, "Go to previous diagnostic message")
	nmap("E", vim.diagnostic.goto_next, "Go to next diagnostic message")
	nmap("<leader>w", vim.diagnostic.open_float, "Open floating diagnostic message")
	nmap("<leader>q", vim.diagnostic.setloclist, "Open diagnostics list")

	local status_ok, illuminate = pcall(require, "illuminate")
	if not status_ok then
		return
	end
	illuminate.on_attach(client)
end

return M

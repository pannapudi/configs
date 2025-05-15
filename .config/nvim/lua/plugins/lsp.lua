return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",

		{
			"rmagatti/goto-preview",
			dependencies = { "rmagatti/logger.nvim" },
			event = "BufEnter",
			opts = {},
		},
		"saghen/blink.cmp",
	},
	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				map("<leader>lr", vim.lsp.buf.rename, "Rename")
				map("<leader>la", vim.lsp.buf.code_action, "Code Action", { "n", "x" })
				map("gd", vim.lsp.buf.definition, "Goto Definition")
				map("gpd", require("goto-preview").goto_preview_definition, "Peek Definition")
				map("gr", function()
					require("trouble").toggle("lsp_references")
				end, "Goto References")
				map("gD", vim.lsp.buf.declaration, "Goto Declaration")
				map("gs", require("telescope.builtin").lsp_document_symbols, "Document Symbols")
				map("gS", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace Symbols")
				map("gw", [[<cmd>Telescope diagnostics bufnr=0<CR>]], "Buffer Diagnostincs")
				map("gW", [[<cmd>Telescope diagnostics<CR>]], "Workspace diagnostics")
				map("W", function()
					vim.diagnostic.jump({ count = -1, float = true })
				end, "Go to previous diagnostic message")
				map("E", function()
					vim.diagnostic.jump({ count = 1, float = true })
				end, "Go to next diagnostic message")
				map("K", vim.lsp.buf.hover, "Hover Documentation")
				map("<leader>q", vim.diagnostic.setloclist, "Open diagnostics list")

				local function client_supports_method(client, method, bufnr)
					return client:supports_method(method, bufnr)
				end

				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if
					client
					and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
				then
					local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})

					vim.api.nvim_create_autocmd("LspDetach", {
						group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
						callback = function(event2)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
						end,
					})
				end

				if
					client
					and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
				then
					vim.lsp.inlay_hint.enable(true)
					vim.keymap.set("n", "<leader>lh", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }), {})
					end, { desc = "Toggle Inlay Hints" })
				end
			end,
		})

		-- Diagnostic Config
		-- See :help vim.diagnostic.Opts
		vim.diagnostic.config({
			severity_sort = true,
			float = { border = "rounded", source = "if_many" },
			underline = { severity = vim.diagnostic.severity.ERROR },
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "󰅚 ",
					[vim.diagnostic.severity.WARN] = "󰀪 ",
					[vim.diagnostic.severity.INFO] = "󰋽 ",
					[vim.diagnostic.severity.HINT] = "󰌶 ",
				},
			},
			virtual_text = {
				source = "if_many",
				spacing = 2,
				format = function(diagnostic)
					local diagnostic_message = {
						[vim.diagnostic.severity.ERROR] = diagnostic.message,
						[vim.diagnostic.severity.WARN] = diagnostic.message,
						[vim.diagnostic.severity.INFO] = diagnostic.message,
						[vim.diagnostic.severity.HINT] = diagnostic.message,
					}
					return diagnostic_message[diagnostic.severity]
				end,
			},
		})

		local capabilities = require("blink.cmp").get_lsp_capabilities()

		local servers = {
			clangd = {},
			gopls = {},
			pyright = {},
			rust_analyzer = {},
			lua_ls = {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
							disable = { "missing-fields" },
						},
						completion = {
							callSnippet = "Replace",
						},
					},
				},
			},
		}

		local ensure_installed = vim.tbl_keys(servers or {})
		vim.list_extend(ensure_installed, {
			"stylua",
		})
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		require("mason-lspconfig").setup({
			ensure_installed = {},
			automatic_installation = false,
			automatic_enable = {
				exclude = {
					"rust_analyzer",
				},
			},
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					-- This handles overriding only values explicitly passed
					-- by the server configuration above. Useful when disabling
					-- certain features of an LSP (for example, turning off formatting for ts_ls)
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
	end,
}

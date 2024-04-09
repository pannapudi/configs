return {
	'mrcjkb/rustaceanvim',
	version = '^4', -- Recommended
	ft = { 'rust' },
	config = function()
		vim.g.rustaceanvim = {
			tools = {
				runnables = {
					use_telescope = true,
				},
				debugables = {
					use_telescope = true,
				},
				crate_graph = {
					full = false,
				},
			},

			-- LSP configuration
			server = {
				cmd = { vim.fn.stdpath("data") .. "/mason/bin/rust-analyzer" },
				on_attach = function(client, bufnr)
					require("plugins.lsp.handlers").on_attach(client, bufnr)
				end,
				capabilities = require("plugins.lsp.handlers").capabilities,
				default_settings = {
					-- rust-analyzer language server configuration
					['rust-analyzer'] = {
						inlayHints = {
							closureReturnTypeHints = true,
							lifetimeElisionHints = { enable = "skip_trivial" },
						},
						assist = {
							-- importMergeBehaviour = "last",
							importPrefix = "by_self",
							expressionFillDefault = "default",
						},
						diagnostics = {
							-- disabled = { "unresolved-import" },
							-- experimental = { enable = true },
						},
						cargo = {
							-- 	extraArgs = { "--profile", "rust-analyzer" },
						},
					},
				},
			},
			-- DAP configuration
			dap = {
			},
		}
	end
}

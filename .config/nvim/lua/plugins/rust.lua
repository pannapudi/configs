return {
	{
		"saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		opts = {
			popup = {
				border = "rounded",
			},
			lsp = {
				enabled = true,
				actions = true,
				completion = true,
			},
		},
	},
	{
		"mrcjkb/rustaceanvim",
		-- version = "^4", -- Recommended
		ft = { "rust" },
		config = function()
			local extension_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/"
			local codelldb_path = extension_path .. "adapter/codelldb"
			local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

			local cfg = require("rustaceanvim.config")
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
					float_win_config = {
						border = "rounded",
					},
				},

				-- LSP configuration
				server = {
					cmd = { vim.fn.stdpath("data") .. "/mason/bin/rust-analyzer" },
					on_attach = function(client, bufnr)
						require("plugins.lsp.handlers").on_attach(client, bufnr)

						require("which-key").register({
							["a"] = { "<Cmd>RustLsp codeAction<CR>", "Code Action" },
							["<Leader>l"] = {
								c = { "<Cmd>RustLsp openCargo<CR>", "Open Cargo.toml" },
								p = { "<Cmd>RustLsp parentModule<CR>", "Parent Module" },
								R = { "<Cmd>RustLsp runnables<CR>", "Runnables" },
								D = { "<Cmd>RustLsp debuggables<CR>", "Debuggables" },
								l = { "<Cmd>RustLsp renderDiagnostic<CR>", "Line Info" },
							},
							["J"] = { "<Cmd>RustLsp joinLines<CR>", "Join Lines" },
							["<A-k>"] = { "<Cmd>RustLsp moveItem up<CR>", "Move item up" },
							["<A-j>"] = { "<Cmd>RustLsp moveItem down<CR>", "Move item down" },
							K = { "<Cmd>RustLsp hover actions<CR>", "Documentation" },
						}, { buffer = bufnr })
					end,
					capabilities = require("plugins.lsp.handlers").capabilities,
					default_settings = {
						-- rust-analyzer language server configuration
						["rust-analyzer"] = {
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
							workspace = {
								symbol = {
									search = {
										kind = "all_symbols",
									},
								},
							},
							cargo = {
								-- 	extraArgs = { "--profile", "rust-analyzer" },
							},
						},
					},
				},
				-- DAP configuration
				dap = {
					adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
				},
			}
		end,
	},
}

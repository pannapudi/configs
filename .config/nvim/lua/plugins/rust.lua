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
	-- {
	-- 	"vxpm/ferris.nvim",
	-- 	opts = {},
	-- },
	{
		"mrcjkb/rustaceanvim",
		version = "^6", -- Recommended
		lazy = false, -- This plugin is already lazy
		config = function()
			local extension_path = vim.fn.expand("$MASON/packages/codelldb/extension/")
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
					default_settings = {
						-- rust-analyzer language server configuration
						["rust-analyzer"] = {
							inlayHints = {
								closureReturnTypeHints = true,
								lifetimeElisionHints = { enable = "skip_trivial" },
								parameterHints = false,
							},
							assist = {
								-- importMergeBehaviour = "last",
								importPrefix = "by_self",
								expressionFillDefault = "default",
							},
							check = {
								command = "check",
							},
							diagnostics = {
								-- disabled = { "unresolved-import" },
								experimental = { enable = true },
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
				dap = {
					adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
				},
			}
		end,
	},
}

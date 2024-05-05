return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		{ "neovim/nvim-lspconfig", event = { "BufReadPre", "BufNewFile" } },
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		require("mason").setup({})
		local mason_lspconfig = require("mason-lspconfig")
		mason_lspconfig.setup({
			ensure_installed = { "lua_ls", "clangd", "rust_analyzer" },
			automatic_installation = true,
		})

		local handlers = require("plugins.lsp.handlers")

		mason_lspconfig.setup_handlers({
			function(server_name)
				require("lspconfig")[server_name].setup({
					on_attach = handlers.on_attach,
					capabilities = handlers.capabilities,
				})
			end,
			["rust_analyzer"] = function() end,
			-- Custom configuration for lua_ls server
			["lua_ls"] = function()
				local lsp_config = require("lspconfig")
				lsp_config.lua_ls.setup({
					-- capabilities = capabilities,
					-- on_attach = on_attach,
					settings = {
						Lua = {
							diagnostics = {
								globals = { "vim" },
							},
							workspace = {
								library = {
									[vim.fn.expand("$VIMRUNTIME/lua")] = true,
									[vim.fn.stdpath("config") .. "/lua"] = true,
								},
								-- library = { "${3rd}/luv/library", unpack(vim.api.nvim_get_runtime_file("", true)), },
							},
						},
					},
				})
			end,
		})
	end,
}

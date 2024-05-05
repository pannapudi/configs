local status_ok, rust_tools = pcall(require, "rust-tools")
if not status_ok then
	return
end

local extension_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

rust_tools.setup({
	tools = {
		runnables = {
			-- whether to use telescope for selection menu or not
			-- default: true
			use_telescope = true,

			-- rest of the opts are forwarded to telescope
		},

		debugables = {
			use_telescope = true,
		},

		-- settings for showing the crate graph based on graphviz and the dot
		-- command
		crate_graph = {
			-- true for all crates.io and external crates, false only the local
			-- crates
			-- default: true
			full = false,
		},
	},

	-- all the opts to send to nvim-lspconfig
	-- these override the defaults set by rust-tools.nvim
	-- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
	server = {
		cmd = { vim.fn.stdpath("data") .. "/mason/bin/rust-analyzer" },
		on_attach = function(client, bufnr)
			require("user.lsp.handlers").on_attach(client, bufnr)
			-- Hover actions
			vim.keymap.set("n", "K", rust_tools.hover_actions.hover_actions, { buffer = bufnr })
			-- Code action groups
			vim.keymap.set("n", "<Leader>a", rust_tools.code_action_group.code_action_group, { buffer = bufnr })
		end,
		capabilities = require("user.lsp.handlers").capabilities,
		settings = {
			["rust-analyzer"] = {
				inlay_hints = {
					closureReturnTypeHints = true,
					lifetimeElisionHints = { enable = "skip_trivial" },
				},
				assits = {
					-- importMergeBehaviour = "last",
					importPrefix = "by_self",
					expressionFillDefault = "default",
				},
				diagnostics = {
					disabled = { "unresolved-import" },
					experimental = { enable = true },
				},
				cargo = {
					loadOutDirFromCheck = true,
				},
				procMacro = {
					enbale = true,
				},
				checkOnSave = {
					-- enable = false,
					-- command = "clippy",
				},
			},
		},
	}, -- rust-analyser options

	dap = {
		adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
	},
})

require("crates").setup()

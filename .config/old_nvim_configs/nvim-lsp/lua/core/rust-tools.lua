local M = {}
M.opts = {
	tools = {
		runnables = {
			-- whether to use telescope for selection menu or not
			-- default: true
			use_telescope = true,

			-- rest of the opts are forwarded to telescope
		},

		-- on_initialized = function()
		-- 	local ih = require("inlay-hints")
		-- 	ih.set_all()
		-- end,
		-- inlay_hints = {
		-- 	auto = true,
		-- },

		inlay_hints = {
			auto = true,
			show_parameter_hints = true,
			only_current_line = false,
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
		on_attach = require("core.lsp_opts").on_attach,
		capabilities = require("core.lsp_opts").capabilities,
		settings = {
			["rust-analyzer"] = {
				inlay_hints = {
					closureReturnTypeHints = true,
				},

				assits = {
					-- importMergeBehaviour = "last",
					importPrefix = "by_self",
					expressionFillDefault = "default",
				},
				diagnostics = {
					disabled = { "unresolved-import" },
					experimental = {
						enable = true,
					},
				},
				cargo = {
					loadOutDirFromCheck = true,
				},
				procMacro = {
					enbale = true,
				},
				-- checkOnSave = {
				-- enable = false,
				-- command = "clippy",
				-- },
			},
		},
	}, -- rust-analyser options
}

M.setup = function()
	local status_ok, rust_tools = pcall(require, "rust-tools")
	if not status_ok then
		return
	end

	rust_tools.setup(M.opts)
end

return M

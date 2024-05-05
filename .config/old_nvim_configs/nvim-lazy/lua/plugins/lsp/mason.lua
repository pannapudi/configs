local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then
	return
end

local lsp_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not lsp_status_ok then
	return
end

local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status then
	return
end

require("neodev").setup({
	library = { plugins = { "nvim-dap-ui" }, types = true },
})

mason.setup()

local handlers = require("plugins.lsp.handlers")
vim.diagnostic.config(handlers.config)

local servers = {
	clangd = {},
	gopls = {},
	dockerls = {},
	pyright = {},
	rust_analyzer = {},
	taplo = {},
	jsonls = {},
	tsserver = {},
	wgsl_analyzer = {
		wgsl = {
			diagnostics = {
				typeErrors = true,
				nagaParsing = true,
				nagaValidation = true,
				nagaVersion = "main",
			},
			inlayHints = {
				enabled = true,
				typeHints = true,
				parameterHints = true,
				structLayoutHints = true,
				typeVerbosity = "compact",
			},
		},
	},
	lua_ls = {
		Lua = {
			diagnostics = { globals = { "vim" } },
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	},
}

mason_lspconfig.setup({
	ensure_installed = vim.tbl_keys(servers),
	automatic_installation = true,
})

mason_lspconfig.setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup({
			capabilities = handlers.capabilities,
			on_attach = handlers.on_attach,
			settings = servers[server_name],
		})
	end,
	["rust_analyzer"] = function()
		require("plugins.config.rust")
	end,
})

mason_null_ls.setup({
	-- list of formatters & linters for mason to install
	ensure_installed = {
		"prettier", -- ts/js formatter
		"stylua", -- lua formatter
		"eslint_d", -- ts/js linter
		"pylint", -- ts/js linter
		"black",
		"flake8",
		"isort",
	},
	-- auto-install configured formatters & linters (with null-ls)
	automatic_installation = true,
})

vim.lsp.handlers["wgsl-analyzer/requestConfiguration"] = function(err, result, ctx, config)
	return {
		success = true,
		customImports = { _dummy_ = "dummy" },
		shaderDefs = {},
		trace = {
			extension = false,
			server = false,
		},
		inlayHints = {
			enabled = true,
			typeHints = true,
			parameterHints = true,
			structLayoutHints = true,
			typeVerbosity = "inner",
		},
		diagnostics = {
			typeErrors = true,
			nagaParsingErrors = true,
			nagaValidationErrors = true,
			nagaVersion = "main",
		},
	}
end

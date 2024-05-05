local status_ok, mason = pcall(require, "mason")
if not status_ok then
	return
end

local lsp_list = {
	"sumneko_lua",
	"clangd",
	"pyright",
	"cmake",
	"zls",
	"texlab",
	"gopls",
	"jsonls",
	"tsserver",
	"rust_analyzer",
	"bashls",
	"cssls",
}

mason.setup({
	ui = {
		icons = {
			package_installed = "✓",
		},
	},
})

local mstatus_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mstatus_ok then
	return
end

mason_lspconfig.setup({
	ensure_installed = lsp_list,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local servers = {
	"sumneko_lua",
	"clangd",
	"pyright",
	"cmake",
	"zls",
	"texlab",
	"gopls",
	"jsonls",
	"tsserver",
	"bashls",
	"cssls",
	"wgsl_analyzer",
}

-- local configs = require("lspconfig.configs")
-- if not configs.wgsl_analyzer then
-- 	configs.wgsl_analyzer = {
-- 		default_config = {
-- 			cmd = { vim.fn.stdpath("data") .. "/mason/bin/wgsl_analyzer" },
-- 			filetypes = { "wgsl" },
-- 			root_dir = lspconfig.util.root_pattern(".git", "wgsl"),
-- 			settings = {},
-- 		},
-- 	}
-- end

local opts = {}
for _, server in pairs(servers) do
	opts = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
	}

	if server == "sumneko_lua" then
		local sumneko_opts = require("user.lsp.settings.sumneko_lua")
		opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	end

	if server == "pyright" then
		local pyright_opts = require("user.lsp.settings.pyright")
		opts = vim.tbl_deep_extend("force", pyright_opts, opts)
	end

	if server == "wgsl_analyzer" then
		local wgsl_opts = require("user.lsp.settings.wgsl_analyzer")
		opts = vim.tbl_deep_extend("force", wgsl_opts, opts)
	end

	lspconfig[server].setup(opts)
end

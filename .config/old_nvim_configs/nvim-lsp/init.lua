local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
end

local packer_ok, packer = pcall(require, "packer")
if not packer_ok then
	return
end

packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "single" })
		end,
	},
})

require("plugins")
require("autocommands")
require("settings")
require("keymappings")

require("telescope").load_extension("ui-select")

vim.cmd([[set shell=/bin/bash]])

local lsp_opts = require("core.lsp_opts")

require("impatient")

require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
		},
	},
})

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
}
require("mason-lspconfig").setup({
	ensure_installed = lsp_list,
})

local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")

local lsp_list_attach = {
	"sumneko_lua",
	"clangd",
	"pyright",
	"cmake",
	"zls",
	"texlab",
	"gopls",
	"jsonls",
	"tsserver",
}
for i, lsp in pairs(lsp_list_attach) do
	require("lspconfig")[lsp].setup({
		on_attach = lsp_opts.on_attach,
		capabilities = lsp_opts.capabilities,
	})
end

-- local rt = require("rust-tools")
-- local rs_opts = require("core.rust-tools")

-- rt.setup(rs_opts.opts)

if not configs.wgsl_analyzer then
	configs.wgsl_analyzer = {
		default_config = {
			-- cmd = { vim.fn.expand("$HOME") .. "/.cargo/bin/wgsl_analyzer" },
			cmd = { vim.fn.stdpath("data") .. "/mason/bin/wgsl_analyzer" },
			filetypes = { "wgsl" },
			root_dir = lspconfig.util.root_pattern(".git", "wgsl"),
			settings = {},
		},
	}
end

lspconfig.wgsl_analyzer.setup({
	on_attach = lsp_opts.on_attach,
	capabilities = lsp_opts.capabilities,
})

vim.api.nvim_exec([[filetype plugin indent on]], false)
vim.bo.shiftwidth = 4
vim.bo.softtabstop = 0
vim.bo.tabstop = 4
vim.bo.expandtab = true
vim.o.smarttab = true

require("luasnip.loaders.from_vscode").lazy_load()

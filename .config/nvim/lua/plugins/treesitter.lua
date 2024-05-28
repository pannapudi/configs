return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		"nvim-treesitter/nvim-treesitter-context",
	},
	build = ":TSUpdate",
	config = function()
		vim.filetype.add({ extension = { wgsl = "wgsl" } })
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			-- Add languages to be installed here that you want installed for treesitter
			ensure_installed = { "c", "cpp", "go", "lua", "python", "rust", "tsx", "typescript", "vim", "glsl", "wgsl" },
			-- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
			auto_install = true,
			sync_install = true,
			highlight = { enable = true, additional_vim_regex_highlighting = false },
			indent = { enable = true, disable = { "python" } },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<c-space>",
					node_incremental = "<c-space>",
					scope_incremental = "<c-s>",
					node_decremental = "<c-a>",
				},
			},
		})
	end,
}

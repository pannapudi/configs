return {
	-- Git related plugins
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",

	{
		-- Theme inspired by Atom
		"navarasu/onedark.nvim",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("onedark")
		end,
	},

	{ "max397574/better-escape.nvim", opts = { mapping = { "jk", "kj" } } },
	{ "folke/todo-comments.nvim", opts = { signs = false } },
	{ "kaplanz/nvim-retrail", opts = {} }, -- Trim and highlight whitespace
	{ "andymass/vim-matchup" }, -- Better matching brackets on S-5
	{ "stevearc/dressing.nvim", event = "VeryLazy", opts = {} }, -- Pretty UI
	{ "tikhomirov/vim-glsl" }, -- glsl support
	{ "nacro90/numb.nvim", opts = {} }, -- peek line jumps
	{ "ron-rs/ron.vim" }, -- ron file suppoort
	{ "rhysd/clever-f.vim" }, -- better f jumps
	{ "rmagatti/goto-preview", opts = {} }, -- peek lsp commands in separate window
	{ "windwp/nvim-spectre", opts = {} }, -- Search and Replace
	{ "NvChad/nvim-colorizer.lua", opts = {} }, -- Color colors in colors
	{ "RRethy/vim-illuminate" }, -- highlight same words with TreeSitter
	{ "kylechui/nvim-surround", event = "VeryLazy", opts = {} }, -- Add/change/delete surrounding brackets
	{ "lewis6991/gitsigns.nvim", event = { "BufReadPre", "BufNewFile" }, opts = {} },
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
	{ "j-hui/fidget.nvim", opts = { notification = {
		window = { winblend = 0 }
	} }, },

	-- Useful plugin to show you pending keybinds.
	{ "folke/which-key.nvim", opts = {  } },

	{
		"jiaoshijie/undotree",
		dependencies = "nvim-lua/plenary.nvim",
		config = true,
		keys = { -- load the plugin only when using it's keybinding:
		{ "<leader>u", "<cmd>lua require('undotree').toggle()<cr>" },
	},
},
-- File explorer
{
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v2.x",
	module = "neo-tree",
	cmd = { "Neotree", "NeoTreeFocusToggle" },
	dependencies = {
		{ "MunifTanjim/nui.nvim", module = "nui" },
		"nvim-lua/plenary.nvim",
	},
	config = function()
		--	require("plugins/config/neo-tree")
	end,
},
{
	"xiyaowong/nvim-transparent",
	opts = {
		extra_groups = { -- table/string: additional groups that should be cleared
		"all",
		"NormalNC",
		"NeoTreeNormal",
		"NeoTreeNormalNC",
		"NeoTreeEndOfBuffer",
	},
},
},
-- remember last session cursor position
{
	"ethanholz/nvim-lastplace",
	opts = {
		lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
		lastplace_ignore_filetype = {
			"gitcommit",
			"gitrebase",
			"svn",
			"hgcommit",
		},
		lastplace_open_folds = true,
	},
},
{
	"hedyhli/outline.nvim",
	lazy = true,
	cmd = { "Outline", "OutlineOpen" },
	keys = { -- Example mapping to toggle outline
	{ "<F8>", "<cmd>Outline<CR>", desc = "Toggle outline" },
},
opts = { -- Your setup opts here },
	},
},
}

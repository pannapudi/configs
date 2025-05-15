return {
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {},
	},

	-- Git related plugins
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("gitsigns").setup()

			-- Popup what's changed in a hunk under cursor
			vim.keymap.set("n", "<Leader>gp", ":Gitsigns preview_hunk<CR>", { silent = true })

			-- Stage/reset individual hunks under cursor in a file
			vim.keymap.set("n", "<Leader>gh", ":Gitsigns stage_hunk<CR>", { silent = true })
			vim.keymap.set("n", "<Leader>gr", ":Gitsigns reset_hunk<CR>", { silent = true })
			vim.keymap.set("n", "<Leader>gu", ":Gitsigns undo_stage_hunk<CR>", { silent = true })

			-- Open git status in interactive window (similar to lazygit)
			vim.keymap.set("n", "<Leader>gg", ":Git<CR>", { silent = true })

			-- Other tools from fugitive
			vim.keymap.set("n", "<Leader>gm", ":Git mergetool<CR>", { silent = true })
			vim.keymap.set("n", "<Leader>gd", ":Gvdiffsplit<CR>", { silent = true })
		end,
	},
	{
		-- Theme inspired by Atom
		"navarasu/onedark.nvim",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("onedark")
		end,
	},

	{ "max397574/better-escape.nvim", opts = {} },
	{ "folke/todo-comments.nvim", opts = { signs = false } },
	{ "kaplanz/nvim-retrail", opts = {} }, -- Trim and highlight whitespace
	{ "stevearc/dressing.nvim", event = "VeryLazy", opts = {} }, -- Pretty UI
	{ "tikhomirov/vim-glsl" }, -- glsl support
	{ "nacro90/numb.nvim", opts = {} }, -- peek line jumps
	{ "ron-rs/ron.vim" }, -- ron file support
	{ "rhysd/clever-f.vim" }, -- better f jumps
	{ "rmagatti/goto-preview", opts = {} }, -- peek lsp commands in separate window
	{ "windwp/nvim-spectre", opts = {} }, -- Search and Replace
	{ "kylechui/nvim-surround", event = "VeryLazy", opts = {} }, -- Add/change/delete surrounding brackets
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
	{ "kevinhwang91/nvim-bqf", ft = "qf", opts = {} },
	{
		"j-hui/fidget.nvim",
		opts = {
			notification = {
				window = { winblend = 0 },
			},
		},
	},

	{
		"felpafel/inlay-hint.nvim",
		event = "LspAttach",
		opts = {},
	},

	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {},
		-- stylua: ignore
		keys = {
			{ "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
			-- { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
			-- { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
			-- { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
			-- { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
		},
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {},
		-- stylua: ignore
		keys = {
			{ "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
			-- { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
			-- { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
			-- { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
			-- { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
		},
	},

	-- Useful plugin to show you pending keybinds.
	{ "folke/which-key.nvim", opts = {} },

	{
		"mbbill/undotree",
		keys = { -- load the plugin only when using it's keybinding:
			{ "<leader>u", vim.cmd.UndotreeToggle },
		},
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
		"stevearc/aerial.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		keys = { -- Example mapping to toggle outline
			{ "<leader>lt", "<cmd>AerialToggle!<CR>", desc = "Toggle outline" },
		},
		opts = {
			layout = {
				min_width = 20,
			},
			highlight_on_hover = true,
			autojump = true,
		},
	},
}

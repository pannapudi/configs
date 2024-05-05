return {
	"lewis6991/impatient.nvim", -- speed?

	-- Git related plugins
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",

	{
		-- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",

			-- Useful status updates for LSP
			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			{ "j-hui/fidget.nvim", opts = { notification = { window = { winblend = 0 } } } },

			-- Additional lua configuration, makes nvim stuff amazing!
			"folke/neodev.nvim",
		},
	},

	{
		"williamboman/mason.nvim",
		config = function()
			require("plugins/lsp/mason")
		end,
	},

	-- Debugging
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			{ "jay-babu/mason-nvim-dap.nvim" },
		},
		config = function()
			require("plugins.config.dap")
		end,
	},

	{
		-- Autocompletion
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lua",
		},
		config = function()
			require("plugins/config/cmp")
		end,
	},

	-- Useful plugin to show you pending keybinds.
	{ "folke/which-key.nvim", opts = {} },
	{
		-- Adds git releated signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		opts = {
			-- See `:help gitsigns.txt`
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},

	{
		-- Theme inspired by Atom
		"navarasu/onedark.nvim",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("onedark")
		end,
	},

	{
		-- Set lualine as statusline
		"nvim-lualine/lualine.nvim",
		config = function()
			require("plugins.config.lualine")
		end,
		opts = {
			options = {
				icons_enabled = false,
				theme = "onedark",
				component_separators = "|",
				section_separators = "",
			},
		},
	},

	{
		-- Add indentation guides even on blank lines
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		-- Enable `lukas-reineke/indent-blankline.nvim`
		-- See `:help indent_blankline.txt`
		opts = {
			--			char = "▏",
			--			show_trailing_blankline_indent = false,
			--			show_first_indent_level = true,
			--			use_treesitter = true,
			--			show_current_context = true,
			--			buftype_exclude = { "terminal", "nofile" },
			--			filetype_exclude = {
			--				"help",
			--				"packer",
			--				"NvimTree",
			--			},
		},
	},

	-- Plugin for easy commenting
	{ "numToStr/Comment.nvim", opts = {} },

	-- Fuzzy Finder (files, lsp, etc)
	{
		"nvim-telescope/telescope.nvim",
		version = "*",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("plugins/config/telescope")
		end,
	},

	-- Fuzzy Finder Algorithm which requires local dependencies to be built.
	-- Only load if `make` is available. Make sure you have the system
	-- requirements installed.
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		-- NOTE: If you are having trouble with this installation,
		--       refer to the README for telescope-fzf-native for more instructions.
		build = "make",
		cond = function()
			return vim.fn.executable("make") == 1
		end,
	},

	{
		-- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"nvim-treesitter/nvim-treesitter-context",
		},
		config = function()
			pcall(require("nvim-treesitter.install").update({ with_sync = true }))
			require("plugins/config/treesitter")
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
			require("plugins/config/neo-tree")
		end,
	},
	{
		-- only needed if you want to use the commands with "_with_window_picker" suffix
		"s1n7ax/nvim-window-picker",
		version = "v1.*",
		config = function()
			require("plugins.config.window-picker")
		end,
	},

	-- Icons
	{ "kyazdani42/nvim-web-devicons" },

	-- Formatting
	{ "jayp0521/mason-null-ls.nvim" },
	{
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			require("plugins/lsp/null-ls")
		end,
	},

	-- Rust
	{ "simrat39/rust-tools.nvim" },
	{ "saecki/crates.nvim" },

	{ "kaplanz/nvim-retrail", opts = {} }, -- Trim and highlight whitespace
	{ "andymass/vim-matchup" }, -- Better matching brackets on S-5
	{ "stevearc/dressing.nvim", opts = {} }, -- Pretty UI
	{ "tikhomirov/vim-glsl" }, -- glsl support
	{ "nacro90/numb.nvim", opts = {} }, -- peek line jumps
	{ "ron-rs/ron.vim" }, -- ron file suppoort
	{ "rhysd/clever-f.vim" }, -- better f jumps
	-- { "phaazon/hop.nvim",             opts = {} }, -- best motions
	{ "max397574/better-escape.nvim", opts = { mapping = { "jk", "kj" } } },
	-- { "WhoIsSethDaniel/lualine-lsp-progress.nvim" },          -- interactive lsp status
	{ "rmagatti/goto-preview", opts = {} }, -- peek lsp commands in separate window
	{ "windwp/nvim-spectre", opts = {} }, -- Search and Replace
	{ "NvChad/nvim-colorizer.lua", opts = {} }, -- Color colors in colors
	{ "RRethy/vim-illuminate" }, -- highlight same words with TreeSitter
	{ "kylechui/nvim-surround", event = "VeryLazy", opts = {} }, -- Add/change/delete surrounding brackets
	-- { "f-person/git-blame.nvim" }, --Blame!
	-- embed terminal
	{
		"akinsho/toggleterm.nvim",
		config = function()
			require("plugins.config.toggleterm")
		end,
	},

	{
		"hedyhli/outline.nvim",
		lazy = true,
		cmd = { "Outline", "OutlineOpen" },
		keys = { -- Example mapping to toggle outline
			{ "<F8>", "<cmd>Outline<CR>", desc = "Toggle outline" },
		},
		opts = {
			-- Your setup opts here
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
	-- autoclosing brackets
	{
		"windwp/nvim-autopairs",
		config = function()
			require("plugins.config.autopairs")
		end,
	},
	{ "folke/todo-comments.nvim", opts = { signs = false } },
	-- Structured error messages
	-- { "https://git.sr.ht/~whynothugo/lsp_lines.nvim", opts = {} },
}

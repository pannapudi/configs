--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "onedarker"

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
lvim.keys.normal_mode["?"] = "?\\v"
lvim.keys.normal_mode["/"] = "/\\v"
lvim.keys.normal_mode[";"] = ":"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<leader><leader>"] = "<C-^>"
lvim.keys.normal_mode["<S-h>"] = "^"
lvim.keys.normal_mode["<S-l>"] = "$"
lvim.keys.normal_mode["<F8>"] = "<cmd>Vista!!<cr>"

lvim.keys.visual_mode["<S-h>"] = "^"
lvim.keys.visual_mode["<S-l>"] = "$"

lvim.keys.insert_mode["<C-k>"] = "<Esc>"
lvim.keys.insert_mode["<C-j>"] = "<Esc>"
lvim.keys.visual_mode["<C-k>"] = "<Esc>"
lvim.keys.visual_mode["<C-j>"] = "<Esc>"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = ""
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
lvim.builtin.telescope.on_config_done = function()
	local actions = require("telescope.actions")
	-- for input mode
	lvim.builtin.telescope.defaults.mappings.i["<C-j>"] = actions.move_selection_next
	lvim.builtin.telescope.defaults.mappings.i["<C-k>"] = actions.move_selection_previous
	lvim.builtin.telescope.defaults.mappings.i["<C-n>"] = actions.cycle_history_next
	lvim.builtin.telescope.defaults.mappings.i["<C-p>"] = actions.cycle_history_prev
	-- for normal mode
	lvim.builtin.telescope.defaults.mappings.n["<C-j>"] = actions.move_selection_next
	lvim.builtin.telescope.defaults.mappings.n["<C-k>"] = actions.move_selection_previous
end

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["t"] = {
	name = "+Trouble",
	r = { "<cmd>Trouble lsp_references<cr>", "References" },
	f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
	d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics" },
	q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
	l = { "<cmd>Trouble loclist<cr>", "LocationList" },
	w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
}

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = "maintained"
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings
-- you can set a custom on_attach function that will be used for all the language servers
-- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end
-- you can overwrite the null_ls setup table (useful for setting the root_dir function)
-- lvim.lsp.null_ls.setup = {
--   root_dir = require("lspconfig").util.root_pattern("Makefile", ".git", "node_modules"),
-- }
-- or if you need something more advanced
-- lvim.lsp.null_ls.setup.root_dir = function(fname)
--   if vim.bo.filetype == "javascript" then
--     return require("lspconfig/util").root_pattern("Makefile", ".git", "node_modules")(fname)
--       or require("lspconfig/util").path.dirname(fname)
--   elseif vim.bo.filetype == "php" then
--     return require("lspconfig/util").root_pattern("Makefile", ".git", "composer.json")(fname) or vim.fn.getcwd()
--   else
--     return require("lspconfig/util").root_pattern("Makefile", ".git")(fname) or require("lspconfig/util").path.dirname(fname)
--   end
-- end

-- set a formatter if you want to override the default lsp one (if it exists)
lvim.lang.python.formatters = {
	{
		exe = "black",
	},
}
-- set an additional linter
lvim.lang.python.linters = {
	{
		exe = "flake8",
	},
}
lvim.lang.lua.formatters = {
	{
		exe = "stylua",
		-- args = {},
	},
}
-- lvim.lang.lua.linters = {
-- 	{
-- 		exe = "luacheck",
-- 		-- args = {},
-- 	},
-- }
lvim.lang.c.formatters = { { exe = "clang_format" } }
lvim.lang.cpp.formatters = lvim.lang.c.formatters

-- Additional Plugins
lvim.plugins = {
	{ "folke/tokyonight.nvim" },
	{
		"ray-x/lsp_signature.nvim",
		config = function()
			local cfg = {
				bind = true,
				doc_lines = 10,
				floating_window = false, -- show hint in a floating window, set to false for virtual text only mode
				floating_window_above_cur_line = true,
				fix_pos = false, -- set to true, the floating window will not auto-close until finish all parameters
				hint_enable = true, -- virtual hint enable
				-- hint_prefix = "🐼 ", -- Panda for parameter
				hint_prefix = " ",
				hint_scheme = "String",
				-- use_lspsaga = false, -- set to true if you want to use lspsaga popup
				hi_parameter = "Search", -- how your parameter will be highlight
				max_height = 12, -- max height of signature floating_window, if content is more than max_height, you can scroll down
				-- to view the hiding contents
				max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
				handler_opts = {
					border = "single", -- double, single, shadow, none
				},
				-- transpancy = 80,
				-- extra_trigger_chars = { "(", "," }, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
				zindex = 200, -- by default it will be on top of all floating windows, set to 50 send it to bottom
				debug = false, -- set to true to enable debug logging
				log_path = "debug_log_file_path", -- debug log path
				padding = "", -- character to pad on left and right of signature can be ' ', or '|'  etc
				shadow_blend = 36, -- if you using shadow as border use this set the opacity
				shadow_guibg = "Black", -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
			}
			require("lsp_signature").setup(cfg)
			-- require("lsp_signature").on_attach()
		end,
		event = "InsertEnter",
	},

	{ "liuchengxu/vista.vim" },
	{ "rhysd/clever-f.vim" },
	{ "ron-rs/ron.vim" },
	{ "tikhomirov/vim-glsl" },
	{ "dyng/ctrlsf.vim" },
	{ "mattn/webapi-vim" },
	{ "bronson/vim-trailing-whitespace" },
	{
		"tpope/vim-fugitive",
		cmd = {
			"G",
			"Git",
			"Gdiffsplit",
			"Gread",
			"Gwrite",
			"Ggrep",
			"GMove",
			"GDelete",
			"GBrowse",
			"GRemove",
			"GRename",
			"Glgrep",
			"Gedit",
		},
		ft = { "fugitive" },
	},
	{ "steelsojka/pears.nvim" },
	{ "vimwiki/vimwiki" },
	{ "shaunsingh/nord.nvim" },
	{ "rktjmp/lush.nvim" },
	{ "ellisonleao/gruvbox.nvim" },
	{ "tjdevries/colorbuddy.vim" },
	{ "tjdevries/gruvbuddy.nvim" },
	{ "DingDean/wgsl.vim" },
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "make",
		after = "telescope.nvim",
		config = function()
			require("telescope").load_extension("fzf")
		end,
	},

	{
		"rmagatti/goto-preview",
		config = function()
			require("goto-preview").setup({
				width = 120, -- Width of the floating window
				height = 25, -- Height of the floating window
				default_mappings = false, -- Bind default mappings
				debug = false, -- Print debug information
				opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
				post_open_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
				-- You can use "default_mappings = true" setup option
				-- Or explicitly set keybindings
				vim.cmd("nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>"),
				vim.cmd("nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>"),
				vim.cmd("nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>"),
			})
		end,
	},
	{
		"simrat39/symbols-outline.nvim",
		cmd = "SymbolsOutline",
	},
	{
		"folke/trouble.nvim",
		cmd = "TroubleToggle",
	},

	{
		"monaqa/dial.nvim",
		event = "BufRead",
		config = function()
			local dial = require("dial")
			vim.cmd([[
        nmap <C-a> <Plug>(dial-increment)
          nmap <C-x> <Plug>(dial-decrement)
          vmap <C-a> <Plug>(dial-increment)
          vmap <C-x> <Plug>(dial-decrement)
          vmap g<C-a> <Plug>(dial-increment-additional)
          vmap g<C-x> <Plug>(dial-decrement-additional)
        ]])

			dial.augends["custom#boolean"] = dial.common.enum_cyclic({
				name = "boolean",
				strlist = { "true", "false" },
			})
			table.insert(dial.config.searchlist.normal, "custom#boolean")

			-- For Languages which prefer True/False, e.g. python.
			dial.augends["custom#Boolean"] = dial.common.enum_cyclic({
				name = "Boolean",
				strlist = { "True", "False" },
			})
			table.insert(dial.config.searchlist.normal, "custom#Boolean")
		end,
	},
	{
		"npxbr/glow.nvim",
		ft = { "markdown" },
		-- run = "yay -S glow"
	},
	{
		"phaazon/hop.nvim",
		event = "BufRead",
		config = function()
			require("hop").setup()
			vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true })
			vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })
		end,
	},
	{
		"ggandor/lightspeed.nvim",
		event = "BufRead",
	},
	{
		"windwp/nvim-spectre",
		event = "BufRead",
		config = function()
			require("spectre").setup()
		end,
	},
	{
		"camspiers/snap",
		rocks = "fzy",
		config = function()
			local snap = require("snap")
			local layout = snap.get("layout").bottom
			local file = snap.config.file:with({ consumer = "fzy", layout = layout })
			local vimgrep = snap.config.vimgrep:with({ layout = layout })
			snap.register.command("find_files", file({ producer = "ripgrep.file" }))
			snap.register.command("buffers", file({ producer = "vim.buffer" }))
			snap.register.command("oldfiles", file({ producer = "vim.oldfile" }))
			snap.register.command("live_grep", vimgrep({}))
		end,
	},
	{
		"andymass/vim-matchup",
		event = "CursorMoved",
		config = function()
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
		end,
	},
	{
		"nacro90/numb.nvim",
		event = "BufRead",
		config = function()
			require("numb").setup({
				show_numbers = true, -- Enable 'number' for the window while peeking
				show_cursorline = true, -- Enable 'cursorline' for the window while peeking
			})
		end,
	},
	{
		"kevinhwang91/nvim-bqf",
		event = { "BufRead", "BufNew" },
		config = function()
			require("bqf").setup({
				auto_enable = true,
				preview = {
					win_height = 12,
					win_vheight = 12,
					delay_syntax = 80,
					border_chars = { "┃", "┃", "━", "━", "┏", "┓", "┗", "┛", "█" },
				},
				func_map = {
					vsplit = "",
					ptogglemode = "z,",
					stoggleup = "",
				},
				filter = {
					fzf = {
						action_for = { ["ctrl-s"] = "split" },
						extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
					},
				},
			})
		end,
	},
	{
		"metakirby5/codi.vim",
		cmd = "Codi",
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufRead",
		setup = function()
			vim.g.indentLine_enabled = 1
			vim.g.indent_blankline_char = "▏"
			vim.g.indent_blankline_filetype_exclude = { "help", "terminal", "dashboard" }
			vim.g.indent_blankline_buftype_exclude = { "terminal" }
			vim.g.indent_blankline_show_trailing_blankline_indent = false
			vim.g.indent_blankline_show_first_indent_level = false
		end,
	},
	{
		"ethanholz/nvim-lastplace",
		event = "BufRead",
		config = function()
			require("nvim-lastplace").setup({
				lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
				lastplace_ignore_filetype = {
					"gitcommit",
					"gitrebase",
					"svn",
					"hgcommit",
				},
				lastplace_open_folds = true,
			})
		end,
	},
	{
		"simrat39/rust-tools.nvim",
		config = function()
			local status_ok, rust_tools = pcall(require, "rust-tools")
			if not status_ok then
				return
			end

			local opts = {
				tools = { -- rust-tools options
					-- automatically set inlay hints (type hints)
					-- There is an issue due to which the hints are not applied on the first
					-- opened file. For now, write to the file to trigger a reapplication of
					-- the hints or just run :RustSetInlayHints.
					-- default: true
					autoSetHints = true,

					-- whether to show hover actions inside the hover window
					-- this overrides the default hover handler
					-- default: true
					hover_with_actions = true,

					runnables = {
						-- whether to use telescope for selection menu or not
						-- default: true
						use_telescope = true,

						-- rest of the opts are forwarded to telescope
					},

					inlay_hints = {
						-- wheter to show parameter hints with the inlay hints or not
						-- default: true
						show_parameter_hints = true,

						-- prefix for parameter hints
						-- default: "<-"
						parameter_hints_prefix = "<-",

						-- prefix for all the other hints (type, chaining)
						-- default: "=>"
						other_hints_prefix = "=> ",

						-- whether to align to the lenght of the longest line in the file
						max_len_align = false,

						-- padding from the left if max_len_align is true
						max_len_align_padding = 1,

						-- whether to align to the extreme right or not
						right_align = false,

						-- padding from the right if right_align is true
						right_align_padding = 7,

						highlight = "Comment",
					},

					hover_actions = {
						-- the border that is used for the hover window
						-- see vim.api.nvim_open_win()
						border = {
							{ "╭", "FloatBorder" },
							{ "─", "FloatBorder" },
							{ "╮", "FloatBorder" },
							{ "│", "FloatBorder" },
							{ "╯", "FloatBorder" },
							{ "─", "FloatBorder" },
							{ "╰", "FloatBorder" },
							{ "│", "FloatBorder" },
						},
					},
				},

				-- all the opts to send to nvim-lspconfig
				-- these override the defaults set by rust-tools.nvim
				-- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
				server = {
					cmd = { vim.fn.stdpath("data") .. "/lspinstall/rust/rust-analyzer" },
					on_attach = require("lsp").common_on_attach,
					on_init = require("lsp").common_on_init,
					settings = {
						["rust-analyzer"] = {
							checkOnSave = {
								command = "clippy",
							},
						},
					},
				}, -- rust-analyser options
			}
			rust_tools.setup(opts)
		end,
		ft = { "rust", "rs" }, -- or you can not lazy load and remove this line
	},
	{
		"Saecki/crates.nvim",
		config = function()
			require("cmp").setup.buffer({ sources = { { name = "crates" } } })
		end,
		requires = { "nvim-lua/plenary.nvim" },
	},
}

vim.cmd([[set shell=/bin/bash]])

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
lvim.autocommands.custom_groups = {
	-- c, cpp
	{ "Filetype", "c,cpp", "nnoremap <leader>m <cmd>lua require('core.terminal')._exec_toggle('make ;read')<CR>" },
	{ "Filetype", "c,cpp", "nnoremap <leader>r <cmd>lua require('core.terminal')._exec_toggle('make run;read')<CR>" },
	{ "Filetype", "c,cpp", "nnoremap <leader>H <Cmd>ClangdSwitchSourceHeader<CR>" },

	-- python
	{
		"Filetype",
		"python",
		"nnoremap <leader>r <cmd>lua require('core.terminal')._exec_toggle('python "
			.. vim.fn.expand("%")
			.. ";read')<CR>",
	},
	{
		"Filetype",
		"python",
		"nnoremap <leader>m <cmd>lua require('core.terminal')._exec_toggle('echo \"compile :pepelaugh:\";read')<CR>",
	},

	-- glsl
	{ "Filetype", "glsl", "map", "<C-K>", ":pyf ~/bins/clang-format.py<cr>" },

	-- rust
	{ "Filetype", "rust", "nnoremap <leader>m <cmd>lua require('core.terminal')._exec_toggle('cargo build;read')<CR>" },
	{ "Filetype", "rust", "nnoremap <leader>r <cmd>lua require('core.terminal')._exec_toggle('cargo run;read')<CR>" },
	{ "Filetype", "rust", "nnoremap <leader>H <cmd>lua require('core.terminal')._exec_toggle('cargo clippy;read')<CR>" },
	{ "Filetype", "rust", "nnoremap <leader>lm <Cmd>RustExpand<CR>" },
	-- { "Filetype", "rust", "nnoremap <leader>lH <Cmd>RustToggleInlayHints<CR>" },
	{ "Filetype", "rust", "nnoremap <leader>le <Cmd>lua require('rust-tools.runnables').runnables()<CR>" },
	-- { "Filetype", "rust", "nnoremap <leader>lh <Cmd>RustHoverActions<CR>" },
	-- uncomment the following if you want to show diagnostics on hover
	-- { "CursorHold", "*", "lua vim.lsp.diagnostic.show_line_diagnostics({ show_header = false, border = 'single' })" },
}
lvim.builtin.which_key.mappings["m"] = { "Build" }
lvim.builtin.which_key.mappings["r"] = { "Run" }
lvim.builtin.which_key.mappings["H"] = { "Check" }

return {
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"folke/trouble.nvim",
		-- { "nvim-telescope/telescope-ui-select.nvim" },
	},
	config = function()
		local telescope = require("telescope")
		local trouble = require("trouble.sources.telescope")

		pcall(require("telescope").load_extension, "fzf")
		-- pcall(require("telescope").load_extension, "ui-select")

		local keymap = function(mode, lhs, rhs, str)
			local opts = { desc = str, noremap = true, silent = true }
			vim.keymap.set(mode, lhs, rhs, opts)
		end
		local builtin = require("telescope.builtin")
		keymap("n", "<C-p>", builtin.find_files, "Search Files")
		keymap("n", "<leader>ff", builtin.live_grep, "Grep search")
		keymap("n", "<leader>fg", builtin.grep_string, "Grep String")
		vim.keymap.set("n", "<leader>fs", function()
			builtin.grep_string({ search = vim.fn.input("Grep > "), only_sort_text = true })
		end, { desc = "Grep Filter String", noremap = true })
		keymap("n", "<leader>fp", ":Telescope projects<CR>", "Search Project")
		keymap("n", "<leader>fb", builtin.buffers, "Search buffers")

		local actions = require("telescope.actions")
		telescope.setup({
			defaults = {
				find_command = {
					"rg",
					"--no-heading",
					-- "--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
				},
				prompt_prefix = " ",
				selection_caret = " ",
				path_display = { "smart" },
				file_ignore_patterns = { ".git/", "node_modules" },
				extensions = {
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
						-- the default case_mode is "smart_case"
					},
				},
				mappings = {
					i = {
						["<C-n>"] = actions.cycle_history_next,
						["<C-p>"] = actions.cycle_history_prev,

						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,

						["<C-c>"] = actions.close,

						["<Down>"] = actions.move_selection_next,
						["<Up>"] = actions.move_selection_previous,

						["<CR>"] = actions.select_default,
						["<C-x>"] = actions.select_horizontal,
						["<C-v>"] = actions.select_vertical,
						["<C-t>"] = actions.select_tab,

						["<C-u>"] = actions.preview_scrolling_up,
						["<C-d>"] = actions.preview_scrolling_down,

						["<PageUp>"] = actions.results_scrolling_up,
						["<PageDown>"] = actions.results_scrolling_down,

						["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
						["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
						["<C-q>"] = trouble.open,
						["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
						["<C-l>"] = actions.complete_tag,
						["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
						["<esc>"] = actions.close,
					},
					n = {
						["<esc>"] = actions.close,
						["<CR>"] = actions.select_default,
						["<C-x>"] = actions.select_horizontal,
						["<C-v>"] = actions.select_vertical,
						["<C-t>"] = actions.select_tab,

						["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
						["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
						["<C-q>"] = trouble.open,
						["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

						["j"] = actions.move_selection_next,
						["k"] = actions.move_selection_previous,
						["H"] = actions.move_to_top,
						["M"] = actions.move_to_middle,
						["L"] = actions.move_to_bottom,

						["<Down>"] = actions.move_selection_next,
						["<Up>"] = actions.move_selection_previous,
						["gg"] = actions.move_to_top,
						["G"] = actions.move_to_bottom,

						["<C-u>"] = actions.preview_scrolling_up,
						["<C-d>"] = actions.preview_scrolling_down,

						["<PageUp>"] = actions.results_scrolling_up,
						["<PageDown>"] = actions.results_scrolling_down,

						["?"] = actions.which_key,
					},
				},
			},
		})
	end,
}

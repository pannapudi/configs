return {
	"saghen/blink.cmp",
	event = "VimEnter",
	dependencies = {
		{
			"L3MON4D3/LuaSnip",
			build = (function()
				if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
					return
				end
				return "make install_jsregexp"
			end)(),
			dependencies = {},
			opts = {},
		},
		"folke/lazydev.nvim",
	},
	opts = {
		keymap = {
			["<Tab>"] = {
				function(cmp)
					local has_words_before = function()
						local col = vim.api.nvim_win_get_cursor(0)[2]
						if col == 0 then
							return false
						end
						return vim.api.nvim_get_current_line():sub(col, col):match("%s") == nil
					end
					if has_words_before() then
						return cmp.select_next()
					end
				end,
				"snippet_forward",
				"fallback",
			},

			["<S-Tab>"] = { "insert_prev", "snippet_backward", "fallback" },
			["<CR>"] = { "select_and_accept", "fallback" },
		},

		appearance = {
			nerd_font_variant = "mono",
		},

		completion = {
			documentation = { auto_show = true, auto_show_delay_ms = 0 },
			menu = { draw = { treesitter = { "lsp" } } },
		},

		snippets = { preset = "luasnip" },
		fuzzy = { implementation = "prefer_rust_with_warning" },
		signature = { enabled = true },
		sources = {
			default = { "lsp", "snippets", "omni", "buffer", "path", "lazydev" },
			providers = {
				lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
			},
		},
	},
}

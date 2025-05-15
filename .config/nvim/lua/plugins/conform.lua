return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	keys = {
		{
			"<leader>lf",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = "",
			desc = "[F]ormat buffer",
		},
	},
	opts = {
		notify_on_error = false,
		format_on_save = {
			-- These options will be passed to conform.format()
			timeout_ms = 500,
			lsp_fallback = true,
		},
		formatters_by_ft = {
			-- typst = { "typstfmt" },
			lua = { "stylua" },
			c = { "clang-format" },
			cpp = { "clang-format" },
			wgsl = { "clang-format" },
			glsl = { "clang-format" },
			["*"] = { "codespell" },
		},
	},
}

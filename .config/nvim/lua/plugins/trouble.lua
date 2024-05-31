return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	cmd = "Trouble",
	config = function()
		vim.keymap.set("n", "<C-q>", function()
			require("trouble").toggle()
		end, { desc = "Trouble: Toggle" })
		vim.keymap.set(
			"n",
			"<leader>xW",
			"<cmd>Trouble diagnostics toggle<cr>",
			{ desc = "Trouble: Workspace Diagnostics" }
		)
		vim.keymap.set("n", "<leader>xw", function()
			require("trouble").toggle("document_diagnostics")
		end, { desc = "Trouble: Document Diagnostics" })
		vim.keymap.set("n", "gR", function()
			require("trouble").toggle("lsp_references")
		end, { desc = "Trouble: References" })
		vim.keymap.set("n", "<A-j>", function()
			require("trouble").next({ skip_groups = true, jump = true })
		end, { desc = "Trouble: Next" })
		vim.keymap.set("n", "<A-k>", function()
			require("trouble").prev({ skip_groups = true, jump = true })
		end, { desc = "Trouble: Previous" })
	end,
}

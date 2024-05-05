return {
	"numToStr/Comment.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local api = require("Comment.api")
		vim.keymap.set("n", "<leader>/", api.toggle.linewise.current, {desc = "Comment line", silent = true})
		local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
		vim.keymap.set("x", "<leader>/", function()
			vim.api.nvim_feedkeys(esc, "nx", false)
			api.toggle.linewise(vim.fn.visualmode())
		end, {silent = true})
	end,
}

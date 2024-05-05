local M = {}

-- Shorten function name
M.keymap = function(mode, lhs, rhs, str)
	local opts = { desc = str, noremap = true, silent = true }
	vim.keymap.set(mode, lhs, rhs, opts)
end

return M

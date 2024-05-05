local keymap = function(mode, lhs, rhs, str)
	local opts = { desc = str, noremap = true, silent = true }
	vim.keymap.set(mode, lhs, rhs, opts)
end

vim.keymap.set({ "n", "v" }, "q:", "<Nop>", { silent = true })
vim.keymap.set({ "n", "v" }, "Q:", "<Nop>", { silent = true })

keymap("n", ";", ":", "")
keymap("n", "<C-s>", "<Cmd>write<CR>", "Safe file")

keymap("n", "<leader><leader>", "<C-^>", "Toggle between buffers")

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", "")
keymap("n", "<C-j>", "<C-w>j", "")
keymap("n", "<C-k>", "<C-w>k", "")
keymap("n", "<C-l>", "<C-w>l", "")

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", "")
keymap("n", "<C-Down>", ":resize +2<CR>", "")
keymap("n", "<C-Left>", ":vertical resize -2<CR>", "")
keymap("n", "<C-Right>", ":vertical resize +2<CR>", "")

keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", "Clear highlights")

keymap("n", "<leader>w", ':e <C-R>=expand("%:p:h") . "/" <CR>', "Open new file adjacent to current")

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Better paste
keymap("v", "p", '"_dP', "")

-- Stay in indent mode
keymap("v", "<", "<gv", "")
keymap("v", ">", ">gv", "")

-- Move selected line / block of text in visual mode
keymap("x", "K", ":move '<-2<CR>gv-gv", "")
keymap("x", "J", ":move '>+1<CR>gv-gv", "")

-- Move current line / block with Alt-j/k ala vscode.
keymap("x", "<A-j>", ":m '>+1<CR>gv-gv", "")
keymap("x", "<A-k>", ":m '<-2<CR>gv-gv", "")

-- NvimTree
keymap("n", "<leader>e", ":NeoTreeFocusToggle<CR>", "File Tree")

-- QuickFix
keymap("n", "]q", ":cnext<CR>", "")
keymap("n", "[q", ":cprev<CR>", "")
keymap("n", "<C-q>", ":call QuickFixToggle()<CR>", "")

-- Telescope
local builtin = require("telescope.builtin")
keymap("n", "<C-p>", builtin.find_files, "Search Files")
keymap("n", "<leader>ff", builtin.live_grep, "Grep search")
keymap("n", "<leader>fg", builtin.grep_string, "Grep String")
keymap("n", "<leader>fp", ":Telescope projects<CR>", "Search Project")
keymap("n", "<leader>fb", builtin.buffers, "Search buffers")

-- Commentary
local api = require("Comment.api")
keymap("n", "<leader>/", api.toggle.linewise.current, "Comment line")
local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
keymap("x", "<leader>/", function()
	vim.api.nvim_feedkeys(esc, "nx", false)
	api.toggle.linewise(vim.fn.visualmode())
end)

-- Fugitive
keymap("n", "<leader>gh", "<cmd>diffget //3<CR>", "Fugitive: Put Right")
keymap("n", "<leader>gf", "<cmd>diffget //2<CR>", "Fugitive: Put Left")

-- Lsp lines
keymap("n", "<Leader>lt", "<cmd>lua require('lsp_lines').toggle()<cr>", "Toggle lsp_lines")

-- DAP
keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Dap: Toggle Breakpoint")
keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", "Dap: Continue")
keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", "Dap: Step Into")
keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", "Dap: Step Over")
keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", "Dap: Step Out")
keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", "Dap: Repl Toggle")
keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", "Dap: Run Last")
keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", "DapUI: Toggle")
keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", "Dap: Terminate")

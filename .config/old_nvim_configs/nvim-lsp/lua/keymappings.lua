local map = require("util").map

map("n", ";", ":")

map("n", "<C-s>", "<Cmd>w<CR>")

map("n", "Y", "y$")

map("i", "<C-j>", "<ESC>")
map("v", "<C-j>", "<ESC>")
map("i", "<C-k>", "<ESC>")
map("v", "<C-k>", "<ESC>")

-- Move current line / block with Alt-j/k a la vscode.
map("n", "<A-j>", ":m .+1<CR>==")
map("n", "<A-k>", ":m .-2<CR>==")

-- QuickFix
map("n", "]q", ":cnext<CR>")
map("n", "[q", ":cprev<CR>")
map("n", "<C-q>", ":call QuickFixToggle()<CR>")

map("n", "<leader>h", "<cmd>noh<CR>")

map("v", "<leader>p", '"_dP')

-- Better window movement
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Move selected line / block of text in visual mode
map("x", "K", ":move '<-2<CR>gv-gv")
map("x", "J", ":move '>+1<CR>gv-gv")

-- Move current line / block with Alt-j/k ala vscode.
map("x", "<A-j>", ":m '>+1<CR>gv-gv")
map("x", "<A-k>", ":m '<-2<CR>gv-gv")

-- <leader><leader> toggles between buffers
map("n", "<leader><leader>", "<C-^>")

-- <leader>, shows/hides hidden characters
map("n", "<leader>,", "<Cmd>set invlist<cr>")

vim.api.nvim_exec(
	[[
map H ^
map L $

" Open new file adjacent to current file
nnoremap <leader>w :e <C-R>=expand("%:p:h") . "/" <CR>
]],
	false
)

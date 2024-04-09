local keymap = function(mode, lhs, rhs, str)
	local opts = { desc = str, noremap = true, silent = true }
	vim.keymap.set(mode, lhs, rhs, opts)
end

vim.keymap.set({ "n", "v" }, "q:", "<Nop>", { silent = true })
vim.keymap.set({ "n", "v" }, "Q:", "<Nop>", { silent = true })

keymap("n", ";", ":", "")
keymap("n", "Q", "q", "")
keymap("n", "<C-s>", "<Cmd>write<CR>", "Safe file")

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

vim.keymap.set("n", "<leader>w", ':e <C-R>=expand("%:p:h") . "/" <CR>', {desc = "Open new file adjacent to current", noremap = true})

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Stay in indent mode
keymap("v", "<", "<gv", "")
keymap("v", ">", ">gv", "")

keymap("n", "<leader><leader>", "<C-^>", "Toggle between buffers")

-- Move current line / block with Alt-j/k ala vscode.
keymap("x", "<A-j>", ":m '>+1<CR>gv-gv", "Move lines down in visual mode")
keymap("x", "<A-k>", ":m '<-2<CR>gv-gv", "Move lines up in visual mode")

-- QuickFix
keymap("n", "]q", ":cnext<CR>", "")
keymap("n", "[q", ":cprev<CR>", "")
-- keymap("n", "<C-q>", ":call QuickFixToggle()<CR>", "")

-- keymaps
keymap("n", "<leader>e", ":Neotree toggle left<CR>")

-- Fugitive
keymap("n", "<leader>gh", "<cmd>diffget //3<CR>", "Fugitive: Put Right")
keymap("n", "<leader>gf", "<cmd>diffget //2<CR>", "Fugitive: Put Left")

-- Stay in middle
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

keymap("x", "<leader>p", "\"_dP", "Paste withoutt overwriting history")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], {noremap = true, desc = "Replace word under cursor"})
keymap("n", "<leader>x", "<cmd>!chmod +x %<CR>", "Execute script in vim")

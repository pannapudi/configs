-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

keymap("n", ";", ":", opts)
keymap("n", "<C-s>", "<Cmd>write<CR>", opts)

-- <leader><leader> toggles between buffers
keymap("n", "<leader><leader>", "<C-^>")

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Clear highlights
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- Close buffers
keymap("n", "<S-q>", "<cmd>Bdelete!<CR>", opts)

-- <leader>, shows/hides hidden characters
keymap("n", "<leader>,", "<Cmd>set invlist<cr>", opts)

-- Open new file adjacent to current file
keymap("n", "<leader>w", ':e <C-R>=expand("%:p:h") . "/" <CR>', { silent = false })

-- Better paste
keymap("v", "p", '"_dP', opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move selected line / block of text in visual mode
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)

-- Move current line / block with Alt-j/k ala vscode.
keymap("x", "<A-j>", ":m '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":m '<-2<CR>gv-gv", opts)

-- NvimTree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- QuickFix
keymap("n", "]q", ":cnext<CR>", opts)
keymap("n", "[q", ":cprev<CR>", opts)
keymap("n", "<C-q>", ":call QuickFixToggle()<CR>", opts)

-- Status outline
keymap("n", "<F8>", "<cmd>SymbolsOutline<CR>", opts)

-- Telescope
local builtin = require("telescope.builtin")
keymap("n", "<C-p>", builtin.find_files, opts)
keymap("n", "<leader>ff", builtin.live_grep, opts)
keymap("n", "<leader>fg", builtin.grep_string, opts)
keymap("n", "<leader>fp", ":Telescope projects<CR>", opts)
keymap("n", "<leader>fb", builtin.buffers, opts)

-- Hop
keymap("n", "s", ":HopChar2<cr>", opts)
keymap("n", "S", ":HopWord<cr>", opts)

-- Goto preview
keymap("n", "gpd", "<Cmd>lua require('goto-preview').goto_preview_definition()<CR>", opts)
keymap("n", "gpi", "<Cmd>lua require('goto-preview').goto_preview_implementation()<CR>", opts)
keymap("n", "gP", "<Cmd>lua require('goto-preview').close_all_win()<CR>", opts)

-- Commentary
local api = require("Comment.api")
keymap("n", "<leader>/", api.toggle.linewise.current, opts)
local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
keymap("x", "<leader>/", function()
	vim.api.nvim_feedkeys(esc, "nx", false)
	api.toggle.linewise(vim.fn.visualmode())
end)

-- Trouble
keymap("n", "tr", "<cmd>Trouble lsp_references<cr>", opts)
keymap("n", "tf", "<cmd>Trouble lsp_definitions<cr>", opts)
keymap("n", "tq", "<cmd>Trouble quickfix<cr>", opts)
keymap("n", "tl", "<cmd>Trouble loclist<cr>", opts)
keymap("n", "tw", "<cmd>Trouble document_diagnostics<cr>", opts)
keymap("n", "tW", "<cmd>Trouble workspace_diagnostics<cr>", opts)

-- DAP
keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts)
keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts)
keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)

-- Fugitive
keymap("n", "<leader>gh", "<cmd>diffget //3<CR>", opts)
keymap("n", "<leader>gf", "<cmd>diffget //2<CR>", opts)

-- AutoTrip whitespaces
vim.api.nvim_exec(
	[[
    fun! TrimWhitespace()
        let l:save = winsaveview()
        keeppatterns %s/\s\+$//e
        call winrestview(l:save)
    endfun

    function! QuickFixToggle()
	if empty(filter(getwininfo(), 'v:val.quickfix'))
    copen
    else
    cclose
    endif
    endfunction

    autocmd FileType lua,go,rust,c,c++,html,typescript,javascript,python autocmd BufWritePre <buffer> call TrimWhitespace()
]],
	false
)

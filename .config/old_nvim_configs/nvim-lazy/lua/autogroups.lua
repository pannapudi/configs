local autocmd = vim.api.nvim_create_autocmd

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

-- Use 'q' to quit from common plugins
autocmd({ "FileType" }, {
	pattern = { "qf", "help", "man", "lspinfo", "spectre_panel", "lir" },
	callback = function()
		vim.cmd([[
      nnoremap <silent> <buffer> q :close<CR>
      set nobuflisted
    ]])
	end,
})

autocmd("FileType", {
	pattern = { "glsl" },
	callback = function()
		vim.keymap.set(
			"n",
			"<C-f>",
			"<cmd>pyf ~/bins/clang-format.py<cr>",
			{ desc = "Format with clang-format", noremap = true, silent = true }
		)
	end,
})

vim.cmd([[
    autocmd Filetype c,cpp nnoremap <leader>H <Cmd>ClangdSwitchSourceHeader<CR>

    autocmd Filetype rust nnoremap <leader>m <cmd>lua require('plugins.config.toggleterm').exec_toggle('cargo build;read')<CR>
    autocmd Filetype rust nnoremap <leader>r <cmd>lua require('plugins.config.toggleterm').exec_toggle('cargo run;read')<CR>
    autocmd Filetype rust nnoremap <leader>R <cmd>lua require('plugins.config.toggleterm').exec_toggle('cargo run --release;read')<CR>
    autocmd Filetype rust nnoremap <leader>t <cmd>lua require('plugins.config.toggleterm').exec_toggle('cargo test;read')<CR>
    autocmd Filetype rust nnoremap <leader>H <cmd>lua require('plugins.config.toggleterm').exec_toggle('cargo clippy;read')<CR>
    autocmd Filetype rust nnoremap <leader>le <Cmd>RustRunnables<CR>
]])

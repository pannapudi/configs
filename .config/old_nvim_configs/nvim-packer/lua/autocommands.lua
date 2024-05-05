local autocmd = vim.api.nvim_create_autocmd

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

-- Set wrap and spell in markdown and gitcommit
autocmd({ "FileType" }, {
	pattern = { "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

vim.cmd("autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif")

-- Fixes Autocomment
autocmd({ "BufWinEnter" }, {
	callback = function()
		vim.cmd("set formatoptions-=cro")
	end,
})

-- Highlight Yanked Text
autocmd({ "TextYankPost" }, {
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
	end,
})

vim.cmd([[
    autocmd Filetype glsl,wgsl nnoremap <C-f> <cmd>pyf ~/bins/clang-format.py<cr>
    autocmd Filetype wgsl,c,cpp,glsl,javascript,typescript,java,lua set tabstop=4 shiftwidth=4

    autocmd Filetype c,cpp nnoremap <leader>m <cmd>lua require('user.toggleterm').exec_toggle('make -B;read')<CR>
    autocmd Filetype c,cpp nnoremap <leader>r <cmd>lua require('user.toggleterm').exec_toggle('make -B && make -B run;read')<CR>
    autocmd Filetype c,cpp nnoremap <leader>H <Cmd>ClangdSwitchSourceHeader<CR>

    autocmd Filetype java nnoremap <leader>r <cmd>lua require('toggleterm.terminal').Terminal:new {cmd='mvn package;read', hidden =false}:toggle()<CR>
    autocmd Filetype java nnoremap <leader>m <cmd>lua require('toggleterm.terminal').Terminal:new {cmd='mvn compile;read', hidden =false}:toggle()<CR>

    autocmd Filetype python nnoremap <leader>r <cmd>lua require('user.toggleterm').exec_toggle('python " .. vim.fn.expand("%") .. ";read')<CR>
    autocmd Filetype python nnoremap <leader>m <cmd>lua require('user.toggleterm').exec_toggle('echo \"compile :pepelaugh:\";read')<CR>

    autocmd Filetype rust nnoremap <leader>m <cmd>lua require('user.toggleterm').exec_toggle('cargo build;read')<CR>
    autocmd Filetype rust nnoremap <leader>r <cmd>lua require('user.toggleterm').exec_toggle('cargo run;read')<CR>
    autocmd Filetype rust nnoremap <leader>R <cmd>lua require('user.toggleterm').exec_toggle('cargo run --release;read')<CR>
    autocmd Filetype rust nnoremap <leader>t <cmd>lua require('user.toggleterm').exec_toggle('cargo test;read')<CR>
    autocmd Filetype rust nnoremap <leader>H <cmd>lua require('user.toggleterm').exec_toggle('cargo clippy;read')<CR>
    autocmd Filetype rust nnoremap <leader>lm <Cmd>RustExpandMacro<CR>
    autocmd Filetype rust nnoremap <leader>lH <Cmd>RustToggleInlayHints<CR>
    autocmd Filetype rust nnoremap <leader>le <Cmd>RustRunnables<CR>
    autocmd Filetype rust nnoremap <leader>lh <Cmd>RustHoverActions<CR>
]])

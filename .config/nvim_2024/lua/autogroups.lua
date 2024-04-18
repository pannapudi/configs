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

local Terminal = require("toggleterm.terminal").Terminal
local exec_toggle = function(exec)
	local exec_term = Terminal:new({ cmd = exec, hidden = true })
	exec_term:toggle()
end

autocmd({ "FileType" }, {
	pattern = { "rust" },
	callback = function()
		vim.keymap.set("n", "<leader>m", function()
			exec_toggle("cargo build;read")
		end)
		vim.keymap.set("n", "<leader>r", function()
			exec_toggle("cargo run;read")
		end)
		vim.keymap.set("n", "<leader>R", function()
			exec_toggle("cargo run --release;read")
		end)
		vim.keymap.set("n", "<leader>t", function()
			exec_toggle("cargo test;read")
		end)
		vim.keymap.set("n", "<leader>H", function()
			exec_toggle("cargo clippy;read")
		end)
		vim.keymap.set("n", "<leader>lm", "<Cmd>RustExpandMacro<cr>")
		vim.keymap.set("n", "<leader>lH", "<Cmd>RustToggleInlayHints<cr>")
		vim.keymap.set("n", "<leader>le", "<Cmd>RustRunnables<cr>")
	end,
})

vim.cmd([[
    autocmd Filetype c,cpp nnoremap <leader>m <cmd>lua exec_toggle('make -B;read')<CR>
    autocmd Filetype c,cpp nnoremap <leader>r <cmd>lua exec_toggle('make -B && make -B run;read')<CR>
    autocmd Filetype c,cpp nnoremap <leader>H <Cmd>ClangdSwitchSourceHeader<CR>

    autocmd Filetype java nnoremap <leader>r <cmd>lua Terminal:new {cmd='mvn package;read', hidden =false}:toggle()<CR>
    autocmd Filetype java nnoremap <leader>m <cmd>lua Terminal:new {cmd='mvn compile;read', hidden =false}:toggle()<CR>

    autocmd Filetype python nnoremap <leader>r <cmd>lua exec_toggle('python " .. vim.fn.expand("%") .. ";read')<CR>
    autocmd Filetype python nnoremap <leader>m <cmd>lua exec_toggle('echo \"compile :pepelaugh:\";read')<CR>

]])

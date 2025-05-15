local autocmd = vim.api.nvim_create_autocmd

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
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
		-- vim.keymap.set("n", "<leader>lm", "<Cmd>RustExpandMacro<cr>")
		-- vim.keymap.set("n", "<leader>lH", "<Cmd>RustToggleInlayHints<cr>")
		-- vim.keymap.set("n", "<leader>le", "<Cmd>RustRunnables<cr>")
	end,
})

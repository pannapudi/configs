vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)
vim.opt.mouse = "a" -- allow the mouse to be used in neovim
vim.opt.number = true -- set numbered lines
vim.opt.relativenumber = true -- set relative numbers
vim.opt.breakindent = true -- Enable break indent
vim.opt.undofile = true -- enable persistent undo
vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.smartcase = true -- smart case
vim.opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
vim.opt.colorcolumn = "100" -- show vertical line on 100th character
vim.opt.splitbelow = true -- force all horizontal splits to go below current window
vim.opt.splitright = true -- force all vertical splits to go to the right of current window
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.inccommand = "split" -- Preview substitutions live, as you type!
vim.opt.spell = true -- enable spell checking
vim.opt.fillchars.eob = " " -- show empty lines at the end of a buffer as ` ` {default `~`}
vim.opt.scrolloff = 5 -- minimal number of screen lines to keep above and below the cursor
vim.opt.shiftwidth = 4 -- the number of spaces inserted for each indentation
vim.opt.tabstop = 4 -- insert 4 spaces for a tab
vim.opt.expandtab = true -- don't expand tab
vim.opt.timeoutlen = 300 -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.timeout = true -- keep timeout turned on
vim.opt.updatetime = 100 -- faster completion (4000ms default)
vim.opt.hlsearch = true -- highlight all matches on previous search pattern
vim.opt.incsearch = true -- incrementally highlight all matches in search
vim.opt.cmdheight = 1 -- more space in the neovim command line for displaying messages

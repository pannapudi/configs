-- Map <leader> to Space
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

require("lazy_bootstrap")
require("options")
require("autogroups")
require("keymaps")

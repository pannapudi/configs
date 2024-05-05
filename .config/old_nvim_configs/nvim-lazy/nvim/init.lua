-- Map <leader> to Space
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

require("lazy_bootstrap")
require("impatient")
require("options")
require("keymaps")
require("autogroups")

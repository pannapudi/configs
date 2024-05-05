require("better_escape").setup({
	mapping = { "jk", "jj", "kj" },
})

require("hop").setup()

require("nvim-lastplace").setup({
	lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
	lastplace_ignore_filetype = {
		"gitcommit",
		"gitrebase",
		"svn",
		"hgcommit",
	},
	lastplace_open_folds = true,
})

require("goto-preview").setup({})

require("numb").setup()

require("bqf").setup({
	auto_enable = true,
	auto_resize_height = true, -- highly recommended enable
})

require("symbols-outline").setup({
	width = 15,
	auto_preview = false,
})

require("nvim-surround").setup()

require("neogit").setup({
	integrations = {
		diffview = true,
	},
})

-- require("fidget").setup()

require("alpha").setup(require("alpha.themes.dashboard").config)

require("color-picker")

require("transparent").setup({
	enable = true, -- boolean: enable transparent
	extra_groups = { -- table/string: additional groups that should be cleared
		"all",
		"BufferLineTabClose",
		"BufferlineBufferSelected",
		"BufferLineFill",
		"BufferLineBackground",
		"BufferLineSeparator",
		"BufferLineIndicatorSelected",
	},
	exclude = {}, -- table: groups you don't want to clear
})
vim.cmd([[hi NvimTreeNormal guibg=NONE ctermbg=NONE]])

require("trouble").setup({})

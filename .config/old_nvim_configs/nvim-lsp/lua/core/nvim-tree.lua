local M = {}
local tree_cb = require("nvim-tree.config").nvim_tree_callback

M.opts = {
	open_on_setup = false,
	-- auto_close = true,
	open_on_tab = false,
	update_focused_file = {
		enable = true,
	},
	diagnostics = {
		enable = false,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	view = {
		width = 25,
		side = "left",
		-- auto_resize = true,
		mappings = {
			custom_only = false,
			list = {
				{ key = { "l", "<CR>", "o" }, cb = tree_cb("edit") },
				{ key = "h", cb = tree_cb("close_node") },
				{ key = "v", cb = tree_cb("vsplit") },
			},
		},
	},
	-- show_icons = {
	-- 	git = 1,
	-- 	folders = 1,
	-- 	files = 1,
	-- 	folder_arrows = 1,
	-- 	tree_width = 30,
	-- },
	-- ignore = { ".git", "node_modules", ".cache" },
	-- quit_on_open = 0,
	-- hide_dotfiles = 1,
	-- git_hl = 1,
	-- root_folder_modifier = ":t",
	-- allow_resize = 1,
	-- auto_ignore_ft = { "startify", "dashboard" },
	-- icons = {
	-- 	default = "",
	-- 	symlink = "",
	-- 	git = {
	-- 		unstaged = "",
	-- 		staged = "S",
	-- 		unmerged = "",
	-- 		renamed = "➜",
	-- 		deleted = "",
	-- 		untracked = "U",
	-- 		ignored = "◌",
	-- 	},
	-- 	folder = {
	-- 		default = "",
	-- 		open = "",
	-- 		empty = "",
	-- 		empty_open = "",
	-- 		symlink = "",
	-- 	},
	-- },
}

M.setup = function()
	local nvim_tree_config = require("nvim-tree")
	nvim_tree_config.setup(M.opts)
end

return M

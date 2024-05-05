local M = {}

M.opts = {
	find_command = {
		"rg",
		"--no-heading",
		"--with-filename",
		"--line-number",
		"--column",
		"--smart-case",
	},
	use_less = true,
	file_previewer = require("telescope.previewers").vim_buffer_cat.new,
	grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
	qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
	extensions = {
		arecibo = {
			["selected_engine"] = "google",
			["url_open_command"] = "open",
			["show_http_headers"] = false,
			["show_domain_icons"] = false,
		},
		fzf = {
			fuzzy = true,
			override_generic_sorter = false,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
	},
}

M.setup = function()
	require("telescope").load_extension("media_files")
	require("telescope").load_extension("fzf")
	require("telescope").load_extension("gh")
	require("telescope").setup(M.opts)
end

return M

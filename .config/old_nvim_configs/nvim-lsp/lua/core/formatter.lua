local M = {}

local clang_format = function()
	return {
		exe = "clang-format",
		args = { "--assume-filename", vim.api.nvim_buf_get_name(0) },
		stdin = true,
		cwd = vim.fn.expand("%:p:h"), -- Run clang-format in cwd of the file.
	}
end

M.opts = {
	filetype = {
		lua = {
			function()
				return {
					exe = "stylua",
					args = {
						--   "--config-path "
						--     .. os.getenv("XDG_CONFIG_HOME")
						--     .. "/stylua/stylua.toml",
						"-",
					},
					stdin = true,
				}
			end,
		},
		cpp = {
			clang_format,
		},
	},
}

M.setup = function()
	require("formatter").setup(M.opts)
end

return M

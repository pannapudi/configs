local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	change_detection = {
		notify = false,
	},
	spec = {
		-- import your plugins
		{ import = "plugins" },
	},
	-- automatically check for plugin updates
	-- checker = { enabled = true },
	performance = {
		rtp = {
			-- disable some rtp plugins
			disabled_plugins = {
				"tohtml",
				"tutor",
			},
		},
	},
})

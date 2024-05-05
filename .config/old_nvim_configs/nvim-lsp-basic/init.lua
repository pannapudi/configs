local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
	execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
	execute "packadd packer.nvim"
end

local packer_ok, packer = pcall(require, "packer")
if not packer_ok then 
	return
end

packer.init {
	git = { clone_timeout = 300 },
	display = {
		open_fn = function()
			return require("packer.util").float { border = "single" }
		end,
	},
}

require("packer").startup(function(use)
	use "wbthomason/packer.nvim"
	
	use { "neovim/nvim-lspconfig" }
	use {
		"kabouzeid/nvim-lspinstall",
		event = "VimEnter",
		config = function()
			require("lspinstall").setup()
		end,
	}

	use { "nvim-lua/popup.nvim" }
	use { "nvim-lua/plenary.nvim" }
	use { "tjdevries/astronauta.nvim" }

	use {
		 "hrsh7th/nvim-compe",
		 config = function()
			 require("core.compe").setup()
		 end,
	 }

	 use {
		 "simrat39/rust-tools.nvim",
	 }

	 use {
		 "nvim-telescope/telescope.nvim",
		 config = function()
			 require("core.telescope").setup()
		 end,
	 }
end)

local cmd = vim.cmd
cmd("filetype plugin on")
cmd("set completeopt=menu,menuone,noselect")
cmd("set shortmess+=c")

local nvim_lsp = require'lspconfig'

local opts = {
    tools = {
        autoSetHints = true,
        hover_with_actions = true,
        runnables = {
            use_telescope = true
        },
        inlay_hints = {
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
    server = {}, -- rust-analyer options
}

require('rust-tools').setup(opts)


cmd "nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>"
cmd "nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>"
cmd "nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>"
cmd "nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>"
vim.api.nvim_set_keymap(
  "n",
  "gl",
  '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ show_header = false, border = "single" })<CR>',
  { noremap = true, silent = true }
)

cmd "nnoremap <silent> gp <cmd>lua require'lsp'.PeekDefinition()<CR>"
cmd "nnoremap <silent> K :lua vim.lsp.buf.hover()<CR>"
cmd "nnoremap <silent> <C-p> :lua vim.lsp.diagnostic.goto_prev({popup_opts = {border = O.lsp.popup_border}})<CR>"
cmd "nnoremap <silent> <C-n> :lua vim.lsp.diagnostic.goto_next({popup_opts = {border = O.lsp.popup_border}})<CR>"
cmd "nnoremap <silent> <tab> <cmd>lua vim.lsp.buf.signature_help()<CR>"
-- scroll down hover doc or scroll in definition preview
-- scroll up hover doc
cmd 'command! -nargs=0 LspVirtualTextToggle lua require("lsp/virtual_text").toggle()'
cmd "nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>"

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;

  source = {
    path = true;
    buffer = true;
    calc = true;
    vsnip = true;
    nvim_lsp = true;
    nvim_lua = true;
    spell = true;
    tags = true;
    snippets_nvim = true;
  };
}

cmd "inoremap <silent><expr> <C-Space> compe#complete()"
cmd "inoremap <silent><expr> <CR>      compe#confirm('<CR>')"
cmd "inoremap <silent><expr> <C-e>     compe#close('<C-e>')"

-- have a fixed column for the diagnostics to appear in
-- this removes the jitter when warnings/errors flow in
cmd 'set signcolumn=yes'

-- Set updatetime for CursorHold
-- 300ms of no cursor movement to trigger CursorHold
cmd 'set updatetime=300'
-- Show diagnostic popup on cursor hover
cmd 'autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()'

-- Goto previous/next diagnostic warning/error
cmd 'nnoremap <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>'
cmd 'nnoremap <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>'

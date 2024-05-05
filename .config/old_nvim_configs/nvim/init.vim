let mapleader = "\<Space>"

let plug_install = 0
let autoload_plug_path = stdpath('config') . '/autoload/plug.vim'
if !filereadable(autoload_plug_path)
    silent exe '!curl -fL --create-dirs -o ' . autoload_plug_path . 
        \ ' https://raw.github.com/junegunn/vim-plug/master/plug.vim'
    execute 'source ' . fnameescape(autoload_plug_path)
    let plug_install = 1
endif
unlet autoload_plug_path

call plug#begin()
" Plug 'neomake/neomake'
" Plug 'tpope/vim-dispatch'
" Plug 'tmsvg/pear-tree'
" Plug 'majutsushi/tagbar'
Plug 'liuchengxu/vista.vim'

Plug 'TimUntersberger/neogit'

Plug 'vimwiki/vimwiki'

Plug 'petrushka/vim-opencl'

Plug 'ziglang/zig.vim'

Plug 'sainnhe/gruvbox-material'
Plug 'vim-airline/vim-airline' 			    " statusline
Plug 'vim-airline/vim-airline-themes'

Plug 'mbbill/undotree'

" Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git', {'autoload':{'filetypes':['gitcommit','gitconfig', 'gitrebase', 'gitsendmail']}}

" Plug 'mattn/emmet-vim', {'autoload':{'filetypes':['html','css','sass','scss','less']}} " HTML completion

" Plug 'jackguo380/vim-lsp-cxx-highlight'

Plug 'vuciv/vim-bujo'

Plug 'rhysd/clever-f.vim'
Plug 'tpope/vim-commentary'
" Tabs or 4 space highlighting
Plug 'nathanaelkane/vim-indent-guides'

Plug 'justinmk/vim-sneak'

" Rust objet notation
Plug 'ron-rs/ron.vim'

" Shaders
Plug 'tikhomirov/vim-glsl'
Plug 'beyondmarc/hlsl.vim'
" Plug 'petrbroz/vim-glsl'

" Trailing whitespaces and :FixWhitespace
Plug 'bronson/vim-trailing-whitespace'

Plug 'machakann/vim-highlightedyank'

" Fuzzy finder
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Plug 'junegunn/fzf.vim'
" Plug 'stsewd/fzf-checkout.vim'

" Teletscope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

Plug 'plasticboy/vim-markdown'
" Syntactic language support
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'

" Multi cursor
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Semantic language support
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

if plug_install
    PlugInstall --sync
endif
unlet plug_install

"""""""""""""""""""""""""""""""""""""""""""""""""
" GENERAL SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""
syntax on
set autoread
set nocompatible

" enable Normal mode keys in ru layout
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

" =============================================================================
" # Autocommands
" =============================================================================

" Prevent accidental writes to buffers that shouldn't be edited
autocmd! BufRead *.orig set readonly
autocmd! BufRead *.pacnew set readonly

" Leave paste mode when leaving insert mode
autocmd InsertLeave * set nopaste

" Jump to last edit position on opening file
if has("autocmd")
  " https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
  au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Help filetype detection
autocmd! BufRead *.plot set filetype=gnuplot
autocmd! BufRead *.md set filetype=markdown
autocmd! BufRead *.lds set filetype=ld
autocmd! BufRead *.tex set filetype=tex
autocmd! BufRead *.trm set filetype=c
autocmd! BufRead *.xlsx.axlsx set filetype=ruby
autocmd! BufRead *.fish set filetype=fish
autocmd! BufRead *.frag,*.vert,*.comp,*.glsl set filetype=glsl

nmap gx yiW:!xdg-open <cWORD><CR> <C-r>" & <CR><CR>

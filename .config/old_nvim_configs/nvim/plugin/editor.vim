" =============================================================================
" # Editor settings
" =============================================================================
filetype plugin indent on
set autoindent
set encoding=utf-8
set noshowmode
" set nowrap
set nojoinspaces
let g:sneak#s_next = 1
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_frontmatter = 1
set printfont=:h10
set printencoding=utf-8
set printoptions=paper:letter
" Always draw sign column. Prevent buffer moving when adding/deleting sign.
set signcolumn=yes
" Lets us yank in vim and then paste to other programs
set clipboard+=unnamedplus
" set linebreak
" Settings needed for .lvimrc
set exrc
set secure

" Permanent undo
set undodir=~/.vimdid
set undofile

" Decent wildmenu
set wildmenu
" set wildmode=list:longest
" set wildignore=.hg,.svn,*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db,*.min.js,*.swp,publish/*,intermediate/*,*.o,*.hi,Zend,vendor

" Use wide tabs
set shiftwidth=4
set softtabstop=4
set tabstop=4
set noexpandtab

" Wrapping options
set formatoptions=tc " wrap text and comments using textwidth
set formatoptions+=r " continue comments when pressing ENTER in I mode
set formatoptions+=q " enable formatting of comments with gq
set formatoptions+=n " detect lists for formatting
set formatoptions+=b " auto-wrap in insert mode, and do not wrap old long lines

" Proper search
set hlsearch 			" Highlight matches
set incsearch 			" Highlight matches as you type
set ignorecase          " Case-insensitive searching
set smartcase 			" But case-sensitive if expression contains a capital letter
set gdefault

" Search results centered please
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" Very magic by default
nnoremap ? ?\v
nnoremap / /\v
cnoremap %s/ %sm/

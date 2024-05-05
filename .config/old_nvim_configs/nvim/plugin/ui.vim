" =============================================================================
" # GUI settings
" =============================================================================
let base16colorspace=256  " Access colors present in 256 colorspace, used with base16-shell
set termguicolors
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
" colorscheme base16-default-dark
set background=dark

let g:gruvbox_material_enable_italic = 1
let g:gruvbox_material_disable_italic_comment = 1
let g:gruvbox_material_background = 'medium'
let g:gruvbox_material_better_performance = 1

colorscheme gruvbox-material

set guioptions-=T " Remove toolbar
set vb t_vb= " No more beeps
set backspace=2 " Backspace over newlines
set nofoldenable
set ttyfast
" https://github.com/vim/vim/issues/1735#issuecomment-383353563
set lazyredraw
set synmaxcol=500
set laststatus=2
set relativenumber " Relative line numbers
set number " Also show current absolute line
set diffopt+=iwhite " No whitespace in vimdiff
" Make diffing better: https://vimways.org/2018/the-power-of-diff/
set diffopt+=algorithm:patience
set diffopt+=indent-heuristic
set colorcolumn=80 " and give me a colored column
set showcmd " Show (partial) command in status line.
set mouse=a " Enable mouse usage (all modes) in terminals
set shortmess+=c " don't give |ins-completion-menu| messages.

" Show those damn hidden characters
" Verbose: set listchars=nbsp:¬,eol:¶,extends:»,precedes:«,trail:•
set listchars=nbsp:¬,extends:»,precedes:«,trail:•

set hidden			" Handle multiple buffers better
set ruler 			" Show the cursor position all the time
set scrolloff=5			" set 5 lines to the cursur (move when moving verticaly)
set sidescrolloff=5		" set 5 columns to the cursur (move when moving verticaly)
set showmatch 			" Briefly jump to matching brace
set matchtime=2 		" Speed things up
set magic 			" Regular expressions
set noerrorbells 		" No beeping
set novisualbell 		" No annoying bells
set splitbelow                  " open horizontal splits below by default
set splitright                  " open vertical splits to right by default
set colorcolumn=+1              " Column width indicator
set nosmartindent               " do not auto ident
set cindent

" indent-guides
"let g:indent_guides_auto_colors = 1
hi IndentGuidesOdd  guibg=#3B3B3B ctermbg=235
hi IndentGuidesEven guibg=#343434 ctermbg=236
let g:indent_guides_space_guides = 1
let g:indent_guides_enable_on_vim_startup = 1
"hi IndentGuidesOdd  ctermbg=black
"hi IndentGuidesEven ctermbg=darkgrey

" deal with colors
if !has('gui_running')
  set t_Co=256
endif
if (match($TERM, "-256color") != -1) && (match($TERM, "screen-256color") == -1)
  " screen does not (yet) support truecolor
  set termguicolors
endif
hi Normal ctermbg=NONE

if has('nvim')
    set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
    set inccommand=nosplit
    noremap <C-q> :confirm qall<CR>
end

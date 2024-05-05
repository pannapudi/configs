" =============================================================================
" # Keyboard shortcuts
" =============================================================================
" ; as :
nnoremap ; :

" Yeld to ent of line
nnoremap Y y$

" Ctrl+c and Ctrl+j as Esc
" Ctrl-j is a little awkward unfortunately:
" https://github.com/neovim/neovim/issues/5916
" So we also map Ctrl+k
inoremap <C-j> <Esc>

nnoremap <C-k> <Esc>
inoremap <C-k> <Esc>
vnoremap <C-k> <Esc>
snoremap <C-k> <Esc>
xnoremap <C-k> <Esc>
cnoremap <C-k> <Esc>
onoremap <C-k> <Esc>
lnoremap <C-k> <Esc>
tnoremap <C-k> <Esc>

" nnoremap <C-c> <Esc>
" inoremap <C-c> <Esc>
" vnoremap <C-c> <Esc>
" snoremap <C-c> <Esc>
" xnoremap <C-c> <Esc>
" cnoremap <C-c> <Esc>
" onoremap <C-c> <Esc>
" lnoremap <C-c> <Esc>
" tnoremap <C-c> <Esc>

" Change current folder(pwd)
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" Ctrl+h to stop searching
vnoremap <C-h> :nohlsearch<cr>
nnoremap <C-h> :nohlsearch<cr>

" Suspend with Ctrl+f
" inoremap <C-f> :sus<cr>
" vnoremap <C-f> :sus<cr>
" nnoremap <C-f> :sus<cr>

" Jump to start and end of line using the home row keys
map H ^
map L $

" Neat X clipboard integration
" ,p will paste clipboard into buffer
" ,c will copy entire buffer into clipboard
" noremap <leader>p :read !xsel --clipboard --output<cr>
" noremap <leader>c :w !xsel -ib<cr><cr>

" <leader>s for Rg search
" There are have to be trailing whitespace. Do not delete it!
" noremap <leader>s :Rg 
" let g:fzf_layout = { 'down': '~20%' }
" command! -bang -nargs=* Rg
"   \ call fzf#vim#grep(
"   \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
"   \   <bang>0 ? fzf#vim#with_preview('up:60%')
"   \           : fzf#vim#with_preview('right:50%:hidden', '?'),
"   \   <bang>0)

function! s:list_cmd()
  let base = fnamemodify(expand('%'), ':h:.:S')
  return base == '.' ? 'fd --type file --follow' : printf('fd --type file --follow | proximity-sort %s', shellescape(expand('%')))
endfunction

function! TermWrapper(command) abort
	if winwidth('%') >= 160 " Minimum width
		let buffercmd = 'vnew'
	else
		let buffercmd = 'new'
	endif
	exec buffercmd
	exec 'term ' . a:command
	exec 'startinsert'
endfunction

autocmd Filetype glsl map <C-K> :pyf ~/bins/clang-format.py<cr>

tnoremap <Esc> <C-\><C-n>

" Open new file adjacent to current file
nnoremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" No arrow keys --- force yourself to use the home row
" nnoremap <up> <nop>
" nnoremap <down> <nop>
" inoremap <up> <nop>
" inoremap <down> <nop>
" inoremap <left> <nop>
" inoremap <right> <nop>

" Left and right can switch buffers
" nnoremap <left> :bp<CR>
" nnoremap <right> :bn<CR>

" Move by line
nnoremap j gj
nnoremap k gk

nnoremap ,b :Buffers<CR>

" <leader><leader> toggles between buffers
nnoremap <leader><leader> <c-^>

" <leader>, shows/hides hidden characters
nnoremap <leader>, :set invlist<cr>

" <leader>q shows stats
nnoremap <leader>q g<c-g>

" Keymap for replacing up to next _ or -
" noremap <leader>m ct_

" I can type :help on my own, thanks.
map <F1> <Esc>
imap <F1> <Esc>

" Smart way to move between windows
" map <C-j> <C-W>j
" map <C-k> <C-W>k
" map <C-h> <C-W>h
" map <C-l> <C-W>l

" Easier error window navigation
" map <leader>n :cn<cr>
" map <leader>p :cp<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

map <C-t>l :tabr<cr>
map <C-t>h :tabl<cr>
map <C-t>j :tabp<cr>
map <C-t>k :tabn<cr>

" Clamp curled braces down on <enter>
inoremap {<cr> {<cr>}<c-o><s-o>

" nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>pf /<C-R>=escape(expand("<cWORD>"), "/")<CR><CR>
nnoremap <leader>pw :CocSearch <C-R>=expand("<cword>")<CR><CR>

vnoremap <leader>p "_dP

map Q <Nop>

" Ctrl-c: Copy (works with system clipboard due to clipboard setting)
vnoremap <c-c> y`]

" Ctrl-r: Easier search and replace
" vnoremap <c-r> "hy:%s/<c-r>h//gc<left><left><left>

" Ctrl-s: Easier substitue
noremap <c-s> :s/\%V//g<left><left><left>

" Ctrl-f: Find with MultipleCursors
" vnoremap <c-f> :MultipleCursorsFind
" Open hotkeys
" map <C-p> :Files<CR>
" nmap <leader>; :Buffers<CR>

" Quick-save
nmap <leader>w :w<CR>

" Move lines in visual mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

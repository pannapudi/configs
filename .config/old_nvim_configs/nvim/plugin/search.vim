"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Shortcuts
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Open hotkeys
" map <C-p> :Files<CR>
" nmap <leader>; :Buffers<CR>

"let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
"let $FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
"let $FZF_DEFAULT_OPTS='--reverse'
"let g:fzf_branch_actions = {
"      \ 'rebase': {
"      \   'prompt': 'Rebase> ',
"      \   'execute': 'echo system("{git} rebase {branch}")',
"      \   'multiple': v:false,
"      \   'keymap': 'ctrl-r',
"      \   'required': ['branch'],
"      \   'confirm': v:false,
"      \ },
"      \ 'track': {
"      \   'prompt': 'Track> ',
"      \   'execute': 'echo system("{git} checkout --track {branch}")',
"      \   'multiple': v:false,
"      \   'keymap': 'ctrl-t',
"      \   'required': ['branch'],
"      \   'confirm': v:false,
"      \ },
"      \}

"" from http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
"if executable('ag')
"	set grepprg=ag\ --nogroup\ --nocolor
"endif
"if executable('rg')
"	let g:rg_derive_root='true'
"        set grepprg=rg\ --no-heading\ --vimgrep
"        set grepformat=%f:%l%c:%m
"endif

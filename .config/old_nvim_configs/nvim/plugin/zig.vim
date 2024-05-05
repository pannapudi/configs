autocmd Filetype zig setlocal makeprg=zig\ build

autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

autocmd Filetype zig command! -bang -nargs=* Zr call TermWrapper('zig run ' . <q-args>)
autocmd Filetype zig command! -bang -nargs=* Zb call TermWrapper('zig build ' . <q-args>)
autocmd Filetype zig nnoremap <leader>fr <C-w>o:Zr<CR>
autocmd Filetype zig nnoremap <leader>fb <C-w>o:Zb<CR>

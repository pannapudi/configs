autocmd Filetype c,cpp command! -bang -nargs=* Cr call TermWrapper('gcc ' . <q-args> . ' ' . @% . '; ./a.out')
autocmd Filetype c,cpp command! -bang -nargs=* Cb call TermWrapper('gcc ' . <q-args> . ' ' . @%)
autocmd Filetype c,cpp nnoremap <leader>fr <C-w>o:Cr<CR>
autocmd Filetype c,cpp nnoremap <leader>fb <C-w>o:Cb<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Keybindings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Leader key (spacebar)
let mapleader = " "

" Fold toggle with spacebar
nnoremap <leader><leader> za
vnoremap <leader><leader> zf

" Switch between tabs with F8 and F9
map <F8> :tabp<cr>
map <F9> :tabn<cr>

" Yank to clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

set foldmethod=indent
set foldlevel=99

nnoremap <space> za
noremap <Leader>y "*y
map <F8> :tabp<cr>
map <F9> :tabn<cr>

Plugin 'tmhedberg/SimpylFold'

Plugin 'tpope/vim-commentary'

au BufNewFile,BufRead *.py
        \ set tabstop=4 |
        \ set softtabstop=4 |
        \ set shiftwidth=4 |
        \ set textwidth=0 |
        \ set expandtab |
        \ set autoindent |
        \ set fileformat=unix

Plugin 'vim-scripts/indentpython.vim'

highlight BadWhiteSpace ctermbg=red guibg=darkred
au BufRead, BufNewFile *.py,*.pyw,*.c,*.h match BadWhiteSpace /\s\+$/

set encoding=utf-8

Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'

let python_highlight_all=1
syntax on

Plugin 'davidhalter/jedi-vim'

set nu

Plugin 'preservim/nerdtree'
map <F2> :NERDTreeToggle<CR>

set textwidth=0
set wrapmargin=0
set wrap

set backspace=indent,eol,start

Plugin 'vim-airline/vim-airline'

set clipboard=unnamed

call vundle#end()
filetype plugin indent on

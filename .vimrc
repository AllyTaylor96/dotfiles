""""""""" Initial setup of both vim + vundle """""""""
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

""""""""" Vundle Plugins """""""""

" Vundle - package manager
Plugin 'gmarik/Vundle.vim'

" Enable folding for python files
" Plugin 'tmhedberg/SimpylFold'

" Comment out code - gcc for line, gc in visual mode
Plugin 'tpope/vim-commentary'

" Does correct indentation for brackets etc in python
Plugin 'vim-scripts/indentpython.vim'

" Syntax checker - off by default
" Plugin 'vim-syntastic/syntastic'

" Auto-complete Python - turns off preview docstring by default
Plugin 'davidhalter/jedi-vim'
autocmd FileType python setlocal completeopt-=preview

" Set auto-complete to tab
Plugin 'ervandew/supertab'

" Add indent lines
Plugin 'Yggdroot/indentLine'

" Enable NERDTree file manager - off by default
" Plugin 'preservim/nerdtree'

" Status bar at bottom of vim editor 
Plugin 'vim-airline/vim-airline'

" Make it look nice
Plugin 'danilo-augusto/vim-afterglow'

" Markdown Preview Plugin
" Plugin 'iamcco/markdown-preview.nvim'

""""""""" Vim Keybinds and Settings """""""""

" set space to toggle fold on indent
set foldmethod=indent
nnoremap <space> za
vnoremap <space> zf
set foldnestmax=3

" switch between tabs with F8 and F9
map <F8> :tabp<cr>
map <F9> :tabn<cr>

" set python-specific tab lengths and settings
au BufNewFile,BufRead *.py
        \ set tabstop=4 |
        \ set softtabstop=4 |
        \ set shiftwidth=4 |
        \ set textwidth=0 |
        \ set expandtab |
        \ set autoindent |
        \ set fileformat=unix

" highlight extra white space with red
highlight BadWhiteSpace ctermbg=red guibg=darkred
au BufRead, BufNewFile *.py,*.pyw,*.c,*.h match BadWhiteSpace /\s\+$/

" self explanatory
set encoding=utf-8

" add syntax highlighting for python (so Class, def etc will be highlighted)
autocmd BufRead,BufNewFile *.py let python_highlight_all=1
syntax on

" turn on line numbers
set nu

" map NERDTree access to F2
" map <F2> :NERDTreeToggle<CR>


" stops text from autowrapping at end of line
set textwidth=0
set wrapmargin=0
set wrap

" set it so that backspace will delete line if used at start of line
set backspace=indent,eol,start

" try and access clipboard - may not work
set clipboard=unnamed

" end vundle call
call vundle#end()

" below line means vim will check filetype, load plugins and indent settings for that
filetype plugin indent on

" Set colorscheme so it looks nice
let g:afterglow_italic_comments=1
let g:afterglow_inherit_background=1
colorscheme afterglow


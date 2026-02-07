""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle Plugin Manager Setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Vundle - package manager
Plugin 'gmarik/Vundle.vim'

" Comment out code - gc in visual mode, gcc for line
Plugin 'tpope/vim-commentary'

" Python indentation
Plugin 'vim-scripts/indentpython.vim'

" Auto-complete Python
Plugin 'davidhalter/jedi-vim'

" Tab completion
Plugin 'ervandew/supertab'

" Visual indent lines
Plugin 'Yggdroot/indentLine'

" Status bar
Plugin 'vim-airline/vim-airline'

" Color scheme
Plugin 'danilo-augusto/vim-afterglow'

call vundle#end()
filetype plugin indent on


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Core Vim Options
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Encoding
set encoding=utf-8

" Line numbers
set number
set relativenumber

" Indentation defaults (4 spaces)
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent

" Show tabs and trailing whitespace
set list

" Text wrapping (soft wrap, no auto line breaks)
set textwidth=0
set wrapmargin=0
set wrap

" Code folding
set foldmethod=indent
set foldnestmax=3

" Search settings
set ignorecase
set smartcase
set nohlsearch
set incsearch

" Scrolling
set scrolloff=8
set sidescrolloff=8

" Backspace behavior
set backspace=indent,eol,start

" Clipboard access
set clipboard=unnamed

" Syntax highlighting
syntax on


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


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocommands
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Python-specific settings
autocmd BufNewFile,BufRead *.py
        \ set tabstop=4 |
        \ set softtabstop=4 |
        \ set shiftwidth=4 |
        \ set textwidth=0 |
        \ set expandtab |
        \ set autoindent |
        \ set fileformat=unix

" JavaScript/HTML/CSS formatting (2 spaces)
autocmd BufNewFile,BufRead *.js,*.html,*.css
        \ set tabstop=2 |
        \ set softtabstop=2 |
        \ set shiftwidth=2

" Python syntax highlighting
autocmd BufRead,BufNewFile *.py let python_highlight_all=1

" Highlight trailing whitespace
highlight BadWhiteSpace ctermbg=red guibg=darkred
autocmd BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhiteSpace /\s\+$/

" Return to last edit position when opening files
autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Jedi-vim: disable preview window
autocmd FileType python setlocal completeopt-=preview

" Afterglow color scheme
let g:afterglow_italic_comments=1
let g:afterglow_inherit_background=1
colorscheme afterglow


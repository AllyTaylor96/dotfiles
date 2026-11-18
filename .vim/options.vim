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

" Statusline
set laststatus=2 "Enable at all times
set statusline=
set statusline +=%1*\ %n\ %*            "buffer number
set statusline +=%5*%{&ff}%*            "file format
set statusline +=%3*%y%*                "file type
set statusline +=%4*\ %<%F%*            "full path
set statusline +=%2*%m%*                "modified flag
set statusline +=%1*%=%5l%*             "current line
set statusline +=%2*/%L%*               "total lines
set statusline +=%1*%4v\ %*             "virtual column number
set statusline +=%2*0x%04B\ %*          "character under cursor

" Command-line completion
set wildmenu

" File search
set path+=**

" Tag files
set tags+=./.tags;

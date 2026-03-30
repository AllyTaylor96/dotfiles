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



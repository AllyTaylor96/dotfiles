let s:vundle_dir = expand('~/.vim/bundle/Vundle.vim')
if !filereadable(s:vundle_dir . '/autoload/vundle.vim')
    finish
endif

set nocompatible
filetype off

execute 'set runtimepath+=' . fnameescape(s:vundle_dir)
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-surround'
call vundle#end()

" Apply sensible's defaults before our own options and mappings.
runtime plugin/sensible.vim
filetype plugin indent on

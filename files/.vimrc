set nocompatible

" Load plugins with pathogen
runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()

set number
set ruler
syntax on

" Set encoding
set encoding=utf-8

" Whitespace stuff
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent
set list listchars=tab:\ \ ,trail:·
filetype indent on

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Status bar
set ruler
set showcmd
set laststatus=2

" Command-t
let g:CommandTMaxHeight=20
let g:CommandTCancelMap=['<ESC>','<C-c>']

" Theme
colorscheme solarized

" Key bindings
let mapleader = ','

imap jj <Esc>
imap ;; <Esc> :wa<CR> :!!<CR>

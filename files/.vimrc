set nocompatible

set wildignore+=*/.git/*
set wildignore+=*.png,*.gif,*.jpg,*.ico,*.swp,*.pdf

" Load plugins with pathogen
runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()

set number
set ruler
set cursorline
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

" Browsing
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_max_height=20

" Unimpaired
nmap <C-Up> [e
nmap <C-Down> ]e
vmap <C-Up> [egv
vmap <C-Down> ]egv
nmap <CR> [<Space>

" Theme
colorscheme solarized

" Key bindings
let mapleader = ','

" Browsing
nmap <Leader>t :CtrlP<CR>
nmap <Leader>b :CtrlPBuffer<CR>

" Quickly exit insert mode.
imap jj <Esc>
imap ;; <Esc> :wa<CR>

" Quickly run the previous shell command.
imap '' <Esc> :wa<CR> :!!<CR>
nmap ! :wa<CR> :!!<CR>

" Handy Rails commands.
nmap <Leader>a :A<CR>
nmap <Leader>r :!rspec %<CR>

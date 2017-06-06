if has('nvim')
  call plug#begin('~/.local/share/nvim/plugged')
else
  set encoding=utf-8

  set nocompatible

  call plug#begin('~/.vim/plugged')
endif

Plug 'altercation/vim-colors-solarized'
Plug 'mileszs/ack.vim'
Plug 'compactcode/open.vim'
Plug 'compactcode/alternate.vim'
Plug 'mattn/emmet-vim'
Plug 'ervandew/supertab'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'godlygeek/tabular'
Plug 'junegunn/fzf'
Plug 'pbogut/fzf-mru.vim'

Plug 'garbas/vim-snipmate'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'

call plug#end()


" ************************************************************
" General
" ************************************************************


" Use the current filename as the title for the terminal
set title

" Make these files completely invisible to vim
set wildignore+=*/.git/*,*/.hg/*,*/.sass-cache/*,*node_modules/*
set wildignore+=*.png,*.gif,*.jpg,*.ico,*.pdf,*.DS_Store,*.pyc


" ************************************************************
"  Display
" ************************************************************

" Show line numbers
set number

" Show the line and column of the cursor location
set ruler

" Show the line and column number in the status bar
set cursorline

" Disable line wrapping
set nowrap

" Show dangling whitespace
set list listchars=tab:\ \ ,trail:·

" Disable code folding
set nofoldenable

" Show a status bar
set laststatus=2

" Use the solarized color scheme
set background=dark
colorscheme solarized


" ************************************************************
" Search
" ************************************************************

" Highlight all matches of the most recent search
set hlsearch

" Update search matches in real time
set incsearch

" Ignore case unless a capital letter is used
set ignorecase
set smartcase


" ************************************************************
" Editing
" ************************************************************

" Copy indentations from the current line to new lines
set autoindent

" Use spaces intead of tabs
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

" Don't let vim manage backups
set nobackup
set nowritebackup
set noswapfile

" Allow buffers to be backgrounded without saving
set hidden

" Allow pasting pre formatted text
set pastetoggle=<F4>

" Show the current command
set showcmd

" ************************************************************
" Leader key
" ************************************************************

" Use a leader key closer to the home row
let mapleader = ','

" ************************************************************
" Normal mode key bindings
" ************************************************************

" Quickly switch between split windows
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Make Y behave like other capitals
nnoremap Y y$

" Insert a newline above the current line
nmap <CR> [<Space>

" Quickly insert whitespace in normal mode
nnoremap <Space> i<Space><Esc>l

" Quickly save all files and re run the last command
nnoremap ! :wa<CR>:!!<CR>

" Quickly save all files and exit vim
nnoremap Q :wa<CR>ZZ

" Clear search highlights
nnoremap <Leader>, :nohlsearch<CR>

" Search through all files
nnoremap <Leader>t :FZF<CR>
nnoremap <Leader>f :FZFMru<CR>

" Open a file explorer in the current directory
nnoremap <Leader>o :! open %:h<CR>

" Switch between test and implementation files
nnoremap <Leader>a :Open(alternate#FindAlternate())<CR>
nnoremap <Leader>h :OpenHorizontal(alternate#FindAlternate())<CR>
nnoremap <Leader>v :OpenVertical(alternate#FindAlternate())<CR>

" Search for the current word in all files
nnoremap <Leader>s :Ack<CR>

" Align symbols
nnoremap <Leader>= :Tabularize /=<CR>
nnoremap <Leader>> :Tabularize /=><CR>
nnoremap <Leader>{ :Tabularize /{<CR>

" Run the test for the current file
autocmd FileType ruby nnoremap <buffer> <Leader>r :execute "! bundle exec rspec " . alternate#FindTest() <CR>

" ************************************************************
" Insert mode key bindings
" ************************************************************

" Quickly exit insert mode
inoremap kj <Esc> :w<CR>

" Emacs bindings
inoremap <C-a> <C-o>^
inoremap <C-e> <C-o>$
inoremap <C-u> <C-o>d^
inoremap <C-k> <C-o>D
inoremap <M-b> <C-o>b
inoremap <M-f> <C-o>w


" ************************************************************
" Visual mode key bindings
" ************************************************************

" Quickly switch to insert mode from visual mode
vnoremap a <Esc>a

" Copy selection to the system clipboard
vnoremap <Leader>c :! pbcopy<CR>


" ************************************************************
" Command mode key bindings
" ************************************************************

" Emacs bindings
cnoremap <C-a> <Home>
cnoremap <C-e> <End>


" ************************************************************
" Quickfix window key bindings
" ************************************************************

" Open the next item and keeping the focus in the quickfix window
autocmd BufWinEnter quickfix noremap <buffer> j :cn<CR><C-w><C-p>

" Open the previous item keeping the focus in the quickfix window
autocmd BufWinEnter quickfix noremap <buffer> k :cp<CR><C-w><C-p>

" Ignore the enter key
autocmd BufWinEnter quickfix noremap <buffer> <Enter> <Nop>


" ************************************************************
" Shell
" ************************************************************

" Configure the vim shell to use standard bash..
set shell=/bin/bash

" Configure the vim shell to be interactive and load aliases.
set shellcmdflag=-c


" ************************************************************
" (plugin) ack.vim
" ************************************************************

let g:ackprg = 'rg --no-heading --column'


" ************************************************************
" (plugin) fzf.vim
" ************************************************************

let g:fzf_history_dir = '~/.fzf-history'

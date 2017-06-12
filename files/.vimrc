if has('nvim')
  call plug#begin('~/.local/share/nvim/plugged')
else
  set encoding=utf-8

  set nocompatible

  call plug#begin('~/.vim/plugged')
endif

Plug 'altercation/vim-colors-solarized'
Plug 'compactcode/open.vim'
Plug 'compactcode/alternate.vim'
Plug 'mattn/emmet-vim'
Plug 'ervandew/supertab'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'junegunn/fzf'
Plug 'junegunn/vim-easy-align'
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
silent! colorscheme solarized


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

" Open a file explorer in the current directory
nnoremap <Leader>o :! open %:h<CR>

" Switch between test and implementation files
nnoremap <Leader>a :Open(alternate#FindAlternate())<CR>
nnoremap <Leader>h :OpenHorizontal(alternate#FindAlternate())<CR>
nnoremap <Leader>v :OpenVertical(alternate#FindAlternate())<CR>

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
if has('nvim')
  vnoremap <Leader>c "*y
else
  vnoremap <Leader>c :! pbcopy<CR>u
endif


" ************************************************************
" Command mode key bindings
" ************************************************************

" Emacs bindings
cnoremap <C-a> <Home>
cnoremap <C-e> <End>


" ************************************************************
" Shell
" ************************************************************

" Explicitly use bash since its faster
set shell=/bin/bash


" ************************************************************
" (plugin) easy-align
" ***********************************************************

" Align symbols
nnoremap <Leader>= :EasyAlign =<CR>

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" ************************************************************
" (plugin) fzf.vim
" ************************************************************

let g:fzf_history_dir = '~/.fzf-history'

" Select a file to open
nnoremap <Leader>t :FZF<CR>

" ************************************************************
" (plugin) fzf-mru.vim
" ************************************************************

" Select a recently edited file to open
nnoremap <Leader>f :FZFMru<CR>


" ************************************************************
" (plugin) fzf.vim & ripgrep
" ************************************************************

" A function to edit a file from a rg search result.
"
" e.g: rg --column --no-heading bundler
"
" => config/boot.rb:3:10:require 'bundler/setup' # Set up gems listed in the Gemfile.
function! s:OpenRgResult(selected_line)
  let file   = split(a:selected_line, ":")[0]
  let column = split(a:selected_line, ":")[1]

  execute open#Open(file)
  execute column
  normal! zz
endfunction

" Configure ripgrep to output single line results in color.
let s:fzf_rg_source  = 'rg --column --no-heading --smart-case --color always %s'
" Configure fzf to handle color and show a preview window.
let s:fzf_rg_options = '--ansi --multi --preview "~/.functions/fzf-column-preview.sh {}"'
" Configure fzf to use our custom function when result is selected.
let s:fzf_rg_sink    = function('s:OpenRgResult')

command! -nargs=1 Rg            call fzf#run(fzf#wrap('fzf', {'source': printf(s:fzf_rg_source, <f-args>),          'options': s:fzf_rg_options, 'sink': s:fzf_rg_sink}))
command! -nargs=0 RgCurrentWord call fzf#run(fzf#wrap('fzf', {'source': printf(s:fzf_rg_source, expand("<cword>")), 'options': s:fzf_rg_options, 'sink': s:fzf_rg_sink}))

" Search the project for occurences of the current word
nnoremap <Leader>s :RgCurrentWord<CR>

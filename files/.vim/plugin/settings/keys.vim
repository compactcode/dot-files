" Quickly switch between split windows
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Make Y behave like other capitals
nnoremap Y y$

" Quickly switch to insert mode from visual mode
vnoremap a <Esc>a

" Quickly switch to normal mode from insert mode
inoremap jj <Esc> :w<CR>
inoremap kj <Esc> :w<CR>
inoremap jk <Esc> :w<CR>

" Insert a newline above the current line
nmap <CR> [<Space>

" Quickly insert whitespace in normal mode
nnoremap <Space> i<Space><Esc>l

" Quickly save all files and re run the last command
nnoremap ! :wa<CR>:!!<CR>

" Quickly save all files and exit vim
nnoremap Q :wa<CR>ZZ

" Emacs bindings in command mode
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" Emacs bindings in insert mode
inoremap <C-a> <C-o>^
inoremap <C-e> <C-o>$
inoremap <C-u> <C-o>d^
inoremap <C-k> <C-o>D
inoremap <M-b> <C-o>b
inoremap <M-f> <C-o>w

" =============================================================================
" Leader
" =============================================================================

" Use a leader key closer to the home row
let mapleader = ','

" Clear search highlights
nnoremap <Leader>, :nohlsearch<CR>

" Search through all files
nnoremap <Leader>t :CtrlP<CR>

" Search through open buffers
nnoremap <Leader>b :CtrlPBuffer<CR>

" Search through most recently used files
nnoremap <Leader>f :CtrlPMRUFiles<CR>

" Open a file explorer in the current directory
nnoremap <Leader>o :! open %:h<CR>

" Copy selection to the system clipboard
vnoremap <Leader>c :! pbcopy<CR>

" Switch between test and implementation files
nnoremap <Leader>a :Open(alternate#FindAlternate())<CR>
nnoremap <Leader>h :OpenHorizontal(alternate#FindAlternate())<CR>
nnoremap <Leader>v :OpenVertical(alternate#FindAlternate())<CR>

" Search for the current word in all files
nnoremap <Leader>s :Ack<CR>

" Run the test for the current file
autocmd FileType ruby nnoremap <buffer> <Leader>r :execute "! bundle exec rspec " . alternate#FindTest() <CR>

" Align symbols
nnoremap <Leader>= :Tabularize /=<CR>
nnoremap <Leader>> :Tabularize /=><CR>
nnoremap <Leader>{ :Tabularize /{<CR>


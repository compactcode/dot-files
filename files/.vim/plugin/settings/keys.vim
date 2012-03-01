" Use a leader key closer to the home row
let mapleader = ','

" Quickly switch between split windows
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Quickly switch to insert mode from visual mode
vnoremap a <Esc>a

" Quickly switch to normal mode from insert mode
inoremap jj <Esc> :w<CR>

" Use the very magic (sane) regex engine when searching
nnoremap / /\v

" Quickly insert whitespace in normal mode
nnoremap <Space> i<Space><Esc>l

" Quickly re run the last command
nnoremap ! :!!<CR>

" Clear any current search highlight
nnoremap <Leader>c :nohlsearch<CR>

" Run the current file using rspec
nnoremap <Leader>r :w<CR>:! rspec %<CR>

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

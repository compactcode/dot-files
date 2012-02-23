set pastetoggle=<F4>

noremap <Space> i<Space><Esc>l

noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

inoremap jj <Esc> :w<CR>

nnoremap ! :!!<CR>

nnoremap <Leader>c :nohlsearch<CR>
nnoremap <Leader>r :! bundle exec rspec %<CR>

" Emacs bindings
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

inoremap <C-a> <C-o>^
inoremap <C-e> <C-o>$
inoremap <C-k> <C-o>D

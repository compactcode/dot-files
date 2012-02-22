set pastetoggle=<F4>

noremap <C-h> <C-w>h " Focus on the window to the left.
noremap <C-j> <C-w>j " Focus on the window below.
noremap <C-k> <C-w>k " Focus on the window above.
noremap <C-l> <C-w>l " Focus on the window to the right.

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

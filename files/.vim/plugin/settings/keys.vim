set pastetoggle=<F4>

noremap <C-h> <C-w>h " Focus on the window to the left.
noremap <C-j> <C-w>j " Focus on the window below.
noremap <C-k> <C-w>k " Focus on the window above.
noremap <C-l> <C-w>l " Focus on the window to the right.

inoremap jj <Esc> :w<CR>

inoremap <C-e> <C-o>$
inoremap <C-a> <C-o>^

nnoremap ! :!!<CR>

nnoremap <Leader>r :! bundle exec rspec %<CR>

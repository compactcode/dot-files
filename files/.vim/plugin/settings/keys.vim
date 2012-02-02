set pastetoggle=<F4>

map <C-h> <C-w>h                          " Focus on the window to the left.
map <C-j> <C-w>j                          " Focus on the window below.
map <C-k> <C-w>k                          " Focus on the window above.
map <C-l> <C-w>l                          " Focus on the window to the right.

imap jj <Esc> :w<CR>                      " Exit insert mode and save.
nmap ! :w<CR> :!!<CR>                     " Save and execute the last command.
nmap <Leader>r :! bundle exec rspec %<CR> " Save and run the current file as a ruby spec.

set pastetoggle=<F4>

map <C-h> <C-w>h " Focus on the window to the left.
map <C-j> <C-w>j " Focus on the window below.
map <C-k> <C-w>k " Focus on the window above.
map <C-l> <C-w>l " Focus on the window to the right.

imap jj <Esc> :w<CR>

imap <C-e> <C-o>$
imap <C-a> <C-o>^

nmap ! :!!<CR>

nmap <Leader>r :! bundle exec rspec %<CR>

" Switch between test and implementation files.
nnoremap <Leader>s :Open(alternate#FindAlternate())<CR>

" Run the spec for the current ruby file
autocmd FileType ruby   nnoremap <buffer> <Leader>r :execute "! rspec " . alternate#FindTest() <CR>

" Run the test for the current python file
autocmd FileType python nnoremap <buffer> <Leader>r :execute "! nosetests " . alternate#FindTest() <CR>


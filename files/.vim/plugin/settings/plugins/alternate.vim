" Switch between test and implementation files.
nnoremap <Leader>s :Alternate<CR>

" Run the spec for the current ruby file
autocmd FileType ruby   nnoremap <buffer> <Leader>r :execute "! rspec " . alternate#FindTest() <CR>

" Run the test for the current python file
autocmd FileType python nnoremap <buffer> <Leader>r :execute "! nosetests " . alternate#FindTest() <CR>


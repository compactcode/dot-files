let g:ctrlp_match_window_reversed = 0
let g:ctrlp_max_height = 20

" Search through all files
nnoremap <Leader>t :CtrlP<CR>

" Search through all currently open buffers
nnoremap <Leader>b :CtrlPBuffer<CR>

" Search through the most recently used files
nnoremap <Leader>f :CtrlPMRUFiles<CR>

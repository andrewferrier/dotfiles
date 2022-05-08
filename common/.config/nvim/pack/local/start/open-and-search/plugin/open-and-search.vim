nnoremap <silent> gx :call open_and_search#open_file(netrw#GX())<CR>
nnoremap <silent> gX :<C-U>set opfunc=open_and_search#open_file_motion<CR>g@
xnoremap <silent> gx :call open_and_search#open_file_visual(visualmode())<CR>

nnoremap <silent> gys :call open_and_search#search(netrw#GX())<CR>
nnoremap <silent> gyS :<C-U>set opfunc=open_and_search#search_motion<CR>g@
xnoremap <silent> gys :call open_and_search#search_visual(visualmode())<CR>

if executable('fasd')
    augroup file-list
        autocmd BufReadPre * call file_list#FasdAdd(expand('%:p'))
        autocmd BufWritePost * call file_list#FasdAdd(expand('%:p'))
    augroup END

    nnoremap <silent> cvf :call file_list#FileSelectorDisplay()<CR>
    nnoremap <silent> cvg :call file_list#DirSelectorDisplay()<CR>
else
    nnoremap <silent> cvf :browse oldfiles<CR>
endif

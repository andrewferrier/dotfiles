function! CreatePdfFromTex(absoluteTexPath) abort
    let l:directory        = fnamemodify(a:absoluteTexPath, ':p:h')
    let l:withoutExtension = fnamemodify(a:absoluteTexPath, ':p:r')

    execute '!pdflatex -output-directory=' . l:directory . ' ' . a:absoluteTexPath
    silent execute '!open ' . l:withoutExtension . '.pdf'
endfunction

nnoremap <buffer> <Leader>cp :call CreatePdfFromTex(expand('%:p'))<CR>

" Adapted from https://gist.github.com/habamax/4662821a1dad716f5c18205489203a67#markdown-headers
"
" Markdown header text object
" * inner object is the text between prev section header(excluded) and the next
"   section of the same level(excluded) or end of file.
" * an object is the text between prev section header(included) and the next section of the same
"   level(excluded) or end of file.
func! s:header_textobj(inner) abort
    let l:lnum_start = search('^#\+\s\+[^[:space:]=]', "ncbW")

    if l:lnum_start
        let l:lvlheader = matchstr(getline(lnum_start), '^#\+')
        let l:lnum_end = search('^#\{1,'..len(lvlheader)..'}\s', "nW")

        if !lnum_end
            let l:lnum_end = search('\%$', 'nW')
        else
            let l:lnum_end -= 1
        endif

        if a:inner && getline(l:lnum_start + 1) !~ '^#\+\s\+[^[:space:]=]'
            let l:lnum_start += 1
        endif

        exe l:lnum_end
        normal! V
        exe l:lnum_start
    endif
endfunc

onoremap <buffer> <silent> i# :<C-u>call <sid>header_textobj(v:true)<CR>
onoremap <buffer> <silent> a# :<C-u>call <sid>header_textobj(v:false)<CR>
xnoremap <buffer> <silent> i# :<C-u>call <sid>header_textobj(v:true)<CR>
xnoremap <buffer> <silent> a# :<C-u>call <sid>header_textobj(v:false)<CR>

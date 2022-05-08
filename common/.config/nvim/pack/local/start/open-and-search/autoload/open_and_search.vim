" Taken from vim-unimpaired
function! s:url_encode(str) abort
    " Added the '\\' to handle escaping of '%' on a command line
    return substitute(iconv(a:str, 'latin1', 'utf-8'),'[^A-Za-z0-9_.~-]','\="\\%".printf("%02X",char2nr(submatch(0)))','g')
endfunction

function! s:open_file_event(job_id, data, event) dict
    if a:data == '1'
        echoerr "Error opening file/URL."
    endif
endfunction

function! open_and_search#open_file(input) abort
    call jobstart(['open-file', a:input], {'detach': v:true, 'on_exit': function('s:open_file_event')})
endfunction

function! open_and_search#open_file_motion(mode) abort
    call open_and_search#open_file(s:GetMotion(a:mode))
endfunction

function! open_and_search#open_file_visual(mode) abort
    call open_and_search#open_file(s:GetVisualSelection(a:mode))
endfunction

function! open_and_search#search(input) abort
    let l:url_to_use = 'https://duckduckgo.com?q=' . s:url_encode(a:input)

    if executable('xdg-open')
        call jobstart(['xdg-open', l:url_to_use], {'detach': v:true})
    else
        call jobstart(['open', l:url_to_use], {'detach': v:true})
    endif
endfunction

function! open_and_search#search_motion(mode) abort
    call open_and_search#search(s:GetMotion(a:mode))
endfunction

function! open_and_search#search_visual(mode) abort
    call open_and_search#search(s:GetVisualSelection(a:mode))
endfunction

function! s:GetMotion(mode)
    call assert_true(a:mode ==# 'char')
    execute 'normal! `[v`]y'
    return getreg('"')
endfunction

" See https://stackoverflow.com/a/61486601/27641
function! s:GetVisualSelection(mode)
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if a:mode ==# 'v'
        " Must trim the end before the start, the beginning will shift left.
        let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
        let lines[0] = lines[0][column_start - 1:]
    elseif  a:mode ==# 'V'
        " Line mode no need to trim start or end
    elseif  a:mode == "\<c-v>"
        " Block mode, trim every line
        let new_lines = []
        let i = 0
        for line in lines
            let lines[i] = line[column_start - 1: column_end - (&selection == 'inclusive' ? 1 : 2)]
            let i = i + 1
        endfor
    else
        return ''
    endif
    for line in lines
        echom line
    endfor
    return join(lines, "\n")
endfunction

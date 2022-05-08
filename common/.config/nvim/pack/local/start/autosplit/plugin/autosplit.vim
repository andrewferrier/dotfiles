" Based on https://www.reddit.com/r/neovim/comments/lmhcmj/the_help_window_is_a_bit_wonky/gnvk5pr

let g:autosplit_ft = ['man', 'fugitive', 'gitcommit']
let g:autosplit_bt = ['help']

fun! s:NewSplit()
    if (index(get(g:, 'autosplit_bt', []), &buftype) != -1 ||
      \ index(get(g:, 'autosplit_ft', []), &filetype) != -1)
        let b = bufnr()
        let p = winnr('#')
        let v = winwidth(p) >= getwinvar(p, '&tw', 80) + getwinvar(winnr(), '&tw', 80)
        wincmd J
        wincmd p
        if v
            vsplit
        else
            split
        endif
        exe b . 'b'
        exe winnr('50j') . 'wincmd q'
    endif
endfun

augroup Autosplit
    autocmd!
    autocmd WinNew * autocmd BufEnter * ++once call s:NewSplit()
augroup END

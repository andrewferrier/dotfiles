" Based on Delete command from vim-eunuch.

command! -bar -bang Trash
      \ let s:file = fnamemodify(bufname(),':p') |
      \ execute 'bdelete<bang>' |
      \ if !bufloaded(s:file) |
      \   call system('trash ' . s:file) |
      \   if v:shell_error > 0 |
      \     echoerr 'Failed to trash "'.s:file.'"' |
      \   endif |
      \ endif |
      \ unlet s:file

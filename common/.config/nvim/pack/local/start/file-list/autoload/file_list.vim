let s:output =  system('cat /dev/null | highlight --out-format=truecolor --syntax-by-name=c')

if v:shell_error == 0
    let s:highlight = '| highlight --force --out-format=truecolor --syntax-by-name={}'
else
    let s:highlight = ''
endif

let s:preview = "echo {} | sed -e 's^~^$HOME^' | tr '\\n' '\\0'" . ' | xargs -0 -I"%" head -200 % ' . s:highlight

function! file_list#FasdAdd(file) abort
    call jobstart(['fasd', '-A', a:file], {'detach': v:true})
endfunction

function! file_list#FileSelectorDisplay() abort
    let l:fzf_params = {'source': '~/.local/bin/common/file-list -t -r', 'options': '--ansi --no-sort --tiebreak=end --preview="' . s:preview . '"'}

    call fzf#run(fzf#wrap(l:fzf_params))
endfunction

function! file_list#DirSelectorDisplay() abort
    let l:fzf_params = {'source': '~/.local/bin/common/file-list -d -r', 'options': '--ansi --no-sort --tiebreak=end', 'sink': 'lcd'}

    call fzf#run(fzf#wrap(l:fzf_params))
endfunction

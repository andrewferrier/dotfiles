set backup
set backupdir-=.

" This is required to make the backup renaming logic below work - see
" https://gist.github.com/nepsilon/003dd7cfefc20ce1e894db9c94749755
set backupcopy=yes

augroup SetBackupFilename
    "Meaningful backup name, ex: filename@2015-04-05T14:59:00
    autocmd!
    autocmd BufWritePre * let &backupext = '@' . strftime("%FT%H:%M:%S")
augroup END

set undofile

if has('nvim-0.5.0')
    set shada='100,s10,/1000,:1000,h
else
    " Remember a max of 25 files so that the oldfiles prompt doesn't overflow
    set shada='25,s10,/1000,:1000,h
endif

let data_dir = '~/.vim'
 
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo ' . data_dir . '/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
  \| endif

call plug#begin()
Plug 'tpope/vim-sensible'
call plug#end()

set nowrap
set number
set undofile

nnoremap <silent> cvf :browse oldfiles<CR>

" Remember a max of 25 files so that the oldfiles prompt doesn't overflow
set viminfo='25,s10,/1000,:1000,h

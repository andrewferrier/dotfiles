set clipboard=unnamed " On OSX, unnamed=unnamedplus, on Linux, autocutsel syncs them anyway
set diffopt+=algorithm:patience,indent-heuristic,vertical " see https://vimways.org/2018/the-power-of-diff/
set expandtab
set formatoptions+=l
set ignorecase
set mouse=nv
set shiftround
set shiftwidth=4
set smartcase
set textwidth=80 " This is the default for many/most languages: https://en.wikipedia.org/wiki/Characters_per_line#In_programming
set virtualedit=block
set wildmode=longest:full

iabbrev zDATE     <C-R>=strftime("%F")<CR>
iabbrev zDATETIME <C-R>=strftime("%FT%H:%M:%S")<CR>

" This generic behaviour for rename will be overwritten by treesitter.lua where
" supported.
nnoremap cxr :%s/<C-R><C-W>/<C-R><C-W>/gc<Left><Left><Left>
xnoremap cxr "zy:%s/<C-R>z/<C-R>z/gc<Left><Left><Left>

set clipboard=unnamed " On OSX, unnamed=unnamedplus, on Linux, autocutsel syncs them anyway
set diffopt+=algorithm:patience,indent-heuristic,vertical " see https://vimways.org/2018/the-power-of-diff/
set expandtab
set formatoptions+=l
set ignorecase
set shiftround
set shiftwidth=4
set smartcase
set textwidth=80 " This is the default for many/most languages: https://en.wikipedia.org/wiki/Characters_per_line#In_programming
set virtualedit=block
set wildmode=longest:full

if has('nvim-0.8.0')
    set mousemodel=extend
else
    set mouse=nvi
end

iabbrev zDATE     <C-R>=strftime("%F")<CR>
iabbrev zDATETIME <C-R>=strftime("%FT%H:%M:%S")<CR>

" This generic behaviour for rename will be overwritten by treesitter.lua where
" supported. Don't use 'cxr' in visual mode as it will block 'c'.
nnoremap cxr :%s/<C-R><C-W>/<C-R><C-W>/gc<Left><Left><Left>

if ! has('nvim-0.8.0')
    " See https://github.com/neovim/neovim/pull/19365
    nnoremap & :&&<CR>
end

if ! has('nvim-0.5.0')
    " Will be overwritten by fzf.lua configuration
    nnoremap <silent> cvf :browse oldfiles<CR>
end

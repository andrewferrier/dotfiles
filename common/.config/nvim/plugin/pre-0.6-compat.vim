if ! has('nvim-0.6.0')
    " https://github.com/neovim/neovim/pull/13268
    nnoremap Y y$
    " https://github.com/neovim/neovim/pull/15410
    set nojoinspaces
    " https://github.com/neovim/neovim/pull/15395
    set inccommand=nosplit
    " https://github.com/neovim/neovim/pull/15387
    xnoremap Y <Nop>
    " https://github.com/neovim/neovim/pull/15433
    call mkdir(expand(&backupdir), "p")

    " Ported from https://github.com/tpope/vim-sensible, with defaults already in
    " NeoVim removed.

    " https://github.com/neovim/neovim/pull/15385
    " Use <C-L> to clear the highlighting of :set hlsearch.
    if maparg('<C-L>', 'n') ==# ''
        nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
    endif

    set viewoptions-=options
endif

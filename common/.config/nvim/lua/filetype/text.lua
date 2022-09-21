local M = {}

M.setup = function()
    -- This might get called multiple times in, for example, the case of
    -- .mkd.txt files, where they are initially detected as .txt by Vim's own
    -- filetype detection, then overridden as markdown in my filetype.lua.
    if not vim.b.text_based_filetype then
        if
            not vim.o.readonly
            and vim.o.modifiable
            and vim.fn.empty(vim.fn.bufname("%")) == 0
            and not vim.o.diff
        then
            -- FIXME: This does not work with vim.wo.spell = true; this has to
            -- be opt_local, because setting it using vim.wo means affecting all
            -- future files loaded into this window. See
            -- https://github.com/neovim/neovim/issues/20271
            vim.opt_local.spell = true
        end

        vim.b.text_based_filetype = true
    end
end

return M

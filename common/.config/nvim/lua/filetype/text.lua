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
            vim.opt_local.spell = true
        end

        vim.api.nvim_create_autocmd("BufWinEnter", {
            group = vim.api.nvim_create_augroup("my-wrapping", {}),
            callback = function()
                require("wrapping").set_mode_heuristically()
            end,
            once = true
        })

        vim.b.text_based_filetype = true
    end
end

return M

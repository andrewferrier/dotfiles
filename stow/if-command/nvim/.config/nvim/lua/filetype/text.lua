local M = {}

M.setup = function()
    if
        not vim.o.readonly
        and vim.o.modifiable
        and vim.fn.bufname("%") ~= ""
        and not vim.o.diff
    then
        vim.opt_local.spell = true
    end

    vim.b.text_based_filetype = true
end

return M

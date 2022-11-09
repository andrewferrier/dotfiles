local M = {}

M.close = function()
    vim.cmd.cclose()
end

M.open = function()
    if vim.tbl_count(vim.fn.getqflist()) == 0 then
        vim.notify(
            "Nothing in quickfix list; not opening.",
            vim.log.levels.WARN
        )
    else
        vim.cmd.copen()
    end
end

return M

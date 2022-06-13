local M = {}

M.close = function()
    vim.cmd("cclose")
end

M.open = function()
    local list = vim.fn.getqflist()

    if vim.tbl_count(list) == 0 then
        vim.notify(
            "Nothing in quickfix list; not opening.",
            vim.log.levels.WARN
        )
    else
        vim.cmd("copen")
    end
end

return M

local M = {}

M.LARGE_FILE_LINE_COUNT = 10000

M.is_large_file = function(bufnr)
    if bufnr == nil then
        bufnr = 0
    end

    return (vim.api.nvim_buf_line_count(bufnr) > M.LARGE_FILE_LINE_COUNT)
end

return M

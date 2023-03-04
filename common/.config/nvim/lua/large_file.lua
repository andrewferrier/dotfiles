local M = {}

M.LARGE_FILE_LINE_COUNT = 10000

M.is_large_file = function(bufnr)
    return vim.api.nvim_buf_line_count(bufnr or 0) > M.LARGE_FILE_LINE_COUNT
end

return M

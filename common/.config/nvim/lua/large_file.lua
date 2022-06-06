local M = {}

M.is_large_file = function(bufnr)
    if bufnr == nil then
        bufnr = 0
    end

    return (vim.api.nvim_buf_line_count(bufnr) > 10000)
end

return M

local M = {}

M.remove_signs = function()
    vim.wo.signcolumn = "no"

    if vim.fn.has("nvim-0.9.0") == 1 then
        vim.wo.statuscolumn = ""
    end
end

M.remove_all = function()
    vim.wo.number = false
    vim.wo.relativenumber = false
    M.remove_signs()
end

return M

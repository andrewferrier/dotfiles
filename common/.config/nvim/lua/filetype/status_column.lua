local M = {}

M.remove_signs = function()
    vim.opt_local.signcolumn = "no"

    if vim.fn.has("nvim-0.9.0") == 1 then
        vim.opt_local.statuscolumn = ""
    end
end

M.remove_all = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    M.remove_signs()
end

return M

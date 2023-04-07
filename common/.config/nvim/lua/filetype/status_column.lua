local M = {}

M.remove_signs = function()
    vim.opt_local.signcolumn = "no"
    vim.opt_local.statuscolumn = ""
end

M.remove_all = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    M.remove_signs()
end

return M

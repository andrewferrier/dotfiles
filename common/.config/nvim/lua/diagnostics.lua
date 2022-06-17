local M = {}

M.hide = function()
    vim.b.diagnostic_enabled = false
    vim.diagnostic.disable(0)
end

M.show = function()
    vim.b.diagnostic_enabled = true
    vim.diagnostic.enable(0)
end

M.swap = function()
    if vim.b.diagnostic_enabled == false then
        M.show()
    else
        M.hide()
    end
end

return M

local M = {}

M.hide_silent = function()
    vim.b.diagnostic_enabled = false
    vim.diagnostic.disable(0)
end

M.hide = function()
    M.hide_silent()
    vim.notify("Diagnostics Hidden.")
end

M.show = function()
    vim.b.diagnostic_enabled = true
    vim.diagnostic.enable(0)
    vim.notify("Diagnostics Displayed.")
end

M.swap = function()
    if vim.b.diagnostic_enabled == false then
        M.show()
    else
        M.hide()
    end
end

return M

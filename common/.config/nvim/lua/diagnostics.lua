local M = {}

M.enabled = function()
    if vim.fn.has("nvim-0.9.0") == 1 then
        return not vim.diagnostic.is_disabled()
    else
        return vim.b.diagnostic_enabled == nil
            or vim.b.diagnostic_enabled == true
    end
end

M.hide = function()
    if vim.fn.has("nvim-0.9.0") ~= 1 then
        vim.b.diagnostic_enabled = false
    end

    vim.diagnostic.disable(0)
end

M.show = function()
    if vim.fn.has("nvim-0.9.0") ~= 1 then
        vim.b.diagnostic_enabled = true
    end

    vim.diagnostic.enable(0)
end

M.swap = function()
    if vim.fn.has("nvim-0.9.0") == 1 then
        if vim.diagnostic.is_disabled() then
            M.show()
        else
            M.hide()
        end
    else
        if vim.b.diagnostic_enabled == false then
            M.show()
        else
            M.hide()
        end
    end
end

return M

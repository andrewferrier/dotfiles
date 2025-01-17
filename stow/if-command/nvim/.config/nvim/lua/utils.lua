local M = {}

---@param out vim.SystemCompleted
M.system_on_exit = function(out)
    vim.schedule(function()
        if out.code ~= 0 then
            vim.notify(out.stderr, vim.log.levels.ERROR)
        end
    end)
end

---@return string
M.get_filename_homedir = function()
    local curfile = vim.fn.expand("%")
    ---@cast curfile string
    return vim.fn.substitute(curfile, "^" .. vim.env.HOME, "~", "")
end

---@return string
M.get_filename_homedir_shortened = function()
    return vim.fn.pathshorten(M.get_filename_homedir())
end

---@param method string
---@return boolean
M.lsp_supports_method = function(method)
    local clients = vim.tbl_filter(function(client)
        return client.supports_method(method)
    end, vim.lsp.get_clients({ bufnr = 0 }))

    return #clients > 0
end

---@return string
M.get_neovim_symbol = function()
    if vim.uv.os_uname().sysname == "Darwin" then
        return "nvim"
    else
        return ""
    end
end

return M

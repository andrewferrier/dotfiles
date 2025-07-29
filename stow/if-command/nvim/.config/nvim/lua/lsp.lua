local M = {}

---@param method string
---@return boolean
M.supports_method = function(method)
    local clients = vim.tbl_filter(function(client)
        return client.supports_method(method)
    end, vim.lsp.get_clients({ bufnr = 0 }))

    return #clients > 0
end

return M

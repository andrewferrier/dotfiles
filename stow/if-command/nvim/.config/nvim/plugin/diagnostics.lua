---@param diagnostic vim.Diagnostic
---@return string?
local diagnostic_source = function(diagnostic)
    if diagnostic.source then
        return diagnostic.source
    else
        local namespace = diagnostic.namespace

        if namespace then
            local namespaces = vim.diagnostic.get_namespaces()
            return namespaces[namespace].name
        end
    end
end

---@param diagnostic vim.Diagnostic
---@return string
local diagnostic_format = function(diagnostic)
    local message = diagnostic.message

    local source = diagnostic_source(diagnostic)

    if source then
        message = message .. "\n(" .. source .. ")"
    end

    return message
end

vim.diagnostic.config({
    severity_sort = true,
    float = {
        format = diagnostic_format,
        header = "",
    },
    virtual_text = {
        format = diagnostic_format,
        severity = {
            min = vim.diagnostic.severity.WARN,
            max = vim.diagnostic.severity.ERROR,
        },
    },
})

vim.api.nvim_create_user_command(
    "DiagnosticQFList",
    vim.diagnostic.setqflist,
    {}
)

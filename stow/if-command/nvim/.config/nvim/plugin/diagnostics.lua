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

    if diagnostic.code and not string.find(message, diagnostic.code) then
        message = message .. "\n[" .. diagnostic.code .. "]"
    end

    local source = diagnostic_source(diagnostic)

    if source then
        message = message .. "\n(" .. source .. ")"
    end

    return message
end

local SIGNS = {
    [vim.diagnostic.severity.ERROR] = "✘",
    [vim.diagnostic.severity.WARN] = "ω",
    [vim.diagnostic.severity.HINT] = "ɦ",
    [vim.diagnostic.severity.INFO] = "ℹ",
}

vim.diagnostic.config({
    float = {
        format = diagnostic_format,
        header = "",
        suffix = "",
        width = math.floor(vim.fn.winwidth(0) / 2),
    },
    virtual_text = {
        format = diagnostic_format,
        severity = {
            min = vim.diagnostic.severity.WARN,
            max = vim.diagnostic.severity.ERROR,
        },
        prefix = function(diagnostic)
            return SIGNS[diagnostic.severity]
        end,
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "▧",
            [vim.diagnostic.severity.WARN] = "▧",
            [vim.diagnostic.severity.HINT] = "▧",
            [vim.diagnostic.severity.INFO] = "▧",
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
            [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
            [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
            [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
        },
    },
})

vim.api.nvim_create_user_command(
    "DiagnosticQFList",
    vim.diagnostic.setqflist,
    {}
)

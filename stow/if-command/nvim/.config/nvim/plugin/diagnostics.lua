---@param diagnostic vim.Diagnostic
---@return string
local diagnostic_format = function(diagnostic)
    local message = diagnostic.message

    if diagnostic.code and not string.find(message, diagnostic.code) then
        message = message .. "\n[" .. diagnostic.code .. "]"
    end

    local source

    if diagnostic.source then
        source = diagnostic.source
    else
        local namespace = diagnostic.namespace

        if namespace then
            local namespaces = vim.diagnostic.get_namespaces()
            source = namespaces[namespace].name
        end
    end

    if source then
        message = message .. "\n(" .. source .. ")"
    end

    return message
end

local SIGNS = {
    [vim.diagnostic.severity.ERROR] = { symbol = "✘" },
    [vim.diagnostic.severity.WARN] = { symbol = "" },
    [vim.diagnostic.severity.HINT] = { symbol = "ɦ" },
    [vim.diagnostic.severity.INFO] = { symbol = "󰋽" },
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
            return SIGNS[diagnostic.severity]["symbol"]
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

require("editorconfig").properties.diagnostics = function(_, val, _)
    if val == "false" then
        vim.diagnostic.enable(false, { bufnr = 0 })
    end
end

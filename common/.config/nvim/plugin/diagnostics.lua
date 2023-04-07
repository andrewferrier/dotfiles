local diagnostic_format = function(diagnostic)
    local message = diagnostic.message

    if diagnostic.code and not string.find(message, diagnostic.code) then
        message = message .. "\n[" .. diagnostic.code .. "]"
    end

    if diagnostic.source then
        message = message .. "\n(" .. diagnostic.source .. ")"
    end

    return message
end

vim.diagnostic.config({
    float = {
        format = diagnostic_format,
        header = "",
        suffix = "",
        width = math.floor(vim.fn.winwidth(0) / 2),
    },
    virtual_text = {
        source = false,
        format = diagnostic_format,
        severity = {
            min = vim.diagnostic.severity.WARN,
            max = vim.diagnostic.severity.ERROR,
        },
    },
})

local signs = { Error = "✘", Warn = "!", Hint = "h", Info = "i" }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.api.nvim_create_user_command(
    "DiagnosticQFList",
    vim.diagnostic.setqflist,
    {}
)

require("editorconfig").properties.diagnostics = function(_, val, _)
    if val == "false" then
        vim.diagnostic.disable(0)
    end
end

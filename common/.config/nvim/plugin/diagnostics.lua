local diagnostic_format = function(diagnostic)
    local message = diagnostic.message

    if diagnostic.code then
        message = message .. " [" .. diagnostic.code .. "]"
    end

    if diagnostic.source then
        message = message .. " (" .. diagnostic.source .. ")"
    end

    return message
end

vim.diagnostic.config({
    float = {
        format = diagnostic_format,
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

vim.api.nvim_create_user_command("DiagnosticQFList", function()
    vim.diagnostic.setqflist({ open = false })
    require("quickfix").open()
end, {})

if vim.fn.has("nvim-0.9.0") == 1 then
    require("editorconfig").properties.diagnostics = function(_, val, _)
        if val == "false" then
            require("diagnostics").hide()
        end
    end
end

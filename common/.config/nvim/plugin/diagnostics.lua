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

local SIGNS = {
    { hlname = "Error", symbol = "✘", level = vim.diagnostic.severity.ERROR },
    { hlname = "Warn", symbol = "⌇", level = vim.diagnostic.severity.WARN },
    { hlname = "Hint", symbol = "ɦ", level = vim.diagnostic.severity.HINT },
    { hlname = "Info", symbol = "ℹ", level = vim.diagnostic.severity.INFO },
}

local virtual_text = {
    source = false,
    format = diagnostic_format,
    severity = {
        min = vim.diagnostic.severity.WARN,
        max = vim.diagnostic.severity.ERROR,
    },
}

if vim.fn.has("nvim-0.10.0") == 1 then
    virtual_text.prefix = function(diagnostic)
        for _, sign in ipairs(SIGNS) do
            if diagnostic.severity == sign.level then
                return sign.symbol
            end
        end
    end
end

vim.diagnostic.config({
    float = {
        format = diagnostic_format,
        header = "",
        suffix = "",
        width = math.floor(vim.fn.winwidth(0) / 2),
    },
    virtual_text = virtual_text,
})

for _, sign in ipairs(SIGNS) do
    local hl = "DiagnosticSign" .. sign.hlname
    local symbol

    if vim.fn.has("nvim-0.10.0") == 1 then
        symbol = "▧"
    else
        symbol = sign.symbol
    end

    vim.fn.sign_define(hl, { text = symbol, texthl = hl, numhl = hl })
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

local diagnostic_format = function(diagnostic)
    local message = diagnostic.message

    if diagnostic.code then
        message = message .. " [" .. diagnostic.code .. "]"
    elseif diagnostic.lsp and diagnostic.lsp.code then
        message = message .. " [" .. diagnostic.lsp.code .. "]"
    end

    if diagnostic.source then
        message = message .. " (" .. diagnostic.source .. ")"
    end

    return message
end

vim.diagnostic.config({
    virtual_text = {
        source = false,
        format = diagnostic_format,
        severity = {
            min = vim.diagnostic.severity.WARN,
            max = vim.diagnostic.severity.ERROR,
        },
    },
    float = {
        source = false,
    },
})

local signs = { Error = "✘", Warn = "▲", Hint = "⚑", Info = "ℹ" }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- These mappings replace ones provided by vim-unimpaired which I don't use, as
-- they affect the 'diff' setting.

vim.keymap.set("n", "yog", function()
    require("diagnostics").swap()
end)
vim.keymap.set("n", "]og", function()
    require("diagnostics").hide()
end)
vim.keymap.set("n", "[og", function()
    require("diagnostics").show()
end)

SEVERITY_MAP = {
    "DiagnosticError",
    "DiagnosticWarn",
    "DiagnosticInfo",
    "DiagnosticHint",
}

local show_diagnostic = function(diagnostic)
    if diagnostic ~= nil then
        vim.cmd("echohl " .. SEVERITY_MAP[diagnostic.severity])
        vim.cmd('echo "' .. diagnostic_format(diagnostic) .. '"')
        vim.cmd("echohl None")
        vim.fn.setcursorcharpos(diagnostic.lnum + 1, diagnostic.col + 1)
    end
end

vim.keymap.set("n", "]g", function()
    local diagnostic = vim.diagnostic.get_next()
    show_diagnostic(diagnostic)
end)

vim.keymap.set("n", "[g", function()
    local diagnostic = vim.diagnostic.get_prev()
    show_diagnostic(diagnostic)
end)

vim.keymap.set("n", "[G", "1G]g", { silent = true, remap = true })
vim.keymap.set("n", "]G", "G[g", { silent = true, remap = true })

vim.api.nvim_create_user_command("DiagnosticQFList", function()
    vim.diagnostic.setqflist({ open = false })
    require("quickfix").open()
end, {})

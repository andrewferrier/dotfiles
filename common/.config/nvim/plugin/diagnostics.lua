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

-- These mappings replace ones provided by vim-unimpaired which I don't use, as
-- they affect the 'diff' setting.

vim.keymap.set("n", "yog", function()
    require("diagnostics").swap()
end)

vim.keymap.set("n", "]g", vim.diagnostic.goto_next)
vim.keymap.set("n", "[g", vim.diagnostic.goto_prev)

vim.keymap.set("n", "[G", "1G]g", { silent = true, remap = true })
vim.keymap.set("n", "]G", "G[g", { silent = true, remap = true })

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

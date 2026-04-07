vim.lsp.on_type_formatting.enable()
vim.lsp.inlay_hint.enable()

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
        local bufnr = event.buf

        vim.keymap.set("n", "yoi", function()
            vim.lsp.inlay_hint.enable(
                not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }),
                { bufnr = bufnr }
            )
        end, { buffer = bufnr, desc = "Toggle inlay hints" })
    end,
})

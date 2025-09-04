---@param bufnr integer
local function keybindings_inlayhints(bufnr)
    vim.keymap.set("n", "yoi", function()
        vim.lsp.inlay_hint.enable(
            not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }),
            { bufnr = bufnr }
        )
    end, { buffer = bufnr, desc = "Toggle inlay hints" })
end

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
        local bufnr = event.buf

        if vim.fn.has("nvim-0.12.0") == 1 then
            vim.lsp.on_type_formatting.enable()
        end

        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        keybindings_inlayhints(bufnr)
    end,
})

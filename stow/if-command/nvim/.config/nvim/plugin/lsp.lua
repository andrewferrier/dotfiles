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

        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        keybindings_inlayhints(bufnr)
    end,
})

vim.api.nvim_create_user_command("LspInspectClient", function()
    require("lsp").inspect_client()
end, {})

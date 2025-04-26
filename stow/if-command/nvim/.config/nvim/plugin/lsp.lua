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

        vim.keymap.set(
            { "n", "x" },
            "gra",
            require("fzf-lua").lsp_code_actions,
            { buffer = bufnr, desc = "Apply code action" }
        )

        if vim.fn.has("nvim-0.12.0") == 1 then
            local client = vim.lsp.get_client_by_id(event.data.client_id)

            if
                client ~= nil
                and client:supports_method("textDocument/documentColor")
            then
                vim.lsp.document_color.enable(true, bufnr)
            end
        end
    end,
})

vim.api.nvim_create_user_command("LspInspectClient", function()
    require("lsp").inspect_client()
end, {})

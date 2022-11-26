require("nvim-semantic-tokens").setup({})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("LspAttach_semantictokens", {}),
    callback = function(args)
        if not (args.data and args.data.client_id and args.buf) then
            return
        end

        local client = vim.lsp.get_client_by_id(args.data.client_id)
        local caps = client.server_capabilities

        if caps.semanticTokensProvider and caps.semanticTokensProvider.full then
            vim.api.nvim_create_autocmd("TextChanged", {
                group = vim.api.nvim_create_augroup("TextChanged_semantictokens", {}),
                buffer = args.buf,
                callback = vim.lsp.buf.semantic_tokens_full
            })

            vim.lsp.buf.semantic_tokens_full()
        end
    end,
})

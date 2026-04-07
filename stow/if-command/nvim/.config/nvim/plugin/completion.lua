vim.opt.autocomplete = true
vim.opt.autocompletedelay = 250
vim.opt.completeopt:append("fuzzy")
vim.opt.completeopt:append("menuone")
vim.opt.completeopt:append("noselect")

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp_completion", { clear = true }),
    callback = function(args)
        local client_id = args.data.client_id
        if not client_id then
            return
        end

        local client = vim.lsp.get_client_by_id(client_id)
        if client and client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client_id, args.buf, {
                autotrigger = true,
            })
        end
    end,
})

vim.keymap.set("i", "<Tab>", function()
    if vim.fn.pumvisible() == 1 then
        local info = vim.fn.complete_info()

        local count = #info.items
        local is_item_selected = info.selected ~= -1

        if is_item_selected and count == 1 then
            return "<C-y>"
        else
            return "<C-n>"
        end
    else
        return "<Tab>"
    end
end, { expr = true, silent = true })

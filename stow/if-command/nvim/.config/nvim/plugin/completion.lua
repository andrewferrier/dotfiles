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

---@param key string
---@param complete_key string
local tab_handler = function(key, complete_key)
    vim.keymap.set("i", key, function()
        if vim.fn.pumvisible() == 1 then
            local info = vim.fn.complete_info()

            local count = #info.items
            local is_item_selected = info.selected ~= -1

            if is_item_selected and count == 1 then
                return "<C-y>"
            else
                return complete_key
            end
        else
            return key
        end
    end, { expr = true, silent = true })
end

---@param key string
---@param include_key boolean
local accept_or_key = function(key, include_key)
    vim.keymap.set("i", key, function()
        if vim.fn.pumvisible() == 1 then
            if include_key then
                return "<C-y>" .. key
            else
                return "<C-y>"
            end
        else
            return key
        end
    end, { expr = true, silent = true })
end

accept_or_key("(", true)
accept_or_key("<CR>", false)
accept_or_key("<Space>", true)
accept_or_key("=", true)
tab_handler("<S-Tab>", "<C-p>")
tab_handler("<Tab>", "<C-n>")

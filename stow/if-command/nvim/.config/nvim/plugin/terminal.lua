if vim.fn.has("nvim-0.11.0") == 0 then
    vim.api.nvim_create_autocmd("TermOpen", {
        callback = function()
            vim.opt_local.signcolumn = "no"
            vim.opt_local.number = false
            vim.opt_local.relativenumber = false
        end,
    })
end

vim.api.nvim_create_autocmd("TermOpen", {
    callback = function()
        vim.cmd.startinsert()
    end,
})

vim.api.nvim_create_autocmd("TermClose", {
    callback = function()
        vim.api.nvim_input("<CR>")
    end,
})

-- Set window navigation to work like in other windows
---@param lhs string
---@param rhs string
local map = function(lhs, rhs)
    vim.keymap.set(
        "t",
        lhs,
        "<C-\\><C-N>" .. rhs,
        { silent = true, unique = true }
    )
end

map("<C-W>+", "<C-W>+")
map("<C-W>-", "<C-W>-")
map("<C-W>>", "<C-W>>")
map("<C-W><", "<C-W><")
map("<C-W><C-C>", ":close<CR>")
map("<C-W><C-N>", ":new<CR>")
map("<C-W><C-O>", ":only<CR>")
map("<C-W><C-W>", "<C-W><C-W>")
map("<C-W><down>", "<C-W>j")
map("<C-W><left>", "<C-W>h")
map("<C-W><right>", "<C-W>l")
map("<C-W><up>", "<C-W>k")
map("<C-W>c", ":close<CR>")
map("<C-W>n", ":new<CR>")
map("<C-W>o", ":only<CR>")
map("<C-W>w", "<C-W><C-W>")

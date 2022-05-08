-- luacheck: globals vim

local id = vim.api.nvim_create_augroup("neovim_terminal", {})

vim.api.nvim_create_autocmd("TermOpen", {
    group = id,
    command = "setlocal nonumber norelativenumber",
})

vim.api.nvim_create_autocmd("TermOpen", {
    group = id,
    command = "startinsert",
})

vim.api.nvim_create_autocmd("TermClose", {
    group = id,
    callback = function()
        vim.api.nvim_input("<CR>")
    end,
})

local opts = { silent = true }

-- Set window navigation to work like in other windows
local map = function(lhs, rhs)
    vim.keymap.set("t", lhs, "<C-\\><C-N>" .. rhs, opts)
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

-- For some reason these need explicit remapping
vim.keymap.set("t", "<M-Left>", "<M-Left>", opts)
vim.keymap.set("t", "<M-Right>", "<M-Right>", opts)
vim.keymap.set("t", "<M-Up>", "<M-Up>", opts)

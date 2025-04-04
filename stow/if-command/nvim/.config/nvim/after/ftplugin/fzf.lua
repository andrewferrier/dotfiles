vim.b.previous_titlestring = vim.o.titlestring
vim.o.titlestring = require("utils").get_neovim_symbol() .. " [fzf]"

vim.api.nvim_create_autocmd("BufLeave", {
    pattern = { "<buffer>" },
    callback = function()
        vim.o.titlestring = vim.b.previous_titlestring
    end,
})

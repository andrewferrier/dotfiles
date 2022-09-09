vim.o.titlestring = "nvim [fzf]"

vim.api.nvim_create_autocmd("BufLeave", {
    group = vim.api.nvim_create_augroup("FZFLeave", {}),
    pattern = { "<buffer>" },
    callback = function()
        vim.o.titlestring = vim.g.general_titlestring
    end,
})

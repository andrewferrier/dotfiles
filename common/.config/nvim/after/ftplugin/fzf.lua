-- luacheck: globals vim

vim.opt.titlestring = "nvim [fzf]"

vim.api.nvim_create_autocmd("BufLeave", {
    group = vim.api.nvim_create_augroup("FZFLeave", {}),
    pattern = { "<buffer>" },
    callback = function()
        vim.opt.titlestring = vim.g.general_titlestring
    end,
})

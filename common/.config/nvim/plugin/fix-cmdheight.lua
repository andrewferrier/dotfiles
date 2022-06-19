-- Work around https://github.com/neovim/neovim/issues/18955

if vim.fn.has("nvim-0.8.0") == 1 then
    vim.api.nvim_create_autocmd("CmdlineEnter", {
        callback = function()
            vim.opt_local.cmdheight = 1
        end,
    })

    vim.api.nvim_create_autocmd("CmdlineLeave", {
        callback = function()
            vim.opt_local.cmdheight = 0
        end,
    })
end

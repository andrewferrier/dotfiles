-- Based on
-- https://www.reddit.com/r/neovim/comments/lmhcmj/the_help_window_is_a_bit_wonky/gnvk5pr

local autosplit_ft = { "man", "gitcommit" }
local autosplit_bt = { "help" }

local new_split = function()
    local buftype = vim.opt.buftype:get()
    local filetype = vim.opt.filetype:get()

    if
        vim.tbl_contains(autosplit_bt, buftype)
        or vim.tbl_contains(autosplit_ft, filetype)
    then
        local bufnr = vim.fn.bufnr()
        local winnr = vim.fn.winnr("#")
        local vertical_split = vim.fn.winwidth(winnr)
            >= (
                vim.fn.getwinvar(winnr, "&textwidth", 80)
                + vim.fn.getwinvar(vim.fn.winnr(), "&textwidth", 80)
            )

        vim.cmd("wincmd J")
        vim.cmd("wincmd p")

        if vertical_split then
            vim.cmd("vsplit")
        else
            vim.cmd("split")
        end

        vim.cmd(bufnr .. "b")
        vim.cmd(vim.fn.winnr("50j") .. "wincmd q")
    end
end

vim.api.nvim_create_autocmd("WinNew", {
    group = vim.api.nvim_create_augroup("Autosplit", {}),
    callback = function()
        vim.api.nvim_create_autocmd("BufEnter", {
            pattern = "*",
            callback = new_split,
            once = true,
        })
    end,
})

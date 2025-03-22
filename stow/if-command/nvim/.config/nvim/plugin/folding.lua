vim.opt.fillchars = "fold: "
vim.opt.foldlevel = 99
vim.opt.foldtext = ""

local set_fold_method = function()
    if vim.wo.foldmethod == "manual" then
        if require("nvim-treesitter.parsers").has_parser() then
            if vim.wo.foldexpr == "0" then
                vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
            end

            vim.opt_local.foldmethod = "expr"
        else
            vim.opt_local.foldmethod = "indent"
        end
    end
end

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    callback = set_fold_method,
})

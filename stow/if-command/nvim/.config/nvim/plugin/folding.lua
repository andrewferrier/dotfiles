vim.opt.foldlevel = 99
vim.opt.foldmethod = "indent"

local set_fold_method = function()
    if
        vim.wo.foldmethod == "indent"
        and require("nvim-treesitter.parsers").has_parser()
    then
        vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.opt_local.foldmethod = "expr"
    end
end

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup("set_fold_method", {}),
    callback = set_fold_method,
})

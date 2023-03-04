local set_fold_method = function()
    local large_file = require("large_file").is_large_file()
    local treesitter_parsers = require("nvim-treesitter.parsers")

    if vim.wo.foldmethod == "manual" then
        if not large_file and treesitter_parsers.has_parser() then
            if vim.fn.has("nvim-0.9.0") == 1 then
                vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
            else
                vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
            end

            vim.wo.foldmethod = "expr"
        else
            vim.wo.foldmethod = "indent"
        end
    end

    vim.wo.foldlevel = 99
end

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup("set_fold_method", {}),
    callback = set_fold_method,
})

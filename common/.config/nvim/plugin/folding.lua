-- luacheck: globals vim

local set_fold_method = function()
    local large_file = require("large_file").is_large_file()
    local treesitter_parsers = require("nvim-treesitter.parsers")

    if vim.opt.filetype:get() == "markdown" then
        vim.cmd("setlocal foldmethod=manual")
    elseif vim.wo.foldmethod == "manual" then
        if not large_file and treesitter_parsers.has_parser() then
            vim.cmd("setlocal foldexpr=nvim_treesitter#foldexpr()")
            vim.cmd("setlocal foldmethod=expr")
        else
            vim.cmd("setlocal foldmethod=indent")
        end
    end
end

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup("set_fold_method", {}),
    callback = set_fold_method,
})

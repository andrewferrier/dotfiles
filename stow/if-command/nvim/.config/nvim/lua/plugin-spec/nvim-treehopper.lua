local enable_treehopper = function()
    local OPTS = { buffer = true, silent = true, unique = true }

    vim.keymap.set("o", "m", ':<C-U>lua require("tsht").nodes()<CR>', OPTS)
    vim.keymap.set("x", "m", ':lua require("tsht").nodes()<CR>', OPTS)
end

return {
    "mfussenegger/nvim-treehopper",
    event = "BufEnter",
    config = function()
        vim.api.nvim_create_autocmd({ "BufReadPost" }, {
            pattern = "*",
            group = vim.api.nvim_create_augroup("BufReadPost_treehopper", {}),
            callback = function()
                if require("nvim-treesitter.parsers").has_parser() then
                    enable_treehopper()
                end
            end,
        })
    end,
}

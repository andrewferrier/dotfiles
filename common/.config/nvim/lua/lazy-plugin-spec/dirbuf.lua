return {
    {
        "elihunter173/dirbuf.nvim",
        config = function()
            require("dirbuf").setup({
                sort_order = "directories_first",
            })
        end,
        -- Pinned because of this bug: https://github.com/elihunter173/dirbuf.nvim/issues/53
        commit = "e0044552",
    },
}

return {
    { "will133/vim-dirdiff", cmd = "DirDiff" },

    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("plugins.gitsigns")
        end,
    }, -- gb
}

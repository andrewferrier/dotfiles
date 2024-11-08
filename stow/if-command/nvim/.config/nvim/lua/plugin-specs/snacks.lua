return {
    "folke/snacks.nvim",
    lazy = false,
    opts = {
        bigfile = { enabled = true },
        notifier = { enabled = false },
        quickfile = { enabled = false },
        statuscolumn = { enabled = false },
        words = { enabled = false },
    },
    keys = {
        {
            "<Leader>r",
            function()
                require("snacks").rename.rename_file()
            end,
            desc = "Rename File",
        },
    },
}

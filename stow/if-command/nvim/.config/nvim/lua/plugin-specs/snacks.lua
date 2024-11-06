return {
    "folke/snacks.nvim",
    lazy = false,
    opts = {
        styles = { notification = { wo = { winblend = 0 } } },

        bigfile = { enabled = true },
        notifier = { enabled = true, style = "minimal" },
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

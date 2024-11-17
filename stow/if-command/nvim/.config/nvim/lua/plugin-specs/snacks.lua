return {
    "folke/snacks.nvim",
    version = "*",
    lazy = false,
    opts = {
        bigfile = { enabled = true },
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

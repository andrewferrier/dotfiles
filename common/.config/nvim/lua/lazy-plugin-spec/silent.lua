return {
    {
        "ellisonleao/gruvbox.nvim",
        config = function()
            require("plugins.gruvbox")
        end,
    },

    "tpope/vim-sleuth",

    {
        "vladdoster/remember.nvim",
        config = function()
            require("remember")
        end,
    },

    {
        "tversteeg/registers.nvim",
        config = function()
            require("plugins.registers")
        end,
    },

    {
        "NvChad/nvim-colorizer.lua",
        config = function()
            require("plugins.colorizer")
        end,
    },

    {
        "levouh/tint.nvim",
        config = function()
            require("plugins.tint")
        end,
    },
}

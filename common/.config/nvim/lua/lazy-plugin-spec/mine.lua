return {
    {
        url = "git@github.com:andrewferrier/wrapping.nvim",
        config = function()
            require("plugins.wrapping")
        end,
    },

    {
        url = "git@github.com:andrewferrier/textobj-diagnostic.nvim",
        config = function()
            require("textobj-diagnostic").setup()
        end,
    },

    {
        url = "git@github.com:andrewferrier/debugprint.nvim",
        config = function()
            require("debugprint").setup()
        end,
        dependencies = "nvim-treesitter/nvim-treesitter",
    },
}

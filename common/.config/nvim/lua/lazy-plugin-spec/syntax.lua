return {
    "qnighy/vim-ssh-annex",

    {
        "iamcco/markdown-preview.nvim",
        build = "cd app && yarn install",
        config = function()
            require("plugins.markdown_preview")
        end,
        ft = "markdown",
    },

    { "jkramer/vim-checkbox", ft = "markdown" },

    {
        "lervag/vimtex",
        config = function()
            require("plugins.vimtex")
        end,
    },

    {
        "mechatroner/rainbow_csv",
        ft = { "csv", "tsv" },
        config = function()
            require("plugins.rainbow_csv")
        end,
    },
}

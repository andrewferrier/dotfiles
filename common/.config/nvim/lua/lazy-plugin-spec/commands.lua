return {
    "tpope/vim-eunuch",

    -- Eventually this can be replaced with
    -- https://github.com/neovim/neovim/issues/5054
    "tyru/capture.vim",

    {
        "tpope/vim-unimpaired",
        dependencies = { "tpope/vim-repeat" },
    }, -- quite slow

    {
        "anuvyklack/hydra.nvim",
        config = function()
            require("plugins.hydra")
        end,
    },

    {
        "ibhagwan/fzf-lua",
        config = function()
            require("plugins.fzf")
        end,
        keys = { "cv" },
    },
}

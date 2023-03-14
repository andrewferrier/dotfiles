return {
    url = "git@github.com:andrewferrier/debugprint.nvim",
    config = function()
        require("debugprint").setup()
    end,
    dependencies = "nvim-treesitter/nvim-treesitter",
    -- Don't use 'keys'; won't work if visual mode is used first
}

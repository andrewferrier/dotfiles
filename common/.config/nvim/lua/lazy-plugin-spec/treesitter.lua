local function install_treesitter_parsers()
    -- Neither of these are sync, but that shouldn't matter as there is no
    -- intersection in the parsers they will touch
    vim.cmd.TSUpdate()
    -- In practice TSInstall may not install new parsers until after NeoVim is
    -- restarted. I don't consider that a major problem, just means we might lag
    -- behind a bit.
    vim.cmd.TSInstall("all")
end

return {
    "RRethy/nvim-treesitter-endwise",
    "mfussenegger/nvim-treehopper",
    "nvim-treesitter/nvim-treesitter-refactor",
    { "nvim-treesitter/playground", command = "TSPlaygroundToggle" },

    {
        "nvim-treesitter/nvim-treesitter",
        build = install_treesitter_parsers,
        config = function()
            require("plugins.treesitter")
        end,
    },

    { "Afourcat/treesitter-terraform-doc.nvim" },

    {
        "cshuaimin/ssr.nvim",
        config = function()
            require("plugins.ssr")
        end,
    },
}

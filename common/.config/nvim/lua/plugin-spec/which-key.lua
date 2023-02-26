return {
    "folke/which-key.nvim",
    dependencies = { "anuvyklack/hydra.nvim" },
    config = function()
        require("which-key").setup({ triggers_blacklist = { n = { "C-W" } } })
    end,
}

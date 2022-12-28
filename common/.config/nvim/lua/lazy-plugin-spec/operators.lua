return {
    { "christoomey/vim-sort-motion", keys = "gs" },

    {
        "johmsalas/text-case.nvim",
        dependencies = { "anuvyklack/hydra.nvim" },
        config = function()
            require("plugins.text_case")
        end,
        keys = "gyc",
    },
}

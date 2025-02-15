-- selene: allow(mixed_table)
---@type LazyPluginSpec
return {
    "folke/lazydev.nvim",
    ft = "lua",
    ---@type lazydev.Config
    opts = {
        library = {
            "conform.nvim",
            "debugprint.nvim",
            "lazy.nvim",
            "lazydev.nvim",
            "oil.nvim",
            "snacks.nvim",
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
    },
}

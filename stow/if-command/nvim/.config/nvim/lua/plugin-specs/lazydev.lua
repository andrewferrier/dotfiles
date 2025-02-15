-- selene: allow(mixed_table)
---@type LazyPluginSpec
return {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
        library = {
            "lazy.nvim",
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
    },
}

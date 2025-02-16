-- selene: allow(mixed_table)
---@type LazyPluginSpec
return {
    "rachartier/tiny-glimmer.nvim",
    event = "VeryLazy",
    opts = {
        overwrite = {
            search = { enabled = true },
            undo = { enabled = true },
            redo = { enabled = true },
        },
    },
}

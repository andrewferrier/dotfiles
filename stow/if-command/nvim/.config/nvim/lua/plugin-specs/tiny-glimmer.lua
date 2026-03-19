-- selene: allow(mixed_table)
---@type LazyPluginSpec
return {
    "rachartier/tiny-glimmer.nvim",
    event = "VeryLazy",
    opts = {
        overwrite = {
            -- Search is too confusing, because the highlight we end up using
            -- isn't clear once the animation has disappeared
            search = { enabled = false },
            undo = { enabled = true },
            redo = { enabled = true },
        },
    },
}

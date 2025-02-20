-- selene: allow(mixed_table)
---@type LazyPluginSpec
return {
    "git@github.com:andrewferrier/debugprint.nvim",
    ---@type DebugprintGlobalOptions
    opts = {
        keymaps = {
            insert = {
                plain = false,
                variable = false,
            },
        },
        filetypes = {
            lf = require("debugprint.filetypes").bash,
        },
    },
    lazy = false,
}

-- selene: allow(mixed_table)
---@type LazyPluginSpec
return {
    "git@github.com:andrewferrier/debugprint.nvim",
    ---@type debugprint.GlobalOptions
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

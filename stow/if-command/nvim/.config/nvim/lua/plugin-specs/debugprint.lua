-- selene: allow(mixed_table)
---@type LazyPluginSpec
return {
    "git@github.com:andrewferrier/debugprint.nvim",
    opts = function()
        ---@type debugprint.GlobalOptions
        return {
            keymaps = {
                insert = {
                    plain = false,
                    variable = false,
                },
            },
            filetypes = {
                lf = require("debugprint.filetypes").bash,
            },
            picker = "fzf-lua",
        }
    end,
    lazy = false,
}

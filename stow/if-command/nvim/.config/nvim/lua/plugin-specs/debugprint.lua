return {
    "git@github.com:andrewferrier/debugprint.nvim",
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

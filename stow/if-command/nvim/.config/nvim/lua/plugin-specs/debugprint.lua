return {
    "git@github.com:andrewferrier/debugprint.nvim",
    opts = {
        keymaps = {
            insert = {
                plain = false,
                variable = false,
            },
        },
    },
    keys = {
        { "g?", mode = "n" },
        { "g?", mode = "x" },
    },
    cmd = {
        "ToggleCommentDebugPrints",
        "DeleteDebugPrints",
    },
}

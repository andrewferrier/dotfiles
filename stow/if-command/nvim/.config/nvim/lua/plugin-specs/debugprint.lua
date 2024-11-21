return {
    "git@github.com:andrewferrier/debugprint.nvim",
    opts = {
        keymaps = {
            insert = {
                plain = nil,
                variable = nil,
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

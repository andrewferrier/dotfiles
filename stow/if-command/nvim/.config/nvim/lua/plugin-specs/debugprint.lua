return {
    "git@github.com:andrewferrier/debugprint.nvim",
    opts = {},
    keys = {
        { "g?", mode = "n" },
        { "g?", mode = "x" },
    },
    cmd = {
        "ToggleCommentDebugPrints",
        "DeleteDebugPrints",
    },
    version = "*",
}

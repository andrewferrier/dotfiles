return {
    "git@github.com:andrewferrier/debugprint.nvim",
    opts = {},
    keys = {
        { "g?", mode = "n" },
        { "g?", mode = "x" },
        { "<C-G>", mode = "i" },
    },
    cmd = {
        "ToggleCommentDebugPrints",
        "DeleteDebugPrints",
    },
}

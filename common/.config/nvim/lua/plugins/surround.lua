require("nvim-surround").setup({
    keymaps = {
        insert = "sa",
        visual = "S",
        delete = "sd",
        change = "sr",
    },
    delimiters = {
        pairs = {
            -- These are really only intended for use with markdown
            ["l"] = { "[", "]()" },
            ["L"] = { "[](", ")" },
        },
    }
})

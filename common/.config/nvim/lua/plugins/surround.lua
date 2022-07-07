vim.keymap.set('n', 's', '<Nop>')
vim.keymap.set('x', 's', '<Nop>')

require("nvim-surround").setup({
    keymaps = {
        insert = "sa",
        visual = "s",
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

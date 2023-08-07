return {
    "chrisgrieser/nvim-various-textobjs",
    config = function()
        vim.keymap.set(
            { "o", "x" },
            "ak",
            '<cmd>lua require("various-textobjs").key(false)<CR>',
            { desc = "'key'/lhs including assignment" }
        )
        vim.keymap.set(
            { "o", "x" },
            "ik",
            '<cmd>lua require("various-textobjs").key(true)<CR>',
            { desc = "'key'/lhs" }
        )
        vim.keymap.set(
            { "o", "x" },
            "av",
            '<cmd>lua require("various-textobjs").value(false)<CR>',
            { desc = "'value'/rhs including terminator" }
        )
        vim.keymap.set(
            { "o", "x" },
            "iv",
            '<cmd>lua require("various-textobjs").value(true)<CR>',
            { desc = "'value'/rhs" }
        )
        vim.keymap.set(
            { "o", "x" },
            "aS",
            '<cmd>lua require("various-textobjs").subword(false)<CR>',
            { desc = "SubWord" }
        )
        vim.keymap.set(
            { "o", "x" },
            "iS",
            '<cmd>lua require("various-textobjs").subword(true)<CR>',
            { desc = "SubWord" }
        )
        vim.keymap.set(
            { "o", "x" },
            "id",
            '<cmd>lua require("various-textobjs").diagnostic()<CR>',
            { desc = "diagnostic" }
        )
    end,
    event = "BufEnter",
}
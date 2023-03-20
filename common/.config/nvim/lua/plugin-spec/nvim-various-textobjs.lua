return {
    "chrisgrieser/nvim-various-textobjs",
    config = function()
        vim.keymap.set({ "o", "x" }, "ak", function()
            require("various-textobjs").key(false)
        end, { desc = "'key'/lhs including assignment" })
        vim.keymap.set({ "o", "x" }, "ik", function()
            require("various-textobjs").key(true)
        end, { desc = "'key'/lhs" })
        vim.keymap.set({ "o", "x" }, "av", function()
            require("various-textobjs").value(false)
        end, { desc = "'value'/rhs including terminator" })
        vim.keymap.set({ "o", "x" }, "iv", function()
            require("various-textobjs").value(true)
        end, { desc = "'value'/rhs" })
        vim.keymap.set({ "o", "x" }, "aS", function()
            require("various-textobjs").subword(false)
        end, { desc = "SubWord" })
        vim.keymap.set({ "o", "x" }, "iS", function()
            require("various-textobjs").subword(true)
        end, { desc = "SubWord" })
        vim.keymap.set({ "o", "x" }, "id", function()
            require("various-textobjs").diagnostic()
        end, { desc = "diagnostic" })
    end,
    event = "BufEnter",
}

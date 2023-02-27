return {
    "chrisgrieser/nvim-various-textobjs",
    config = function()
        require("various-textobjs").setup({
            useDefaultKeymaps = false,
            lookForwardLines = 10,
        })

        vim.keymap.set({ "o", "x" }, "ak", function()
            require("various-textobjs").key(false)
        end)
        vim.keymap.set({ "o", "x" }, "ik", function()
            require("various-textobjs").key(true)
        end)
        vim.keymap.set({ "o", "x" }, "av", function()
            require("various-textobjs").value(false)
        end)
        vim.keymap.set({ "o", "x" }, "iv", function()
            require("various-textobjs").value(true)
        end)
        vim.keymap.set({ "o", "x" }, "aS", function()
            require("various-textobjs").subword(false)
        end)
        vim.keymap.set({ "o", "x" }, "iS", function()
            require("various-textobjs").subword(true)
        end)
        vim.keymap.set({ "o", "x" }, "ig", function()
            require("various-textobjs").diagnostic()
        end)
    end,
    event = "VeryLazy",
}

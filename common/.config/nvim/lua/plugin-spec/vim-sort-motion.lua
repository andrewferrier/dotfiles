return {
    "christoomey/vim-sort-motion",
    event = "VeryLazy",
    config = function()
        -- Avoid conflict since I don't use this keymap anyway
        vim.keymap.del("n", "gss")
    end,
}

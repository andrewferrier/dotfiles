return {
    "tpope/vim-unimpaired",
    dependencies = { "tpope/vim-repeat" },
    config = function()
        -- This is needed to make [C and ]C work without delay
        vim.keymap.del("n", "[CC")
        vim.keymap.del("n", "]CC")
    end,
} -- quite slow

vim.g.textobj_indent_no_default_key_mappings = true

return {
    "kana/vim-textobj-indent",
    dependencies = { "kana/vim-textobj-user" },
    config = function()
        vim.keymap.set(
            { "o", "x" },
            "ai",
            "<Plug>(textobj-indent-a)",
            { unique = true }
        )
        vim.keymap.set(
            { "o", "x" },
            "ii",
            "<Plug>(textobj-indent-i)",
            { unique = true }
        )
    end,
    event = "VeryLazy",
}

return {
    "echasnovski/mini.nvim",
    config = function()
        require("mini.ai").setup()

        require("mini.align").setup({
            mappings = {
                start = nil,
                start_with_preview = "gl",
            },
        })

        vim.g.minibasics_silence = true

        require("mini.basics").setup({
            options = { basic = false },
            mappings = { basic = false, option_toggle_prefix = "yo" },
        })

        -- Delete option-toggling prefixes I don't use to avoid accidentally
        -- turning them off
        vim.keymap.del("n", "yoh")
        vim.keymap.del("n", "yoi")

        require("mini.bracketed").setup({
            comment = { suffix = "o" },
            diagnostic = { options = { float = false } },
            jump = { suffix = "" },
            oldfile = { suffix = "" },
            window = { suffix = "" },
        })

        require("mini.comment").setup({})

        require("mini.surround").setup({})
    end,
}

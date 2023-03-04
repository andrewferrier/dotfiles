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
            indent = { options = { change_type = "diff" } },
            jump = { suffix = "" },
            oldfile = { suffix = "" },
            window = { suffix = "" },
            undo = { suffix = "" }, -- Undo causes a lot of flicker with cmdheight=0
        })

        require("mini.comment").setup({})

        -- Will be replaced with https://github.com/neovim/neovim/issues/16339
        require("mini.misc").setup_restore_cursor()

        require("mini.surround").setup({})
    end,
}

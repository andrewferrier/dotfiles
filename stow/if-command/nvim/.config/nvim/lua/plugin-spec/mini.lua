return {
    "echasnovski/mini.nvim",
    config = function()
        require("mini.ai").setup()

        require("mini.align").setup({
            silent = true,
            mappings = {
                start = "gl",
            },
        })

        require("mini.basics").setup({
            silent = true,
            options = { basic = false },
            mappings = { basic = false, option_toggle_prefix = "yo" },
        })

        -- Delete option-toggling prefixes I don't use to avoid accidentally
        -- turning them off
        vim.keymap.del("n", "yoh")
        vim.keymap.del("n", "yoi")

        require("mini.bracketed").setup({
            comment = { suffix = "o" }, -- 'c' is used in diff mode for diffs
            indent = { options = { change_type = "diff" } },
            jump = { suffix = "" },
            oldfile = { suffix = "" },
            window = { suffix = "" },
        })

        require("plugin-config.mini.clue")

        require("mini.comment").setup()

        -- Will be replaced with https://github.com/neovim/neovim/issues/16339
        require("mini.misc").setup_restore_cursor()

        require("mini.surround").setup({
            mappings = { find = "", find_left = "", highlight = "" },
        })

        require("plugin-config.mini.hipatterns")
    end,
    -- Uncomment once mini.clue promoted to stable
    -- version = "*",
}
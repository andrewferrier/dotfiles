return {
    "echasnovski/mini.nvim",
    config = function()
        require("mini.basics").setup({
            silent = true,
            options = { basic = false },
            mappings = { basic = false, option_toggle_prefix = "yo" },
        })

        -- Will be replaced with https://github.com/neovim/neovim/issues/16339
        require("mini.misc").setup_restore_cursor()

        vim.api.nvim_create_autocmd({ "BufEnter" }, {
            group = vim.api.nvim_create_augroup("BufEnter_mini.lua", {}),
            once = true,
            callback = function()
                require("mini.ai").setup()

                require("mini.align").setup({
                    mappings = {
                        start = nil,
                        start_with_preview = "gl",
                    },
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
                    undo = { suffix = "" }, -- Undo causes a lot of flicker with cmdheight=0
                })

                require("mini.comment").setup({})

                require("mini.surround").setup({
                    mappings = { find = "", find_left = "", highlight = "" },
                })
            end,
        })
    end,
}

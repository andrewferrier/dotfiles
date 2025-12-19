-- selene: allow(mixed_table)
---@type LazyPluginSpec
return {
    "echasnovski/mini.nvim",
    config = function()
        require("mini.ai").setup({
            -- Disable setup of 'an'/'in' for new LSP mappings in NeoVim 0.12
            mappings = {
                around_next = "",
                inside_next = "",
            },
        })

        require("mini.align").setup({
            mappings = {
                start = "gl",
            },
        })

        require("mini.basics").setup({
            silent = true,
            autocommands = { basic = false },
            options = { basic = false },
            mappings = { basic = false, option_toggle_prefix = "yo" },
        })

        -- Delete option-toggling prefixes I don't use to avoid accidentally
        -- turning them off
        vim.keymap.del("n", "yoh")
        vim.keymap.del("n", "yoi")
        vim.keymap.del("n", "yow")

        require("mini.bracketed").setup({
            comment = { suffix = "o" }, -- 'c' is used in diff mode for diffs
            indent = { options = { change_type = "diff" } },
            jump = { suffix = "" },
            oldfile = { suffix = "" },
            window = { suffix = "" },
        })

        require("mini.cmdline").setup({})

        -- Will be replaced with https://github.com/neovim/neovim/issues/16339
        require("mini.misc").setup_restore_cursor()

        require("mini.operators").setup({
            evaluate = { prefix = "g=" },
            exchange = { prefix = "" },
            multiply = { prefix = "" },
            replace = { prefix = "" },
            sort = { prefix = "gs" },
        })

        require("mini.surround").setup({
            mappings = { find = "", find_left = "", highlight = "" },
        })

        -- I never use 's' by itself, so disabling as this is just annoying
        vim.keymap.set({ "n", "x" }, "s", "<Nop>")

        require("plugin-specs.mini.hipatterns")
    end,
    init = function()
        package.preload["nvim-web-devicons"] = function()
            require("mini.icons").mock_nvim_web_devicons()
            return package.loaded["nvim-web-devicons"]
        end
    end,
    version = "*",
}

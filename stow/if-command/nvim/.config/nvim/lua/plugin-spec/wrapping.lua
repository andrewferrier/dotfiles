return {
    url = "git@github.com:andrewferrier/wrapping.nvim",
    config = function()
        require("wrapping").setup({
            create_keymaps = false,
            softener = { mail = true },
            notify_on_switch = false,
            auto_set_mode_filetype_allowlist = {
                "asciidoc",
                "gitcommit",
                "help", -- Experiment with adding 'help'
                "latex",
                "mail",
                "markdown",
                "rst",
                "tex",
                "text",
            },
        })

        vim.keymap.set("n", "yow", function()
            require("wrapping").toggle_wrap_mode()
        end, { desc = "Toggle wrap mode", unique = true })
    end,
}

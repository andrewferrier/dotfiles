return {
    url = "git@github.com:andrewferrier/wrapping.nvim",
    config = function()
        require("wrapping").setup({
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
    end,
}

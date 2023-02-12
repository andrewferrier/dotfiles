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

        require("mini.basics").setup({
            options = { basic = false },
            mappings = { basic = false, option_toggle_prefix = '' },
        })

        require("mini.comment").setup({})

        require("mini.surround").setup({})
    end,
    branch = "stable",
}

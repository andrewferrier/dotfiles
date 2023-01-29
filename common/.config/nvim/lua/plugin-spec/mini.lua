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
            autocommands = { basic = true },
        })

        require("mini.comment").setup({})

        require("mini.surround").setup({})
    end,
    -- TODO: Reinstate once mini.lua basics promoted to stable
    -- branch = "stable",
}

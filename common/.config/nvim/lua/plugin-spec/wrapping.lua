return {
    url = "git@github.com:andrewferrier/wrapping.nvim",
    config = function()
        require("wrapping").setup({
            softener = { mail = true },
            notify_on_switch = false,
        })
    end,
}

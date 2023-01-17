return {
    "tversteeg/registers.nvim",
    config = function()
        require("registers").setup({
            show = "*-/#%.0123456789abcdefghijklmnopqrstuvwxyz",
            window = { border = "rounded", transparency = 0 },
            events = {
                on_register_highlighted = false, -- Do nothing
            },
        })
    end,
    version = "*"
}

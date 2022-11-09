require("registers").setup({
    show = "*-/#%.0123456789abcdefghijklmnopqrstuvwxyz",
    window = { border = "rounded", transparency = 0 },
    events = {
        on_register_highlighted = function()
            -- Do nothing
        end,
    },
})

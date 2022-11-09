require("registers").setup({
    show = "*-/#%.0123456789abcdefghijklmnopqrstuvwxyz",
    show_empty = false,
    trim_whitespace = true,
    window = { border = "rounded", transparency = 0 },
    events = {
        on_register_highlighted = function()
            -- Do nothing
        end,
    },
})

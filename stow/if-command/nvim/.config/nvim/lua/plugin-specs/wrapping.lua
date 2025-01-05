return {
    url = "git@github.com:andrewferrier/wrapping.nvim",
    opts = {
        create_keymaps = false,
        softener = { mail = true },
        notify_on_switch = false,
    },
    keys = {
        {
            "yow",
            function()
                require("wrapping").toggle_wrap_mode()
            end,
            desc = "Toggle wrap mode",
            unique = true,
        },
    },
    lazy = false,
    -- Set up mapping before mini.basics
    priority = 49,
}

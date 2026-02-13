---@type LazyPluginSpec
return {
    url = "git@github.com:andrewferrier/wrapping.nvim",
    opts = {
        create_keymaps = false,
        softener = { mail = true },
        notify_on_switch = false,
    },
    -- selene: allow(mixed_table)
    keys = {
        {
            "yow",
            "<Plug>(wrapping-toggle-wrap-mode)",
            desc = "Toggle wrap mode",
            unique = true,
        },
    },
    lazy = false,
    -- Set up mapping before mini.basics
    priority = 49,
}

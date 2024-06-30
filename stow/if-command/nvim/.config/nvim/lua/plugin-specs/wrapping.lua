return {
    url = "git@github.com:andrewferrier/wrapping.nvim",
    config = function()
        require("wrapping").setup({
            create_keymaps = false,
            softener = { mail = true },
            notify_on_switch = false,
        })

        vim.keymap.set("n", "yow", function()
            require("wrapping").toggle_wrap_mode()
        end, { desc = "Toggle wrap mode", unique = true })
    end,
    -- Set up mapping before mini.basics
    priority = 49,
}

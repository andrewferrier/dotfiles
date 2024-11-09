return {
    url = "git@github.com:andrewferrier/wrapping.nvim",
    config = function()
        ---@diagnostic disable-next-line: missing-fields
        require("wrapping").setup({
            create_keymaps = false,
            ---@diagnostic disable-next-line: missing-fields
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

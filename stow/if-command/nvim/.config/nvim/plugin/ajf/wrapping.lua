---@diagnostic disable: missing-fields
vim.cmd.packadd("wrapping.nvim")

require("wrapping").setup({
    create_keymaps = false,
    softener = { mail = true },
    notify_on_switch = false,
})

vim.keymap.set(
    "n",
    "yow",
    "<Plug>(wrapping-toggle-wrap-mode)",
    { desc = "Toggle wrap mode", unique = true }
)

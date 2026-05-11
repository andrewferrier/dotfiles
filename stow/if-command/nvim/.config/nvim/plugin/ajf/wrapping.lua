---@diagnostic disable: missing-fields
vim.cmd.packadd("wrapping.nvim")

---@type wrapping.Options
local opts = {
    create_keymaps = false,
    softener = { mail = true },
    notify_on_switch = false,
}

require("wrapping").setup(opts)

vim.keymap.set(
    "n",
    "yow",
    "<Plug>(wrapping-toggle-wrap-mode)",
    { desc = "Toggle wrap mode", unique = true }
)

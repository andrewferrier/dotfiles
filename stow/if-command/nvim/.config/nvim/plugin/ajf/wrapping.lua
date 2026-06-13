---@diagnostic disable: missing-fields
if #vim.fn.globpath(vim.o.packpath, "pack/*/opt/wrapping.nvim", 0, 1) > 0 then
    vim.cmd.packadd("wrapping.nvim")
else
    vim.pack.add({ "https://github.com/andrewferrier/wrapping.nvim" })
end

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

vim.keymap.set("n", "s", "<Nop>")
vim.keymap.set("x", "s", "<Nop>")

require("nvim-surround").setup({
    keymaps = {
        normal = "sa",
        visual = "s",
        delete = "sd",
        change = "sr",
    },
    indent_lines = false,
})

local warn = function()
    vim.notify("Don't use 'ys', 'ds', or 'cs'!", vim.log.levels.WARN)
end

vim.keymap.set("n", "ys", warn)
vim.keymap.set("n", "ds", warn)
vim.keymap.set("n", "cs", warn)

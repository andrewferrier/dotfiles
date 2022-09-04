vim.keymap.set("n", "s", "<Nop>")
vim.keymap.set("x", "s", "<Nop>")

require("nvim-surround").setup({
    keymaps = {
        normal = "sa",
        visual = "s",
        delete = "sd",
        change = "sr",
    },
})

require("nvim-surround.buffer").format_lines = function(_, _)
    -- Disable indenting by nvim-surround; see
    -- https://github.com/kylechui/nvim-surround/issues/109#issuecomment-1194034971
end

local warn = function()
    vim.notify("Don't use 'ys', 'ds', or 'cs'!", vim.log.levels.WARN)
end

vim.keymap.set("n", "ys", function()
    warn()
end)

vim.keymap.set("n", "ds", function()
    warn()
end)

vim.keymap.set("n", "cs", function()
    warn()
end)

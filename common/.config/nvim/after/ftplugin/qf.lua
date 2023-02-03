vim.keymap.set("n", "q", function()
    vim.cmd.cclose()
end, { buffer = true })

vim.keymap.set("n", "gyr", function()
    require("replacer").run()
end)

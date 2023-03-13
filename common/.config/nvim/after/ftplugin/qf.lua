vim.keymap.set("n", "q", function()
    vim.cmd.cclose()
end, { buffer = true })

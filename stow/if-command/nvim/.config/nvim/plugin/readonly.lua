vim.keymap.set("n", "cvr", function()
    require("readonly").make_readonly()
    vim.notify("Effective R/O on.")
end, { desc = "Turn on effective r/o" })

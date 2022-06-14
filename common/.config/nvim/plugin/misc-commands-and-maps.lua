vim.api.nvim_create_user_command("ReadonlyEffective", function()
    require("readonly").make_readonly()
    vim.notify("Effective R/O on.")
end, {})

vim.keymap.set("n", "Q", "<Nop>")
vim.keymap.set("n", "<C-Z>", "<Nop>")

vim.keymap.set("n", "<Leader>r", ':Rename <C-R>=expand("%:t")<CR>')

-- luacheck: globals vim
vim.keymap.set("n", "cvo", function()
    require('readonly').make_readonly()
    vim.notify("Effective R/O on.")
end)

vim.keymap.set("n", "Q", "<Nop>")
vim.keymap.set("n", "<C-Z>", "<Nop>")

vim.keymap.set("n", "<Leader>r", ':Rename <C-R>=expand("%:t")<CR>')

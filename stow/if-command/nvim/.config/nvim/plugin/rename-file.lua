vim.keymap.set(
    "n",
    "<Leader>r",
    ':Rename <C-R>=expand("%:t")<CR>',
    { desc = "Rename file", unique = true }
)

vim.keymap.set("n", "<Leader>r", ':Rename <C-R>=expand("%:t")<CR>')

vim.keymap.set("n", "<CR>", function()
    if vim.o.buftype == "" and vim.o.modified == true then
        return ":update<CR>"
    else
        return "<CR>"
    end
end, { expr = true })

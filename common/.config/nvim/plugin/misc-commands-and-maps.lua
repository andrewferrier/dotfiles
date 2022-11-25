vim.keymap.set("n", "<Leader>r", function()
    if vim.o.filetype == "javascript" or vim.o.filetype == "typescript" then
        return ':TypescriptRenameFile<CR>'
    else
        return ':Rename <C-R>=expand("%:t")<CR>'
    end
end, { expr = true })

vim.keymap.set("n", "<CR>", function()
    if vim.o.buftype == "" and vim.o.modified == true then
        return ":update<CR>"
    else
        return "<CR>"
    end
end, { expr = true })

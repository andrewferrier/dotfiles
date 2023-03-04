vim.keymap.set("n", "<Leader>r", function()
    if vim.o.filetype == "javascript" or vim.o.filetype == "typescript" then
        return ':TypescriptRenameFile<CR>'
    else
        return ':Rename <C-R>=expand("%:t")<CR>'
    end
end, { expr = true })

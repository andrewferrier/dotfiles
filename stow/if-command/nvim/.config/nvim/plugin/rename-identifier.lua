vim.pack.add({ "https://github.com/smjonas/inc-rename.nvim" })

require("inc_rename").setup({ cmd_name = "LspRename" })

vim.keymap.set("n", "grn", function()
    if
        require("lsp").supports_method(
            vim.lsp.protocol.Methods.textDocument_rename
        )
    then
        return ":LspRename " .. vim.fn.expand("<cword>")
    else
        return ":%s/<C-R><C-W>/<C-R><C-W>/gc<Left><Left><Left>"
    end
end, {
    expr = true,
    desc = "Rename identifier using LSP/regex",
})

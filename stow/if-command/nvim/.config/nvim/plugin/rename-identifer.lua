local TREESITTER_RENAME_INEFFECTIVE = { "markdown", "latex" }

-- Don't use 'cxr' in visual mode as it will block 'c'
vim.keymap.set("n", "cxr", function()
    if
        vim.fn.has("nvim-0.10.0") == 0
        or require("utils").lsp_supports_method(
            vim.lsp.protocol.Methods.textDocument_rename
        )
    then
        return ":LspRename " .. vim.fn.expand("<cword>")
    elseif
        require("nvim-treesitter.parsers").has_parser()
        and not vim.tbl_contains(
            TREESITTER_RENAME_INEFFECTIVE,
            vim.opt.filetype:get()
        )
    then
        vim.schedule(function()
            require("nvim-treesitter-refactor.smart_rename").smart_rename(0)
        end)
        return "<Nop>"
    else
        return ":%s/<C-R><C-W>/<C-R><C-W>/gc<Left><Left><Left>"
    end
end, {
    expr = true,
    desc = "Rename identifier using LSP/Treesitter/regex",
})

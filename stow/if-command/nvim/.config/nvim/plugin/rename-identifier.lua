vim.pack.add({ { src = "https://github.com/smjonas/inc-rename.nvim" } })

-- FIXME: Technically this plugin is deprecated, however it still seems to work,
-- so keeping it for now
vim.pack.add({
    { src = "https://github.com/nvim-treesitter/nvim-treesitter-refactor" },
})

require("inc_rename").setup({ cmd_name = "LspRename" })

local TREESITTER_RENAME_INEFFECTIVE = { "markdown", "latex" }

vim.keymap.set("n", "grn", function()
    local has_parser = pcall(vim.treesitter.get_parser)

    if
        require("lsp").supports_method(
            vim.lsp.protocol.Methods.textDocument_rename
        )
    then
        return ":LspRename " .. vim.fn.expand("<cword>")
    elseif
        has_parser
        and not vim.tbl_contains(
            TREESITTER_RENAME_INEFFECTIVE,
            vim.opt.filetype:get()
        )
    then
        vim.schedule(function()
            require("nvim-treesitter-refactor.smart_rename").smart_rename(
                vim.fn.bufnr()
            )
        end)
        return "<Nop>"
    else
        return ":%s/<C-R><C-W>/<C-R><C-W>/gc<Left><Left><Left>"
    end
end, {
    expr = true,
    desc = "Rename identifier using LSP/Treesitter/regex",
})

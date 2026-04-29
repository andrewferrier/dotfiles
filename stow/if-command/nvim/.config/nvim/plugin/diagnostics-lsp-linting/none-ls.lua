vim.pack.add({ "https://github.com/nvimtools/none-ls.nvim" })
vim.pack.add({
    {
        src = "https://github.com/nvim-lua/plenary.nvim",
        version = vim.version.range("*"),
    },
})

local null_ls = require("null-ls")

local sources = {
    null_ls.builtins.diagnostics.gitlint.with({
        extra_args = {
            "--ignore",
            "B6",
        },
    }),
    null_ls.builtins.diagnostics.hadolint,
    null_ls.builtins.diagnostics.markdownlint,
    null_ls.builtins.diagnostics.sqlfluff,
    null_ls.builtins.diagnostics.zsh,
}

if vim.fn.executable("selene") == 1 then
    -- selene is only installed on Arch
    table.insert(sources, null_ls.builtins.diagnostics.selene)
end

require("null-ls").setup({ sources = sources })

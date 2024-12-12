return {
    "nvimtools/none-ls.nvim",
    dependencies = { { "nvim-lua/plenary.nvim", version = "*" } },
    opts = function()
        local null_ls = require("null-ls")

        return {
            -- debug = true,
            sources = {
                null_ls.builtins.diagnostics.gitlint.with({
                    extra_args = {
                        "--ignore",
                        "B6",
                    },
                }),
                null_ls.builtins.diagnostics.hadolint,
                null_ls.builtins.diagnostics.markdownlint,
                null_ls.builtins.diagnostics.sqlfluff,
                null_ls.builtins.diagnostics.terraform_validate,
                null_ls.builtins.diagnostics.vale,
                null_ls.builtins.diagnostics.yamllint,
                null_ls.builtins.diagnostics.zsh,
            },
        }
    end,
    event = "BufEnter",
}

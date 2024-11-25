return {
    "nvimtools/none-ls.nvim",
    dependencies = { { "nvim-lua/plenary.nvim", version = "*" } },
    config = function()
        local null_ls = require("null-ls")

        local sources = {
            null_ls.builtins.diagnostics.gitlint.with({
                extra_args = {
                    "--ignore",
                    "B6",
                },
            }),
            null_ls.builtins.diagnostics.hadolint,
            null_ls.builtins.diagnostics.mdl.with({
                extra_args = {
                    "--ignore-front-matter",
                    "-s",
                    vim.env.XDG_CONFIG_HOME .. "/mdl/.mdl.rb",
                },
            }),
            null_ls.builtins.diagnostics.sqlfluff,
            null_ls.builtins.diagnostics.terraform_validate,
            null_ls.builtins.diagnostics.vale,
            null_ls.builtins.diagnostics.yamllint,
            null_ls.builtins.diagnostics.zsh,
        }

        null_ls.setup({
            -- debug = true,
            sources = sources,
        })
    end,
    event = "BufEnter",
}

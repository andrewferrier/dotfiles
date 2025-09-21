---@type LazyPluginSpec
-- selene: allow(mixed_table)
return {
    "nvimtools/none-ls.nvim",
    dependencies = { { "nvim-lua/plenary.nvim", version = "*" } },
    opts = function()
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

        return {
            -- debug = true,
            sources = sources,
        }
    end,
    event = "BufEnter",
}

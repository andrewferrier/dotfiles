return {
    "nvimtools/none-ls.nvim",
    dependencies = { { "nvim-lua/plenary.nvim", version = "*" } },
    config = function()
        local null_ls = require("null-ls")

        local sources = {
            -- Formatters

            null_ls.builtins.formatting.prettier.with({
                filetypes = { "html", "yaml" },
                extra_args = function(params)
                    return {
                        "--print-width",
                        vim.api.nvim_get_option_value(
                            "textwidth",
                            { buf = params.bufnr }
                        ),
                        "--tab-width",
                        vim.api.nvim_get_option_value(
                            "shiftwidth",
                            { buf = params.bufnr }
                        ),
                    }
                end,
            }),
            null_ls.builtins.formatting.sqlfluff,
            null_ls.builtins.formatting.stylua.with({
                extra_args = function(params)
                    return {
                        "--column-width",
                        vim.api.nvim_get_option_value(
                            "textwidth",
                            { buf = params.bufnr }
                        ),
                        "--indent-width",
                        vim.api.nvim_get_option_value(
                            "shiftwidth",
                            { buf = params.bufnr }
                        ),
                        "--indent-type",
                        "spaces",
                    }
                end,
            }),
            null_ls.builtins.formatting.remark,

            -- Diagnostics

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
            should_attach = function(bufnr)
                local status_ok, bigfile_detected =
                    pcall(vim.api.nvim_buf_get_var, bufnr, "bigfile_detected")

                if status_ok then
                    return bigfile_detected <= 0
                else
                    return true
                end
            end,
        })
    end,
    event = "BufEnter",
}

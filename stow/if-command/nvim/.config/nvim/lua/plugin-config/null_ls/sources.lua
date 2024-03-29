local M = {}

local null_ls = require("null-ls")

M.sources = {
    -- Formatters

    null_ls.builtins.formatting.prettier.with({
        filetypes = { "html", "toml", "yaml"},
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
    null_ls.builtins.formatting.shfmt.with({
        extra_args = function(params)
            return {
                "-i",
                vim.api.nvim_get_option_value(
                    "shiftwidth",
                    { buf = params.bufnr }
                ),
            }
        end,
    }),
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
    null_ls.builtins.diagnostics.trail_space.with({
        -- for 'mail' it's just annoying
        -- for 'markdown' it's more accurate than mdl
        disabled_filetypes = {
            "dirbuf",
            "gitcommit",
            "lua",
            "mail",
        },
    }),
    null_ls.builtins.diagnostics.vale,
    null_ls.builtins.diagnostics.yamllint,
    null_ls.builtins.diagnostics.zsh,
}

return M

local M = {}

local null_ls = require("null-ls")
local diagnostics = require("null-ls.helpers.diagnostics")

local custom_diagnostics = require("plugin-config.null_ls.custom_diagnostics")

local SEVERITIES = diagnostics.severities

M.sources = {
    -- Code actions

    null_ls.builtins.code_actions.shellcheck,

    -- Formatters

    null_ls.builtins.formatting.black.with({
        extra_args = function(params)
            return {
                "--line-length="
                    .. vim.api.nvim_buf_get_option(params.bufnr, "textwidth"),
            }
        end,
    }),
    null_ls.builtins.formatting.latexindent.with({
        extra_args = function(params)
            local COLUMNS = "modifyLineBreaks:textWrapOptions:columns:"
                .. vim.api.nvim_buf_get_option(params.bufnr, "textwidth")
            local INDENT = "defaultIndent:'"
                .. string.rep(
                    " ",
                    vim.api.nvim_buf_get_option(params.bufnr, "shiftwidth")
                )
                .. "'"

            return {
                "-m",
                "--cruft=/tmp",
                "--yaml=" .. COLUMNS .. "," .. INDENT,
            }
        end,
        filetypes = { "tex", "latex" },
    }),
    null_ls.builtins.formatting.prettier.with({
        filetypes = { "css", "html", "less", "scss", "toml", "yaml" },
        extra_args = function(params)
            return {
                "--print-width",
                vim.api.nvim_buf_get_option(params.bufnr, "textwidth"),
                "--tab-width",
                vim.api.nvim_buf_get_option(params.bufnr, "shiftwidth"),
            }
        end,
    }),
    null_ls.builtins.formatting.sqlfluff,
    null_ls.builtins.formatting.shfmt.with({
        extra_args = function(params)
            return {
                "-i",
                vim.api.nvim_buf_get_option(params.bufnr, "shiftwidth"),
            }
        end,
    }),
    null_ls.builtins.formatting.stylua.with({
        extra_args = function(params)
            return {
                "--column-width",
                vim.api.nvim_buf_get_option(params.bufnr, "textwidth"),
                "--indent-width",
                vim.api.nvim_buf_get_option(params.bufnr, "shiftwidth"),
                "--indent-type",
                "spaces",
            }
        end,
    }),
    null_ls.builtins.formatting.remark,
    null_ls.builtins.formatting.trim_whitespace, -- only works for ff=unix
    null_ls.builtins.formatting.xmllint,

    -- Diagnostics

    null_ls.builtins.diagnostics.ansiblelint,
    null_ls.builtins.diagnostics.checkmake,
    null_ls.builtins.diagnostics.chktex.with({
        filetypes = { "tex", "latex" },
    }),
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
    null_ls.builtins.diagnostics.shellcheck,
    null_ls.builtins.diagnostics.sqlfluff,
    null_ls.builtins.diagnostics.tidy,
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
    custom_diagnostics.diagnostics_by_line({
        name = "todo-fixme",
        -- disabled for 'gitcommit'/'gitrebase' because it doesn't make any
        -- sense, sometimes we will want to write TODO and that's a valid part
        -- of the message.
        disabled_filetypes = { "dirbuf", "gitcommit", "gitrebase" },
        fn = function(match_regex)
            match_regex(vim.regex("TODO"), "TODO", SEVERITIES.hint)
            match_regex(vim.regex("FIXME"), "FIXME", SEVERITIES.hint)
        end,
    }),

    require("typescript.extensions.null-ls.code-actions"),
}

return M

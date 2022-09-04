local M = {}

local null_ls = require("null-ls")

local whitespace_str = function(length)
    local indent_str = ""

    while indent_str:len() < length do
        indent_str = indent_str .. " "
    end

    return indent_str
end

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
            return {
                "--cruft=/tmp",
                "--yaml=defaultIndent:'"
                    .. whitespace_str(
                        vim.api.nvim_buf_get_option(params.bufnr, "shiftwidth")
                    )
                    .. "'",
            }
        end,
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

    null_ls.builtins.diagnostics.checkmake,
    null_ls.builtins.diagnostics.chktex,
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
            vim.env.HOME .. "/.config/mdl/.mdl.rb",
        },
    }),
    null_ls.builtins.diagnostics.shellcheck.with({
        extra_args = {
            "--enable",
            "add-default-case",
            "--enable",
            "avoid-nullary-conditions",
            "--enable",
            "check-unassigned-uppercase",
            "--enable",
            "deprecate-which",
        },
    }),
    null_ls.builtins.diagnostics.sqlfluff,
    null_ls.builtins.diagnostics.tidy,
    null_ls.builtins.diagnostics.todo_comments.with({
        -- disabled for 'gitcommit'/'gitrebase' because it doesn't make any
        -- sense, sometimes we will want to write TODO and that's a valid part
        -- of the message.
        disabled_filetypes = { "dirbuf", "gitcommit", "gitrebase" },
    }),
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
    null_ls.builtins.diagnostics.zsh,
}

return M

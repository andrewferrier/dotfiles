-- luacheck: globals vim

local M = {}

local null_ls = require("null-ls")
local null_ls_helpers = require("null-ls.helpers")

local SEVERITIES = null_ls_helpers.diagnostics.severities

local diagnostics_by_line_results = function(content, match_regex, name)
    local result = {}

    for line_number = 1, #content do
        match_regex(function(regex, message, severity)
            local line = content[line_number]
            local start_byte, end_byte = regex:match_str(line)

            if start_byte ~= nil then
                table.insert(result, {
                    message = message,
                    severity = severity,
                    row = line_number,
                    col = start_byte + 1,
                    end_row = line_number,
                    end_col = end_byte + 1,
                    source = name,
                })
            end
        end)
    end

    return result
end

local diagnostics_by_line = function(options)
    return {
        method = null_ls.methods.DIAGNOSTICS,
        name = options.name,
        filetypes = {},
        disabled_filetypes = options.disabled_filetypes,
        generator = {
            async = true,
            fn = function(params, done)
                return done(
                    diagnostics_by_line_results(
                        params.content,
                        options.fn,
                        options.name
                    )
                )
            end,
        },
    }
end

local REGEX_TODO = vim.regex("TODO")
local REGEX_FIXME = vim.regex("FIXME")

M.sources = {
    -- Code actions

    null_ls.builtins.code_actions.shellcheck,

    -- Formatters

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
    null_ls.builtins.formatting.black.with({
        extra_args = function(params)
            return {
                "--line-length=" .. vim.api.nvim_buf_get_option(
                    params.bufnr,
                    "textwidth"
                ),
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
    null_ls.builtins.diagnostics.trail_space.with({
        -- for 'mail' it's just annoying
        disabled_filetypes = {
            "dirbuf",
            "gitcommit",
            "lua",
            "markdown",
            "mail",
        },
    }),
    null_ls.builtins.diagnostics.zsh,
    diagnostics_by_line({
        name = "todo-fixme",
        -- disabled for 'gitcommit'/'gitrebase' because it doesn't make any
        -- sense, sometimes we will want to write TODO and that's a valid part
        -- of the message.
        disabled_filetypes = { "dirbuf", "gitcommit", "gitrebase" },
        fn = function(match_regex)
            match_regex(REGEX_TODO, "TODO", SEVERITIES.hint)
            match_regex(REGEX_FIXME, "FIXME", SEVERITIES.hint)
        end,
    }),
}

return M

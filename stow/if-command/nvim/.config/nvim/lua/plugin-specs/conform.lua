local format_key = function()
    require("conform").format({}, function(err, did_edit)
        if not err then
            if did_edit then
                vim.notify("Formatted document using conform.")
            else
                vim.notify("Formatted document using conform; no changes.")
            end
        else
            vim.notify(
                "Could not format document; " .. err .. ".",
                vim.log.levels.ERROR
            )
        end
    end)
end

local opts = {
    formatters_by_ft = {
        lua = { "stylua" },
        html = { "prettier" },
        yaml = { "prettier" },
        sql = { "sqlfluff" },
        markdown = { "mdformat" },
    },
    default_format_opts = {
        lsp_format = "fallback",
    },
    formatters = {
        prettier = {
            prepend_args = function(_, context)
                return {
                    "--print-width",
                    vim.api.nvim_get_option_value(
                        "textwidth",
                        { buf = context.buf }
                    ),
                    "--tab-width",
                    vim.api.nvim_get_option_value(
                        "shiftwidth",
                        { buf = context.buf }
                    ),
                }
            end,
        },
        stylua = {
            prepend_args = function(_, context)
                return {
                    "--column-width",
                    vim.api.nvim_get_option_value(
                        "textwidth",
                        { buf = context.buf }
                    ),
                    "--indent-width",
                    vim.api.nvim_get_option_value(
                        "shiftwidth",
                        { buf = context.buf }
                    ),
                    "--indent-type",
                    "spaces",
                }
            end,
        },
    },
}

return {
    "stevearc/conform.nvim",
    opts = opts,
    keys = {
        {
            "gQ",
            format_key,
            desc = "Format buffer",
        },
    },
    version = "*",
}

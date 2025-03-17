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

---@type conform.setupOpts
local opts = {
    formatters_by_ft = {
        d2 = { "d2" },
        html = { "prettier" },
        lua = { "stylua" },
        markdown = { "mdformat" },
        python = { "ruff_organize_imports" },
        sql = { "sqlfluff" },
        yaml = { "prettier", "yamlfix" },
    },
    default_format_opts = {
        lsp_format = "first",
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

---@type LazyPluginSpec
-- selene: allow(mixed_table)
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
    cmd = { "ConformInfo" },
    version = "*",
}

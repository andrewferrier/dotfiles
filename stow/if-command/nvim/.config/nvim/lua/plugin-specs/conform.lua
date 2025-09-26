local format_key = function()
    local opts = {}

    if vim.o.filetype == "tex" then
        -- Can't find a way to disable this in texlab configuration - texlab
        -- causes latexindex to time out
        opts = { lsp_format = "never", timeout_ms = 5000 }
    end

    require("conform").format(opts, function(err, did_edit)
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
        tex = { "latexindent" },
        lua = { "stylua" },
        make = { "bake" },
        markdown = { "mdformat" },
        python = { "ruff_organize_imports" },
        sql = { "sqlfluff" },
    },
    default_format_opts = {
        lsp_format = "first",
    },
    formatters = {
        bake = {
            -- This is now the preferred name, see https://pypi.org/project/mbake/
            command = "mbake",
        },
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

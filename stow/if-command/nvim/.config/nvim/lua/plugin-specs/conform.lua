return {
    "stevearc/conform.nvim",
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                lua = { "stylua" },
                html = { "prettier" },
                yaml = { "prettier" },
                sql = { "sqlfluff" },
                md = { "remark" },
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
        })

        vim.keymap.set("n", "gQ", function()
            require("conform").format({}, function(err, did_edit)
                if not err then
                    if did_edit then
                        vim.notify("Formatted document using conform.")
                    else
                        vim.notify(
                            "Formatted document using conform; no changes."
                        )
                    end
                else
                    vim.notify(
                        "Could not format document; " .. err .. ".",
                        vim.log.levels.ERROR
                    )
                end
            end)
        end, { desc = "Format buffer" })
    end,
}

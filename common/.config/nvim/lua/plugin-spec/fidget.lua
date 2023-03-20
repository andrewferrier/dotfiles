return {
    "j-hui/fidget.nvim",
    opts = {
        fmt = {
            task = function(task_name, _, percentage)
                return string.format(
                    "%s - %s",
                    percentage and string.format(" %s%%", percentage) or "",
                    task_name
                )
            end,
        },
        sources = {
            ["null-ls"] = {
                -- null-ls seems to just generate noise in the fidget widget
                ignore = true,
            },
        },
    },
    event = "LspAttach",
}

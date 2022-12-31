return {
    "j-hui/fidget.nvim",
    config = function()
        require("fidget").setup({
            timer = { fidget_decay = 500, task_decay = 500 },
            text = { spinner = "star" },
            fmt = {
                task = function(task_name, _, percentage)
                    return string.format(
                        "%s [%s]",
                        percentage and string.format(" (%s%%)", percentage)
                            or "",
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
        })
    end,
    event = "LspAttach",
}

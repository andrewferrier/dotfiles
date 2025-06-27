-- selene: allow(mixed_table)
---@type LazyPluginSpec
return {
    "rachartier/tiny-code-action.nvim",
    dependencies = {
        { "nvim-lua/plenary.nvim" },
    },
    event = "LspAttach",
    opts = {},
    keys = {
        {
            "gra",
            function()
                require("tiny-code-action").code_action({})
            end,
            silent = true,
        },
    },
}

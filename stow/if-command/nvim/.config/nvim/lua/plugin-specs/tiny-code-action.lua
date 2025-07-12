-- selene: allow(mixed_table)
---@type LazyPluginSpec
return {
    "rachartier/tiny-code-action.nvim",
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        { "ibhagwan/fzf-lua" },
    },
    event = "LspAttach",
    opts = {
        picker = "select",
    },
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

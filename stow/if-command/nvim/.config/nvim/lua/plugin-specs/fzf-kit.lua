-- selene: allow(mixed_table)
---@type LazyPluginSpec
return {
    "nuvic/fzf-kit.nvim",
    dependencies = { "ibhagwan/fzf-lua" },
    opts = {
        folder = {
            fd_command = "file-list -d -p",
            fd_args = {},
        },
    },
    keys = {
        {
            "cvl",
            function()
                require("fzf-kit").folder_grep()
            end,
            desc = "Live grep",
        },
    },
}

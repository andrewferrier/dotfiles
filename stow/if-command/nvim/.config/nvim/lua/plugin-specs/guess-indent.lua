-- selene: allow(mixed_table)
---@type LazyPluginSpec
return {
    "NMAC427/guess-indent.nvim",
    opts = {
        filetype_exclude = {
            "go",
            "tutor",
            "terraform",
        },
    },
}

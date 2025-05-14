-- selene: allow(mixed_table)
---@type LazyPluginSpec
return {
    "chentoast/marks.nvim",
    opts = {
        mappings = {
            next = "]m",
            prev = "[m",
        },
    },
    event = "BufEnter",
}

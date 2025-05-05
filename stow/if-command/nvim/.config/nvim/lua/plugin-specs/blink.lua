---@type LazyPluginSpec
-- selene: allow(mixed_table)
return {
    "saghen/blink.cmp",
    version = "*",
    ---@type blink.cmp.Config
    opts = {
        keymap = {
            preset = "super-tab",
        },
        sources = {
            default = { "lsp", "path", "buffer" },
        },
    },
}

---@type LazyPluginSpec
-- selene: allow(mixed_table)
return {
    "saghen/blink.cmp",
    version = "*",
    ---@type blink.cmp.Config
    opts = {
        keymap = {
            preset = "super-tab",
            ["<C-N>"] = { "select_and_accept", "fallback" },
            ["<C-P>"] = {},
        },
        sources = {
            default = { "lsp", "path", "buffer" },
        },
    },
}

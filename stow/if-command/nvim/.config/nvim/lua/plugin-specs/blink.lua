---@type LazyPluginSpec
-- selene: allow(mixed_table)
return {
    "saghen/blink.cmp",
    version = "*",
    ---@type blink.cmp.Config
    opts = {
        keymap = {
            preset = "default",
            ["<Tab>"] = { "select_and_accept", "fallback" },
            ["<C-N>"] = { "select_and_accept", "fallback" },
            ["<C-P>"] = {},
            ["<C-Y>"] = { "fallback" },
        },
        sources = {
            default = { "lsp", "path", "buffer" },
        },
    },
}

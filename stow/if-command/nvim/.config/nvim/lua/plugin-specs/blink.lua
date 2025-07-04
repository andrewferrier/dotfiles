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
        completion = {
            accept = {
                auto_brackets = {
                    enabled = false,
                },
            },
        },
        signature = {
            enabled = true,
        },
        cmdline = {
            -- Because of https://github.com/Saghen/blink.cmp/issues/1878#issuecomment-3017120394
            enabled = false,
        },
    },
}

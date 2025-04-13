---@type LazyPluginSpec
-- selene: allow(mixed_table)
return {
    "saghen/blink.cmp",
    version = "*",
    ---@type blink.cmp.Config
    opts = {
        keymap = {
            preset = "default",
            ["<CR>"] = { "select_and_accept", "fallback" },
            ["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
            ["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },
            ["<C-Y>"] = { "fallback" },
        },
        sources = {
            default = { "lsp", "path", "buffer" },
        },
    },
}

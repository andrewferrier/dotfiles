return {
    "saghen/blink.cmp",
    lazy = false,
    version = "*",
    opts = {
        accept = { auto_brackets = { enabled = true } },
        trigger = { signature_help = { enabled = true } },
        keymap = {
            preset = "default",
            ["<Up>"] = { "select_prev", "fallback" },
            ["<Down>"] = { "select_next", "fallback" },
        },
    },
}

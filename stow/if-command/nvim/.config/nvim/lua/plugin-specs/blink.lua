return {
    "saghen/blink.cmp",
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

return {
    "saghen/blink.cmp",
    lazy = false,
    version = "*",
    opts = {
        accept = { auto_brackets = { enabled = true } },
        trigger = { signature_help = { enabled = true } },
        keymap = {
            ["<CR>"] = { "select_and_accept", "fallback" },
            ["<Tab>"] = { "select_and_accept", "fallback" },

            ["<C-e>"] = { "hide" },

            ["<C-p>"] = { "select_prev", "fallback" },
            ["<C-n>"] = { "select_next", "fallback" },

            ["<C-b>"] = { "scroll_documentation_up", "fallback" },
            ["<C-f>"] = { "scroll_documentation_down", "fallback" },
        },
    },
}

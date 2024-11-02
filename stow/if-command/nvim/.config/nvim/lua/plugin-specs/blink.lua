return {
    "saghen/blink.cmp",
    lazy = false,
    -- FIXME: For now we are using the head version until
    -- https://github.com/Saghen/blink.cmp/commit/193423ca584e4e1a9639d6c480a6b952db566c21
    -- is merged into a stable version
    --
    -- version = "*"
    opts = {
        accept = { auto_brackets = { enabled = true } },
        trigger = { signature_help = { enabled = true } },
        fuzzy = { -- FIXME: For now we are using the head version
            prebuilt_binaries = {
                force_version = "v0.5.0",
            },
        },
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

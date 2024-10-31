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
    },
}

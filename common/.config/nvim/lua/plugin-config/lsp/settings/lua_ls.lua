return {
    settings = {
        Lua = {
            -- Formatting is disabled because it doesn't reflow nicely; we use
            -- stylua instead.
            format = { enable = false },
            runtime = { version = "LuaJIT" },
            diagnostics = {
                globals = { "IMAP", "Set", "hs", "options", "pipe_to", "vim" },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            -- hint = { enable = true }, -- these hints seem fairly useless for now
        },
    },
}

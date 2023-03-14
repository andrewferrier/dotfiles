return {
    -- See
    -- https://github.com/LuaLS/lua-language-server/issues/1788#issuecomment-1464886248
    cmd = {
        "lua-language-server",
        "--logpath",
        vim.fn.stdpath("log") .. "/lua-language-server/",
        "--metapath",
        vim.fn.stdpath("cache") .. "/lua-language-server/meta/",
    },
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

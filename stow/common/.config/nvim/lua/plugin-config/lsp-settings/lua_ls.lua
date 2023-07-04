-- See https://github.com/LuaLS/lua-language-server/issues/1788#issuecomment-1464886248
local LOG_PATH = vim.fn.stdpath("log") .. "/lua-language-server/"
local META_PATH = vim.fn.stdpath("cache") .. "/lua-language-server/meta/"

return {
    cmd = {
        "lua-language-server",
        "--logpath",
        LOG_PATH,
        "--metapath",
        META_PATH,
    },
    on_attach = function(_, bufnr)
        vim.lsp.inlay_hint(bufnr, true)
    end,
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
                library = vim.tbl_extend(
                    "keep",
                    { META_PATH },
                    vim.api.nvim_get_runtime_file("", true)
                ),

                checkThirdParty = false,
            },
            hint = { arrayIndex = "Disable", enable = true },
        },
    },
}

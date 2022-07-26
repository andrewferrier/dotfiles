require("mason-tool-installer").setup({
    ensure_installed = {
        "hadolint",
        "lua-language-server",
        "stylua",
        "yaml-language-server",
        "vale",
    },

    auto_update = true,
    run_on_start = false,
})

-- selene: allow(mixed_table)
---@type LazyPluginSpec
return {
    "neovim/nvim-lspconfig",
    config = function()
        -- For doing diagnostics:
        -- vim.lsp.set_log_level("info")

        for _, lsp in ipairs({
            "ansiblels",
            "basedpyright",
            "bashls",
            "cssls",
            "dockerls",
            "gopls",
            "jsonls",
            "lemminx",
            "lua_ls",
            "ruff",
            "rust_analyzer",
            "taplo",
            "tofu_ls",
            "texlab",
            "ts_ls",
            "vimls",
            "yamlls",
        }) do
            vim.lsp.enable(lsp)
        end
    end,
    -- Don't configure any events here otherwise this doesn't attach when files
    -- are opened directly from the command line
}

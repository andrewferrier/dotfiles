return {
    "neovim/nvim-lspconfig",
    config = function()
        -- For doing diagnostics:
        -- vim.lsp.set_log_level("info")

        for lsp, settings in pairs({
            ansiblels = {},
            bashls = {},
            cssls = require("plugin-config.lsp-settings.css"),
            dockerls = {},
            gopls = require("plugin-config.lsp-settings.gopls"),
            pyright = {},
            lua_ls = require("plugin-config.lsp-settings.lua_ls"),
            terraformls = require("plugin-config.lsp-settings.terraformls"),
            tflint = require("plugin-config.lsp-settings.tflint"),
            tsserver = require("plugin-config.lsp-settings.tsserver"),
            vimls = {},
            yamlls = require("plugin-config.lsp-settings.yaml"),
        }) do
            require("lspconfig")[lsp].setup(settings)
        end
    end,
    event = "BufEnter",
}

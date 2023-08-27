return {
    "neovim/nvim-lspconfig",
    config = function()
        local lspconfig = require("lspconfig")

        -- For doing diagnostics:
        -- vim.lsp.set_log_level("info")

        local servers = {
            ansiblels = {},
            bashls = {},
            cssls = require("plugin-config.lsp-settings.css"),
            dockerls = {},
            gopls = require("plugin-config.lsp-settings.gopls"),
            jsonls = {},
            pyright = {},
            lua_ls = require("plugin-config.lsp-settings.lua_ls"),
            terraformls = require("plugin-config.lsp-settings.terraformls"),
            tflint = require("plugin-config.lsp-settings.tflint"),
            tsserver = require("plugin-config.lsp-settings.tsserver"),
            vimls = {},
            yamlls = require("plugin-config.lsp-settings.yaml"),
        }

        for lsp, settings in pairs(servers) do
            lspconfig[lsp].setup(settings)
        end
    end,
    event = "BufEnter",
}

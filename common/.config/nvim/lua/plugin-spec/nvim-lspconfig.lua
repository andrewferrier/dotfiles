return {
    "neovim/nvim-lspconfig",
    config = function()
        local lspconfig = require("lspconfig")

        -- For doing diagnostics:
        -- vim.lsp.set_log_level("info")

        local servers = {
            ansiblels = {},
            bashls = require("plugin-config.lsp-settings.bashls"),
            cssls = require("plugin-config.lsp-settings.css"),
            dockerls = {},
            gopls = {},
            jsonls = {},
            pyright = {},
            lua_ls = require("plugin-config.lsp-settings.lua_ls"),
            terraformls = require("plugin-config.lsp-settings.terraformls"),
            tflint = require("plugin-config.lsp-settings.tflint"),
            tsserver = {},
            vimls = {},
            yamlls = require("plugin-config.lsp-settings.yaml"),
        }

        for lsp, settings in pairs(servers) do
            if lsp == "tsserver" then
                require("typescript").setup({ server = settings })
            else
                lspconfig[lsp].setup(settings)
            end
        end
    end,
    event = "BufEnter",
}

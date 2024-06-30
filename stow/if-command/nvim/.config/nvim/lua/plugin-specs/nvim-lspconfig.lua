return {
    "neovim/nvim-lspconfig",
    config = function()
        -- For doing diagnostics:
        -- vim.lsp.set_log_level("info")

        for lsp, settings in pairs({
            ansiblels = {},
            basedpyright = {},
            bashls = {},
            cssls = require("plugin-specs.nvim-lspconfig.css"),
            dockerls = {},
            gopls = require("plugin-specs.nvim-lspconfig.gopls"),
            jsonls = {},
            lemminx = {},
            lua_ls = require("plugin-specs.nvim-lspconfig.lua_ls"),
            ruff = {},
            terraformls = require("plugin-specs.nvim-lspconfig.terraformls"),
            texlab = require("plugin-specs.nvim-lspconfig.texlab"),
            tflint = require("plugin-specs.nvim-lspconfig.tflint"),
            tsserver = require("plugin-specs.nvim-lspconfig.tsserver"),
            vimls = {},
            yamlls = require("plugin-specs.nvim-lspconfig.yaml"),
        }) do
            require("lspconfig")[lsp].setup(settings)
        end
    end,
    event = "BufEnter",
}

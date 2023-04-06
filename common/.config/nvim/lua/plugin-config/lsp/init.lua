local lspconfig = require("lspconfig")

local attach = require("plugin-config.lsp.attach")

-- For doing diagnostics:
-- vim.lsp.set_log_level("info")

local servers = {
    ansiblels = {},
    bashls = {
        -- Disable shellcheck because we use it from null-ls where we have more control
        cmd_env = { SHELLCHECK_PATH = "" },
    },
    cssls = require("plugin-config.lsp.settings.css"),
    dockerls = {},
    gopls = {},
    jsonls = {},
    pyright = {},
    lua_ls = require("plugin-config.lsp.settings.lua_ls"),
    terraformls = require("plugin-config.lsp.settings.terraformls"),
    tflint = require("plugin-config.lsp.settings.tflint"),
    tsserver = {},
    vimls = {},
    yamlls = require("plugin-config.lsp.settings.yaml"),
}

for lsp, settings in pairs(servers) do
    if lsp == "tsserver" then
        require("typescript").setup({ server = settings })
    else
        lspconfig[lsp].setup(settings)
    end
end

attach.setup_attach()

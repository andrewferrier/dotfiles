local lspconfig = require("lspconfig")

local attach = require("plugins.lsp.attach")

-- For doing diagnostics:
-- vim.lsp.set_log_level("info")

local servers = {
    bashls = {
        -- Disable shellcheck because we use it from null-ls where we have more control
        cmd_env = { SHELLCHECK_PATH = "" },
    },
    cssls = require("plugins.lsp.settings.css"),
    dockerls = {},
    gopls = {},
    jsonls = {},
    pyright = {},
    sumneko_lua = require("plugins.lsp.settings.sumneko"),
    terraformls = {},
    tflint = require("plugins.lsp.settings.tflint"),
    tsserver = require("plugins.lsp.settings.tsserver"),
    vimls = {},
    yamlls = require("plugins.lsp.settings.yaml"),
}

for lsp, settings in pairs(servers) do
    settings.on_attach = attach.on_attach

    if lsp == "tsserver" then
        require("typescript").setup({ server = settings })
    else
        lspconfig[lsp].setup(settings)
    end
end

attach.keybindings_defaults()

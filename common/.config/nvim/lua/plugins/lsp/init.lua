local lspconfig = require("lspconfig")

local attach = require("plugins.lsp.attach")
local css_settings = require("plugins.lsp.css_settings")

-- For doing diagnostics:
-- vim.lsp.set_log_level("info")

local sumneko_settings = {
    settings = {
        Lua = {
            -- Formatting is disabled because it doesn't reflow nicely; we use
            -- stylua instead.
            format = { enable = false },
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "IMAP", "Set", "hs", "options", "pipe_to", "vim" } },
            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
            telemetry = { enable = false },
        },
    },
}

local yaml_settings = {
    settings = {
        yaml = {
            schemaStore = {
                url = "https://www.schemastore.org/api/json/catalog.json",
                enable = true,
            },
            schemas = {
                kubernetes = {
                    "cronjob.y*ml",
                    "deployment.y*ml",
                    "service.y*ml",
                },
            },
        },
    },
}

local servers = {
    bashls = {},
    cssls = css_settings.settings,
    dockerls = {},
    gopls = {},
    jsonls = {},
    pyright = {},
    sumneko_lua = sumneko_settings,
    terraformls = {},
    tflint = {},
    tsserver = {},
    vimls = {},
    yamlls = yaml_settings,
}

for lsp, settings in pairs(servers) do
    local opts = { on_attach = attach.on_attach }
    opts = vim.tbl_extend("keep", opts, settings)
    lspconfig[lsp].setup(opts)
end

attach.keybindings_defaults()

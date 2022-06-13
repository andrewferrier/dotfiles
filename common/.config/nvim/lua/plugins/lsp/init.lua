local lspconfig = require("lspconfig")

local attach = require("plugins.lsp.attach")
local css_settings = require("plugins.lsp.css_settings")

-- For doing diagnostics:
-- vim.lsp.set_log_level("info")

-- luacheck: push no max line length

-- You can find more schemas in the catalogue:
-- https://github.com/SchemaStore/schemastore/blob/master/src/api/json/catalog.json

local yaml_schemas = {
    ["http://json.schemastore.org/kustomization"] = "kustomization.yaml",
    ["http://json.schemastore.org/ansible-playbook"] = "*play*.{yml,yaml}",
    ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
    ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose.y*ml",
}

-- luacheck: pop

local sumneko_settings = {
    settings = {
        Lua = {
            -- Formatting is disabled because it doesn't reflow nicely; we use
            -- stylua instead.
            format = { enable = false },
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "hs", "vim" } },
            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
            telemetry = { enable = false },
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
    yamlls = { schemas = yaml_schemas, completion = true },
}

for lsp, settings in pairs(servers) do
    local opts = { on_attach = attach.on_attach }
    opts = vim.tbl_extend("keep", opts, settings)
    lspconfig[lsp].setup(opts)
end

attach.keybindings_defaults()

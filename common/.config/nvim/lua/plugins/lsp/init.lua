-- luacheck: globals vim

local lspconfig = require("lspconfig")
local lspconfig_configs = require("lspconfig.configs")

local attach = require("plugins.lsp.attach")
local css_settings = require("plugins.lsp.css_settings")

-- For doing diagnostics:
-- vim.lsp.set_log_level("info")

lspconfig_configs.lualsp = {
    default_config = {
        cmd = { "lua-lsp" },
        filetypes = { "lua" },
        root_dir = function(file)
            return lspconfig.util.find_git_ancestor(file) or vim.fn.getcwd()
        end,
    },
}

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

local prosemd_cmd

if vim.loop.os_uname().sysname == "Darwin" then
    prosemd_cmd = "prosemd-lsp-macos"
else
    prosemd_cmd = "prosemd-lsp-linux"
end

local servers = {
    bashls = {},
    cssls = css_settings.settings,
    dockerls = {},
    gopls = {},
    jsonls = {},
    lualsp = {},
    pyright = {},
    prosemd_lsp = { cmd = { prosemd_cmd, "--stdio" } },
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

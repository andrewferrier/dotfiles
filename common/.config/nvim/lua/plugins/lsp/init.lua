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
            diagnostics = {
                globals = { "IMAP", "Set", "hs", "options", "pipe_to", "vim" },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            telemetry = { enable = false },
            -- hint = { enable = true }, -- these hints seem fairly useless for now
        },
    },
}

local tsserver_settings = {
    settings = {
        typescript = {
            inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
            },
        },
        javascript = {
            inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
            },
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
    bashls = {
        -- Disable shellcheck because we use it from null-ls where we have more control
        cmd_env = { SHELLCHECK_PATH = "" },
    },
    cssls = css_settings.settings,
    dockerls = {},
    gopls = {},
    jsonls = {},
    pyright = {},
    sumneko_lua = sumneko_settings,
    terraformls = {},
    tflint = {
        cmd = {
            "tflint",
            "--langserver",
            "--config",
            vim.env.XDG_CONFIG_HOME .. "/.tflint.hcl",
        },
    },
    vimls = {},
    yamlls = yaml_settings,
}

for lsp, settings in pairs(servers) do
    settings.on_attach = attach.on_attach
    lspconfig[lsp].setup(settings)
end

tsserver_settings.on_attach = attach.on_attach
require("typescript").setup({ server = tsserver_settings })

attach.keybindings_defaults()

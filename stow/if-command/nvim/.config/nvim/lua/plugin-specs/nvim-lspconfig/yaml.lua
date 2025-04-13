---@type vim.lsp.Config
return {
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

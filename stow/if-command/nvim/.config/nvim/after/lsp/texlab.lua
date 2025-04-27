-- See https://github.com/latex-lsp/texlab/wiki/Configuration
---@type vim.lsp.Config
return {
    settings = {
        texlab = {
            chktex = {
                onOpenAndSave = true,
                onEdit = true,
            },
        },
    },
}

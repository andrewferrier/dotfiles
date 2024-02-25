-- See https://github.com/latex-lsp/texlab/wiki/Configuration
return {
    settings = {
        texlab = {
            -- This doesn't do anything yet and therefore disables formatting
            latexFormatter = 'texlab',
            chktex = {
                onOpenAndSave = true,
                onEdit = true,
            },
        },
    },
}

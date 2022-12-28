return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("plugins.lsp")
        end,
    }, -- gyq, gQ, cx

    {
        "jose-elias-alvarez/null-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("plugins.null_ls")
        end,
    },

    {
        "smjonas/inc-rename.nvim",
        config = function()
            require("inc_rename").setup({ cmd_name = "LspRename" })
        end,
        event = "LspAttach",
    },

    {
        "j-hui/fidget.nvim",
        config = function()
            require("plugins.fidget")
        end,
        event = "LspAttach",
    },

    {
        "lvimuser/lsp-inlayhints.nvim",
        config = function()
            require("plugins.inlayhints")
        end,
    },

    "jose-elias-alvarez/typescript.nvim",
}

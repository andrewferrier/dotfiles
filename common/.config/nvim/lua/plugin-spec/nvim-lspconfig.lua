return {
    "neovim/nvim-lspconfig",
    config = function()
        require("plugin-config.lsp")
    end,
    event = "VeryLazy",
} -- gQ, cx

return {
    "neovim/nvim-lspconfig",
    config = function()
        require("plugin-config.lsp")
    end,
    event = "BufEnter",
} -- gQ, cx

return {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { { "nvim-lua/plenary.nvim", version = "*" } },
    config = function()
        require("plugin-config.null_ls")
    end,
    event = "BufEnter",
}

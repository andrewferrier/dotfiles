return {
    "nvimtools/none-ls.nvim",
    dependencies = { { "nvim-lua/plenary.nvim", version = "*" } },
    config = function()
        require("null-ls").setup({
            -- debug = true,
            sources = require("plugin-config.null_ls.sources").sources,
            should_attach = function(bufnr)
                return not require("utils").is_large_file(bufnr)
            end,
        })
    end,
    event = "BufEnter",
}

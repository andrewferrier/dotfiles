return {
    "nvimtools/none-ls.nvim",
    dependencies = { { "nvim-lua/plenary.nvim", version = "*" } },
    config = function()
        require("null-ls").setup({
            -- debug = true,
            sources = require("plugin-config.null_ls.sources").sources,
            should_attach = function(bufnr)
                local status_ok, bigfile_detected =
                    pcall(vim.api.nvim_buf_get_var, bufnr, "bigfile_detected")

                if status_ok then
                    return bigfile_detected <= 0
                else
                    return true
                end
            end,
        })
    end,
    event = "BufEnter",
}

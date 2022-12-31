return {
    "iamcco/markdown-preview.nvim",
    build = "cd app && yarn install",
    config = function()
        vim.g.mkdp_auto_start = 0
        vim.g.mkdp_preview_options = { disable_filename = 1 }
    end,
    ft = "markdown",
}

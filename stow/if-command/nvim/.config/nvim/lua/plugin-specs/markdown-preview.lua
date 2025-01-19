-- selene: allow(mixed_table)
return {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install",
    init = function()
        vim.g.mkdp_auto_start = 0
    end,
    ft = "markdown",
    version = "*",
}

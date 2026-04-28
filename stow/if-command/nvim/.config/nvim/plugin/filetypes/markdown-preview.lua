vim.g.mkdp_auto_start = 0

vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        if ev.data.spec.name == "markdown-preview.nvim" then
            if ev.data.kind == "install" or ev.data.kind == "update" then
                vim.notify("Installing markdown-preview.nvim...")
                vim.system(
                    { "npm", "install" },
                    { cwd = ev.data.path .. "/app" }
                )
                vim.notify("markdown-preview.nvim installed")
            end
        end
    end,
})

vim.pack.add({
    {
        src = "https://github.com/iamcco/markdown-preview.nvim",
        version = vim.version.range("*"),
    },
}, { load = true })

vim.pack.add({ "https://github.com/jfryy/keytrail.nvim" })

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "json", "yaml" },
    callback = function()
        vim.cmd.packadd("keytrail.nvim")
        require("keytrail").setup({
            key_mapping = nil,
        })
        vim.keymap.set("n", "gO", ":KeyTrailJump<CR>", { silent = true })
    end,
})

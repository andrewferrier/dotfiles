vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*",
    callback = function()
        if vim.bo.filetype == "" then
            vim.cmd.filetype("detect")
        end
    end,
})

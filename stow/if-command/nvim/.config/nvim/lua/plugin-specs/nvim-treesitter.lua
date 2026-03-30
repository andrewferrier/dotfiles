-- Enable treesitter on all filetypes
vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
        pcall(vim.treesitter.start, args.buf)
    end,
})

-- selene: allow(mixed_table)
return {
    "nvim-treesitter/nvim-treesitter",
    build = function()
        vim.cmd.TSInstall("all")
        vim.cmd.TSUpdate()
    end,
    -- Don't use lazy initialization as TSInstall command is needed for build()
    -- function
    lazy = false,
}

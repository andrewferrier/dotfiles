-- Enable treesitter on all filetypes
vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
        pcall(vim.treesitter.start, args.buf)
    end,
})

-- selene: allow(mixed_table)
---@type LazyPluginSpec
return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = function()
        vim.cmd.TSInstall("all")
        vim.cmd.TSUpdate()
    end,
    -- Don't use lazy initialization as TSInstall command is needed for build()
    -- function
    lazy = false,

    -- Don't use stable version, it always seems to cause issues
}

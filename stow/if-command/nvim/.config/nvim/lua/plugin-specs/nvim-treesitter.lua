-- selene: allow(mixed_table)
return {
    "nvim-treesitter/nvim-treesitter",
    -- Without this, it keeps switching back to 'master' as the branch
    branch = "main",
    build = function()
        vim.cmd.TSInstall("all")
        vim.cmd.TSUpdate()
    end,
    config = function()
        require("nvim-treesitter").setup()

        -- Enable treesitter on all installed filetypes
        local parsers_installed =
            require("nvim-treesitter").get_installed("parsers")

        local all_filetypes = vim.iter(parsers_installed)
            :map(function(parser)
                return vim.treesitter.language.get_filetypes(parser)
            end)
            :flatten()
            :totable()

        vim.api.nvim_create_autocmd({ "FileType" }, {
            group = vim.api.nvim_create_augroup("treesitter-start-files", {}),
            pattern = all_filetypes,
            callback = function()
                vim.treesitter.start()
            end,
        })
    end,
    -- Don't use lazy initialization as TSInstall command is needed for build()
    -- function
    lazy = false,
}

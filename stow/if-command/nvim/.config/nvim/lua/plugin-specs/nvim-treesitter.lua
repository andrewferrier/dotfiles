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
        local treesitter_start_group =
            vim.api.nvim_create_augroup("treesitter-start-files", {})

        for _, parser in pairs(parsers_installed) do
            local filetypes = vim.treesitter.language.get_filetypes(parser)
            vim.api.nvim_create_autocmd({ "FileType" }, {
                group = treesitter_start_group,
                pattern = filetypes,
                callback = function()
                    vim.treesitter.start()
                end,
            })
        end
    end,
    -- Don't use lazy initialization as TSInstall command is needed for build()
    -- function
    lazy = false,
}

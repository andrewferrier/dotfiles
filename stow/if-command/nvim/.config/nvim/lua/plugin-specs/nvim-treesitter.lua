local config_object = {
    "nvim-treesitter/nvim-treesitter",

    build = function()
        vim.cmd.TSInstall("all")
        vim.cmd.TSUpdate()
    end,
    -- Don't use lazy initialization as TSInstall command is needed for build()
    -- function
    lazy = false,
}

if vim.fn.has("nvim-0.12.0") == 1 then
    -- Enable treesitter on all filetypes
    vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
            pcall(vim.treesitter.start, args.buf)
        end,
    })
else
    config_object.branch = "master"
    config_object.config = function()
        require("nvim-treesitter.configs").setup({
            sync_install = true,
            highlight = { enable = true },
            refactor = {
                smart_rename = {
                    enable = true,
                    keymaps = {
                        smart_rename = false,
                    },
                },
            },
            indent = { enable = true },
            endwise = { enable = true },
        })
    end
end

return config_object

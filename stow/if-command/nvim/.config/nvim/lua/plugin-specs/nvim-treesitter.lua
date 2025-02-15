-- selene: allow(mixed_table)
---@type LazyPluginSpec
return {
    "nvim-treesitter/nvim-treesitter",
    main = "nvim-treesitter.configs",
    build = function()
        vim.cmd("TSInstall all")
        vim.cmd("TSUpdate")
    end,
    opts = {
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
    },

    -- Don't use lazy initialization as TSInstall command is needed for build()
    -- function
    --
    -- Don't use stable version, it always seems to cause issues
}

return {
    "nvim-treesitter/nvim-treesitter",
    build = function()
        vim.cmd("TSInstall all")
        vim.cmd("TSUpdate")
    end,
    config = function()
        ---@diagnostic disable-next-line: missing-fields
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
    end,
    event = { "BufReadPre", "BufNewFile" },
    -- Don't use stable version, it always seems to cause issues
}

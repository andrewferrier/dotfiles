return {
    "nvim-treesitter/nvim-treesitter",
    build = function()
        vim.cmd("TSInstall all")
        vim.cmd("TSUpdate")
    end,
    config = function()
        require("nvim-treesitter.configs").setup({
            -- Don't use ensure_installed; slows down startup
            highlight = { enable = true },
            refactor = { smart_rename = { enable = true } },
            indent = { enable = true },
            endwise = { enable = true },
        })
    end,
    event = { "BufReadPre", "BufNewFile" },
    -- Re-enable once on NeoVim 0.10
    -- version = "*",
}

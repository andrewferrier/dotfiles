local configure = function()
    require("nvim-treesitter.configs").setup({
        ensure_installed = "all",

        -- Ignore parsers I've had issues with and don't need
        ignore_install = { "julia", "smali" },

        highlight = {
            enable = true,
            disable = function()
                return require("utils").is_large_file()
            end,
        },
        refactor = { smart_rename = { enable = true } },
        indent = { enable = true },
        endwise = { enable = true },
    })
end

return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = configure,
    event = { "BufReadPre", "BufNewFile" },
    -- Re-enable once on NeoVim 0.10
    -- version = "*",
}

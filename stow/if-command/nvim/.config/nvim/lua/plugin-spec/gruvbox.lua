return {
    "ellisonleao/gruvbox.nvim",
    config = function()
        local overrides = {
            NormalFloat = { link = "Normal" },
            TermCursorNC = { bg = "#00DD00" },
            ["@lsp.mod.readonly"] = { bold = true },
        }

        require("gruvbox").setup({
            contrast = "hard",
            dim_inactive = true,
            overrides = overrides,
            italic = {
                strings = false,
                operators = false,
            },
        })

        vim.cmd.colorscheme("gruvbox")
    end,
}

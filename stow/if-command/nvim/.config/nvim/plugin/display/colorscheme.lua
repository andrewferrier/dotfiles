vim.pack.add({ "https://github.com/ellisonleao/gruvbox.nvim" })

require("gruvbox").setup({
    contrast = "hard",
    dim_inactive = true,
    transparent_mode = false,
    overrides = {
        DebugPrintLine = { link = "ErrorMsg" },
        DiagnosticUnnecessary = { link = "Whitespace" },
        OilInfo = { link = "NonText" },
        SignColumn = { link = "LineNr" },
        ["@lsp.mod.readonly"] = { bold = true },
    },
    ---@diagnostic disable-next-line missing-fields
    italic = {
        strings = false,
    },
})

vim.cmd.colorscheme("gruvbox")

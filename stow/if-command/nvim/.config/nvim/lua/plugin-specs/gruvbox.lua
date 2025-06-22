-- selene: allow(mixed_table)
---@type LazyPluginSpec
return {
    "ellisonleao/gruvbox.nvim",
    opts = {
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
        italic = {
            strings = false,
        },
    },
    config = function(_, opts)
        require("gruvbox").setup(opts)
        vim.cmd.colorscheme("gruvbox")
    end,
}

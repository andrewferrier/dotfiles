vim.pack.add({ "https://github.com/ellisonleao/gruvbox.nvim" })

local opts = {
    contrast = "hard",
    dim_inactive = true,
    transparent_mode = false,
    overrides = {
        DebugPrintLine = { link = "ErrorMsg" },
        OilInfo = { link = "NonText" },
        SignColumn = { link = "LineNr" },
        ["@lsp.mod.readonly"] = { bold = true },
    },
    ---@diagnostic disable-next-line missing-fields
    italic = {
        strings = false,
    },
}

if vim.fn.has("nvim-0.13") == 1 then
    opts.overrides.OilInfo = { link = "Dimmed" }
end

require("gruvbox").setup(opts)

vim.cmd.colorscheme("gruvbox")

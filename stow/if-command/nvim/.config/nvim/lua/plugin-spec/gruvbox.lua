return {
    "ellisonleao/gruvbox.nvim",
    config = function()
        local STATEFILE = vim.fn.expand("~/.cache/day-night/state")

        ---@cast STATEFILE string
        if
            vim.fn.filereadable(STATEFILE)
            and vim.fn.index(vim.fn.readfile(STATEFILE), "day") >= 0
        then
            vim.opt.background = "light"
        else
            vim.opt.background = "dark"
        end

        local overrides = {
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

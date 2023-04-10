return {
    "ellisonleao/gruvbox.nvim",
    config = function()
        local STATEFILE = vim.fn.expand("~/.cache/day-night/state-terminal")

        if
            vim.fn.filereadable(STATEFILE)
            and vim.fn.index(vim.fn.readfile(STATEFILE), "day") >= 0
        then
            vim.opt.background = "light"
        else
            vim.opt.background = "dark"
        end

        local overrides = {
            FidgetTitle = { link = "FidgetTask" },
            HydraHint = { link = "TabLineSel" },
            TermCursorNC = { bg = "#00DD00" },

            GruvboxAquaSign = { link = "GruvboxAqua" },
            GruvboxBlueSign = { link = "GruvboxBlue" },
            GruvboxGreenSign = { link = "GruvboxGreen" },
            GruvboxOrangeSign = { link = "GruvboxOrange" },
            GruvboxPurpleSign = { link = "GruvboxPurple" },
            GruvboxRedSign = { link = "GruvboxRed" },
            GruvboxYellowSign = { link = "GruvboxYellow" },

            ["@lsp.mod.readonly"] = { bold = true },
        }

        require("gruvbox").setup({
            contrast = "hard",
            overrides = overrides,
            italic = {
                strings = false,
                operators = false,
            },
        })

        vim.cmd.colorscheme("gruvbox")
    end,
}

return {
    "ellisonleao/gruvbox.nvim",
    config = function()
        local overrides = {
            FidgetTitle = { link = "FidgetTask" },
            HydraHint = { link = "TabLineSel" },
            NotifyDEBUGBorder = { link = "GruvboxBlue" },
            NotifyDEBUGIcon = { link = "GruvboxBlue" },
            NotifyDEBUGTitle = { link = "GruvboxBlue" },
            NotifyERRORBorder = { link = "GruvboxRed" },
            NotifyERRORIcon = { link = "GruvboxRed" },
            NotifyERRORTitle = { link = "GruvboxRed" },
            NotifyINFOBorder = { link = "GruvboxGreen" },
            NotifyINFOIcon = { link = "GruvboxGreen" },
            NotifyINFOTitle = { link = "GruvboxGreen" },
            NotifyTRACEBorder = { link = "GruvboxPurple" },
            NotifyTRACEIcon = { link = "GruvboxPurple" },
            NotifyTRACETitle = { link = "GruvboxPurple" },
            NotifyWARNBorder = { link = "GruvboxYellow" },
            NotifyWARNIcon = { link = "GruvboxYellow" },
            NotifyWARNTitle = { link = "GruvboxYellow" },
            Operator = { italic = false },
            QuickFixLine = { link = "IncSearch" },
            String = { italic = false },
            TermCursorNC = { bg = "#00FF00" },
            ["@readonly"] = { bold = true },
        }

        if vim.fn.has("nvim-0.9.0") == 1 then
            overrides = vim.tbl_extend("error", overrides, {
                SignColumn = { link = "Normal" },
                GitSignsAdd = { link = "GruvboxGreen" },
                GitSignsChange = { link = "GruvboxAqua" },
                GitSignsDelete = { link = "GruvboxRed" },
                GruvboxAquaSign = { link = "GruvboxAqua" },
                GruvboxBlueSign = { link = "GruvboxBlue" },
                GruvboxGreenSign = { link = "GruvboxGreen" },
                GruvboxOrangeSign = { link = "GruvboxOrange" },
                GruvboxPurpleSign = { link = "GruvboxPurple" },
                GruvboxRedSign = { link = "GruvboxRed" },
                GruvboxYellowSign = { link = "GruvboxYellow" },
            })
        end

        local STATEFILE = vim.fn.expand("~/.cache/day-night/state-terminal")

        if
            vim.fn.filereadable(STATEFILE)
            and vim.fn.index(vim.fn.readfile(STATEFILE), "day") >= 0
        then
            vim.opt.background = "light"
        else
            vim.opt.background = "dark"
        end

        require("gruvbox").setup({
            contrast = "hard",
            overrides = overrides,
        })

        vim.cmd.colorscheme("gruvbox")

        vim.api.nvim_set_hl(0, "MatchParen", { bold = true })
    end,
}

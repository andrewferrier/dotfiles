return {
    "ellisonleao/gruvbox.nvim",
    config = function()
        local statefile = vim.fn.expand("~/.cache/day-night/state-terminal")

        local palette = require("gruvbox.palette")

        local overrides = {
            CurSearch = { reverse = true }, -- Workaround for tint.nvim; see https://github.com/levouh/tint.nvim/issues/11
            FidgetTitle = { link = "FidgetTask" },
            HydraBlue = { fg = palette.neutral_blue, bold = true },
            HydraHint = { link = "TabLineSel" },
            LspInlayHint = { link = "Folded" }, -- lsp-inlayhints.nvim
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

        if
            vim.fn.filereadable(statefile)
            and vim.fn.index(vim.fn.readfile(statefile), "day") >= 0
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

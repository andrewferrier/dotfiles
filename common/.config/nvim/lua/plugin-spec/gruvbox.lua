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
            TermCursorNC = { bg = "#00FF00" },
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

                -- https://gist.github.com/swarn/fb37d9eefe1bc616c2a7e476c0bc0316
                ["@lsp.type.class"] = { link = "@type" },
                ["@lsp.type.decorator"] = { link = "@function" },
                ["@lsp.type.enum"] = { link = "@type" },
                ["@lsp.type.enumMember"] = { link = "@constant" },
                ["@lsp.type.function"] = { link = "@function" },
                ["@lsp.type.interface"] = { link = "@type" },
                ["@lsp.type.macro"] = { link = "@macro" },
                ["@lsp.type.method"] = { link = "@method" },
                ["@lsp.type.namespace"] = { link = "@namespace" },
                ["@lsp.type.parameter"] = { link = "@parameter" },
                ["@lsp.type.property"] = { link = "@property" },
                ["@lsp.type.struct"] = { link = "@structure" },
                ["@lsp.type.type"] = { link = "@type" },
                ["@lsp.type.variable"] = { link = "@variable" },

                ["@lsp.mod.readonly"] = { bold = true },
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
            italic = {
                strings = false,
                operators = false,
            },
        })

        vim.cmd.colorscheme("gruvbox")

        vim.api.nvim_set_hl(0, "MatchParen", { bold = true })
    end,
}

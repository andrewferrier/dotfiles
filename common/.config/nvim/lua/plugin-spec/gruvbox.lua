return {
    "ellisonleao/gruvbox.nvim",
    config = function()
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
        }

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
    end,
}

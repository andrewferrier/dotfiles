return {
    "ellisonleao/gruvbox.nvim",
    config = function()
        local STATEFILE = vim.fn.expand("~/.cache/day-night/state-terminal")

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

            -- See https://github.com/ellisonleao/gruvbox.nvim/issues/230#issuecomment-1493883602
            GruvboxAquaSign = { bg = "" },
            GruvboxBlueSign = { bg = "" },
            GruvboxGreenSign = { bg = "" },
            GruvboxOrangeSign = { bg = "" },
            GruvboxPurpleSign = { bg = "" },
            GruvboxRedSign = { bg = "" },
            GruvboxYellowSign = { bg = "" },

            ["@lsp.mod.readonly"] = { bold = true },
        }

        if vim.fn.has("nvim-0.10.0") == 0 then
            -- This is a workaround; see ~/.config/nvim/plugin/status-column.lua
            overrides["SignColumn"] = { link = "Normal" }
        end

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

return {
    "ellisonleao/gruvbox.nvim",
    config = function()
        local palette = require("gruvbox.palette")

        local overrides = {
            CurSearch = { reverse = true }, -- Workaround for tint.nvim; see https://github.com/levouh/tint.nvim/issues/11
            FidgetTitle = { link = "FidgetTask" },
            HydraBlue = { fg = palette.neutral_blue, bold = true },
            HydraHint = { link = "TabLineSel" },
            LspInlayHint = { link = "Folded" }, -- lsp-inlayhints.nvim
            Operator = { italic = false },
            QuickFixLine = { link = "IncSearch" },
            String = { italic = false },
            TermCursorNC = { bg = "#00FF00" },
            ["@readonly"] = { bold = true },
        }

        require("gruvbox").setup({
            contrast = "hard",
            overrides = overrides,
        })

        vim.cmd.colorscheme("gruvbox")

        vim.api.nvim_set_hl(0, "MatchParen", { bold = true })

        vim.api.nvim_create_autocmd("TextYankPost", {
            group = vim.api.nvim_create_augroup("HighlightYanked", {}),
            callback = function()
                require("vim.highlight").on_yank({ timeout = 200 })
            end,
        })
    end,
}

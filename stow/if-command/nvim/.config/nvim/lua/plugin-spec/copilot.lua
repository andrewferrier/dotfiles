return {
    "github/copilot.vim",
    keys = {
        {
            "yop",
            function()
                if vim.b.copilot_enabled then
                    vim.b.copilot_enabled = false
                    vim.cmd.redrawstatus()
                    vim.notify("Copilot disabled.")
                else
                    vim.b.copilot_enabled = true
                    vim.cmd.redrawstatus()
                    vim.notify("Copilot enabled.")
                end
            end,
            mode = "n",
        },
    },
    config = function()
        vim.g.copilot_filetypes = {
            ["*"] = false,
        }
    end,
}

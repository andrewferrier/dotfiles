return {
    "gabrielpoca/replacer.nvim",
    ft = "qf",
    config = function()
        vim.api.nvim_create_user_command("Replacer", function()
            require("replacer").run()
        end, { desc = "Use replacer.nvim for quickfix list" })
    end,
}

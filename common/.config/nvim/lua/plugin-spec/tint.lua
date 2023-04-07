return {
    "levouh/tint.nvim",
    dependencies = { "ellisonleao/gruvbox.nvim" },
    config = function()
        if vim.o.background == "light" then
            require("tint").setup({ tint = 55, saturation = 0.3 })
        else
            require("tint").setup({ saturation = 0.3 })
        end
    end,
    event = "VeryLazy",
}

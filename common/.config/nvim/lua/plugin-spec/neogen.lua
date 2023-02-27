return {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
        vim.keymap.set("n", "cxA", function()
            require("neogen").generate()
        end, { desc = "Generate code annotation" })

        require("neogen").setup({})
    end,
    version = "*",
}

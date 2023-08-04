return {
    "chrishrb/gx.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = "gx",
    config = true,
    enabled = function()
        return vim.fn.has("nvim-0.10.0") == 0
    end,
}

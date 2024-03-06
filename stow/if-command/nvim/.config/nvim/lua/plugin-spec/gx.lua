return {
    "chrishrb/gx.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
    cmd = { "Browse" },
    config = true,
    enabled = function()
        return vim.fn.has("nvim-0.10.0") == 0
    end,
}

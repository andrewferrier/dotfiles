vim.pack.add({ "https://github.com/folke/lazydev.nvim" })

---@type lazydev.Config
local opts = {
    library = {
        "blink.cmp",
        "conform.nvim",
        "debugprint.nvim",
        "lazy.nvim",
        "lazydev.nvim",
        "oil.nvim",
        "quicker.nvim",
        "snacks.nvim",
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
}

require("lazydev").setup(opts)

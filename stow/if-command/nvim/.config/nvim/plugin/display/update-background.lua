vim.pack.add({ "https://github.com/afonsofrancof/OSC11.nvim" })
require("osc11").setup({
    on_dark = function()
        vim.opt.background = "dark"
    end,
    on_light = function()
        vim.opt.background = "light"
    end,
})

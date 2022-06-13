if vim.fn.has("nvim-0.8.0") then
    vim.opt.cmdheight = 0

    vim.notify = require("notify")

    require("notify").setup({
        timeout = 400,
        render = "minimal",
        stages = "fade",
    })
end

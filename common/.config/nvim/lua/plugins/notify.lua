if vim.fn.has("nvim-0.8.0") == 1 then
    vim.opt.cmdheight = 0
end

vim.notify = require("notify")

require("notify").setup({
    timeout = 1500,
    render = "minimal",
    stages = "static",
})

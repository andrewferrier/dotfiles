if vim.fn.has("nvim-0.8.0") == 1 then
    vim.opt.cmdheight = 0
end

vim.notify = require("notify")

vim.api.nvim_echo = function(chunks, _, _)
    for chunk = 1, #chunks do
        vim.notify(chunks[chunk][1])
    end
end

require("notify").setup({
    timeout = 400,
    render = "minimal",
    stages = "fade",
})

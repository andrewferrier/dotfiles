if vim.fn.has("nvim-0.8.0") == 1 then
    vim.opt.cmdheight = 0
end

vim.notify = function(msg, level, opts)
    msg = vim.fn.expand("%:t") .. ": " .. msg
    require("notify")(msg, level, opts)
end

require("notify").setup({
    timeout = 1500,
    render = "minimal",
    stages = "static",
})

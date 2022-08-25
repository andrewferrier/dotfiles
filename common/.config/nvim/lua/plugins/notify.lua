vim.notify = function(msg, level, opts)
    msg = vim.fn.expand("%:t") .. ": " .. msg
    require("notify")(msg, level, opts)
end

require("notify").setup({
    timeout = 1500,
    render = "minimal",
    stages = "static",
})

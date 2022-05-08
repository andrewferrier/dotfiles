-- luacheck: globals vim

local check_large_file = function()
    if require("large_file").is_large_file() then
        -- Setting the syntax to a nonsense value effectively disables it
        vim.cmd("set syntax=foobar")
    end
end

vim.api.nvim_create_autocmd({ "BufRead" }, {
    group = vim.api.nvim_create_augroup("check_large_file", {}),
    callback = check_large_file,
})

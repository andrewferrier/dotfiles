vim.api.nvim_create_autocmd({ "QuickFixCmdPost" }, {
    group = vim.api.nvim_create_augroup("after_quick_fix", {}),
    callback = function()
        require("quickfix").open()
    end,
})

vim.keymap.set("n", "yoq", function()
    if vim.fn.getqflist({ winid = 0 }).winid ~= 0 then
        require("quickfix").close()
    else
        require("quickfix").open()
    end
end)

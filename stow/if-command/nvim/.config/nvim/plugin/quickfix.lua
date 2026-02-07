vim.api.nvim_create_autocmd({ "QuickFixCmdPost" }, {
    callback = function()
        require("quicker").open()
    end,
})

vim.keymap.set("n", "yoq", function()
    require("quicker").toggle()
end, { desc = "Toggle quickfix window", unique = true })

vim.cmd.packadd("cfilter")

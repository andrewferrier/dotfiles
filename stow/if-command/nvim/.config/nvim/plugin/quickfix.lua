local open = function()
    if vim.tbl_count(vim.fn.getqflist()) == 0 then
        vim.notify(
            "Nothing in quickfix list; not opening.",
            vim.log.levels.WARN
        )
    else
        vim.cmd.copen()
    end
end

vim.api.nvim_create_autocmd({ "QuickFixCmdPost" }, {
    callback = open,
})

vim.keymap.set("n", "yoq", function()
    if vim.fn.getqflist({ winid = 0 }).winid ~= 0 then
        vim.cmd.cclose()
    else
        open()
    end
end, { desc = "Toggle quickfix window", unique = true })

vim.cmd.packadd("cfilter")

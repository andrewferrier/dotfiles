vim.pack.add({
    {
        src = "https://github.com/stevearc/quicker.nvim",
        version = vim.version.range("*"),
    },
})

-- selene: allow(mixed_table)
require("quicker").setup({
    keys = {
        {
            ">",
            "<cmd>lua require('quicker').expand()<CR>",
            desc = "Expand quickfix content",
        },
        {
            "<",
            "<cmd>lua require('quicker').collapse()<CR>",
            desc = "Collapse quickfix content",
        },
    },
})

vim.api.nvim_create_autocmd({ "QuickFixCmdPost" }, {
    callback = function()
        require("quicker").open()
    end,
})

vim.keymap.set("n", "yoq", function()
    require("quicker").toggle()
end, { desc = "Toggle quickfix window", unique = true })

vim.cmd.packadd("cfilter")

vim.g.cursorhold_updatetime = 100

require("nvim-lightbulb").setup({
    sign = { enabled = false },
    autocmd = { enabled = true },
    virtual_text = { enabled = true, text = " α" },
})

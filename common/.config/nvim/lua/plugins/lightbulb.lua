vim.g.cursorhold_updatetime = 100

require("nvim-lightbulb").setup({
    sign = { enabled = true, priority = 5 },
    autocmd = { enabled = true },
})

vim.fn.sign_define('LightBulbSign', { text = "◌", texthl="LineNr" })

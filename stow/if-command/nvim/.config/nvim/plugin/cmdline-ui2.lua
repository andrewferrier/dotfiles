vim.o.cmdheight = 0

require("vim._core.ui2").enable({
    msg = {
        target = "msg",
        timeout = 2000,
    },
})

vim.keymap.set("n", "g<", ":messages<CR>", { silent = true })

vim.o.cmdheight = 0

require("vim._core.ui2").enable({
    msg = {
        -- 'target' is for NeoVim 0.12
        target = "msg",
        -- 'targets' is for NeoVim nightly
        targets = { default = "msg" },
        msg = {
            timeout = 2000,
        },
    },
})

vim.keymap.set("n", "g<", ":messages<CR>", { silent = true })

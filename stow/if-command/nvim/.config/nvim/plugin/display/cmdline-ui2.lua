vim.o.cmdheight = 0

require("vim._core.ui2").enable({
    msg = {
        -- 'target' is for NeoVim 0.12
        target = "msg",
        -- 'targets' is for NeoVim nightly
        targets = { default = "msg" },
    },
})

vim.opt.messagesopt:append("history:10000")

if vim.fn.has("nvim-0.13") == 1 then
    vim.opt.messagesopt:append("timeout:2000")
end

vim.keymap.set("n", "g<", ":messages<CR>", { silent = true })

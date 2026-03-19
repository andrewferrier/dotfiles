if vim.fn.has("nvim-0.12.0") == 1 then
    vim.o.cmdheight = 0

    require("vim._core.ui2").enable({
        msg = {
            target = "msg",
            timeout = 2000,
        },
    })

    vim.keymap.set("n", "g<", ":messages<CR>", { silent = true })
else
    vim.opt.showmode = false
end

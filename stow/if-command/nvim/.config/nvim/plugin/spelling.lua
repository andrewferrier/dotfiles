vim.opt.dictionary:append("/usr/share/dict/words")
vim.opt.dictionary:append(vim.opt.spellfile:get())

vim.opt.spell = true
vim.opt.spelllang = "en_gb"
vim.opt.spelloptions:append("camel")

vim.cmd.iabbrev("Reciept", "Receipt")
vim.cmd.iabbrev("Reciepts", "Receipts")
vim.cmd.iabbrev("reciept", "receipt")
vim.cmd.iabbrev("reciepts", "receipts")
vim.cmd.iabbrev("recieve", "receive")
vim.cmd.iabbrev("recieved", "received")

vim.pack.add({ { src = "https://github.com/chaneyzorn/spellwand.nvim" } })
vim.lsp.enable("spellwand")
vim.lsp.config("spellwand", {
    settings = {
        spellwand = {
            cond = function()
                if vim.o.filetype == "oil" or vim.o.filetype == "nftables" then
                    vim.opt_local.spell = false
                    return false
                end

                return true
            end,
        },
    },
})
vim.cmd.packadd("spellwand.nvim") -- required for SpellwandRefresh command

vim.keymap.set("n", "zg", "zg<cmd>SpellwandRefresh!<cr>]szz", { remap = false })
vim.keymap.set("n", "zw", "zw<cmd>SpellwandRefresh!<cr>]szz", { remap = false })

local spelldir = vim.fn.stdpath("data") .. "/spell"
vim.fn.mkdir(vim.fn.expand(spelldir), "p")

vim.opt.spellfile = vim.fn.expand(spelldir .. "/en.utf-8.add")
vim.opt.dictionary:append("/usr/share/dict/words")
vim.opt.dictionary:append(vim.opt.spellfile:get())

vim.opt.spelllang = "en_gb"
vim.opt.spelloptions:append("camel")

vim.keymap.set("n", "zg", "zg]s")

vim.cmd.iabbrev("Reciept", "Receipt")
vim.cmd.iabbrev("Reciepts", "Receipts")
vim.cmd.iabbrev("reciept", "receipt")
vim.cmd.iabbrev("reciepts", "receipts")
vim.cmd.iabbrev("recieve", "receive")
vim.cmd.iabbrev("recieved", "received")

if vim.fn.has("nvim-0.9.0") == 1 then
    require("editorconfig").properties.spell = function(bufnr, val, opts)
        if val == 'true' then
            vim.opt_local.spell = true
        elseif val == 'false' then
            vim.opt_local.spell = false
        end
    end
end

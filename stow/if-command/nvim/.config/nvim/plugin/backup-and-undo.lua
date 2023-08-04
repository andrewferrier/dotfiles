vim.opt.backup = true
vim.opt.backupdir:remove(".")

-- This is required to make the backup renaming logic below work - see
-- https://gist.github.com/nepsilon/003dd7cfefc20ce1e894db9c94749755
vim.opt.backupcopy = "yes"

vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("BufWritePre_SetBackupFilename", {}),
    pattern = "*",
    callback = function()
        -- Meaningful backup name, ex: filename@2015-04-05T14:59:00
        vim.opt.backupext = "@" .. vim.fn.strftime("%FT%H:%M:%S")
    end,
})

vim.opt.undofile = true
vim.opt.shada = "'100,s10,/1000,:1000,h"

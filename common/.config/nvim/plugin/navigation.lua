vim.opt.path:remove("/usr/include")

local change_to_root = function()
    require("git").if_in_git(function(dir)
        vim.cmd.lcd(dir)
    end)
end

vim.keymap.set("n", "cdf", ":lcd %:p:h<CR>", { silent = true })
vim.keymap.set("n", "cdh", ":lcd ~<CR>", { silent = true })
vim.keymap.set("n", "cdu", ":lcd ..<CR>", { silent = true })
vim.keymap.set("n", "cdg", change_to_root, { silent = true })

vim.keymap.set("n", "gof", function()
    require("open_filedirterm").open_file_manager("%:p")
end)

vim.keymap.set("n", "goF", function()
    require("open_filedirterm").open_file_manager(vim.fn.getcwd(0))
end)

vim.keymap.set("n", "got", function()
    require("open_filedirterm").open_terminal(vim.o.shell, "%:p:h")
end)

vim.keymap.set("n", "goT", function()
    require("open_filedirterm").open_terminal(vim.o.shell, vim.fn.getcwd(0))
end)

vim.keymap.set("n", "god", function()
    require("open_filedirterm").open_split_dirbuf("%:p:h")
end)

vim.keymap.set("n", "goD", function()
    require("open_filedirterm").open_split_dirbuf(vim.fn.getcwd(0))
end)

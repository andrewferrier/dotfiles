vim.opt.path:remove("/usr/include")

local change_to_root = function()
    local dir = vim.fn.expand("%:p:h")
    local cmd = "cd " .. dir .. "; git rev-parse --show-toplevel"
    local root = vim.fn.system(cmd)

    if vim.v.shell_error == 0 then
        vim.cmd("lcd " .. vim.fn.trim(root))
    else
        vim.notify("Not in git directory.", vim.log.levels.ERROR)
    end
end

vim.keymap.set("n", "cdf", ":lcd %:p:h<CR>", { silent = true })
vim.keymap.set("n", "cdh", ":lcd ~<CR>", { silent = true })
vim.keymap.set("n", "cdu", ":lcd ..<CR>", { silent = true })
vim.keymap.set("n", "cdg", change_to_root, { silent = true })

vim.keymap.set("n", "gof", function()
    require("open_filedirterm").open_file_manager("%:p")
end)

vim.keymap.set("n", "goF", function()
    require("open_filedirterm").open_file_manager(vim.fn.getcwd())
end)

vim.keymap.set("n", "got", function()
    require("open_filedirterm").open_terminal(vim.o.shell, "%:p:h")
end)

vim.keymap.set("n", "goT", function()
    require("open_filedirterm").open_terminal(vim.o.shell, vim.fn.getcwd())
end)

vim.keymap.set("n", "god", function()
    require("open_filedirterm").open_split_dirbuf("%:p:h")
end)

vim.keymap.set("n", "goD", function()
    require("open_filedirterm").open_split_dirbuf(vim.fn.getcwd())
end)

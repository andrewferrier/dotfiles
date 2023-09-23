vim.opt.path:remove("/usr/include")

local change_to_root = function()
    require("git").if_in_git(function(dir)
        vim.cmd.lcd(dir)
    end)
end

vim.keymap.set(
    "n",
    "cdf",
    ":lcd %:p:h<CR>",
    { silent = true, desc = "cd to directory of file", unique = true }
)
vim.keymap.set(
    "n",
    "cdh",
    ":lcd ~<CR>",
    { silent = true, desc = "cd to " .. vim.env.HOME, unique = true }
)
vim.keymap.set(
    "n",
    "cdu",
    ":lcd ..<CR>",
    { silent = true, desc = "cd to ..", unique = true }
)
vim.keymap.set(
    "n",
    "cdg",
    change_to_root,
    { silent = true, desc = "cd to git root", unique = true }
)

vim.keymap.set("n", "gof", function()
    require("open_filedirterm").open_file_manager("%:p")
end, { desc = "Open ranger in directory of file", unique = true })

vim.keymap.set("n", "goF", function()
    require("open_filedirterm").open_file_manager(vim.fn.getcwd(0))
end, { desc = "Open ranger in lcd", unique = true })

vim.keymap.set("n", "got", function()
    require("open_filedirterm").open_terminal(vim.o.shell, "%:p:h")
end, { desc = "Open terminal in directory of file", unique = true })

vim.keymap.set("n", "goT", function()
    require("open_filedirterm").open_terminal(vim.o.shell, vim.fn.getcwd(0))
end, { desc = "Open terminal in lcd", unique = true })

vim.keymap.set("n", "god", function()
    require("open_filedirterm").open_split_oil("%:p:h")
end, { desc = "Open oil in directory of file", unique = true })

vim.keymap.set("n", "goD", function()
    require("open_filedirterm").open_split_oil(vim.fn.getcwd(0))
end, { desc = "Open oil in lcd", unique = true })

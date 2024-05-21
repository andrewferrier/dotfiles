vim.opt.path:remove("/usr/include")

local change_to_root = function()
    require("git").if_in_git(function(dir)
        vim.cmd.lcd(dir)
    end)
end

---@param lhs string
---@param rhs string|function
---@param description string
local map = function(lhs, rhs, description)
    vim.keymap.set(
        "n",
        'cd' .. lhs,
        rhs,
        { silent = true, desc = "cd to " .. description, unique = true }
    )
end

map("f", ":lcd %:p:h<CR>", "directory of file")
map("h", ":lcd ~<CR>", vim.env.HOME)
map("u", ":lcd ..<CR>", "..")
map("g", change_to_root, "git root")

vim.keymap.set("n", "gof", function()
    require("open_filedirterm").open_file_manager("%:p")
end, { desc = "Open lf in directory of file", unique = true })

vim.keymap.set("n", "goF", function()
    require("open_filedirterm").open_file_manager(vim.fn.getcwd(0))
end, { desc = "Open lf in lcd", unique = true })

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

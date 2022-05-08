-- luacheck: globals vim

vim.opt.path:remove("/usr/include")

local change_to_root = function()
    local dir = vim.fn.expand("%:p:h")
    local cmd = "cd " .. dir .. "; git rev-parse --show-toplevel"
    local root = vim.fn.trim(vim.fn.system(cmd))
    vim.cmd("lcd " .. root)
end

vim.keymap.set("n", "cdf", ":lcd %:p:h<CR>", { silent = true })
vim.keymap.set("n", "cdh", ":lcd ~<CR>", { silent = true })
vim.keymap.set("n", "cdu", ":lcd ..<CR>", { silent = true })
vim.keymap.set("n", "cdg", change_to_root, { silent = true })

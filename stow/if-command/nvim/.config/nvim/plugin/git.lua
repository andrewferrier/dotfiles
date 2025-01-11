---@param command string
---@param dir string
---@return nil
local run_git_cmd = function(command, dir)
    local expanded_dir = vim.fn.expand(dir, true)

    if vim.fs.root(expanded_dir, ".git") then
        require("open_filedirterm").open_terminal(
            command,
            { cwd = expanded_dir }
        )
    else
        vim.notify("Not in git directory", vim.log.levels.WARN)
    end
end

vim.keymap.set("n", "gbc", function()
    run_git_cmd("git commit", "%:p:h")
end, { desc = "git commit", unique = true })

vim.keymap.set("n", "gbs", function()
    run_git_cmd("tig status", "%:p:h")
end, { desc = "tig status in filedir", unique = true })

vim.keymap.set("n", "gbS", function()
    run_git_cmd("tig status", vim.fn.getcwd(0))
end, { desc = "tig status in lcd", unique = true })

vim.keymap.set("n", "gbt", function()
    run_git_cmd("tig", "%:p:h")
end, { desc = "tig history in filedir", unique = true })

vim.keymap.set("n", "gbT", function()
    run_git_cmd("tig", vim.fn.getcwd(0))
end, { desc = "tig history in lcd", unique = true })

vim.keymap.set("n", "gbo", function()
    vim.system(
        { "git", "open" },
        { cwd = vim.fn.expand("%:p:h"), detach = true },
        require("utils").system_on_exit
    )
end, { desc = "Open git repo in browser", unique = true })

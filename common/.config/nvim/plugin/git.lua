local run_git_cmd = function(command, dir)
    require("git").if_in_git(function()
        require("open_filedirterm").open_terminal(command, dir)
    end, dir)
end

vim.keymap.set("n", "gbc", function()
    run_git_cmd("git commit", "%:p:h")
end, { desc = "git commit" })

vim.keymap.set("n", "gbs", function()
    run_git_cmd("tig status", "%:p:h")
end, { desc = "tig status in file directory" })

vim.keymap.set("n", "gbS", function()
    run_git_cmd("tig status", vim.fn.getcwd(0))
end, { desc = "tig status in lcd" })

vim.keymap.set("n", "gbt", function()
    run_git_cmd("tig", "%:p:h")
end, { desc = "tig commit history" })

vim.keymap.set("n", "gbT", function()
    run_git_cmd("tig", vim.fn.getcwd(0))
end, { desc = "git commit" })

vim.keymap.set("n", "gbo", function()
    vim.fn.jobstart({ "git", "open" }, {
        cwd = vim.fn.expand("%:p:h"),
        detach = true,
        on_stderr = require("utils").job_stderr,
    })
end, { desc = "Open git repo in browser" })

vim.keymap.set("n", "[C", "gg]c", { remap = true })
vim.keymap.set("n", "]C", "G[c", { remap = true })

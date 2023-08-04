vim.keymap.set("n", "gbc", function()
    require("git").run_git_cmd("git commit", "%:p:h")
end, { desc = "git commit" })

vim.keymap.set("n", "gbs", function()
    require("git").run_git_cmd("tig status", "%:p:h")
end, { desc = "tig status in filedir" })

vim.keymap.set("n", "gbS", function()
    require("git").run_git_cmd("tig status", vim.fn.getcwd(0))
end, { desc = "tig status in lcd" })

vim.keymap.set("n", "gbt", function()
    require("git").run_git_cmd("tig", "%:p:h")
end, { desc = "tig history in filedir" })

vim.keymap.set("n", "gbT", function()
    require("git").run_git_cmd("tig", vim.fn.getcwd(0))
end, { desc = "tig history in lcd" })

vim.keymap.set("n", "gbo", function()
    vim.fn.jobstart({ "git", "open" }, {
        cwd = vim.fn.expand("%:p:h"),
        detach = true,
        on_stderr = require("utils").job_stderr,
    })
end, { desc = "Open git repo in browser" })

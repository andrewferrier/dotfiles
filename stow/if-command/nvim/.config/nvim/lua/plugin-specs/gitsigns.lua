---@param bufnr integer
local attach = function(bufnr)
    local gitsigns = require("gitsigns")

    local git_nav_hunk = function(lhs, direction)
        vim.keymap.set("n", lhs, function()
            gitsigns.nav_hunk(string.lower(direction), { target = "all" })
        end, {
            desc = direction .. " hunk",
            buffer = bufnr,
        })
    end

    git_nav_hunk("]h", "Next")
    git_nav_hunk("[h", "Prev")
    git_nav_hunk("[H", "First")
    git_nav_hunk("]H", "Last")

    vim.keymap.set(
        { "o", "x" },
        "ih",
        ":<C-U>Gitsigns select_hunk<CR>",
        { buffer = bufnr, silent = true }
    )

    vim.keymap.set("n", "gbhs", function()
        vim.cmd.update()
        vim.schedule(function()
            gitsigns.stage_hunk()
            gitsigns.nav_hunk("next", { target = "all" })
        end)
    end, { desc = "Stage/unstage hunk", buffer = bufnr })

    vim.keymap.set("v", "gbhs", function()
        local first_line = vim.fn.line("v")
        local last_line = vim.fn.getpos(".")[2]
        gitsigns.stage_hunk({ first_line, last_line })

        local mode = vim.fn.mode():lower()
        if mode:find("^v") or mode:find("^ctrl-v") then
            vim.cmd.normal({ args = { "V" }, bang = true })
        end
    end, { desc = "Stage/unstage hunk", buffer = bufnr })

    vim.keymap.set("n", "gbhr", function()
        gitsigns.reset_hunk()
    end, { desc = "Reset hunk", buffer = bufnr })

    vim.keymap.set("n", "gba", function()
        vim.cmd.update()
        gitsigns.stage_buffer()
    end, {
        desc = "Stage/add entire file",
        buffer = bufnr,
    })
end

vim.api.nvim_create_user_command("GitQFList", function()
    if vim.fs.root(vim.fn.getcwd(0), ".git") then
        -- gitsigns always opens QuickFix list, async, even if empty
        require("gitsigns").setqflist("all")
    else
        vim.notify("Not in git directory", vim.log.levels.WARN)
    end
end, {})

-- selene: allow(mixed_table)
return {
    "lewis6991/gitsigns.nvim",
    opts = {
        signs_staged = {
            add = { text = "┋ " },
            change = { text = "┋ " },
            delete = { text = "﹍" },
            topdelete = { text = "﹉" },
            changedelete = { text = "┋ " },
        },
        signs = { change = { text = "~" }, changedelete = { text = "⋍" } },
        sign_priority = 10,
        on_attach = attach,
    },
    event = "BufEnter",
    version = "*",
}

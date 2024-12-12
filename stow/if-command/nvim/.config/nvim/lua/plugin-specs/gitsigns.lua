---@param bufnr integer
local attach = function(bufnr)
    local gitsigns = require("gitsigns")

    vim.keymap.set("n", "]h", function()
        vim.schedule(function()
            gitsigns.next_hunk()
        end)
    end, { desc = "Hunk forward", buffer = bufnr })

    vim.keymap.set("n", "[h", function()
        vim.schedule(function()
            gitsigns.prev_hunk()
        end)
    end, { desc = "Hunk backward", buffer = bufnr })

    vim.keymap.set(
        "n",
        "[H",
        "gg]h",
        { remap = true, desc = "Hunk first", buffer = bufnr }
    )

    vim.keymap.set(
        "n",
        "]H",
        "G[h",
        { remap = true, desc = "Hunk last", buffer = bufnr }
    )

    vim.keymap.set(
        { "o", "x" },
        "ih",
        ":<C-U>Gitsigns select_hunk<CR>",
        { buffer = bufnr, silent = true }
    )

    vim.keymap.set("n", "gbhs", function()
        vim.cmd.update()
        gitsigns.stage_hunk()
        vim.schedule(function()
            gitsigns.next_hunk()
        end)
    end, { desc = "Stage hunk", buffer = bufnr })

    vim.keymap.set("n", "gbhu", function()
        vim.cmd.update()
        gitsigns.undo_stage_hunk()
        vim.schedule(function()
            gitsigns.next_hunk()
        end)
    end, { desc = "Undo stage hunk", buffer = bufnr })

    vim.keymap.set("v", "gbhs", function()
        local first_line = vim.fn.line("v")
        local last_line = vim.fn.getpos(".")[2]
        gitsigns.stage_hunk({ first_line, last_line })

        local mode = vim.fn.mode():lower()
        if mode:find("^v") or mode:find("^ctrl-v") then
            vim.cmd.normal({ args = { "V" }, bang = true })
        end
    end, { desc = "Stage hunk", buffer = bufnr })

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

    vim.keymap.set("n", "yo_", function()
        gitsigns.toggle_deleted()
        vim.cmd.redrawstatus()
    end, {
        desc = "Toggle deleted lines",
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

return {
    "lewis6991/gitsigns.nvim",
    opts = {
        _signs_staged_enable = true,
        _signs_staged = {
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

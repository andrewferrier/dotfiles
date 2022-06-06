local attach = function(bufnr)
    local function map(l, r, opts)
        opts = vim.tbl_extend("force", { buffer = bufnr }, opts or {})
        local mode = opts.mode or "n"
        opts.mode = nil
        vim.keymap.set(mode, l, r, opts)
    end

    map(
        "]c",
        "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'",
        { expr = true }
    )
    map(
        "[c",
        "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'",
        { expr = true }
    )

    map("gbhs", function()
        vim.cmd("update")
        require("gitsigns").stage_hunk()
    end)

    map("gbhr", function()
        require("gitsigns").reset_hunk()
    end)

    map("gba", function()
        vim.cmd("update")
        require("gitsigns").stage_buffer()
    end)

    map("yog", function()
        require("gitsigns").toggle_deleted()
        vim.notify("Deleted lines toggled.")
    end)
end

require("gitsigns").setup({
    signs = { change = { text = "~" }, changedelete = { text = "⋍" } },
    sign_priority = 10,
    on_attach = attach,
})

local in_git_dir = function()
    local dir = vim.fn.getcwd()
    local cmd = "cd " .. dir .. "; git rev-parse --show-toplevel"
    vim.fn.system(cmd)

    return vim.v.shell_error == 0
end

vim.api.nvim_create_user_command("GitQFList", function()
    if in_git_dir() then
        -- gitsigns always opens QuickFix list, async, even if empty
        require("gitsigns").setqflist("all")
    else
        vim.notify("Not in git directory.", vim.log.levels.ERROR)
    end
end, {})

local configure = function()
    local gitsigns = require("gitsigns")

    local function visual_stage()
        local first_line = vim.fn.line("v")
        local last_line = vim.fn.getpos(".")[2]
        gitsigns.stage_hunk({ first_line, last_line })

        local mode = vim.fn.mode():lower()
        if mode:find("^v") or mode:find("^ctrl-v") then
            vim.cmd.normal({ args = { "V" }, bang = true })
        end
    end

    local attach = function(bufnr)
        local function map(l, r, opts)
            opts = vim.tbl_extend("force", { buffer = bufnr }, opts or {})
            local mode = opts.mode or "n"
            opts.mode = nil
            vim.keymap.set(mode, l, r, opts)
        end

        map("]c", function()
            if vim.wo.diff then
                return "]c"
            end
            vim.schedule(function()
                gitsigns.next_hunk()
            end)
            return "<Ignore>"
        end, { expr = true, desc = "Diff/hunk forward" })

        map("[c", function()
            if vim.wo.diff then
                return "[c"
            end
            vim.schedule(function()
                gitsigns.prev_hunk()
            end)
            return "<Ignore>"
        end, { expr = true, desc = "Diff/hunk backward" })

        map("[C", "gg]c", { remap = true, desc = "Diff/junk first" })
        map("]C", "G[c", { remap = true, desc = "Diff/junk last" })

        map("ih", ":<C-U>Gitsigns select_hunk<CR>", { mode = { "o", "x" } })

        map("gbhs", function()
            vim.cmd.update()
            gitsigns.stage_hunk()
            vim.schedule(function()
                gitsigns.next_hunk()
            end)
        end, { desc = "Stage hunk" })

        vim.keymap.set("v", "gbhs", function()
            visual_stage()
        end, { desc = "Stage hunk" })

        map("gbhr", function()
            gitsigns.reset_hunk()
        end, { desc = "Reset hunk" })

        map("gba", function()
            vim.cmd.update()
            gitsigns.stage_buffer()
        end, { desc = "Stage/add entire file" })

        map("yo_", function()
            gitsigns.toggle_deleted()
        end, { desc = "Toggle deleted lines" })
    end

    gitsigns.setup({
        signs = { change = { text = "~" }, changedelete = { text = "⋍" } },
        sign_priority = 10,
        on_attach = attach,
        max_file_length = require("large_file").LARGE_FILE_LINE_COUNT,
    })

    vim.api.nvim_create_user_command("GitQFList", function()
        require("git").if_in_git(function()
            -- gitsigns always opens QuickFix list, async, even if empty
            gitsigns.setqflist("all")
        end, vim.fn.getcwd(0))
    end, {})
end

return {
    "lewis6991/gitsigns.nvim",
    config = configure,
    event = "VeryLazy",
    version = "*",
} -- gb

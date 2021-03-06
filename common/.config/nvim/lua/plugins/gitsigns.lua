local gitsigns = require("gitsigns")

local function visual_stage()
    local first_line = vim.fn.line("v")
    local last_line = vim.fn.getpos(".")[2]
    gitsigns.stage_hunk({ first_line, last_line })

    local mode = vim.fn.mode():lower()
    if mode:find("^v") or mode:find("^ctrl-v") then
        vim.cmd("normal! V")
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
            require("gitsigns").next_hunk()
        end)
        return "<Ignore>"
    end, { expr = true })

    map("[c", function()
        if vim.wo.diff then
            return "[c"
        end
        vim.schedule(function()
            require("gitsigns").prev_hunk()
        end)
        return "<Ignore>"
    end, { expr = true })

    map("ih", ":<C-U>Gitsigns select_hunk<CR>", { mode = { "o", "x" } })

    map("gbhs", function()
        vim.cmd("update")
        require("gitsigns").stage_hunk()
    end)

    vim.keymap.set("v", "gbhs", function()
        visual_stage()
    end)

    map("gbhr", function()
        require("gitsigns").reset_hunk()
    end)

    map("gba", function()
        vim.cmd("update")
        require("gitsigns").stage_buffer()
    end)

    map("yod", function()
        require("gitsigns").toggle_deleted()
    end)
end

gitsigns.setup({
    signs = { change = { text = "~" }, changedelete = { text = "⋍" } },
    sign_priority = 10,
    on_attach = attach,
    max_file_length = require('large_file').LARGE_FILE_LINE_COUNT
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

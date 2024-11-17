local M = {}

---@param desc string
---@return table
local create_opts = function(desc)
    return {
        buffer = true,
        silent = true,
        desc = desc,
    }
end

---@param pattern_start string
local setup_outline = function(pattern_start)
    vim.keymap.set("n", "gO", function()
        local view = vim.fn.winsaveview()
        vim.cmd.vimgrep("'" .. pattern_start .. "'", "%")
        vim.fn.winrestview(view)
        vim.cmd.copen()
    end, create_opts("Show file outline"))
end

---@param pattern_start string
---@param pattern_end? string
M.setup_navigation = function(pattern_start, pattern_end)
    vim.keymap.set("n", "]]", function()
        vim.cmd.mark("'")
        vim.fn.search(pattern_start, "W")
    end, create_opts("Move to start of next section"))

    vim.keymap.set("n", "[[", function()
        vim.cmd.mark("'")
        vim.fn.search(pattern_start, "bW")
    end, create_opts("Move to start of previous section"))

    vim.keymap.set("v", "]]", function()
        vim.cmd.normal({ args = { "gv" }, bang = true })
        vim.fn.search(pattern_start, "W")
    end, create_opts("Move to start of next section"))

    vim.keymap.set("v", "[[", function()
        vim.cmd.normal({ args = { "gv" }, bang = true })
        vim.fn.search(pattern_start, "bW")
    end, create_opts("Move to start of previous section"))

    if pattern_end ~= nil then
        vim.keymap.set("n", "][", function()
            vim.cmd.mark("'")
            vim.fn.search(pattern_end, "W")
        end, create_opts("Move to end of next section"))

        vim.keymap.set("n", "[]", function()
            vim.cmd.mark("'")
            vim.fn.search(pattern_end, "bW")
        end, create_opts("Move to start of previous section"))

        vim.keymap.set("v", "][", function()
            vim.cmd.mark("'")
            vim.cmd.normal({ args = { "gv" }, bang = true })
            vim.fn.search(pattern_end, "W")
        end, create_opts("Move to end of next section"))

        vim.keymap.set("v", "[]", function()
            vim.cmd.mark("'")
            vim.cmd.normal({ args = { "gv" }, bang = true })
            vim.fn.search(pattern_end, "bW")
        end, create_opts("Move to start of previous section"))
    end
end

---@param pattern_start string
---@param pattern_end? string
M.setup = function(pattern_start, pattern_end)
    setup_outline(pattern_start)
    M.setup_navigation(pattern_start, pattern_end)
end

return M
